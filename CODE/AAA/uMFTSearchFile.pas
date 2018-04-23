unit uMFTSearchFile;

interface

uses Windows, System.Classes, Generics.Collections;

{ 获取磁盘所有文件列表 }
function GetLogicalDiskAllFiles(const chrLogiclDiskName: Char; var FileList: TStringList; const bSort: Boolean = False): Boolean;

implementation

type
  PFileInfo = ^TFileInfo;

  TFileInfo = record
    strFileName: String;               // 文件名称
    FileReferenceNumber: UInt64;       // 文件的ID
    ParentFileReferenceNumber: UInt64; // 文件的父ID
  end;

const
  PARTITION_IFS          = $07;
  BUF_LEN                = 500 * 1024;
  USN_DELETE_FLAG_DELETE = $00000001;

type
  PARTITION_INFORMATION = record
    StartingOffset: LARGE_INTEGER;
    PartitionLength: LARGE_INTEGER;
    HiddenSectors: Cardinal;
    PartitionNumber: Cardinal;
    PartitionType: Byte;
    BootIndicator: Boolean;
    RecognizedPartition: Boolean;
    RewritePartition: Boolean;
  end;

  CREATE_USN_JOURNAL_DATA = record
    MaximumSize: UInt64;
    AllocationDelta: UInt64;
  end;

  USN_JOURNAL_DATA = record
    UsnJournalID: UInt64;
    FirstUsn: Int64;
    NextUsn: Int64;
    LowestValidUsn: Int64;
    MaxUsn: Int64;
    MaximumSize: UInt64;
    AllocationDelta: UInt64;
  end;

  MFT_ENUM_DATA = record
    StartFileReferenceNumber: UInt64;
    LowUsn: Int64;
    HighUsn: Int64;
  end;

  PUSN = ^USN;

  USN = record
    RecordLength: Cardinal;
    MajorVersion: Word;
    MinorVersion: Word;
    FileReferenceNumber: UInt64;
    ParentFileReferenceNumber: UInt64;
    USN: Int64;
    TimeStamp: LARGE_INTEGER;
    Reason: Cardinal;
    SourceInfo: Cardinal;
    SecurityId: Cardinal;
    FileAttributes: Cardinal;
    FileNameLength: Word;
    FileNameOffset: Word;
    FileName: PWideChar;
  end;

  DELETE_USN_JOURNAL_DATA = record
    UsnJournalID: UInt64;
    DeleteFlags: Cardinal;
  end;

const
  c_UInt64Root = 1407374883553285;

{ TStringList 按数值排序 }
function MySort(List: TStringList; Index1, Index2: Integer): Integer;
var
  Int64A, Int64B: Int64;
begin
  Int64A := PFileInfo(List.Objects[Index1])^.FileReferenceNumber;
  Int64B := PFileInfo(List.Objects[Index2])^.FileReferenceNumber;
  if Int64A < Int64B then
    Result := -1
  else if Int64A = Int64B then
    Result := 0
  else
    Result := 1;
end;

{ 简化的 MOVE 函数，也可以用 MOVE 函数来替代 }
procedure MyMove(const Source; var Dest; Count: NativeInt); assembler;
asm
  FILD    QWORD PTR [EAX]
  FISTP   QWORD PTR [EDX]
end;

procedure GetFullFileName(var FileList: TStringList; const chrLogiclDiskName: Char; const bSort: Boolean = False);
var
  UInt64List: TArray<UInt64>;
  III       : Integer;
  UPID      : UInt64;
  intIndex  : Integer;
begin
  { 将 FileList 按 FileReferenceNumber 数值排序 }
  FileList.Sorted := False;
  FileList.CustomSort(MySort);

  { 将排序好的 FileReferenceNumber 复制到 UInt64 数组列表中，便于下面进行快速查找 <BinarySearch 为高效的折半查找> }
  SetLength(UInt64List, FileList.Count);
  for III := 0 to FileList.Count - 1 do
  begin
    UInt64List[III] := PFileInfo(FileList.Objects[III])^.FileReferenceNumber;
  end;

  { 获取每一个文件全路径名称 }
  for III := 0 to FileList.Count - 1 do
  begin
    UPID := PFileInfo(FileList.Objects[III])^.ParentFileReferenceNumber;
    while TArray.BinarySearch(UInt64List, UPID, intIndex) do
    begin
      UPID                  := PFileInfo(FileList.Objects[intIndex])^.ParentFileReferenceNumber;
      FileList.Strings[III] := String(PFileInfo(FileList.Objects[intIndex])^.strFileName) + '\' + FileList.Strings[III];
    end;
    FileList.Strings[III] := (chrLogiclDiskName + ':\' + FileList.Strings[III]);
  end;

  { 将所有文件按文件名排序 }
  if bSort then
    FileList.Sort;
end;

{ 获取磁盘所有文件列表 }
function GetLogicalDiskAllFiles(const chrLogiclDiskName: Char; var FileList: TStringList; const bSort: Boolean = False): Boolean;
var
  Info       : PARTITION_INFORMATION;
  bStatus    : Boolean;
  hRootHandle: THandle;
  hTempHandle: Cardinal;
  cujd       : CREATE_USN_JOURNAL_DATA;
  ujd        : USN_JOURNAL_DATA;
  med        : MFT_ENUM_DATA;
  dujd       : DELETE_USN_JOURNAL_DATA;
  dwRet      : DWORD;
  Buffer     : array [0 .. BUF_LEN - 1] of Char;
  UsnRecord  : PUSN;
  strFileName: String;
  int64Size  : Integer;
  pfi        : PFileInfo;

begin
  Result := False;

  { 打开磁盘 需要管理员权限 }
  hTempHandle := 0;
  hRootHandle := CreateFile(PChar('\\.\' + chrLogiclDiskName + ':'), GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_ATTRIBUTE_READONLY, hTempHandle);
  if hRootHandle = INVALID_HANDLE_VALUE then
    Exit;

  try
    { 是否是NTFS磁盘格式 }
    if not DeviceIoControl(hRootHandle, IOCTL_DISK_GET_PARTITION_INFO, nil, 0, @Info, Sizeof(Info), dwRet, nil) then
      Exit;

    if not Info.RecognizedPartition then
      Exit;

    if Info.PartitionType <> PARTITION_IFS then
      Exit;

    { 初始化USN日志文件 }
    bStatus := DeviceIoControl(hRootHandle, FSCTL_CREATE_USN_JOURNAL, @cujd, Sizeof(cujd), nil, 0, dwRet, nil);
    if not bStatus then
      Exit;

    { 获取USN日志基本信息 }
    bStatus := DeviceIoControl(hRootHandle, FSCTL_QUERY_USN_JOURNAL, nil, 0, @ujd, Sizeof(ujd), dwRet, nil);
    if not bStatus then
      Exit;

    { 枚举USN日志文件中的所有记录 }
    med.StartFileReferenceNumber := 0;
    med.LowUsn                   := 0;
    med.HighUsn                  := ujd.NextUsn;
    int64Size                    := Sizeof(Int64);
    while DeviceIoControl(hRootHandle, FSCTL_ENUM_USN_DATA, @med, Sizeof(med), @Buffer, BUF_LEN, dwRet, nil) do
    begin
      { 找到第一个 USN 记录 }
      UsnRecord := PUSN(Integer(@(Buffer)) + int64Size);
      while dwRet > 60 do
      begin
        { 获取文件名称 }
        strFileName := PWideChar(Integer(UsnRecord) + UsnRecord^.FileNameOffset);
        strFileName := Copy(strFileName, 1, UsnRecord^.FileNameLength div 2);

        { 将文件信息添加到列表中 }
        pfi                            := AllocMem(Sizeof(TFileInfo));
        pfi^.strFileName               := strFileName;
        pfi^.FileReferenceNumber       := UsnRecord^.FileReferenceNumber;
        pfi^.ParentFileReferenceNumber := UsnRecord^.ParentFileReferenceNumber;
        FileList.AddObject(strFileName, TObject(pfi));

        { 获取下一个 USN 记录 }
        if UsnRecord.RecordLength > 0 then
          Dec(dwRet, UsnRecord.RecordLength)
        else
          Break;
        UsnRecord := PUSN(Cardinal(UsnRecord) + UsnRecord.RecordLength);
      end;
      MyMove(Buffer, med, int64Size);
    end;

    { 获取文件全路径，包含路径和文件名 }
    GetFullFileName(FileList, chrLogiclDiskName, bSort);

    { 删除USN日志文件信息 }
    dujd.UsnJournalID := ujd.UsnJournalID;
    dujd.DeleteFlags  := USN_DELETE_FLAG_DELETE;
    DeviceIoControl(hRootHandle, FSCTL_DELETE_USN_JOURNAL, @dujd, Sizeof(dujd), nil, 0, dwRet, nil);
  finally
    CloseHandle(hRootHandle);
  end;
end;

end.

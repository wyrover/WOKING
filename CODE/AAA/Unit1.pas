unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.IniFiles, Generics.Collections,
  Vcl.StdCtrls, System.StrUtils;

type
  TForm1 = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ 获取磁盘所有文件列表 }
function GetLogicalDiskAllFiles(const chrLogiclDiskName: Char; var FileList: TStringlist): Boolean;
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

  TFileInfo = record
    strFileName: ShortString;
    FileAttributes: Cardinal;
    FileReferenceNumber: UInt64;
    ParentFileReferenceNumber: UInt64;
  end;

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
  // Queue      : TQueue<TFileInfo>;
  // fi         : TFileInfo;
  intInt64: Integer;
  hsl     : THashedStringList;

  { 获取文件全路径，包含路径和文件名 }
  procedure GetFileFullPathName;
  var
    III     : Integer;
    intIndex: Integer;
  begin
    hsl.Sort;
    hsl.SaveToFile('e:\sort.txt');
    for III := 0 to hsl.Count - 1 do
    begin
      intIndex := III;
      repeat
        intIndex := hsl.IndexOfName(hsl.ValueFromIndex[intIndex]);
      until intIndex = -1;
    end;
  end;

{ 优化的 MOVE 函数，也可以直接用 MOVE 函数 }
  procedure MyMove(const Source; var Dest; Count: NativeInt); assembler;
  asm
    FILD    QWORD PTR [EAX]
    FISTP   QWORD PTR [EDX]
  end;

  begin
    Result := False;

    { 打开磁盘 }
    hTempHandle := 0;
    hRootHandle := CreateFile(PChar('\\.\' + chrLogiclDiskName + ':'), GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_ATTRIBUTE_READONLY, hTempHandle); // 需要管理员权限
    if hRootHandle = INVALID_HANDLE_VALUE then
      Exit;

    // Queue := TQueue<TFileInfo>.Create;
    hsl := THashedStringList.Create;
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
      intInt64                     := Sizeof(Int64);
      while DeviceIoControl(hRootHandle, FSCTL_ENUM_USN_DATA, @med, Sizeof(med), @Buffer, BUF_LEN, dwRet, nil) do
      begin
        { 找到第一个 USN 记录 }
        UsnRecord := PUSN(Integer(@(Buffer)) + intInt64);
        while dwRet > 60 do
        begin
          { 获取文件名称 }
          strFileName := PWideChar(Integer(UsnRecord) + UsnRecord^.FileNameOffset);
          strFileName := Copy(strFileName, 1, UsnRecord^.FileNameLength div 2);
          FileList.Add(strFileName);

          { 添加此结构， 是为了寻找此文件的路径 }
          // fi.strFileName               := ShortString(strFileName);
          // fi.FileAttributes            := UsnRecord^.FileAttributes;
          // fi.FileReferenceNumber       := UsnRecord^.FileReferenceNumber;
          // fi.ParentFileReferenceNumber := UsnRecord^.ParentFileReferenceNumber;
          // Queue.Enqueue(fi);
          hsl.Add(IntToStr(UsnRecord^.FileReferenceNumber) + '=' + IntToStr(UsnRecord^.ParentFileReferenceNumber));

          { 获取下一个 USN 记录 }
          if UsnRecord.RecordLength > 0 then
            Dec(dwRet, UsnRecord.RecordLength)
          else
            Break;
          UsnRecord := PUSN(Cardinal(UsnRecord) + UsnRecord.RecordLength);
        end;
        MyMove(Buffer, med, intInt64);
      end;

      { 获取文件全路径，包含路径和文件名 }
      GetFileFullPathName;

      { 删除USN日志文件信息 }
      dujd.UsnJournalID := ujd.UsnJournalID;
      dujd.DeleteFlags  := USN_DELETE_FLAG_DELETE;
      DeviceIoControl(hRootHandle, FSCTL_DELETE_USN_JOURNAL, @dujd, Sizeof(dujd), nil, 0, dwRet, nil);
    finally
      // Queue.Free;
      hsl.Free;
      CloseHandle(hRootHandle);
    end;
  end;

procedure TForm1.btn1Click(Sender: TObject);
var
  FileList    : TStringlist;
  intST, intET: Cardinal;
begin
  FileList := TStringlist.Create;
  try
    intST := GetTickCount;
    GetLogicalDiskAllFiles('C', FileList);
    intET := GetTickCount;
    ShowMessage(Format('C:\ 盘共计文件和文件夹： %d 个。用时： %0.2f 秒', [FileList.Count, (intET - intST) / 1000]));
    FileList.SaveToFile('E:\temp.txt');
  finally
    FileList.Free;
  end;
end;

end.

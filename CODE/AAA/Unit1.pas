﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.IniFiles, Generics.Collections,
  Vcl.StdCtrls, System.StrUtils, System.Math, System.DateUtils;

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

type
  PFileInfo = ^TFileInfo;

  TFileInfo = record
    strFileName: ShortString;
    bDirectory: Boolean;
    FileDateTime: TDateTime;
    FileSize: Cardinal;
    FileReason: Cardinal;
    FileReferenceNumber: UInt64;
    ParentFileReferenceNumber: UInt64;
  end;

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

{ 获取磁盘所有文件列表 }
function GetLogicalDiskAllFiles(const chrLogiclDiskName: Char; var FileList: TStringList): Boolean;
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
  pPath      : PFileInfo;

  procedure MyMove(const Source; var Dest; Count: NativeInt); assembler;
  asm
    FILD    QWORD PTR [EAX]
    FISTP   QWORD PTR [EDX]
  end;

  { 获取文件全路径，包含路径和文件名 }
  procedure GetFileFullPathName;
  var
    III     : Integer;
    strList : TStringList;
    UPID    : UInt64;
    intIndex: Integer;
  begin
    FileList.Sorted := False;
    FileList.CustomSort(MySort);
    strList := TStringList.Create;
    try
      for III := 0 to FileList.Count - 1 do
      begin
        strList.Add(UIntToStr(PFileInfo(FileList.Objects[III])^.FileReferenceNumber));
      end;

      for III := 0 to FileList.Count - 1 do
      begin
        UPID := PFileInfo(FileList.Objects[III])^.ParentFileReferenceNumber;
        while strList.Find(UIntToStr(UPID), intIndex) do
        begin
          UPID                  := PFileInfo(FileList.Objects[intIndex])^.ParentFileReferenceNumber;
          FileList.Strings[III] := String(PFileInfo(FileList.Objects[intIndex])^.strFileName) + '\' + FileList.Strings[III];
        end;
        FileList.Strings[III] := chrLogiclDiskName + ':\' + FileList.Strings[III];
      end;
    finally
      strList.Free;
    end;
  end;

begin
  Result := False;

  { 打开磁盘 }
  hTempHandle := 0;
  hRootHandle := CreateFile(PChar('\\.\' + chrLogiclDiskName + ':'), GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_ATTRIBUTE_READONLY, hTempHandle); // 需要管理员权限
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

        { 将文件信息添加到列表 }
        pPath                            := AllocMem(Sizeof(TFileInfo));
        pPath^.strFileName               := ShortString(strFileName);
        pPath^.bDirectory                := (PCardinal(Integer(UsnRecord) + 52)^) and faDirectory = 16;
        pPath^.FileReason                := PCardinal(Integer(UsnRecord) + 40)^;
        pPath^.FileDateTime              := Pint64(Integer(UsnRecord) + 32)^ / 3600 + 25569;
        pPath^.FileReferenceNumber       := UsnRecord^.FileReferenceNumber;
        pPath^.ParentFileReferenceNumber := UsnRecord^.ParentFileReferenceNumber;
        FileList.AddObject(string(pPath^.strFileName), TObject(pPath));

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
    GetFileFullPathName;

    { 按文件名排序 }
    FileList.CaseSensitive := True;
    FileList.Sort;

    { 删除USN日志文件信息 }
    dujd.UsnJournalID := ujd.UsnJournalID;
    dujd.DeleteFlags  := USN_DELETE_FLAG_DELETE;
    DeviceIoControl(hRootHandle, FSCTL_DELETE_USN_JOURNAL, @dujd, Sizeof(dujd), nil, 0, dwRet, nil);
  finally
    CloseHandle(hRootHandle);
  end;
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  FileList    : TStringList;
  intST, intET: Cardinal;
begin
  FileList     := TStringList.Create;
  btn1.Enabled := False;
  try
    intST := GetTickCount;
    GetLogicalDiskAllFiles('C', FileList);
    intET := GetTickCount;
    ShowMessage(Format('文件和文件夹合计： %d 个； 搜索用时： %0.2f 秒', [FileList.Count, (intET - intST) / 1000]));
    FileList.SaveToFile('E:\AAA.txt');
  finally
    btn1.Enabled := True;
    FileList.Free;
  end;
end;

end.

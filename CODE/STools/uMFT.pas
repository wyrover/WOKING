{
  ** uMFT.pas
  ** zm
  ** created: 13.11.2010
  **
  *  Copyright (c) 2010, Zeljko Marjanovic <savethem4ever@gmail.com>
  *  This code is licensed under MPL 1.1
  *  For details, see http://www.mozilla.org/MPL/MPL-1.1.html
  *
}

unit uMFT;

interface

uses
  Windows, SysUtils, Dialogs;

const
  FILE_DEVICE_FILE_SYSTEM = $00000009;
  METHOD_NEITHER          = 3;
  METHOD_BUFFERED         = 0;
  FILE_ANY_ACCESS         = 0;
  FILE_SPECIAL_ACCESS     = 0;
  FILE_READ_ACCESS        = 1;
  FILE_WRITE_ACCESS       = 2;

  ERROR_JOURNAL_DELETE_IN_PROGRESS = 1178;
  ERROR_JOURNAL_NOT_ACTIVE         = 1179;
  ERROR_JOURNAL_ENTRY_DELETED      = 1181;

  FSCTL_GET_OBJECT_ID      = $9009C;
  FSCTL_ENUM_USN_DATA      = (FILE_DEVICE_FILE_SYSTEM shl 16) or (FILE_ANY_ACCESS shl 14) or (44 shl 2) or METHOD_NEITHER;
  FSCTL_READ_USN_JOURNAL   = (FILE_DEVICE_FILE_SYSTEM shl 16) or (FILE_ANY_ACCESS shl 14) or (46 shl 2) or METHOD_NEITHER;
  FSCTL_CREATE_USN_JOURNAL = (FILE_DEVICE_FILE_SYSTEM shl 16) or (FILE_ANY_ACCESS shl 14) or (57 shl 2) or METHOD_NEITHER;
  FSCTL_QUERY_USN_JOURNAL  = (FILE_DEVICE_FILE_SYSTEM shl 16) or (FILE_ANY_ACCESS shl 14) or (61 shl 2) or METHOD_BUFFERED;
  FSCTL_DELETE_USN_JOURNAL = (FILE_DEVICE_FILE_SYSTEM shl 16) or (FILE_ANY_ACCESS shl 14) or (62 shl 2) or METHOD_BUFFERED;

  USN_PAGE_SIZE                    = $1000;
  USN_REASON_DATA_OVERWRITE        = $00000001;
  USN_REASON_DATA_EXTEND           = $00000002;
  USN_REASON_DATA_TRUNCATION       = $00000004;
  USN_REASON_NAMED_DATA_OVERWRITE  = $00000010;
  USN_REASON_NAMED_DATA_EXTEND     = $00000020;
  USN_REASON_NAMED_DATA_TRUNCATION = $00000040;
  USN_REASON_FILE_CREATE           = $00000100;
  USN_REASON_FILE_DELETE           = $00000200;
  USN_REASON_EA_CHANGE             = $00000400;
  USN_REASON_SECURITY_CHANGE       = $00000800;
  USN_REASON_RENAME_OLD_NAME       = $00001000;
  USN_REASON_RENAME_NEW_NAME       = $00002000;
  USN_REASON_INDEXABLE_CHANGE      = $00004000;
  USN_REASON_BASIC_INFO_CHANGE     = $00008000;
  USN_REASON_HARD_LINK_CHANGE      = $00010000;
  USN_REASON_COMPRESSION_CHANGE    = $00020000;
  USN_REASON_ENCRYPTION_CHANGE     = $00040000;
  USN_REASON_OBJECT_ID_CHANGE      = $00080000;
  USN_REASON_REPARSE_POINT_CHANGE  = $00100000;
  USN_REASON_STREAM_CHANGE         = $00200000;
  USN_REASON_CLOSE                 = $80000000;

  USN_DELETE_FLAG_DELETE = $00000001;
  USN_DELETE_FLAG_NOTIFY = $00000002;
  USN_DELETE_VALID_FLAGS = $00000003;

  USNREC_MAJVER_OFFSET    = 4;
  USNREC_MINVER_OFFSET    = 8;
  USNREC_FR_OFFSET        = 8;
  USNREC_PFR_OFFSET       = 16;
  USNREC_USN_OFFSET       = 24;
  USNREC_TIMESTAMP_OFFSET = 32;
  USNREC_REASON_OFFSET    = 40;
  USNREC_SINFO_OFFSET     = 44;
  USNREC_SECID_OFFSET     = 48;
  USNREC_FA_OFFSET        = 52;
  USNREC_FNL_OFFSET       = 56;
  USNREC_FN_OFFSET        = 58;

  IOCTL_DISK_BASE               = $00000007;
  IOCTL_DISK_GET_PARTITION_INFO = (IOCTL_DISK_BASE shl 16) or (FILE_READ_ACCESS shl 14) or ($0001 shl 2) or METHOD_BUFFERED;
  PARTITION_IFS                 = $07;

type
  USN_JOURNAL_DATA = record
    UsnJournalID: UInt64;
    FirstUsn: Int64;
    NextUsn: Int64;
    LowestValidUsn: Int64;
    MaxUsn: Int64;
    MaximumSize: UInt64;
    AllocationDelta: UInt64;
  end;

  TUSNJournalData = USN_JOURNAL_DATA;
  PUSNJournalData = ^TUSNJournalData;

  MFT_ENUM_DATA = record
    StartFileReferenceNumber: UInt64;
    LowUsn: Int64;
    HighUsn: Int64;
  end;

  TMFTEnumData = MFT_ENUM_DATA;
  PMFTEnumData = ^TMFTEnumData;

  CREATE_USN_JOURNAL_DATA = record
    MaximumSize: UInt64;
    AllocationDelta: UInt64;
  end;

  TCreateUSNJournalData = CREATE_USN_JOURNAL_DATA;
  PCreateUSNJournalData = ^TCreateUSNJournalData;

  READ_USN_JOURNAL_DATA = record
    StartUsn: Int64;
    ReasonMask: Cardinal;
    ReturnOnlyOnClose: Cardinal;
    Timeout: UInt64;
    BytesToWaitFor: UInt64;
    UsnJournalID: UInt64;
  end;

  TReadUSNJournalData = READ_USN_JOURNAL_DATA;
  PReadUSNJournalData = ^TReadUSNJournalData;

  DELETE_USN_JOURNAL_DATA = record
    UsnJournalID: UInt64;
    DeleteFlags: Cardinal;
  end;

  TDeleteUSNJournalData = DELETE_USN_JOURNAL_DATA;
  PDeleteUSNJournalData = ^TDeleteUSNJournalData;

  USN_RECORD = record
    RecordLength: Cardinal;
    MajorVersion: Word;
    MinorVersion: Word;
    FileReferenceNumber: UInt64;
    ParentFileReferenceNumber: UInt64;
    Usn: Int64;
    TimeStamp: LARGE_INTEGER;
    Reason: Cardinal;
    SourceInfo: Cardinal;
    SecurityId: Cardinal;
    FileAttributes: Cardinal;
    FileNameLength: Word;
    FileNameOffset: Word;
    FileName: PWChar;
  end;

  TUSNRecord = USN_RECORD;
  PUSNRecord = ^TUSNRecord;

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

  TPartitionInformation = PARTITION_INFORMATION;
  PPartitionInformation = ^TPartitionInformation;

  TMFTEnumCallback = function(AUSN: PUSNRecord; Extra: Pointer = nil): Boolean of object;
  PUInt64          = ^UInt64;
  EMFTException    = class(Exception);

  TChangeJournalState = (cjsInitializing, csjIndexing, csjIdle, csjMonitoring, csjErrorsOccured);
  TUSNRecChangeType   = (uceNew, uceDeleted, uceRenamed);
  TUSNRecChangeEvt    = procedure(AUSN: PUSNRecord; AChangeType: TUSNRecChangeType) of object;

function USNRecFromPointer(const P: Pointer): TUSNRecord;
function GetRootFRN(const Drive: Char): UInt64;
function GetRootHandle(const Drive: Char; ASync: Boolean = False; NeedWriteAccess: Boolean = False): Cardinal;
function CreateUSNJournal(ARootHandle: Cardinal; MaxSize, AllocationDelta: UInt64): Boolean;
function DeleteUSNJournal(ARootHandle: Cardinal; UsnJournalID: UInt64; DeleteFlags: Cardinal): Boolean;
function QueryUSNJournal(ARootHandle: Cardinal; var UsnJournalData: TUSNJournalData): Boolean;
function AllocMFTEnumBuffer(ARootHandle: Cardinal): Pointer;
procedure AdjustChangeJournal(ARootHandle: Cardinal);
function EnumMFTEntries(ARootHandle: Cardinal; AMFTEnumBuff: Pointer; EnumCallBack: TMFTEnumCallback; Extra: Pointer = nil): Boolean;
function GetNameFromRec(AUSN: PUSNRecord; UseOffset: Boolean): WideString;
function IsPartitionNTFS(const Drive: Char): Boolean;

implementation

function USNRecFromPointer(const P: Pointer): TUSNRecord;
var
  PA: PAnsiChar;
begin
  PA                               := PAnsiChar(P);
  Result.RecordLength              := PInteger(PA)^;
  Result.MajorVersion              := PInteger(PA + USNREC_MAJVER_OFFSET)^;
  Result.MinorVersion              := PInteger(PA + USNREC_MINVER_OFFSET)^;
  Result.FileReferenceNumber       := PUInt64(PA + USNREC_FR_OFFSET)^;
  Result.ParentFileReferenceNumber := PUInt64(PA + USNREC_PFR_OFFSET)^;
  Result.Usn                       := PInt64(PA + USNREC_USN_OFFSET)^;
  Result.TimeStamp.QuadPart        := PInt64(PA + USNREC_TIMESTAMP_OFFSET)^;
  Result.Reason                    := PCardinal(PA + USNREC_REASON_OFFSET)^;
  Result.SourceInfo                := PCardinal(PA + USNREC_SINFO_OFFSET)^;
  Result.SecurityId                := PCardinal(PA + USNREC_SECID_OFFSET)^;
  Result.FileAttributes            := PCardinal(PA + USNREC_FA_OFFSET)^;
  Result.FileNameLength            := PWord(PA + USNREC_FNL_OFFSET)^;
  Result.FileNameOffset            := PWord(PA + USNREC_FN_OFFSET)^;
  Result.FileName                  := PWChar(Integer(P) + Result.FileNameOffset);
end;

function GetRootFRN(const Drive: Char): UInt64;
var
  W         : WideString;
  RootHandle: Cardinal;
  FileInfo  : TByHandleFileInformation;
begin
  W          := '\\.\' + Drive + ':\';
  RootHandle := CreateFileW(PWChar(W), 0, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, 0);
  if RootHandle <> INVALID_HANDLE_VALUE then
  begin
    if GetFileInformationByHandle(RootHandle, FileInfo) then
      Result := (UInt64(FileInfo.nFileIndexHigh) shl 32) or FileInfo.nFileIndexLow
    else
      raise EMFTException.Create(SysErrorMessage(GetLastError));
  end
  else
    raise EMFTException.Create(SysErrorMessage(GetLastError));
end;

{ this requires admin privileges }
function GetRootHandle(const Drive: Char; ASync: Boolean; NeedWriteAccess: Boolean): Cardinal;
var
  W         : WideString;
  RootHandle: Cardinal;
  Flags     : Cardinal;
  Access    : Cardinal;
begin
  Flags := 0;
  if ASync then
    Flags := FILE_FLAG_OVERLAPPED;
  W       := '\\.\' + Drive + ':';
  Access  := GENERIC_READ;
  if NeedWriteAccess then
    Access   := Access or GENERIC_WRITE;
  RootHandle := CreateFileW(PWChar(W), Access, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, Flags, 0);
  if RootHandle <> INVALID_HANDLE_VALUE then
    Result := RootHandle
  else
    raise EMFTException.Create(SysErrorMessage(GetLastError));
end;

function CreateUSNJournal(ARootHandle: Cardinal; MaxSize, AllocationDelta: UInt64): Boolean;
var
  BytesRet  : Cardinal;
  CreateData: TCreateUSNJournalData;
begin
  CreateData.MaximumSize     := MaxSize;
  CreateData.AllocationDelta := AllocationDelta;
  Result                     := DeviceIoControl(ARootHandle, FSCTL_CREATE_USN_JOURNAL, @CreateData, sizeof(TCreateUSNJournalData), nil, 0, BytesRet, nil);
end;

function DeleteUSNJournal(ARootHandle: Cardinal; UsnJournalID: UInt64; DeleteFlags: Cardinal): Boolean;
var
  DeleteData: TDeleteUSNJournalData;
  BytesRet  : Cardinal;
begin
  DeleteData.UsnJournalID := UsnJournalID;
  DeleteData.DeleteFlags  := DeleteFlags;
  Result                  := DeviceIoControl(ARootHandle, FSCTL_DELETE_USN_JOURNAL, @DeleteData, sizeof(TDeleteUSNJournalData), nil, 0, BytesRet, nil);
end;

function QueryUSNJournal(ARootHandle: Cardinal; var UsnJournalData: TUSNJournalData): Boolean;
var
  BytesRet: Cardinal;
begin
  Result := DeviceIoControl(ARootHandle, FSCTL_QUERY_USN_JOURNAL, nil, 0, @UsnJournalData, sizeof(TUSNJournalData), BytesRet, nil);
end;

function AllocMFTEnumBuffer(ARootHandle: Cardinal): Pointer;
var
  USNBuf  : TUSNJournalData;
  BytesRet: Cardinal;
  EnumBuf : PMFTEnumData;
begin
  if DeviceIoControl(ARootHandle, FSCTL_QUERY_USN_JOURNAL, nil, 0, @USNBuf, sizeof(TUSNJournalData), BytesRet, nil) then
  begin
    GetMem(EnumBuf, sizeof(TMFTEnumData));
    EnumBuf.StartFileReferenceNumber := 0;
    EnumBuf.LowUsn                   := 0;
    EnumBuf.HighUsn                  := USNBuf.NextUsn;
    Result                           := EnumBuf;
  end
  else
    raise EMFTException.Create(SysErrorMessage(GetLastError));
end;

procedure AdjustChangeJournal(ARootHandle: Cardinal);
begin
  if not CreateUSNJournal(ARootHandle, $10000000, $100000) then
    raise EMFTException.Create(SysErrorMessage(GetLastError));
end;

function EnumMFTEntries(ARootHandle: Cardinal; AMFTEnumBuff: Pointer; EnumCallBack: TMFTEnumCallback; Extra: Pointer): Boolean;
const
  BUF_SIZE = sizeof(UInt64) + $10000;
var
  P       : Pointer;
  MFTEnum : Pointer;
  BytesRet: Cardinal;
  PUSN    : PUSNRecord;
begin
  Result := False;
  if (ARootHandle = INVALID_HANDLE_VALUE) or (AMFTEnumBuff = nil) then
    Exit;

  MFTEnum := AMFTEnumBuff;
  GetMem(P, BUF_SIZE);
  try
    ZeroMemory(P, BUF_SIZE);
    while DeviceIoControl(ARootHandle, FSCTL_ENUM_USN_DATA, MFTEnum, sizeof(TMFTEnumData), P, BUF_SIZE, BytesRet, nil) do
    begin
      PUSN := PUSNRecord(Integer(P) + sizeof(Int64));
      while BytesRet > 60 do
      begin
        if not EnumCallBack(PUSN, Extra) then
          Exit;

        if PUSN.RecordLength > 0 then
          Dec(BytesRet, PUSN.RecordLength)
        else
          break;
        PUSN := PUSNRecord(Cardinal(PUSN) + PUSN.RecordLength);
      end;
      CopyMemory(MFTEnum, P, sizeof(Int64));
    end;
    Result := True;
  finally
    FreeMem(P);
  end;
end;

function GetNameFromRec(AUSN: PUSNRecord; UseOffset: Boolean): WideString;
begin
  Result := '';
  if Assigned(AUSN) then
  begin
    SetLength(Result, AUSN.FileNameLength div sizeof(WChar));
    if not UseOffset then
      CopyMemory(@Result[1], AUSN.FileName, AUSN.FileNameLength)
    else
      CopyMemory(@Result[1], Pointer(Integer(AUSN) + AUSN.FileNameOffset), AUSN.FileNameLength);
  end;
end;

function IsPartitionNTFS(const Drive: Char): Boolean;
var
  Handle  : Cardinal;
  BytesRet: Cardinal;
  Info    : TPartitionInformation;
begin
  Result := False;

  try
    Handle := GetRootHandle(Drive);
  except
    Exit;
  end;

  if Handle <> INVALID_HANDLE_VALUE then
  begin
    if DeviceIoControl(Handle, IOCTL_DISK_GET_PARTITION_INFO, nil, 0, @Info, sizeof(TPartitionInformation), BytesRet, nil) then
    begin
      if Info.RecognizedPartition then
        Result := Info.PartitionType = PARTITION_IFS;
    end;
    CloseHandle(Handle);
  end;
end;

end.

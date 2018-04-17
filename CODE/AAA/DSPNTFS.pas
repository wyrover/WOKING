unit DSPNTFS; 

interface 

uses 
  Windows, SysUtils, Classes; 

resourcestring 
  SCantOpenVolume = 'Can''t open the drive "%s"'; 
  SNotAnNTFSVolume = 'The volume "%s" is not a NTFS Volume, can''t continue..'; 
  SErrorReadingBootSector = 'Error when reading the boot sector on drive "%s"'; 
  SErrorReadingFileRecord = 'Error when reading the file record on drive "%s"'; 
  SReachedMFTEnd = 'Reached the MFT END on the drive "%s"'; 
  SIsNotAValidFileRecord = 'The read record is not a valid File Record'; 

const 
{ BootSector } 
  bsNTFSOEMID: Int64 = $202020205346544E; //= 'NTFS'#20#20#20#20 (Litle Indian) 
  { Media Descriptor } 
  mdHardDisk = $F8; 
  mdFloppyHD35 = $F0; 

  { File Record generals} 
  frDefaultIndentifier = $454C4946;  //= 'FILE' (Litle Indian) 
  frEndMarker: array[0..3]of Byte = ($FF, $FF, $FF, $FF); 

  { File Record Flags } 
  frFlagDeleted = $0000; 
  frFlagInUse = $0001; 
  frFlagDirectory = $0002; 

  {Attribute Types } 
  atSTANDARD_INFORMATION  = $10; 
  atATTRIBUTE_LIST        = $20; 
  atFILE_NAME            = $30; 
  atVOLUME_VERSION        = $40;        //NT 
  atOBJECT_ID            = $40;        //Win2k 
  atSECURITY_DESCRIPTOR  = $50; 
  atVOLUME_NAME          = $60; 
  atVOLUME_INFORMATION    = $70; 
  atDATA                  = $80; 
  atINDEX_ROOT            = $90; 
  atINDEX_ALLOCATION      = $A0; 
  atBITMAP                = $B0; 
  atSYMBOLIC_LINK        = $C0;        //NT 
  atREPARSE_POINT        = $C0;        //Win2k 
  atEA_INFORMATION        = $D0; 
  atEA                    = $E0; 
  atPROPERTY_SET          = $F0;        //NT 
  atLOGGED_UTILITY_STREAM = $100;        //Win2K 

  { Attribute Flags } 
  afCompressed = $0001; 
  afEncrypted  = $4000; 
  afSparse    = $8000; 

  { DOS File Permissons } 
  fpReadOnly          = $0001; 
  fpHidden            = $0002; 
  fpSystem            = $0004; 
  fpArchive          = $0020; 
  fpDevice            = $0040; 
  fpNormal            = $0080; 
  fpTemporary        = $0100; 
  fpSparseFile        = $0200; 
  fpReparsePoint      = $0400; 
  fpCompressed        = $0800; 
  fpOffline          = $1000; 
  fpNotContentIndexed = $2000; 
  fpEncrypted        = $4000; 
  fpDirectory        = $10000000; 
  fpIndexView        = $20000000; 

  { Volume Information attribute Flags } 
  viDirty            = $0001; 
  viResizeLogFile    = $0002; 
  viUpgradeOnMount    = $0004; 
  viMountedOnNT4      = $0008; 
  viDeleteUSNunderway = $0010; 
  viRepairObjectIds  = $0020; 
  viModifiedBychkdsk  = $8000; 

  (* 
  { Index_Root_Header Flags } 
  ihSmallIndex = $00; 
  ihLargeIndex = $01; 
  *) 

{Others} 
  DeviceAccessFolder = '\\.\';          // ex: for drive a: "\\.\PhysicalDrive0" or "\\.\a:", on me,98,95 use "\\.\vwin32" 

type 

  PBootSector = ^TBootSector; 
  TBootSector = packed record 
    JmpInst : array[0..2] of Byte;                      //Jump Instruction 
  OEMID: Int64; 
  BytesPerSector: Word; 
  SectorsPerCluster: Byte; 
    ReservedSectors: Word; 
  Mbz1: Byte;                                        //Always 0 
  Mbz2: Word;                                        //Always 0 
  Reserved1: Word;                                    //not used 
  MediaDescriptor: Byte; 
  Mbz3: Word;                                        //Always 0 
  SectorsPerTrack: Word; 
  NumberOfHeads: Word; 
  HiddenSectors: DWord; 
  Reserved2: DWord;                                  //not used 
  Reserved3: DWord;                                  //not used 
  TotalSectors: Int64; 
  MftLCN: Int64;                                      //Logical Cluster Number for the file $MFT 
  MftMirrLCN: Int64;                                  //Logical Cluster Number for the file $MFTMirr 
  ClustersPerMFTRecord: Byte;                        //Size of each MFT Record 
    Reserved4: array[0..2]of Byte;                      //not used 
  ClustersPerIndexBuffer: Byte;                      //Clusters Per Index Block 
    Reserved5: array[0..2]of Byte;                      //not used 
  VolumeSerialNumber: Int64; 
    Reserved6: DWord;                                  //CheckSum 
  BootStrapCode: array[0..425] of Byte; 
  EndOfSectorMarker: Word; 
  end; 

  //TODO: Review this one (TFile Record) 
  TFileRecordHeader = packed record 
    Identifier: DWORD; 
    UsaOffset : Word; 
    UsaCount : Word; 
    LSN : Int64; 
  SequenceNumber : Word; 
  ReferenceCount : Word; 
  AttributesOffset : Word; 
  Flags : Word; 
  BytesInUse : DWord; 
  BytesAllocated : DWord; 
  BaseFileRecord : Int64; 
  end; 

  TStandardAttributeHeaderStart = packed record 
    AttributeType: DWord; 
    AttributeTotalLength: DWord; 
    NonResident: Boolean; 
    NameLength: Byte;                                  //number of characters 
    NameOffset: Word; 
    AttributeFlags: Word; 
    AttributeId: Word; 
  end; 

  TStandardAttributeHeaderEndR = packed record          //Resident 
    AttributeLength: DWord; 
    AttributeOffset: Word; 
    IndexedFlag: Byte; 
    Padding: Byte; 
    //Attribute Name (not null terminated, Unicode) 
    //Attribute (rounded up to a multiple of 4 Byte) 
  end; 

  TStandardAttributeHeaderEndN = packed record          //Nonresident 
    StartingVCN: Int64; 
    LastVCN: Int64; 
    DataRunsOffset: Word;                              //Rounded up to a multiple of 4 bytes 
    CompressionUnitSize: Word;                          //Compression unit size = 2^x clusters. 0 implies uncompressed 
    Padding: Cardinal; 
    AttributeAllocatedSize: Int64;                      //Allocated size of the attribute, rounded up to the cluster size 
    AttributeRealSize: Int64;                          //Real size of the attribute 
    InitializedDataSize: Int64;                        //Initialized data size of the stream, When is this not equal to the allocated size? 
    //Attribute Name (not null terminated, Unicode) 
    //DataRuns 
  end; 

  TStandardInformationAttribute = packed record 
    //StandardAttributeHeaderStart 
    //StandardAttributeHeaderEnd 
    CTime: TDateTime;                                  //Creation time 
    ATime: TDateTime;                                  //Altered time 
    MTime: TDateTime;                                  //MFT changed time 
    RTime: TDateTime;                                  //Read Time 
    DosFilePermission: DWord; 
    MaxNumerOfVersions: DWord; 
    VersionNumber: DWord; 
    ClassId: DWord; 
    //these ones are only used in Win2K 
    OwnerId: DWord; 
    SecurityId: DWord; 
    QuotaCharged: Int64; 
    UpdateSequenceNumber: Int64; 
  end; 

  TAttributeListAttribute = packed record 
    //StandardAttributeHeaderStart 
    //StandardAttributeHeaderEnd 
    AttributeType: DWord; 
    RecordLength: Word; 
    NameLength: Byte; 
    NameOffset: Byte; 
    StartingVCN: Int64; 
    BaseFileRef: Int64;                                //Base File Reference of the attribute 
    AttributeId: Word; 
    //Name (not null terminated, Unicode) 
  end; 

  TFilenameAttribute = packed record 
    //StandardAttributeHeaderStart 
    //StandardAttributeHeaderEnd 
    ParentDirRef: Int64;                                //File reference to the parent directory. 
    CTime: TDateTime;                                  //Creation time 
    ATime: TDateTime;                                  //Altered time 
    MTime: TDateTime;                                  //MFT changed time 
    RTime: TDateTime;                                  //Read Time 
    FileAllocatedSize: Int64; 
    FileRealSize: Int64; 
    Flags: DWord; 
    EAReparse: DWord;                                  //Used by Extanded Atributes and Reparse 
    FilenameLength: Byte;                              //Filename length in characters (L) 
    FilenameNamespace: Byte; 
    //File name in Unicode (not null terminated) 
  end; 

  TObjectIdAttribute = packed record 
    //StandardAttributeHeaderStart 
    //StandardAttributeHeaderEnd 
    GUIDObjectId: Int64; 
    GUIDBirthVolumeId: Int64; 
    GUIDBirthObjectId: Int64; 
    GUIDDomainId: Int64; 
  end; 

  TVolumeNameAttribute = packed record 
    //StandardAttributeHeaderStart 
    //StandardAttributeHeaderEnd 
    //VolumeName (not null terminated, Unicode), length = AttributeTotalLength / 2 
  end; 

  TVolumeInformationAttribute = packed record 
    //StandardAttributeHeaderStart 
    //StandardAttributeHeaderEnd 
    Mbz1: Int64; 
    MajVersionNumber: Byte; 
    MinVersionNumber: Byte; 
    Flags: Word; 
    Mbz2: DWord; 
  end; 

  TDataAttribute = packed record 
    //StandardAttributeHeaderStart 
    //StandardAttributeHeaderEnd 
    //Datas 
  end; 

  TIndexRootAttribute = packed record 
    //StandardAttributeHeaderStart 
    //StandardAttributeHeaderEnd 
    AttributeType: Cardinal; 
    CollationRule: Cardinal; 
    IndexAllocationEntrySize: Cardinal; 
    ClustersPerIndexRecord: Byte; 
    Padding: array [0..2]of Byte; 
  end; 

  (* 
  TIndexHeaderAttribute = packed record 
    //StandardAttributeHeaderStart 
    //StandardAttributeHeaderEnd 
    OffsetToFirstIndexEntry: Cardinal; 
    TotalSizeOfIndexEntries: Cardinal; 
    AllocatedSizeOfIndexEntries Cardinal; 
    Flags: Byte; 
    Padding: array [0..2]of Byte; 
  end; 
  *) 

  { Classes and others } 
  PDynByteArray = ^TDynByteArray; 
  TDynByteArray = array of Byte; 

  TResidentAttribute = record 
    SI: TStandardInformationAttribute; 

    AL: TAttributeListAttribute; 
    ALN: WideString; 

    FN: TFileNameAttribute; 
    FNFN: WideString; 

    OI: TObjectIdAttribute; 

    VN: TVolumeNameAttribute; 
    VNN: WideString; 

    VI: TVolumeInformationAttribute; 

    D: TDataAttribute; 
    DD: TDynByteArray; 

    IR: TIndexRootAttribute; 
  end; 

  TAttribute = record 
    SAHS: TStandardAttributeHeaderStart; 
    AttributeName: WideString; 

    SAHER: TStandardAttributeHeaderEndR; 
    RA: TResidentAttribute; 

    SAHEN: TStandardAttributeHeaderEndN; 
    DataRuns: TDynByteArray; 
  end; 

  ENTFSVolume = class(Exception); 

  TFileRecord = class(TObject) 
  private 
    FContent: TDynByteArray; 
    FIndex: Integer; 
  public 
    constructor Create; virtual; 
    destructor Destroy; override; 
    function GetAttributeByType(AttributeType: DWord): TAttribute; 
    function GetFileRecordHeader: TFileRecordHeader; 
    function GetNextAttribute: TAttribute; 
    procedure SetContentLength(NewLength: Integer); 
    property Content: TDynByteArray read FContent; 
    property Index: Integer read FIndex write FIndex; 
  end; 

  TNTFSVolume = class(TObject) 
  private 
    FBootSector: PBootSector; 
    FBytesPerCluster: Cardinal; 
    FBytesPerMFTRecord: Cardinal; 
    FMFTEnd: Int64; 
    FMFTStart: Int64; 
    FDrive: Char; 
    FHDevice: Cardinal; 
    procedure GetMftInfos; 
    function GetBootSector: TBootSector; 
  public 
    constructor Create(Drive: Char); virtual; 
    destructor Destroy; override; 
    function GotoMftMirrStart: Int64; 
    function GotoMftStart: Int64; 
    procedure ReadBootSector; 
    procedure ReadRecord(FR: TFileRecord; RecordsToJump: Int64 = 0); overload; 
    function ReadRecord(RecordsToJump: Int64 = 0): TFileRecord; overload; 
    property BootSector: TBootSector read GetBootSector; 
    property BytesPerCluster: Cardinal read FBytesPerCluster; 
    property BytesPerMFTRecord: Cardinal read FBytesPerMFTRecord; 
  end; 

implementation 

{ TFileRecord } 

constructor TFileRecord.Create; 
begin 
  Index := 0; 
end; 

destructor TFileRecord.Destroy; 
begin 
  inherited; 
end; 

procedure TFileRecord.SetContentLength(NewLength: Integer); 
begin 
  if NewLength <> Length(FContent) then 
    SetLength(FContent, NewLength); 
end; 

function TFileRecord.GetAttributeByType(AttributeType: DWord): TAttribute; 
begin 
  if FIndex = 0 then 
    GetFileRecordHeader; 
  repeat 
    Result := GetNextAttribute; 
  until (Result.SAHS.AttributeTotalLength = 0) or (Result.SAHS.AttributeType = AttributeType); 
end; 

function TFileRecord.GetFileRecordHeader: TFileRecordHeader; 
begin 
  CopyMemory(@Result, @FContent[0], SizeOf(TFileRecordHeader)); 
  FIndex := Result.AttributesOffset; 
  if (Result.Identifier <> frDefaultIndentifier) then 
  begin 
    FIndex := MaxInt; 
    raise ENTFSVolume.Create(SIsNotAValidFileRecord); 
  end; 
end; 

function TFileRecord.GetNextAttribute: TAttribute; 
var 
  I: Cardinal; 
begin 
  ZeroMemory(@Result, SizeOf(TAttribute)); 
  if (FIndex >= Length(FContent) - SizeOf(frEndMarker)) or 
    ((FContent[FIndex] = frEndMarker[0]) and (FContent[FIndex + 1] = frEndMarker[1]) and 
    (FContent[FIndex + 2] = frEndMarker[2]) and (FContent[FIndex + 3] = frEndMarker[3])) then 
    Exit; 
  I := FIndex; 
  CopyMemory(@Result.SAHS, @FContent[I], SizeOf(TStandardAttributeHeaderStart)); 
  I := I + SizeOf(TStandardAttributeHeaderStart); 

  SetLength(Result.AttributeName, Result.SAHS.NameLength); 
  if Result.SAHS.NameLength > 0 then 
    CopyMemory(@Result.AttributeName[1], @FContent[Result.SAHS.NameOffset + FIndex], Result.SAHS.NameLength * SizeOf(WideChar)); 

  if Result.SAHS.NonResident = True then 
  begin 
    CopyMemory(@Result.SAHEN, @FContent[I], SizeOf(TStandardAttributeHeaderEndN)); 
    SetLength(Result.DataRuns, (Result.SAHS.AttributeTotalLength - Result.SAHEN.DataRunsOffset) div SizeOf(Result.DataRuns[0])); 
    CopyMemory(@Result.DataRuns[0], @FContent[Result.SAHEN.DataRunsOffset + FIndex], Length(Result.DataRuns) * SizeOf(Result.DataRuns[0])); 
  end 
  else 
  begin 
    CopyMemory(@Result.SAHER, @FContent[I], SizeOf(TStandardAttributeHeaderEndR)); 
    case Result.SAHS.AttributeType of 
      atSTANDARD_INFORMATION: begin 
        CopyMemory(@Result.RA.SI, @FContent[Result.SAHER.AttributeOffset + FIndex],  SizeOf(TStandardInformationAttribute)); 
      end; 

      atATTRIBUTE_LIST: begin 
        CopyMemory(@Result.RA.AL, @FContent[Result.SAHER.AttributeOffset + FIndex],  SizeOf(TAttributeListAttribute)); 
        SetLength(Result.RA.ALN, Result.RA.AL.NameLength); 
        CopyMemory(@Result.RA.ALN[1], @FContent[Result.RA.AL.NameOffset + FIndex], Result.RA.AL.NameLength * SizeOf(WideChar)); 
      end; 

      atFILE_NAME: begin 
        CopyMemory(@Result.RA.FN, @FContent[Result.SAHER.AttributeOffset + FIndex],  SizeOf(TFilenameAttribute)); 
        I := FIndex + Result.SAHER.AttributeOffset + SizeOf(TFilenameAttribute); 
        SetLength(Result.RA.FNFN, Result.RA.FN.FilenameLength); 
        CopyMemory(@Result.RA.FNFN[1], @FContent[I], Result.RA.FN.FilenameLength * SizeOf(WideChar)); 
      end; 

      atOBJECT_ID: begin 
        CopyMemory(@Result.RA.OI, @FContent[Result.SAHER.AttributeOffset + FIndex],  SizeOf(TObjectIdAttribute)); 
      end; 

      atVOLUME_NAME: begin 
        SetLength(Result.RA.VNN, Result.SAHER.AttributeLength div 2); 
        CopyMemory(@Result.RA.VNN[1], @FContent[Result.SAHER.AttributeOffset + FIndex], Result.SAHER.AttributeLength); 
      end; 

      atVOLUME_INFORMATION: begin 
        CopyMemory(@Result.RA.VI, @FContent[Result.SAHER.AttributeOffset + FIndex],  SizeOf(TVolumeInformationAttribute)); 
      end; 

      atDATA: begin 
        SetLength(Result.RA.DD, Result.SAHER.AttributeLength); 
        CopyMemory(@Result.RA.DD[0], @FContent[Result.SAHER.AttributeOffset + FIndex], Result.SAHER.AttributeLength); 
      end; 

      atINDEX_ROOT: begin 
        CopyMemory(@Result.RA.IR, @FContent[Result.SAHER.AttributeOffset + FIndex],  SizeOf(TIndexRootAttribute)); 
      end; 
    end; 
  end; 
  FIndex := FIndex + Integer(Result.SAHS.AttributeTotalLength); 
end; 

{ TNTFSVolume } 

procedure TNTFSVolume.GetMftInfos; 
var 
  FR: TFileRecord; 
  A: TAttribute; 
begin 
  FR := TFileRecord.Create; 
  try 
    ReadRecord(FR); 
    A := FR.GetAttributeByType(atData); 
    FMFTEnd := FMFTStart + (A.SAHEN.LastVCN - A.SAHEN.StartingVCN) * FBytesPerCluster; 
  finally 
    FR.Free; 
  end; 
end; 

function TNTFSVolume.GetBootSector: TBootSector; 
begin 
  Result := FBootSector^; 
end; 

constructor TNTFSVolume.Create(Drive: Char); 
begin 
  FDrive := Drive; 
  New(FBootSector); 
  FHDevice := CreateFile(PChar(DeviceAccessFolder + Drive + DriveDelim), GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE, 
                      nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0); 
  if FHDevice = INVALID_HANDLE_VALUE then 
    raise ENTFSVolume.CreateFmt(SCantOpenVolume, [Drive]); 

  ReadBootSector; 
  GotoMftStart; 
  GetMftInfos; 
  GotoMftStart; 
end; 

destructor TNTFSVolume.Destroy; 
begin 
  if FHDevice <> INVALID_HANDLE_VALUE then 
    CloseHandle(FHDevice); 
  Dispose(FBootSector); 
  inherited; 
end; 

function TNTFSVolume.GotoMftStart: Int64; 
begin 
  Result := FBootSector.MftLCN * FBootSector.SectorsPerCluster * FBootSector.BytesPerSector; 
  FMFTStart := Result; 
  SetFilePointer(FHDevice, Int64Rec(Result).Lo,  @Int64Rec(Result).Hi, FILE_BEGIN); 
end; 

function TNTFSVolume.GotoMftMirrStart: Int64; 
begin 
  Result := FBootSector.MftMirrLCN * FBootSector.SectorsPerCluster * FBootSector.BytesPerSector; 
  FMFTStart := Result; 
  SetFilePointer(FHDevice, Int64Rec(Result).Lo,  @Int64Rec(Result).Hi, FILE_BEGIN); 
end; 

procedure TNTFSVolume.ReadBootSector; 
var 
  dwRead: Cardinal; 
begin 
  ZeroMemory(FBootSector, SizeOf(TBootSector)); 
  SetFilePointer(FHDevice, 0, nil, FILE_BEGIN); 
  ReadFile(FHDevice, FBootSector^, SizeOf(TBootSector), dwRead, nil); 
  if dwRead <> SizeOf(TBootSector) then 
    raise ENTFSVolume.CreateFMT(SErrorReadingBootSector, [FDrive]); 

  if (FBootSector^.OEMID <> bsNTFSOEMID) then 
    raise ENTFSVolume.CreateFMT(SNotAnNTFSVolume, [FDrive]); 
  FBytesPerCluster := FBootSector^.BytesPerSector * FBootSector^.SectorsPerCluster; 
  if (FBootSector^.ClustersPerMFTRecord < $80) then 
      FBytesPerMFTRecord := FBootSector^.ClustersPerMFTRecord * FBytesPerCluster 
  else 
      FBytesPerMFTRecord := 1 shl ($100 - FBootSector^.ClustersPerMFTRecord); 
end; 

procedure TNTFSVolume.ReadRecord(FR: TFileRecord; RecordsToJump: Int64 = 0); 
var 
  dwRead: Cardinal; 
begin 
  if not Assigned(FR) then 
    Exit; 
  if RecordsToJump > 0 then 
  begin 
    RecordsToJump := RecordsToJump * FBytesPerMFTRecord; 
    SetFilePointer(FHDevice, Int64Rec(RecordsToJump).Lo, @Int64Rec(RecordsToJump).Hi, FILE_CURRENT) 
  end; 
  if FMFTEnd > 0 then 
  begin 
    RecordsToJump := 0; 
    Int64Rec(RecordsToJump).Lo := SetFilePointer(FHDevice, Int64Rec(RecordsToJump).Lo, @Int64Rec(RecordsToJump).Hi, FILE_CURRENT); 
    if RecordsToJump >= FMFTEnd then 
      raise ENTFSVolume.CreateFMT(SReachedMFTEnd, [FDrive]); 
  end; 
  FR.SetContentLength(FBytesPerMFTRecord); 
  FR.Index := 0; 
  ReadFile(FHDevice, FR.FContent[0], Length(FR.Content), dwRead, nil); 
  if dwRead <> FBytesPerMFTRecord then 
    raise ENTFSVolume.CreateFMT(SErrorReadingFileRecord, [FDrive]); 
end; 

function TNTFSVolume.ReadRecord(RecordsToJump: Int64 = 0): TFileRecord; 
begin 
  Result := TFileRecord.Create; 
  try 
    ReadRecord(Result, RecordsToJump); 
  except 
    FreeAndNil(Result); 
    raise; 
  end; 
end; 

end. 

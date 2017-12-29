unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    srchbxOpenFile: TSearchBox;
    lbl1: TLabel;
    tvPE: TTreeView;
    mmo1: TMemo;
    procedure srchbxOpenFileInvokeSearch(Sender: TObject);
    procedure tvPEChange(Sender: TObject; Node: TTreeNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FstrFileName          : String;
    FbX64                 : Boolean;
    FintImageFileHeaderPos: Integer;
    FintNumberOfSections  : Integer;
    FimgSectionTable      : array of TImageSectionHeader;
    procedure PEInfo(const strFileName: string);
    procedure ShowSummary;
    procedure ShowImageDosHeader;
    procedure ShowImageDosStub;
    procedure ShowHexData(const intStartPos, Count: Integer);
    procedure ShowImageDosHeaderRecord;
    procedure ShowImageDosHeaderInfo;
    procedure ShowImageFileHeader;
    procedure ShowImageFileHeaderRecord;
    procedure ShowImageSectionTable;
    procedure ShowImageSectionTableRecord(const intStartPos: Integer);
    procedure ShowImageSectionData;
  public
    { Public declarations }
    function RVA2FOA(const intRVA: DWORD; const isth: array of TImageSectionHeader): Integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm1.PEInfo(const strFileName: string);
var
  tnRoot         : TTreeNode;
  tnImageNTHeader: TTreeNode;
begin
  tnRoot := tvPE.Items.Add(nil, ExtractFileName(strFileName));
  tvPE.Items.AddChild(tnRoot, '1 Image Dos Header');
  tvPE.Items.AddChild(tnRoot, '2 Dos Stub');
  tnImageNTHeader := tvPE.Items.AddChild(tnRoot, '3 Image NT Headers');
  tvPE.Items.AddChild(tnImageNTHeader, '3.1 Image Sign');
  tvPE.Items.AddChild(tnImageNTHeader, '3.2 Image File Header');
  tvPE.Items.AddChild(tnImageNTHeader, '3.3 Image Optional Header');
  tvPE.Items.AddChild(tnRoot, '4 Section Table');
  tvPE.Items.AddChild(tnRoot, '5 Section Data');

  tvPE.Items.Item[0].Expand(True);
  tvPE.Items.Item[0].Selected;
  tvPE.SetFocus;
end;

function TForm1.RVA2FOA(const intRVA: DWORD; const isth: array of TImageSectionHeader): Integer;
var
  III         : Integer;
  intVS, intVP: DWORD;
begin
  Result := -1;

  for III := Low(isth) to High(isth) do
  begin
    intVS := isth[III].VirtualAddress;
    intVP := intVS + isth[III].SizeOfRawData;
    if (intRVA >= intVS) and (intRVA <= intVP) then
    begin
      Result := intVS - isth[III].PointerToRawData;
      Break;
    end;
  end;
end;

procedure TForm1.ShowSummary;
var
  hFile         : THandle;
  imgDosHeader  : TImageDosHeader;
  imgNtHeaders32: TImageNtHeaders32;
  imgNtHeaders64: TImageNtHeaders64;
  intFileSize   : Integer;
begin
  hFile := FileOpen(FstrFileName, fmOpenRead or fmShareDenyNone);
  if hFile = INVALID_HANDLE_VALUE then
  begin
    ShowMessage('Open File Error! Check whether the file has been opened');
    Exit;
  end;

  try
    FileRead(hFile, imgDosHeader, SizeOf(TImageDosHeader));
    FintImageFileHeaderPos := imgDosHeader._lfanew;
    intFileSize            := FileSeek(hFile, 0, 2);
    FileSeek(hFile, FintImageFileHeaderPos, 0);
    FileRead(hFile, imgNtHeaders32, SizeOf(TImageNtHeaders));
    FintNumberOfSections := imgNtHeaders32.FileHeader.NumberOfSections;
    FbX64                := imgNtHeaders32.FileHeader.Machine = IMAGE_FILE_MACHINE_AMD64;
    if FbX64 then
      FileRead(hFile, imgNtHeaders64, SizeOf(imgNtHeaders64));

    mmo1.Lines.Add('文件摘要：');
    mmo1.Lines.Add(Format('%s%-10s%s%s', [Chr(9), '文件名称', '：', FstrFileName]));
    mmo1.Lines.Add(Format('%s%-10s%s%d', [Chr(9), '文件大小', '：', intFileSize]));
    mmo1.Lines.Add(Format('%s%-7s%s$%0.8x', [Chr(9), '文件头偏移位置', '：', FintImageFileHeaderPos]));
    mmo1.Lines.Add(Format('%s%-11s%s%s', [Chr(9), 'X64位程序', '：', Ifthen(FbX64, '是', '否')]));
    mmo1.Lines.Add(Format('%s%-10s%s%d', [Chr(9), '节的数量', '：', FintNumberOfSections]));
  finally
    FileClose(hFile);
  end;
end;

function GetLineValue(const intIndex: Integer; Buffer: array of Byte): String;
var
  III        : Integer;
  intStartPos: Integer;
  intStopXPos: Integer;
begin
  intStartPos := (intIndex + 0) * 16;
  intStopXPos := (intIndex + 1) * 16;
  Result      := '';
  for III     := intStartPos to intStopXPos - 1 do
  begin
    Result := Result + Ifthen((Buffer[III] >= 33) and (Buffer[III] <= 126), Chr(Buffer[III]), '.');
  end;
end;

function DisplayString(Buffer: array of Byte; const intStartPos: Integer = 0): String;
var
  III         : Integer;
  JJJ         : Integer;
  StrLineValue: String;
begin
  Result  := '$' + IntToHex(intStartPos, 8) + Chr(9);
  JJJ     := 0;
  for III := Low(Buffer) to High(Buffer) do
  begin
    if III mod 16 <> 15 then
    begin
      Result := Result + IntToHex(Buffer[III], 2) + ' ';
    end
    else
    begin
      Inc(JJJ);
      Result       := Result + IntToHex(Buffer[III], 2) + ' ';
      StrLineValue := GetLineValue(III div 16, Buffer);
      if III = High(Buffer) then
        Result := Result + Chr(9) + StrLineValue
      else
        Result := Result + Chr(9) + StrLineValue + #13#10 + '$' + IntToHex(JJJ * 16 + intStartPos, 8) + Chr(9);
    end;
  end;
end;

procedure TForm1.ShowHexData(const intStartPos, Count: Integer);
var
  hFile  : THandle;
  strTemp: String;
  Buffer : TBytes;
begin
  hFile := FileOpen(FstrFileName, fmOpenRead or fmShareDenyNone);
  if hFile = INVALID_HANDLE_VALUE then
  begin
    ShowMessage('Open File Error! Check whether the file has been opened');
    Exit;
  end;

  try
    SetLength(Buffer, Count);
    FileSeek(hFile, intStartPos, 0);
    FileRead(hFile, Buffer[0], Count);
  finally
    FileClose(hFile);
  end;

  strTemp := DisplayString(Buffer, intStartPos);
  mmo1.Lines.Add(strTemp);
end;

procedure TForm1.ShowImageDosHeaderRecord;
var
  hFile       : THandle;
  imgDosHeader: TImageDosHeader;
begin
  hFile := FileOpen(FstrFileName, fmOpenRead or fmShareDenyNone);
  if hFile = INVALID_HANDLE_VALUE then
  begin
    ShowMessage('Open File Error! Check whether the file has been opened');
    Exit;
  end;

  try
    FileRead(hFile, imgDosHeader, SizeOf(TImageDosHeader));
  finally
    FileClose(hFile);
  end;

  mmo1.Lines.Add('');
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_magic', imgDosHeader.e_magic, Chr(9) + Chr(9), '//魔术数字，所有MS-DOS兼容的可执行文件都将此值设为0X5A4D(MZ)']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_cblp', imgDosHeader.e_cblp, Chr(9) + Chr(9), '//文件最后页的字节数']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_cp', imgDosHeader.e_cp, Chr(9) + Chr(9), '//文件页数']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_crlc', imgDosHeader.e_crlc, Chr(9) + Chr(9), '//重定义元素个数']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_cparhdr', imgDosHeader.e_cparhdr, Chr(9) + Chr(9), '//头部尺寸，以段落为单位']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_minalloc', imgDosHeader.e_minalloc, Chr(9) + Chr(9), '//所需的最小附加段']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_maxalloc', imgDosHeader.e_maxalloc, Chr(9) + Chr(9), '//所需的最大附加段']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_ss', imgDosHeader.e_ss, Chr(9) + Chr(9), '//初始的SS值(相对偏移量)']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_sp', imgDosHeader.e_sp, Chr(9) + Chr(9), '//初始的SP值']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_csum', imgDosHeader.e_csum, Chr(9) + Chr(9), '//校验和']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_ip', imgDosHeader.e_ip, Chr(9) + Chr(9), '//初始的IP值']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_cs', imgDosHeader.e_cs, Chr(9) + Chr(9), '//初始的CS值(相对偏移量)']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_lfarlc', imgDosHeader.e_lfarlc, Chr(9) + Chr(9), '//重分配表文件地址']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_ovno', imgDosHeader.e_ovno, Chr(9) + Chr(9), '//覆盖号']));
  mmo1.Lines.Add(Format('%-10s：$%0.2x%0.2x%0.2x%0.2x %s%s', ['e_res', imgDosHeader.e_res[0], imgDosHeader.e_res[1], imgDosHeader.e_res[2], imgDosHeader.e_res[3], Chr(9) + Chr(9), '//保留字']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_oemid', imgDosHeader.e_oemid, Chr(9) + Chr(9), '//OEM标识符(相对e_oeminfo)']));
  mmo1.Lines.Add(Format('%-10s：$%0.4x %s%s', ['e_oeminfo', imgDosHeader.e_oeminfo, Chr(9) + Chr(9), '//OEM信息']));
  mmo1.Lines.Add(Format('%-10s：$%0.2x%0.2x%0.2x%0.2x%0.2x%0.2x%0.2x%0.2x %s%s', ['e_res2', imgDosHeader.e_res2[0], imgDosHeader.e_res2[1], imgDosHeader.e_res2[2], imgDosHeader.e_res2[3], imgDosHeader.e_res2[4], imgDosHeader.e_res2[5], imgDosHeader.e_res2[6], imgDosHeader.e_res2[7], Chr(9), '//保留字']));
  mmo1.Lines.Add(Format('%-10s：$%0.8x %s%s', ['_lfanew', imgDosHeader._lfanew, Chr(9) + Chr(9), '//PE头部的起始地址']));
end;

procedure TForm1.ShowImageDosHeaderInfo;
begin
  mmo1.Lines.Add('');
  mmo1.Lines.Add(Format('ImageDosHeader Offset：$%0.8x', [FintImageFileHeaderPos]));
end;

procedure TForm1.ShowImageDosHeader;
begin
  ShowHexData(0, SizeOf(TImageDosHeader));
  ShowImageDosHeaderRecord;
  ShowImageDosHeaderInfo;
end;

procedure TForm1.ShowImageDosStub;
begin
  ShowHexData(SizeOf(TImageDosHeader), FintImageFileHeaderPos - SizeOf(TImageDosHeader));
end;

procedure TForm1.ShowImageFileHeaderRecord;
const
  c_strSectionTableName: array [0 .. 15] of ShortString = ('导出表', '导入表', '资源表', '异常表', '安全表', '重定位表', '调试表', '版权表', '全局指针表', 'TLS 表', '载入配置表', 'Bound Import 表', 'IAT表', '延时导入描述表', 'COM表', '保留');
var
  hFile         : THandle;
  imgNtHeaders32: TImageNtHeaders32;
  imgNtHeaders64: TImageNtHeaders64;
  III           : Integer;
begin
  hFile := FileOpen(FstrFileName, fmOpenRead or fmShareDenyNone);
  if hFile = INVALID_HANDLE_VALUE then
  begin
    ShowMessage('Open File Error! Check whether the file has been opened');
    Exit;
  end;

  mmo1.Lines.BeginUpdate;
  mmo1.Lines.Add('');
  try
    FileSeek(hFile, FintImageFileHeaderPos, 0);
    if FbX64 then
    begin
      FileRead(hFile, imgNtHeaders64, SizeOf(imgNtHeaders64));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['Signature', imgNtHeaders64.Signature, Chr(9) + Chr(9), '//有效的PE标记']));
      mmo1.Lines.Add('');

      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['FileHeader.Machine', imgNtHeaders64.FileHeader.Machine, Chr(9) + Chr(9), '//可执行文件的目标CPU']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['FileHeader.NumberOfSections', imgNtHeaders64.FileHeader.NumberOfSections, Chr(9) + Chr(9), '//节表中有多少个节']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['FileHeader.TimeDateStamp', imgNtHeaders64.FileHeader.TimeDateStamp, Chr(9) + Chr(9), '//文件被创建的时间']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['FileHeader.PointerToSymbolTable', imgNtHeaders64.FileHeader.PointerToSymbolTable, Chr(9) + Chr(9), '//COFF符号表的文件偏移']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['FileHeader.NumberOfSymbols', imgNtHeaders64.FileHeader.NumberOfSymbols, Chr(9) + Chr(9), '//COFF符号表的数目']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['FileHeader.SizeOfOptionalHeader', imgNtHeaders64.FileHeader.SizeOfOptionalHeader, Chr(9) + Chr(9), '//之后的可选数据的大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['FileHeader.Characteristics', imgNtHeaders64.FileHeader.Characteristics, Chr(9) + Chr(9), '//文件属性']));
      mmo1.Lines.Add('');

      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.Magic', imgNtHeaders64.OptionalHeader.Magic, Chr(9) + Chr(9), '//签名，确定这是什么类型的头']));
      mmo1.Lines.Add(Format('%-50s：$%0.2x %s%s', ['OptionalHeader.MajorLinkerVersion', imgNtHeaders64.OptionalHeader.MajorLinkerVersion, Chr(9) + Chr(9), '//创建可执行文件的链接器的主版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.2x %s%s', ['OptionalHeader.MinorLinkerVersion', imgNtHeaders64.OptionalHeader.MinorLinkerVersion, Chr(9) + Chr(9), '//创建可执行文件的链接器的次版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfCode', imgNtHeaders64.OptionalHeader.SizeOfCode, Chr(9) + Chr(9), '//所有具有IMAGE_SCN_CNT_CODE属性的节的总的大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfInitializedData', imgNtHeaders64.OptionalHeader.SizeOfInitializedData, Chr(9) + Chr(9), '//所有包含已初始数据的节的总的大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfUninitializedData', imgNtHeaders64.OptionalHeader.SizeOfUninitializedData, Chr(9) + Chr(9), '//所有包含未初始化数据的节的总的大小。这个域总是0，因为链接器可以把未初始化数据附加到常规数据节的末尾']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.AddressOfEntryPoint', imgNtHeaders64.OptionalHeader.AddressOfEntryPoint, Chr(9) + Chr(9), '//文件中将被执行的第一个代码字节的RVA']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.BaseOfCode', imgNtHeaders64.OptionalHeader.BaseOfCode, Chr(9) + Chr(9), '//加载到内存后代码的第一个字节的RVA']));
      // mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.BaseOfData', imgNtHeaders64.OptionalHeader.BaseOfData, chr(9) + chr(9), '//加载到内存后数据的第一个字节的RVA']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.ImageBase', imgNtHeaders64.OptionalHeader.ImageBase, Chr(9) + Chr(9), '//文件在内存中的首选加载地址']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SectionAlignment', imgNtHeaders64.OptionalHeader.SectionAlignment, Chr(9) + Chr(9), '//加载到内存后节的对齐大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.FileAlignment', imgNtHeaders64.OptionalHeader.FileAlignment, Chr(9) + Chr(9), '//文件中节的对齐大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.MajorOperatingSystemVersion', imgNtHeaders64.OptionalHeader.MajorOperatingSystemVersion, Chr(9) + Chr(9), '//所要求的操作系统的主版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.MinorOperatingSystemVersion', imgNtHeaders64.OptionalHeader.MinorOperatingSystemVersion, Chr(9) + Chr(9), '//所要求的操作系统的次版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.MajorImageVersion', imgNtHeaders64.OptionalHeader.MajorImageVersion, Chr(9) + Chr(9), '//这个文件的主版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.MinorImageVersion', imgNtHeaders64.OptionalHeader.MinorImageVersion, Chr(9) + Chr(9), '//这个文件的次版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.MajorSubsystemVersion', imgNtHeaders64.OptionalHeader.MajorSubsystemVersion, Chr(9) + Chr(9), '//可执行文件所要求的操作子系统的主版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.MinorSubsystemVersion', imgNtHeaders64.OptionalHeader.MinorSubsystemVersion, Chr(9) + Chr(9), '//可执行文件所要求的操作子系统的次版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.Win64VersionValue', imgNtHeaders64.OptionalHeader.Win32VersionValue, Chr(9) + Chr(9), '//通常设为0']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfImage', imgNtHeaders64.OptionalHeader.SizeOfImage, Chr(9) + Chr(9), '//映像的大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfHeaders', imgNtHeaders64.OptionalHeader.SizeOfHeaders, Chr(9) + Chr(9), '//PE头和节表的总的大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.CheckSum', imgNtHeaders64.OptionalHeader.CheckSum, Chr(9) + Chr(9), '//映像的校验和']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.Subsystem', imgNtHeaders64.OptionalHeader.Subsystem, Chr(9) + Chr(9), '//可执行文件期望的子系统']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.DllCharacteristics', imgNtHeaders64.OptionalHeader.DllCharacteristics, Chr(9) + Chr(9), '//DLL的特性']));
      mmo1.Lines.Add(Format('%-50s：$%0.16x %s%s', ['OptionalHeader.SizeOfStackReserve', imgNtHeaders64.OptionalHeader.SizeOfStackReserve, Chr(9) + Chr(9), '//为线程保留的堆栈大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.16x %s%s', ['OptionalHeader.SizeOfStackCommit', imgNtHeaders64.OptionalHeader.SizeOfStackCommit, Chr(9) + Chr(9), '//为堆栈初始提交的内存数量']));
      mmo1.Lines.Add(Format('%-50s：$%0.16x %s%s', ['OptionalHeader.SizeOfHeapReserve', imgNtHeaders64.OptionalHeader.SizeOfHeapReserve, Chr(9) + Chr(9), '//为默认进程堆初始保留的内存大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.16x %s%s', ['OptionalHeader.SizeOfHeapCommit', imgNtHeaders64.OptionalHeader.SizeOfHeapCommit, Chr(9) + Chr(9), '//提交到堆的内存大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.LoaderFlags', imgNtHeaders64.OptionalHeader.LoaderFlags, Chr(9) + Chr(9), '//保留']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.NumberOfRvaAndSizes', imgNtHeaders64.OptionalHeader.NumberOfRvaAndSizes, Chr(9) + Chr(9), '//随后 DataDirectory 结构的数量']));
      mmo1.Lines.Add(Format('%-50s %s%s', ['OptionalHeader.DataDirectory', Chr(9) + Chr(9) + Chr(9), '//数据目录项']));
      for III := 0 to 15 do
      begin
        mmo1.Lines.Add(Format('%s[%2d]：地址：$%0.8x  大小：$%0.8x %s//%s', [Chr(9) + 'OptionalHeader.DataDirectory', III, imgNtHeaders64.OptionalHeader.DataDirectory[III].VirtualAddress, imgNtHeaders64.OptionalHeader.DataDirectory[III].Size, Chr(9) + Chr(9), c_strSectionTableName[III]]));
      end;
    end
    else
    begin
      FileRead(hFile, imgNtHeaders32, SizeOf(imgNtHeaders32));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['Signature', imgNtHeaders32.Signature, Chr(9) + Chr(9), '//有效的PE标记']));
      mmo1.Lines.Add('');

      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['FileHeader.Machine', imgNtHeaders32.FileHeader.Machine, Chr(9) + Chr(9), '//可执行文件的目标CPU']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['FileHeader.NumberOfSections', imgNtHeaders32.FileHeader.NumberOfSections, Chr(9) + Chr(9), '//节表中有多少个节']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['FileHeader.TimeDateStamp', imgNtHeaders32.FileHeader.TimeDateStamp, Chr(9) + Chr(9), '//文件被创建的时间']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['FileHeader.PointerToSymbolTable', imgNtHeaders32.FileHeader.PointerToSymbolTable, Chr(9) + Chr(9), '//COFF符号表的文件偏移']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['FileHeader.NumberOfSymbols', imgNtHeaders32.FileHeader.NumberOfSymbols, Chr(9) + Chr(9), '//COFF符号表的数目']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['FileHeader.SizeOfOptionalHeader', imgNtHeaders32.FileHeader.SizeOfOptionalHeader, Chr(9) + Chr(9), '//之后的可选数据的大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['FileHeader.Characteristics', imgNtHeaders32.FileHeader.Characteristics, Chr(9) + Chr(9), '//文件属性']));
      mmo1.Lines.Add('');

      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.Magic', imgNtHeaders32.OptionalHeader.Magic, Chr(9) + Chr(9), '//签名，确定这是什么类型的头']));
      mmo1.Lines.Add(Format('%-50s：$%0.2x %s%s', ['OptionalHeader.MajorLinkerVersion', imgNtHeaders32.OptionalHeader.MajorLinkerVersion, Chr(9) + Chr(9), '//创建可执行文件的链接器的主版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.2x %s%s', ['OptionalHeader.MinorLinkerVersion', imgNtHeaders32.OptionalHeader.MinorLinkerVersion, Chr(9) + Chr(9), '//创建可执行文件的链接器的次版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfCode', imgNtHeaders32.OptionalHeader.SizeOfCode, Chr(9) + Chr(9), '//所有具有IMAGE_SCN_CNT_CODE属性的节的总的大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfInitializedData', imgNtHeaders32.OptionalHeader.SizeOfInitializedData, Chr(9) + Chr(9), '//所有包含已初始数据的节的总的大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfUninitializedData', imgNtHeaders32.OptionalHeader.SizeOfUninitializedData, Chr(9) + Chr(9), '//所有包含未初始化数据的节的总的大小。这个域总是0，因为链接器可以把未初始化数据附加到常规数据节的末尾']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.AddressOfEntryPoint', imgNtHeaders32.OptionalHeader.AddressOfEntryPoint, Chr(9) + Chr(9), '//文件中将被执行的第一个代码字节的RVA']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.BaseOfCode', imgNtHeaders32.OptionalHeader.BaseOfCode, Chr(9) + Chr(9), '//加载到内存后代码的第一个字节的RVA']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.BaseOfData', imgNtHeaders32.OptionalHeader.BaseOfData, Chr(9) + Chr(9), '//加载到内存后数据的第一个字节的RVA']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.ImageBase', imgNtHeaders32.OptionalHeader.ImageBase, Chr(9) + Chr(9), '//文件在内存中的首选加载地址']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SectionAlignment', imgNtHeaders32.OptionalHeader.SectionAlignment, Chr(9) + Chr(9), '//加载到内存后节的对齐大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.FileAlignment', imgNtHeaders32.OptionalHeader.FileAlignment, Chr(9) + Chr(9), '//文件中节的对齐大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.MajorOperatingSystemVersion', imgNtHeaders32.OptionalHeader.MajorOperatingSystemVersion, Chr(9) + Chr(9), '//所要求的操作系统的主版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.MinorOperatingSystemVersion', imgNtHeaders32.OptionalHeader.MinorOperatingSystemVersion, Chr(9) + Chr(9), '//所要求的操作系统的次版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.MajorImageVersion', imgNtHeaders32.OptionalHeader.MajorImageVersion, Chr(9) + Chr(9), '//这个文件的主版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.MinorImageVersion', imgNtHeaders32.OptionalHeader.MinorImageVersion, Chr(9) + Chr(9), '//这个文件的次版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.MajorSubsystemVersion', imgNtHeaders32.OptionalHeader.MajorSubsystemVersion, Chr(9) + Chr(9), '//可执行文件所要求的操作子系统的主版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.MinorSubsystemVersion', imgNtHeaders32.OptionalHeader.MinorSubsystemVersion, Chr(9) + Chr(9), '//可执行文件所要求的操作子系统的次版本号']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.Win32VersionValue', imgNtHeaders32.OptionalHeader.Win32VersionValue, Chr(9) + Chr(9), '//通常设为0']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfImage', imgNtHeaders32.OptionalHeader.SizeOfImage, Chr(9) + Chr(9), '//映像的大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfHeaders', imgNtHeaders32.OptionalHeader.SizeOfHeaders, Chr(9) + Chr(9), '//PE头和节表的总的大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.CheckSum', imgNtHeaders32.OptionalHeader.CheckSum, Chr(9) + Chr(9), '//映像的校验和']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.Subsystem', imgNtHeaders32.OptionalHeader.Subsystem, Chr(9) + Chr(9), '//可执行文件期望的子系统']));
      mmo1.Lines.Add(Format('%-50s：$%0.4x %s%s', ['OptionalHeader.DllCharacteristics', imgNtHeaders32.OptionalHeader.DllCharacteristics, Chr(9) + Chr(9), '//DLL的特性']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfStackReserve', imgNtHeaders32.OptionalHeader.SizeOfStackReserve, Chr(9) + Chr(9), '//为线程保留的堆栈大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfStackCommit', imgNtHeaders32.OptionalHeader.SizeOfStackCommit, Chr(9) + Chr(9), '//为堆栈初始提交的内存数量']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfHeapReserve', imgNtHeaders32.OptionalHeader.SizeOfHeapReserve, Chr(9) + Chr(9), '//为默认进程堆初始保留的内存大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.SizeOfHeapCommit', imgNtHeaders32.OptionalHeader.SizeOfHeapCommit, Chr(9) + Chr(9), '//提交到堆的内存大小']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.LoaderFlags', imgNtHeaders32.OptionalHeader.LoaderFlags, Chr(9) + Chr(9), '//保留']));
      mmo1.Lines.Add(Format('%-50s：$%0.8x %s%s', ['OptionalHeader.NumberOfRvaAndSizes', imgNtHeaders32.OptionalHeader.NumberOfRvaAndSizes, Chr(9) + Chr(9), '//随后 DataDirectory 结构的数量']));
      mmo1.Lines.Add(Format('%-50s %s%s', ['OptionalHeader.DataDirectory', Chr(9) + Chr(9) + Chr(9), '//数据目录项']));
      for III := 0 to 15 do
      begin
        mmo1.Lines.Add(Format('%s[%2d]：地址：$%0.8x  大小：$%0.8x %s//%s', [Chr(9) + 'OptionalHeader.DataDirectory', III, imgNtHeaders32.OptionalHeader.DataDirectory[III].VirtualAddress, imgNtHeaders32.OptionalHeader.DataDirectory[III].Size, Chr(9) + Chr(9), c_strSectionTableName[III]]));
      end;
    end;

  finally
    FileClose(hFile);
    mmo1.Lines.EndUpdate;
  end;
end;

procedure TForm1.ShowImageFileHeader;
begin
  ShowHexData(FintImageFileHeaderPos, SizeOf(TImageNtHeaders32));
  ShowImageFileHeaderRecord;
end;

procedure TForm1.srchbxOpenFileInvokeSearch(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  begin
    Filter := 'PE(*.EXE;*.DLL;*.OCX;*.AX;*.SCR;*.CPL;*.SYS)|*.EXE;*.DLL;*.OCX;*.AX;*.SCR;*.CPL;*.SYS';
    if Execute() then
    begin
      srchbxOpenFile.Text := FileName;
      FstrFileName        := srchbxOpenFile.Text;
      PEInfo(FstrFileName);
    end;
    Free;
  end;
end;

procedure TForm1.ShowImageSectionTableRecord(const intStartPos: Integer);
var
  hFile              : THandle;
  III                : Integer;
  strSectionTableName: String;
begin
  hFile := FileOpen(FstrFileName, fmOpenRead or fmShareDenyNone);
  if hFile = INVALID_HANDLE_VALUE then
  begin
    ShowMessage('Open File Error! Check whether the file has been opened');
    Exit;
  end;

  SetLength(FimgSectionTable, FintNumberOfSections);
  try
    FileSeek(hFile, intStartPos, 0);
    FileRead(hFile, FimgSectionTable[0], FintNumberOfSections * SizeOf(TImageSectionHeader));
  finally
    FileClose(hFile);
  end;

  mmo1.Lines.Add('');
  mmo1.Lines.Add(Format('序列  名称%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s', [Chr(9), 'VirtualSize', Chr(9), 'VirtualAddress', Chr(9), 'SizeOfRawData', Chr(9), 'PointerToRawData', Chr(9), 'PointerToRelocations', Chr(9), 'PointerToLinenumbers', Chr(9), 'NumberOfRelocations', Chr(9), 'NumberOfLinenumbers', Chr(9), 'Characteristics']));
  for III := 0 to FintNumberOfSections - 1 do
  begin
    strSectionTableName := String(PAnsiChar(@FimgSectionTable[III].Name[0]));
    mmo1.Lines.Add(Format('%d  %-10s%s$%0.8x%s$%0.8x%s$%0.8x%s$%0.8x%s$%0.8x%s$%0.8x%s$%0.8x%s$%0.8x%s$%0.8x', [III + 1, strSectionTableName, Chr(9), FimgSectionTable[III].Misc.VirtualSize, Chr(9), FimgSectionTable[III].VirtualAddress, Chr(9), FimgSectionTable[III].SizeOfRawData, Chr(9), FimgSectionTable[III].PointerToRawData, Chr(9) + Chr(9), FimgSectionTable[III].PointerToRelocations,
      Chr(9) + Chr(9), FimgSectionTable[III].PointerToLinenumbers, Chr(9) + Chr(9), FimgSectionTable[III].NumberOfRelocations, Chr(9) + Chr(9), FimgSectionTable[III].NumberOfLinenumbers, Chr(9) + Chr(9), FimgSectionTable[III].Characteristics]));
  end;
end;

procedure TForm1.ShowImageSectionTable;
var
  intStartPos: Integer;
begin
  if FbX64 then
    intStartPos := FintImageFileHeaderPos + SizeOf(TImageNtHeaders64)
  else
    intStartPos := FintImageFileHeaderPos + SizeOf(TImageNtHeaders32);

  ShowHexData(intStartPos, FintNumberOfSections * SizeOf(TImageSectionHeader));
  ShowImageSectionTableRecord(intStartPos);
end;

procedure TForm1.ShowImageSectionData;
var
  hFile              : THandle;
  III                : Integer;
  strSectionTableName: String;
  intStartPos        : Integer;
begin
  hFile := FileOpen(FstrFileName, fmOpenRead or fmShareDenyNone);
  if hFile = INVALID_HANDLE_VALUE then
  begin
    ShowMessage('Open File Error! Check whether the file has been opened');
    Exit;
  end;

  if FbX64 then
    intStartPos := FintImageFileHeaderPos + SizeOf(TImageNtHeaders64)
  else
    intStartPos := FintImageFileHeaderPos + SizeOf(TImageNtHeaders32);

  SetLength(FimgSectionTable, FintNumberOfSections);
  try
    FileSeek(hFile, intStartPos, 0);
    FileRead(hFile, FimgSectionTable[0], FintNumberOfSections * SizeOf(TImageSectionHeader));
  finally
    FileClose(hFile);
  end;

  mmo1.Lines.Add(Format('序列  名称%s%s%s%s%s%s%s%s%s%s%s%s', [Chr(9), 'VirtualSize', Chr(9), 'VirtualAddress', Chr(9), 'SizeOfRawData', Chr(9), 'PointerToRawData', Chr(9), 'Characteristics', Chr(9), '物理地址']));
  for III := 0 to FintNumberOfSections - 1 do
  begin
    strSectionTableName := String(PAnsiChar(@FimgSectionTable[III].Name[0]));
    mmo1.Lines.Add(Format('%4d  %-8s%s$%0.8x%s$%0.8x%s$%0.8x%s$%0.8x%s$%0.8x%s$%0.8x', [III + 1, strSectionTableName, Chr(9), FimgSectionTable[III].Misc.VirtualSize, Chr(9), FimgSectionTable[III].VirtualAddress, Chr(9), FimgSectionTable[III].SizeOfRawData, Chr(9), FimgSectionTable[III].PointerToRawData, Chr(9) + Chr(9), FimgSectionTable[III].Characteristics, Chr(9), 0]));
  end;
end;

procedure TForm1.tvPEChange(Sender: TObject; Node: TTreeNode);
begin
  if Node = nil then
    Exit;

  mmo1.Clear;

  if (Node.Index = 0) and (Node.Parent.Index = -1) then
    ShowSummary;

  if (Node.Index = 0) and (Node.Parent.Index = 0) then
    ShowImageDosHeader;

  if (Node.Index = 1) and (Node.Parent.Index = 0) then
    ShowImageDosStub;

  if (Node.Index = 2) and (Node.Parent.Index = 0) then
    ShowImageFileHeader;

  if (Node.Index = 3) and (Node.Parent.Index = 0) then
    ShowImageSectionTable;

  if (Node.Index = 4) and (Node.Parent.Index = 0) then
    ShowImageSectionData;
end;

end.

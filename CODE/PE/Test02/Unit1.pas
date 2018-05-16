unit Unit1;
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCtrls, System.IOUtils, FileCtrl, Vcl.ExtCtrls, System.Math,
  Vcl.ComCtrls, Vcl.Menus, RzButton;

type
  TForm1 = class(TForm)
    srchbxPEFileName: TSearchBox;
    pnl1: TPanel;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    ts3: TTabSheet;
    ts4: TTabSheet;
    ts5: TTabSheet;
    ts6: TTabSheet;
    lblPEInfo: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl17: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    lbl25: TLabel;
    lbl26: TLabel;
    lbl27: TLabel;
    lbl28: TLabel;
    lbl29: TLabel;
    lbl30: TLabel;
    lbl31: TLabel;
    lbl32: TLabel;
    lbl33: TLabel;
    lbl34: TLabel;
    lbl35: TLabel;
    lbl36: TLabel;
    lbl37: TLabel;
    lbl38: TLabel;
    lbl39: TLabel;
    lbl40: TLabel;
    lbl41: TLabel;
    lbl42: TLabel;
    lbl43: TLabel;
    lbl44: TLabel;
    lbl45: TLabel;
    lbl46: TLabel;
    lbl47: TLabel;
    lbl48: TLabel;
    lbl49: TLabel;
    lbl50: TLabel;
    lbl51: TLabel;
    lbl52: TLabel;
    lbl53: TLabel;
    lbl54: TLabel;
    lbl55: TLabel;
    lbl56: TLabel;
    mmoHexView: TMemo;
    lbl57: TLabel;
    lbl58: TLabel;
    lbl59: TLabel;
    lbl60: TLabel;
    lbl61: TLabel;
    lbl62: TLabel;
    lbl63: TLabel;
    lbl64: TLabel;
    lbl65: TLabel;
    lbl66: TLabel;
    lbl67: TLabel;
    lbl68: TLabel;
    lbl69: TLabel;
    lbl70: TLabel;
    lbl71: TLabel;
    lbl72: TLabel;
    lbl73: TLabel;
    lbl74: TLabel;
    lbl75: TLabel;
    lbl76: TLabel;
    scrlbx1: TScrollBox;
    lbl77: TLabel;
    lbl78: TLabel;
    lbl79: TLabel;
    lbl80: TLabel;
    lbl81: TLabel;
    lbl82: TLabel;
    lbl83: TLabel;
    lbl84: TLabel;
    lbl85: TLabel;
    lbl86: TLabel;
    lbl87: TLabel;
    lbl88: TLabel;
    lbl89: TLabel;
    lbl90: TLabel;
    lbl91: TLabel;
    lbl92: TLabel;
    lbl93: TLabel;
    lbl94: TLabel;
    lbl95: TLabel;
    lbl96: TLabel;
    lbl97: TLabel;
    lbl98: TLabel;
    lbl99: TLabel;
    lbl100: TLabel;
    lbl101: TLabel;
    lbl102: TLabel;
    lbl103: TLabel;
    lbl104: TLabel;
    lbl105: TLabel;
    lbl106: TLabel;
    lbl107: TLabel;
    lbl108: TLabel;
    lbl109: TLabel;
    lbl110: TLabel;
    lbl111: TLabel;
    lbl112: TLabel;
    lbl113: TLabel;
    lbl114: TLabel;
    lbl115: TLabel;
    lbl116: TLabel;
    lbl117: TLabel;
    lbl118: TLabel;
    lbl119: TLabel;
    lbl120: TLabel;
    lbl121: TLabel;
    lbl122: TLabel;
    lbl123: TLabel;
    lbl124: TLabel;
    lbl125: TLabel;
    lbl126: TLabel;
    lbl127: TLabel;
    lbl128: TLabel;
    lbl129: TLabel;
    lbl130: TLabel;
    lbl131: TLabel;
    lbl132: TLabel;
    lbl133: TLabel;
    lbl134: TLabel;
    lbl135: TLabel;
    lbl136: TLabel;
    lbl137: TLabel;
    lbl138: TLabel;
    lbl139: TLabel;
    lbl140: TLabel;
    lbl141: TLabel;
    lbl142: TLabel;
    lbl143: TLabel;
    lbl144: TLabel;
    lbl145: TLabel;
    lbl146: TLabel;
    lbl147: TLabel;
    lbl148: TLabel;
    lbl149: TLabel;
    lbl150: TLabel;
    lbl151: TLabel;
    lbl152: TLabel;
    lbl153: TLabel;
    lbl154: TLabel;
    lbl155: TLabel;
    lbl156: TLabel;
    lbl157: TLabel;
    lbl158: TLabel;
    lbl160: TLabel;
    lbl159: TLabel;
    lbl161: TLabel;
    lbl162: TLabel;
    lbl164: TLabel;
    lbl166: TLabel;
    lbl168: TLabel;
    lbl163: TLabel;
    lbl165: TLabel;
    lbl167: TLabel;
    lbl169: TLabel;
    lbl170: TLabel;
    lbl172: TLabel;
    lbl174: TLabel;
    lbl176: TLabel;
    lbl178: TLabel;
    lbl180: TLabel;
    lbl182: TLabel;
    lbl184: TLabel;
    lbl171: TLabel;
    lbl173: TLabel;
    lbl175: TLabel;
    lbl177: TLabel;
    lbl179: TLabel;
    lbl181: TLabel;
    lbl183: TLabel;
    lbl185: TLabel;
    lbl186: TLabel;
    lbl187: TLabel;
    lbl188: TLabel;
    lbl189: TLabel;
    lbl190: TLabel;
    lbl191: TLabel;
    lbl192: TLabel;
    lbl193: TLabel;
    lbl195: TLabel;
    lbl196: TLabel;
    lbl197: TLabel;
    lbl198: TLabel;
    lbl199: TLabel;
    lbl200: TLabel;
    lbl201: TLabel;
    lbl194: TLabel;
    lbl202: TLabel;
    lbl203: TLabel;
    lbl204: TLabel;
    lbl205: TLabel;
    lbl206: TLabel;
    lbl207: TLabel;
    lbl208: TLabel;
    lbl209: TLabel;
    lbl210: TLabel;
    lbl211: TLabel;
    lbl212: TLabel;
    lbl213: TLabel;
    lbl214: TLabel;
    lbl215: TLabel;
    lbl216: TLabel;
    btn1: TRzMenuButton;
    pm1: TPopupMenu;
    IMAGEDOSSIGNATURE5A4DMZ1: TMenuItem;
    IMAGEOS2SIGNATURE454ENE1: TMenuItem;
    IMAGEOS2SIGNATURELE454CLE1: TMenuItem;
    IMAGEVXDSIGNATURE454CLE1: TMenuItem;
    btn2: TRzMenuButton;
    pm2: TPopupMenu;
    IMAGEFILEMACHINEUNKNOWN01: TMenuItem;
    IMAGEFILEMACHINEI386014cIntel3861: TMenuItem;
    IMAGEFILEMACHINER30000162MIPSlittleendian0x160bigendian1: TMenuItem;
    IMAGEFILEMACHINER40000166MIPSlittleendian1: TMenuItem;
    IMAGEFILEMACHINER100000168MIPSlittleendian1: TMenuItem;
    IMAGEFILEMACHINEALPHA0184AlphaAXP1: TMenuItem;
    IMAGEFILEMACHINEPOWERPC01F0IBMPowerPCLittleEndian1: TMenuItem;
    IMAGEFILEMACHINEIA640200Intel641: TMenuItem;
    IMAGEFILEMACHINEALPHA640284Alpha641: TMenuItem;
    IMAGEFILEMACHINEAMD648664AMD64K81: TMenuItem;
    btn3: TButton;
    btn4: TRzMenuButton;
    pm3: TPopupMenu;
    IMAGENTOPTIONALHDR32MAGIC010B1: TMenuItem;
    IMAGENTOPTIONALHDR64MAGIC020B1: TMenuItem;
    IMAGEROMOPTIONALHDRMAGIC01071: TMenuItem;
    btn5: TRzMenuButton;
    pm4: TPopupMenu;
    IMAGESUBSYSTEMUNKNOWN0Unknownsubsystem1: TMenuItem;
    IMAGESUBSYSTEMNATIVE1Imagedoesntrequireasubsystem1: TMenuItem;
    IMAGESUBSYSTEMWINDOWSGUI2ImagerunsintheWindowsGUIsubsystem1: TMenuItem;
    IMAGESUBSYSTEMWINDOWSCUI3ImagerunsintheWindowscharactersubsystem1: TMenuItem;
    IMAGESUBSYSTEMOS2CUI5imagerunsintheOS2charactersubsystem1: TMenuItem;
    IMAGESUBSYSTEMPOSIXCUI7imagerunsinthePosixcharactersubsystem1: TMenuItem;
    IMAGESUBSYSTEMNATIVEWINDOWS8imageisanativeWin9xdriver1: TMenuItem;
    IMAGESUBSYSTEMWINDOWSCEGUI9ImagerunsintheWindowsCEsubsystem1: TMenuItem;
    IMAGESUBSYSTEMEFIAPPLICATION101: TMenuItem;
    IMAGESUBSYSTEMEFIBOOTSERVICEDRIVER111: TMenuItem;
    IMAGESUBSYSTEMEFIRUNTIMEDRIVER121: TMenuItem;
    IMAGESUBSYSTEMEFIROM131: TMenuItem;
    IMAGESUBSYSTEMXBOX141: TMenuItem;
    IMAGESUBSYSTEMWINDOWSBOOTAPPLICATION161: TMenuItem;
    btn6: TRzMenuButton;
    pm5: TPopupMenu;
    IMAGEDLLCHARACTERISTICSDYNAMICBASE0x0040DLLcanmove1: TMenuItem;
    IMAGEDLLCHARACTERISTICSFORCEINTEGRITY0x0080CodeIntegrityImage1: TMenuItem;
    IMAGEDLLCHARACTERISTICSNXCOMPAT0x0100ImageisNXcompatible1: TMenuItem;
    IMAGEDLLCHARACTERISTICSNOISOLATION0x0200Imageunderstandsisolationanddoesntwantit1: TMenuItem;
    IMAGEDLLCHARACTERISTICSNOSEH0x0400ImagedoesnotuseSEHNoSEhandlermayresidei1: TMenuItem;
    IMAGEDLLCHARACTERISTICSNOBIND0x0800Donotbindthisimage1: TMenuItem;
    N0x1000Reserved1: TMenuItem;
    IMAGEDLLCHARACTERISTICSWDMDRIVER0x2000DriverusesWDMmodel1: TMenuItem;
    N0x4000Reserved1: TMenuItem;
    mniIMAGEDLLCHARACTERISTICSTERMINALSERVERAWARE0x80001: TMenuItem;
    lv1: TListView;
    pm6: TPopupMenu;
    mniReadSectionData: TMenuItem;
    mniSectionAttr: TMenuItem;
    procedure srchbxPEFileNameInvokeSearch(Sender: TObject);
    procedure scrlbx1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure IMAGEFILEMACHINEAMD648664AMD64K81DrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
    procedure IMAGEFILEMACHINEAMD648664AMD64K81MeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure btn3Click(Sender: TObject);
    procedure IMAGESUBSYSTEMWINDOWSBOOTAPPLICATION161MeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure mniIMAGEDLLCHARACTERISTICSTERMINALSERVERAWARE0x80001MeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
    procedure mniReadSectionDataClick(Sender: TObject);
    procedure mniSectionAttrClick(Sender: TObject);
  private
    { 检测是否是PE文件 }
    function CheckPERight(const strPEFileName: string; var bX64: Boolean; var bDll: Boolean): Boolean;
    { 解析PE }
    procedure AnalyzePE(const strPEFileName: String; const bX64, bDll: Boolean);
    procedure AnalyzePEX86(const strPEFileName: string; const bDll: Boolean);
    procedure AnalyzePEX64(const strPEFileName: string; const bDll: Boolean);
    { PE 简介 }
    procedure PEInfo(const strPEFileName: string; const bX64, bDll: Boolean);
    { 读取 IMAGE DOS HEADER }
    procedure ReadImageDosHeader(const strPEFileName: string);
    { 读取 DOS STUB }
    procedure ShowDosStub(const strPEFileName: string);
    { 16进制显示 }
    procedure ShowHexView(const strFileName: String; const intStartPos, intEndPos: Integer);
    { 显示 NT HEADER 信息 }
    procedure ShowNTHeaderX64(const strFileName: string);
    procedure ShowNTHeaderX86(const strFileName: string);
    { 显示 节表 }
    procedure ShowSectionTable(const strFileName: string; const bX64: Boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3;

{$R *.dfm}

procedure TForm1.scrlbx1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if WheelDelta < 0 then
    SendMessage(scrlbx1.Handle, WM_VSCROLL, SB_LINEDOWN, 0) // 向下滚
  else
    SendMessage(scrlbx1.Handle, WM_VSCROLL, SB_LINEUP, 0); // 向上滚
end;

procedure TForm1.srchbxPEFileNameInvokeSearch(Sender: TObject);
var
  strPEFileName: string;
  bX64         : Boolean;
  bDll         : Boolean;
begin
  with TOpenDialog.Create(nil) do
  begin
    Filter := 'PE文件(*.EXE;*.OCX;*.DLL;*.AX)|*.EXE;*.OCX;*.DLL;*.AX';
    if Execute() then
    begin
      strPEFileName := FileName;
      if CheckPERight(strPEFileName, bX64, bDll) then
      begin
        srchbxPEFileName.Text := strPEFileName;
        { 解析PE }
        AnalyzePE(strPEFileName, bX64, bDll);
      end
      else
      begin
        ShowMessage('不是PE文件，或者文件被占用');
      end;
    end;
    Free;
  end;
end;

{ 检测是否是PE文件 }
function TForm1.CheckPERight(const strPEFileName: string; var bX64: Boolean; var bDll: Boolean): Boolean;
var
  idh    : TImageDosHeader;
  inh    : TImageNtHeaders32;
  hPEFile: Cardinal;
begin
  Result  := False;
  hPEFile := FileOpen(strPEFileName, fmOpenRead);
  if hPEFile = INVALID_HANDLE_VALUE then
    Exit;

  try
    FileRead(hPEFile, idh, SizeOf(idh));
    if idh.e_magic <> IMAGE_DOS_SIGNATURE then
      Exit;

    FileSeek(hPEFile, idh._lfanew, 0);
    FileRead(hPEFile, inh, SizeOf(TImageNtHeaders32));
    Result := inh.Signature = IMAGE_NT_SIGNATURE;
    bX64   := inh.OptionalHeader.Magic = IMAGE_NT_OPTIONAL_HDR64_MAGIC;
    bDll   := inh.FileHeader.Characteristics and IMAGE_FILE_DLL = IMAGE_FILE_DLL;
  finally
    FileClose(hPEFile);
  end;
end;

procedure TForm1.IMAGEFILEMACHINEAMD648664AMD64K81DrawItem(Sender: TObject; ACanvas: TCanvas; ARect: TRect; Selected: Boolean);
begin
  ACanvas.Font.Name := '宋体';
  ACanvas.Font.Size := 11;
  ACanvas.TextOut(ARect.Left, ARect.Top, (Sender as TMenuItem).Caption);
end;

procedure TForm1.IMAGEFILEMACHINEAMD648664AMD64K81MeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
begin
  Width := 700;
end;

procedure TForm1.IMAGESUBSYSTEMWINDOWSBOOTAPPLICATION161MeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
begin
  Width := 800;
end;

procedure TForm1.mniIMAGEDLLCHARACTERISTICSTERMINALSERVERAWARE0x80001MeasureItem(Sender: TObject; ACanvas: TCanvas; var Width, Height: Integer);
begin
  Width := 1050;
end;

procedure TForm1.mniReadSectionDataClick(Sender: TObject);
begin
  //
end;

procedure TForm1.mniSectionAttrClick(Sender: TObject);
begin
  if lv1.ItemIndex = -1 then
    Exit;

  ShowSectionAttrForm(StrToInt(lv1.Selected.SubItems[4]));
end;

{ 解析PE }
procedure TForm1.AnalyzePE(const strPEFileName: String; const bX64, bDll: Boolean);
begin
  pgc1.ActivePageIndex := 0;
  pgc1.Visible         := True;

  if not bX64 then
    AnalyzePEX86(strPEFileName, bDll)
  else
    AnalyzePEX64(strPEFileName, bDll);
end;

{ PE 简介 }
procedure TForm1.PEInfo(const strPEFileName: string; const bX64, bDll: Boolean);
begin
  lblPEInfo.Caption := Format('%s%s文件', [Ifthen(bX64, '64位', '32位'), Ifthen(bDll, 'dll', 'exe')]);
end;

procedure TForm1.ReadImageDosHeader(const strPEFileName: string);
var
  idh    : TImageDosHeader;
  hPEFile: Cardinal;
begin
  hPEFile := FileOpen(strPEFileName, fmOpenRead);
  try
    FileRead(hPEFile, idh, SizeOf(TImageDosHeader));
    lbl17.Caption := Format('$%0.4x', [idh.e_magic]);
    lbl21.Caption := Format('$%0.4x', [idh.e_cblp]);
    lbl22.Caption := Format('$%0.4x', [idh.e_cp]);
    lbl23.Caption := Format('$%0.4x', [idh.e_crlc]);
    lbl24.Caption := Format('$%0.4x', [idh.e_cparhdr]);
    lbl25.Caption := Format('$%0.4x', [idh.e_minalloc]);
    lbl26.Caption := Format('$%0.4x', [idh.e_maxalloc]);
    lbl27.Caption := Format('$%0.4x', [idh.e_ss]);
    lbl28.Caption := Format('$%0.4x', [idh.e_sp]);
    lbl29.Caption := Format('$%0.4x', [idh.e_csum]);
    lbl30.Caption := Format('$%0.4x', [idh.e_ip]);
    lbl31.Caption := Format('$%0.4x', [idh.e_cs]);
    lbl32.Caption := Format('$%0.4x', [idh.e_lfarlc]);
    lbl33.Caption := Format('$%0.4x', [idh.e_ovno]);
    lbl34.Caption := Format('$%0.8x', [0]);
    lbl35.Caption := Format('$%0.4x', [idh.e_oemid]);
    lbl36.Caption := Format('$%0.4x', [idh.e_oeminfo]);
    lbl37.Caption := Format('$%0.8x%0.8x%0.4x', [0, 0, 0]);
    lbl38.Caption := Format('$%0.8x', [idh._lfanew]);
  finally
    FileClose(hPEFile);
  end;
end;

{ 16进制显示 }
procedure TForm1.ShowHexView(const strFileName: String; const intStartPos, intEndPos: Integer);
var
  hPEFile   : Cardinal;
  buffer    : array of Byte;
  intLen    : Integer;
  III, JJJ  : Integer;
  strLine   : String;
  strContent: String;
  intBlank  : Integer;
  strBlank  : string;
begin
  hPEFile := FileOpen(strFileName, fmOpenRead);
  try
    FileSeek(hPEFile, intStartPos, 0);
    intLen := intEndPos - intStartPos;
    SetLength(buffer, intLen);
    FileRead(hPEFile, buffer[0], intLen);
    strLine := '';
    mmoHexView.Clear;
    JJJ     := 0;
    for III := 0 to intLen - 1 do
    begin
      { 每16个字符一行 }
      strLine    := strLine + ' ' + IntToHex(buffer[III]);
      strContent := strContent + Ifthen((buffer[III] >= 33) and (buffer[III] <= 128), Chr(buffer[III]), '.');
      if III mod 16 = 15 then
      begin
        Inc(JJJ);
        mmoHexView.Lines.Add(IntToHex(intStartPos + 16 * (JJJ - 1), 8) + '  ' + strLine + '  ' + strContent);
        strLine    := '';
        strContent := '';
      end;
    end;

    { 最后一行 }
    if strLine <> '' then
    begin
      strBlank := '';
      intBlank := 3 * (16 - intLen mod 16);
      for III  := 0 to intBlank - 1 do
      begin
        strBlank := strBlank + ' ';
      end;
      mmoHexView.Lines.Add(IntToHex(intStartPos + 16 * JJJ, 8) + '  ' + strLine + strBlank + '  ' + strContent);
    end;

  finally
    FileClose(hPEFile);
  end;
end;

procedure TForm1.ShowNTHeaderX64(const strFileName: string);
var
  hPEFile: Cardinal;
  idh    : TImageDosHeader;
  inh    : TImageNtHeaders64;
  III    : Integer;
begin
  hPEFile := FileOpen(strFileName, fmOpenRead);
  try
    FileRead(hPEFile, idh, SizeOf(TImageDosHeader));
    FileSeek(hPEFile, idh._lfanew, 0);
    FileRead(hPEFile, inh, SizeOf(TImageNtHeaders32));
    lbl67.Caption := Format('$%0.8x', [inh.Signature]);
    lbl68.Caption := Format('$%0.4x', [inh.FileHeader.Machine]);
    lbl69.Caption := Format('$%0.4x', [inh.FileHeader.NumberOfSections]);
    lbl70.Caption := Format('$%0.8x', [inh.FileHeader.TimeDateStamp]);
    lbl71.Caption := Format('$%0.8x', [inh.FileHeader.PointerToSymbolTable]);
    lbl72.Caption := Format('$%0.8x', [inh.FileHeader.NumberOfSymbols]);
    lbl73.Caption := Format('$%0.4x', [inh.FileHeader.SizeOfOptionalHeader]);
    lbl74.Caption := Format('$%0.4x', [inh.FileHeader.Characteristics]);

    lbl124.Caption := Format('$%0.4x', [inh.OptionalHeader.Magic]);
    lbl125.Caption := Format('$%0.2x', [inh.OptionalHeader.MajorLinkerVersion]);
    lbl126.Caption := Format('$%0.2x', [inh.OptionalHeader.MinorLinkerVersion]);
    lbl127.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfCode]);
    lbl128.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfInitializedData]);
    lbl129.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfUninitializedData]);
    lbl130.Caption := Format('$%0.8x', [inh.OptionalHeader.AddressOfEntryPoint]);
    lbl131.Caption := Format('$%0.8x', [inh.OptionalHeader.BaseOfCode]);
    lbl132.Visible := False;
    lbl85.Visible  := False;
    lbl133.Caption := Format('$%0.8x', [inh.OptionalHeader.ImageBase]);
    lbl134.Caption := Format('$%0.8x', [inh.OptionalHeader.SectionAlignment]);
    lbl135.Caption := Format('$%0.8x', [inh.OptionalHeader.FileAlignment]);
    lbl136.Caption := Format('$%0.4x', [inh.OptionalHeader.MajorOperatingSystemVersion]);
    lbl137.Caption := Format('$%0.4x', [inh.OptionalHeader.MinorOperatingSystemVersion]);
    lbl138.Caption := Format('$%0.4x', [inh.OptionalHeader.MajorImageVersion]);
    lbl139.Caption := Format('$%0.4x', [inh.OptionalHeader.MinorImageVersion]);
    lbl140.Caption := Format('$%0.4x', [inh.OptionalHeader.MajorSubsystemVersion]);
    lbl141.Caption := Format('$%0.4x', [inh.OptionalHeader.MinorSubsystemVersion]);
    lbl142.Caption := Format('$%0.8x', [inh.OptionalHeader.Win32VersionValue]);
    lbl143.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfImage]);
    lbl144.Caption := Format('$%0.4x', [inh.OptionalHeader.SizeOfHeaders]);
    lbl145.Caption := Format('$%0.8x', [inh.OptionalHeader.CheckSum]);
    lbl146.Caption := Format('$%0.4x', [inh.OptionalHeader.Subsystem]);
    lbl147.Caption := Format('$%0.4x', [inh.OptionalHeader.DllCharacteristics]);
    lbl148.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfStackReserve]);
    lbl149.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfStackCommit]);
    lbl150.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfHeapReserve]);
    lbl151.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfHeapCommit]);
    lbl152.Caption := Format('$%0.8x', [inh.OptionalHeader.LoaderFlags]);
    lbl153.Caption := Format('$%0.8x', [inh.OptionalHeader.NumberOfRvaAndSizes]);
    for III        := 0 to 15 do
    begin
      TLabel(FindComponent('lbl' + IntToStr(154 + 2 * III + 0))).Caption := Format('$%0.8x', [inh.OptionalHeader.DataDirectory[III].VirtualAddress]);
      TLabel(FindComponent('lbl' + IntToStr(154 + 2 * III + 1))).Caption := Format('$%0.8x', [inh.OptionalHeader.DataDirectory[III].Size]);
    end;
  finally
    FileClose(hPEFile);
  end;
end;

procedure TForm1.ShowNTHeaderX86(const strFileName: string);
var
  hPEFile: Cardinal;
  idh    : TImageDosHeader;
  inh    : TImageNtHeaders32;
  III    : Integer;
begin
  hPEFile := FileOpen(strFileName, fmOpenRead);
  try
    FileRead(hPEFile, idh, SizeOf(TImageDosHeader));
    FileSeek(hPEFile, idh._lfanew, 0);
    FileRead(hPEFile, inh, SizeOf(TImageNtHeaders32));
    lbl67.Caption := Format('$%0.8x', [inh.Signature]);
    lbl68.Caption := Format('$%0.4x', [inh.FileHeader.Machine]);
    lbl69.Caption := Format('$%0.4x', [inh.FileHeader.NumberOfSections]);
    lbl70.Caption := Format('$%0.8x', [inh.FileHeader.TimeDateStamp]);
    lbl71.Caption := Format('$%0.8x', [inh.FileHeader.PointerToSymbolTable]);
    lbl72.Caption := Format('$%0.8x', [inh.FileHeader.NumberOfSymbols]);
    lbl73.Caption := Format('$%0.4x', [inh.FileHeader.SizeOfOptionalHeader]);
    lbl74.Caption := Format('$%0.4x', [inh.FileHeader.Characteristics]);

    lbl124.Caption := Format('$%0.4x', [inh.OptionalHeader.Magic]);
    lbl125.Caption := Format('$%0.2x', [inh.OptionalHeader.MajorLinkerVersion]);
    lbl126.Caption := Format('$%0.2x', [inh.OptionalHeader.MinorLinkerVersion]);
    lbl127.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfCode]);
    lbl128.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfInitializedData]);
    lbl129.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfUninitializedData]);
    lbl130.Caption := Format('$%0.8x', [inh.OptionalHeader.AddressOfEntryPoint]);
    lbl131.Caption := Format('$%0.8x', [inh.OptionalHeader.BaseOfCode]);
    lbl132.Caption := Format('$%0.8x', [inh.OptionalHeader.BaseOfData]);
    lbl132.Visible := True;
    lbl85.Visible  := True;
    lbl133.Caption := Format('$%0.8x', [inh.OptionalHeader.ImageBase]);
    lbl134.Caption := Format('$%0.8x', [inh.OptionalHeader.SectionAlignment]);
    lbl135.Caption := Format('$%0.8x', [inh.OptionalHeader.FileAlignment]);
    lbl136.Caption := Format('$%0.4x', [inh.OptionalHeader.MajorOperatingSystemVersion]);
    lbl137.Caption := Format('$%0.4x', [inh.OptionalHeader.MinorOperatingSystemVersion]);
    lbl138.Caption := Format('$%0.4x', [inh.OptionalHeader.MajorImageVersion]);
    lbl139.Caption := Format('$%0.4x', [inh.OptionalHeader.MinorImageVersion]);
    lbl140.Caption := Format('$%0.4x', [inh.OptionalHeader.MajorSubsystemVersion]);
    lbl141.Caption := Format('$%0.4x', [inh.OptionalHeader.MinorSubsystemVersion]);
    lbl142.Caption := Format('$%0.8x', [inh.OptionalHeader.Win32VersionValue]);
    lbl143.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfImage]);
    lbl144.Caption := Format('$%0.4x', [inh.OptionalHeader.SizeOfHeaders]);
    lbl145.Caption := Format('$%0.8x', [inh.OptionalHeader.CheckSum]);
    lbl146.Caption := Format('$%0.4x', [inh.OptionalHeader.Subsystem]);
    lbl147.Caption := Format('$%0.4x', [inh.OptionalHeader.DllCharacteristics]);
    lbl148.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfStackReserve]);
    lbl149.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfStackCommit]);
    lbl150.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfHeapReserve]);
    lbl151.Caption := Format('$%0.8x', [inh.OptionalHeader.SizeOfHeapCommit]);
    lbl152.Caption := Format('$%0.8x', [inh.OptionalHeader.LoaderFlags]);
    lbl153.Caption := Format('$%0.8x', [inh.OptionalHeader.NumberOfRvaAndSizes]);
    for III        := 0 to 15 do
    begin
      TLabel(FindComponent('lbl' + IntToStr(154 + 2 * III + 0))).Caption := Format('$%0.8x', [inh.OptionalHeader.DataDirectory[III].VirtualAddress]);
      TLabel(FindComponent('lbl' + IntToStr(154 + 2 * III + 1))).Caption := Format('$%0.8x', [inh.OptionalHeader.DataDirectory[III].Size]);
    end;
  finally
    FileClose(hPEFile);
  end;
end;

{ 显示 节表 }
procedure TForm1.ShowSectionTable(const strFileName: string; const bX64: Boolean);
type
  PPImageSectionHeader = ^PImageSectionHeader;
  PImageSectionHeader  = ^TImageSectionHeader;

  _IMAGE_SECTION_HEADER = record
    Name: packed array [0 .. IMAGE_SIZEOF_SHORT_NAME - 1] of AnsiChar;
    Misc: TISHMisc;
    VirtualAddress: DWORD;
    SizeOfRawData: DWORD;
    PointerToRawData: DWORD;
    PointerToRelocations: DWORD;
    PointerToLinenumbers: DWORD;
    NumberOfRelocations: Word;
    NumberOfLinenumbers: Word;
    Characteristics: DWORD;
  end;

  TImageSectionHeader  = _IMAGE_SECTION_HEADER;
  IMAGE_SECTION_HEADER = _IMAGE_SECTION_HEADER;
var
  idh             : TImageDosHeader;
  inh32           : TImageNtHeaders32;
  inh64           : TImageNtHeaders64;
  hPEFile         : Cardinal;
  intSectionTables: Integer;
  III             : Integer;
  sts             : array of TImageSectionHeader;
begin
  hPEFile := FileOpen(strFileName, fmOpenRead);
  try
    FileRead(hPEFile, idh, SizeOf(TImageDosHeader));
    FileSeek(hPEFile, idh._lfanew, 0);
    if not bX64 then
    begin
      FileRead(hPEFile, inh32, SizeOf(TImageNtHeaders32));
      intSectionTables := inh32.FileHeader.NumberOfSections;
    end
    else
    begin
      FileRead(hPEFile, inh64, SizeOf(TImageNtHeaders64));
      intSectionTables := inh64.FileHeader.NumberOfSections;
    end;
    SetLength(sts, intSectionTables);
    FileRead(hPEFile, sts[0], SizeOf(TImageSectionHeader) * intSectionTables);
    lv1.Items.Clear;
    for III := 0 to intSectionTables - 1 do
    begin
      with lv1.Items.Add do
      begin
        Caption := string(sts[III].Name);
        SubItems.Add(Format('$%0.8x', [sts[III].Misc.PhysicalAddress]));
        SubItems.Add(Format('$%0.8x', [sts[III].VirtualAddress]));
        SubItems.Add(Format('$%0.8x', [sts[III].SizeOfRawData]));
        SubItems.Add(Format('$%0.8x', [sts[III].PointerToRawData]));
        SubItems.Add(Format('$%0.8x', [sts[III].Characteristics]));
      end;
    end;
  finally
    FileClose(hPEFile);
  end;
end;

{ 读取 DOS STUB }
procedure TForm1.ShowDosStub(const strPEFileName: string);
var
  idh    : TImageDosHeader;
  hPEFile: Cardinal;
begin
  hPEFile := FileOpen(strPEFileName, fmOpenRead);
  try
    FileRead(hPEFile, idh, SizeOf(TImageDosHeader));
  finally
    FileClose(hPEFile);
  end;
  ShowHexView(strPEFileName, SizeOf(TImageDosHeader), idh._lfanew);
end;

{ 解析PE x64 }
procedure TForm1.AnalyzePEX64(const strPEFileName: string; const bDll: Boolean);
begin
  PEInfo(strPEFileName, True, bDll);
  ReadImageDosHeader(strPEFileName);
  ShowDosStub(strPEFileName);
  ShowNTHeaderX64(strPEFileName);
  ShowSectionTable(strPEFileName, True);
end;

{ 解析PE x86 }
procedure TForm1.AnalyzePEX86(const strPEFileName: string; const bDll: Boolean);
begin
  PEInfo(strPEFileName, False, bDll);
  ReadImageDosHeader(strPEFileName);
  ShowDosStub(strPEFileName);
  ShowNTHeaderX86(strPEFileName);
  ShowSectionTable(strPEFileName, False);
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  ShowCharSignForm(StrToInt(lbl74.Caption));
end;

end.

unit Unit1;
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCtrls, System.IOUtils, FileCtrl, Vcl.ExtCtrls,
  Vcl.ComCtrls;

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
    procedure srchbxPEFileNameInvokeSearch(Sender: TObject);
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
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

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
        TSearchBox(Sender).Text := strPEFileName;
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
    lbl17.Caption := Format('$%0.2x', [idh.e_magic]);
    lbl21.Caption := Format('$%0.2x', [idh.e_cblp]);
    lbl22.Caption := Format('$%0.2x', [idh.e_cp]);
    lbl23.Caption := Format('$%0.2x', [idh.e_crlc]);
    lbl24.Caption := Format('$%0.2x', [idh.e_cparhdr]);
    lbl25.Caption := Format('$%0.2x', [idh.e_minalloc]);
    lbl26.Caption := Format('$%0.2x', [idh.e_maxalloc]);
    lbl27.Caption := Format('$%0.2x', [idh.e_ss]);
    lbl28.Caption := Format('$%0.2x', [idh.e_sp]);
    lbl29.Caption := Format('$%0.2x', [idh.e_csum]);
    lbl30.Caption := Format('$%0.2x', [idh.e_ip]);
    lbl31.Caption := Format('$%0.2x', [idh.e_cs]);
    lbl32.Caption := Format('$%0.2x', [idh.e_lfarlc]);
    lbl33.Caption := Format('$%0.2x', [idh.e_ovno]);
    lbl34.Caption := Format('$%0.8x', [0]);
    lbl35.Caption := Format('$%0.2x', [idh.e_oemid]);
    lbl36.Caption := Format('$%0.2x', [idh.e_oeminfo]);
    lbl37.Caption := Format('$%0.8x%0.8x%0.4x', [0, 0, 0]);
    lbl38.Caption := Format('$%0.4x', [idh._lfanew]);
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
begin

end;

procedure TForm1.ShowNTHeaderX86(const strFileName: string);
begin

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
end;

{ 解析PE x86 }
procedure TForm1.AnalyzePEX86(const strPEFileName: string; const bDll: Boolean);
begin
  PEInfo(strPEFileName, False, bDll);
  ReadImageDosHeader(strPEFileName);
  ShowDosStub(strPEFileName);
  ShowNTHeaderX86(strPEFileName);
end;

end.

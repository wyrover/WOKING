unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls;

type
  TForm4 = class(TForm)
    lvFunc: TListView;
    grp1: TGroupBox;
    lbl62: TLabel;
    lbl63: TLabel;
    lbl64: TLabel;
    lbl65: TLabel;
    lbl66: TLabel;
    lbl74: TLabel;
    lbl73: TLabel;
    lbl72: TLabel;
    lbl71: TLabel;
    lbl70: TLabel;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private declarations }
    procedure FindExportTablePos(const sts: array of TImageSectionHeader; const intVA, intSize: Cardinal; var intRA: Cardinal); overload;
  public
    { Public declarations }
  end;

procedure ShowExportFuncList(const strPEFileName: string);

implementation

{$R *.dfm}

procedure ShowExportFuncList(const strPEFileName: string);
var
  hPEFile        : Cardinal;
  idh            : TImageDosHeader;
  inhX86         : TImageNtHeaders32;
  inhX64         : TImageNtHeaders64;
  bX64           : Boolean;
  intVA          : Cardinal;
  intSize        : Cardinal;
  intRA          : Cardinal;
  stsArr         : array of TImageSectionHeader;
  eft            : TImageExportDirectory;
  strDllFileName : array [0 .. 255] of AnsiChar;
  strFunctionName: array [0 .. 255] of Char;
  III            : Integer;
  intFuncVA      : Cardinal;
  intFuncRA      : Cardinal;
begin
  with TForm4.Create(nil) do
  begin
    Position := poScreenCenter;
    hPEFile  := FileOpen(strPEFileName, fmOpenRead);
    if hPEFile = INVALID_HANDLE_VALUE then
    begin
      ShowMessage('文件无法打开，请确认是否被其它程序占用了');
      Exit;
    end;

    try
      FileRead(hPEFile, idh, SizeOf(TImageDosHeader));
      FileSeek(hPEFile, idh._lfanew, 0);
      FileRead(hPEFile, inhX86, SizeOf(TImageNtHeaders32));
      bX64 := inhX86.Signature = IMAGE_FILE_MACHINE_AMD64;
      if bX64 then
      begin
        FileSeek(hPEFile, idh._lfanew, 0);
        FileRead(hPEFile, inhX64, SizeOf(TImageNtHeaders64));
        intVA   := inhX64.OptionalHeader.DataDirectory[0].VirtualAddress;
        intSize := inhX64.OptionalHeader.DataDirectory[0].Size;
        SetLength(stsArr, inhX64.FileHeader.NumberOfSections);
        FileRead(hPEFile, stsArr[0], inhX64.FileHeader.NumberOfSections * SizeOf(TImageSectionHeader));
      end
      else
      begin
        intVA   := inhX86.OptionalHeader.DataDirectory[0].VirtualAddress;
        intSize := inhX86.OptionalHeader.DataDirectory[0].Size;
        SetLength(stsArr, inhX86.FileHeader.NumberOfSections);
        FileRead(hPEFile, stsArr[0], inhX86.FileHeader.NumberOfSections * SizeOf(TImageSectionHeader));
      end;

      FindExportTablePos(stsArr, intVA, intSize, intRA);
      if intRA <> 0 then
      begin
        FileSeek(hPEFile, intRA, 0);
        FileRead(hPEFile, eft, SizeOf(TImageExportDirectory));
        lbl70.Caption := Format('$%0.8x', [intRA]);
        lbl71.Caption := Format('$%0.8x', [eft.Characteristics]);
        lbl72.Caption := Format('$%0.8x', [eft.Base]);
        lbl73.Caption := Format('$%0.8x', [eft.Name]);
        FileSeek(hPEFile, eft.Name - intVA + intRA, 0);
        FileRead(hPEFile, strDllFileName, 256);
        lbl74.Caption := String((strDllFileName));
        lbl6.Caption  := Format('$%0.8x', [eft.NumberOfFunctions]);
        lbl7.Caption  := Format('$%0.8x', [eft.NumberOfNames]);
        lbl8.Caption  := Format('$%0.8x', [eft.AddressOfFunctions]);
        lbl9.Caption  := Format('$%0.8x', [eft.AddressOfNames]);
        lbl10.Caption := Format('$%0.8x', [eft.AddressOfNameOrdinals]);
        lvFunc.Items.Clear;
        for III := 0 to eft.NumberOfNames - 1 do
        begin
          intFuncVA := eft.AddressOfNames + DWORD(4 * III);
          intFuncRA := intFuncVA - intVA + intRA;
          FileSeek(hPEFile, intFuncRA, 0);
          FileRead(hPEFile, strFunctionName, 256);
          with lvFunc.Items.Add do
          begin
            Caption := Format('%0.2d', [III]);
            SubItems.Add('');
            SubItems.Add('');
            SubItems.Add(string(strFunctionName));
          end;
        end;
      end;
    finally
      FileClose(hPEFile);
    end;

    ShowModal;
    Free;
  end;
end;

{ TForm4 }

procedure TForm4.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := 0;
end;

procedure TForm4.FindExportTablePos(const sts: array of TImageSectionHeader; const intVA, intSize: Cardinal; var intRA: Cardinal);
var
  III, Count: Integer;
  intIndex  : Integer;
begin
  intRA := 0;

  Count    := High(sts) - Low(sts) + 1;
  intIndex := -1;
  for III  := 0 to Count - 1 do
  begin
    if (sts[III].VirtualAddress < intVA) and (sts[III].VirtualAddress + sts[III].SizeOfRawData >= intVA + intSize) then
    begin
      intIndex := III;
      Break;
    end;
  end;

  if intIndex <> -1 then
  begin
    intRA := intVA - sts[intIndex].VirtualAddress + sts[intIndex].PointerToRawData;
  end;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

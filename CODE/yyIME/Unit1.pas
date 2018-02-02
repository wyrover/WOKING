unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.IniFiles, Vcl.WinXCtrls;

type
  TForm1 = class(TForm)
    srchbx1: TSearchBox;
    pnl1: TPanel;
    edt2: TEdit;
    lstHZ: TListBox;
    lstHZPY: TListBox;
    lstCY: TListBox;
    lstCYPY: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure srchbx1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure srchbx1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FHZPYHashList  : THashedStringList;
    FChenYuHashList: THashedStringList;
    function LengthText(const strValue: string; const fFont: TFont): Integer;
    procedure FormPos;
    procedure SendHZToFocusWindow;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.LengthText(const strValue: string; const fFont: TFont): Integer;
var
  tmpCanvas: TCanvas;
begin
  tmpCanvas := TCanvas.Create;
  try
    tmpCanvas.Handle := GetDC(Handle);
    tmpCanvas.Font   := fFont;
    Result           := tmpCanvas.TextWidth(strValue);
  finally
    ReleaseDC(Handle, tmpCanvas.Handle);
    tmpCanvas.Free;
  end;
end;

procedure TForm1.SendHZToFocusWindow;
begin
  //
end;

procedure TForm1.srchbx1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = $20 then
  begin
    SendHZToFocusWindow;
  end;
end;

procedure TForm1.srchbx1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  strPY: String;
  III  : Integer;
  JJJ  : Integer;
begin
  if Key = $20 then
  begin
    srchbx1.Text      := Trim(srchbx1.Text);
    srchbx1.SelStart  := Length(srchbx1.Text);
    srchbx1.SelLength := Length(srchbx1.Text);
    Exit;
  end;

  strPY := Trim(srchbx1.Text);
  if Length(strPY) <= 1 then
  begin
    edt2.Text  := '';
    pnl1.Width := 125;
    Width      := edt2.Width + 164;
    Exit;
  end;

  { }
  JJJ       := 0;
  edt2.Text := '';
  for III   := 0 to lstHZ.Count - 1 do
  begin
    if string(lstHZPY.Items.Strings[III]).Contains(strPY) then
    begin
      if JJJ >= 10 then
        Break;

      Inc(JJJ);
      edt2.Text := edt2.Text + ' ' + Format('%d.%s', [JJJ, lstHZ.Items.Strings[III]]);
    end;
  end;

  { }
  if JJJ = 0 then
  begin
    for III := 0 to lstCY.Count - 1 do
    begin
      if string(lstCYPY.Items.Strings[III]).Contains(strPY) then
      begin
        if JJJ >= 10 then
          Break;

        Inc(JJJ);
        edt2.Text := edt2.Text + ' ' + Format('%d.%s', [JJJ, lstCY.Items.Strings[III]]);
      end;
    end;
  end;

  if edt2.Text = '' then
    pnl1.Width := 125
  else
    pnl1.Width := LengthText(edt2.Text, edt2.Font) + 15;

  Width := edt2.Width + 164;
  FormPos;
end;

procedure TForm1.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style   := Params.Style or WS_POPUP;
  Params.ExStyle := WS_EX_TOPMOST or WS_EX_TOOLWINDOW OR WS_EX_NOACTIVATE or WS_EX_WINDOWEDGE;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  III: Integer;
begin
  { }
  FHZPYHashList := THashedStringList.Create;
  for III       := 0 to lstHZ.Count - 1 do
  begin
    FHZPYHashList.Add(Format('%s=%s', [lstHZ.Items.Strings[III], lstHZPY.Items.Strings[III]]));
  end;

  { }
  FChenYuHashList := THashedStringList.Create;
  for III         := 0 to lstCY.Count - 1 do
  begin
    FChenYuHashList.Add(Format('%s=%s', [lstCY.Items.Strings[III], lstCYPY.Items.Strings[III]]));
  end;

  FormPos;
  Left := Screen.Width - Width - 10;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FHZPYHashList.Free;
  FChenYuHashList.Free;
end;

procedure TForm1.FormPos;
begin
  Top := Screen.Height - Height - 10;

  if Left + Width + 10 > Screen.Width then
    Left := Screen.Width - Width - 10;
end;

end.

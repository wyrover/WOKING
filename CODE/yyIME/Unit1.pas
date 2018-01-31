unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.IniFiles, Vcl.WinXCtrls;

type
  TForm1 = class(TForm)
    srchbx1: TSearchBox;
    pnl1: TPanel;
    edt2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure srchbx1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FstrhashList: THashedStringList;
    function LengthText(const strValue: string; const fFont: TFont): Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses untHZ;

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

procedure TForm1.srchbx1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  strPY: String;
  III  : Integer;
  JJJ  : Integer;
begin
  strPY := Trim(srchbx1.Text);
  if Length(strPY) <= 1 then
  begin
    edt2.Text  := '';
    pnl1.Width := 125;
    Width      := edt2.Width + 164;
    Exit;
  end;

  JJJ       := 0;
  edt2.Text := '';

  for III := Low(c_hzpy) to High(c_hzpy) do
  begin
    if string(c_hzpy[III]).Contains(strPY) then
    begin
      if JJJ >= 10 then
        Break;

      Inc(JJJ);
      edt2.Text := edt2.Text + ' ' + Format('%0.2d.%s', [JJJ, c_hz[III]]);
    end;
  end;

  if edt2.Text = '' then
    pnl1.Width := 125
  else
    pnl1.Width := LengthText(edt2.Text, edt2.Font) + 15;

  Width := edt2.Width + 164;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  III: Integer;
begin
  FstrhashList := THashedStringList.Create;
  for III      := Low(c_hzpy) to High(c_hzpy) do
  begin
    FstrhashList.Add(Format('%s=%s', [c_hz[III], c_hzpy[III]]));
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FstrhashList.Free;
end;

end.

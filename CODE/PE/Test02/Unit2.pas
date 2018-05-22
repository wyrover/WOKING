unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    pnl1: TPanel;
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
    lbl15: TLabel;
    lbl16: TLabel;
    chk1: TCheckBox;
    chk2: TCheckBox;
    chk3: TCheckBox;
    chk4: TCheckBox;
    chk5: TCheckBox;
    chk6: TCheckBox;
    chk7: TCheckBox;
    chk8: TCheckBox;
    chk9: TCheckBox;
    chk10: TCheckBox;
    chk11: TCheckBox;
    chk12: TCheckBox;
    chk13: TCheckBox;
    chk14: TCheckBox;
    chk15: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowCharSignForm(const intCharSign: Word);

implementation

{$R *.dfm}

procedure ShowCharSignForm(const intCharSign: Word);
var
  III    : Integer;
  chkTemp: TCheckBox;
begin
  with TForm2.Create(nil) do
  begin
    Caption := Format('标志：($%0.4x)', [intCharSign]);
    for III := 1 to 15 do
    begin
      chkTemp         := TCheckBox(FindComponent('chk' + IntToStr(III)));
      chkTemp.Checked := chkTemp.Tag and intCharSign = chkTemp.Tag;
    end;
    ShowModal;
    Free;
  end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

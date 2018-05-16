unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm3 = class(TForm)
    pnl1: TPanel;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowSectionAttrForm(const intAttr: Integer);

implementation

{$R *.dfm}

procedure ShowSectionAttrForm(const intAttr: Integer);
var
  intTag : int64;
  chkTemp: TCheckBox;
  III    : Integer;
begin
  with TForm3.Create(nil) do
  begin
    for III := 1 to 15 do
    begin
      chkTemp := TCheckBox(FindComponent('chk' + IntToStr(III)));
      if III <> 4 then
      begin
        chkTemp.Checked := chkTemp.Tag and intAttr = chkTemp.Tag;
      end
      else
      begin
        intTag          := chk4.Tag + 1;
        chkTemp.Checked := intTag and intAttr = intTag;
      end;
    end;
    Caption := Format('Characteristics/Çø¶Î±ê¼Ç ($%0.8x)', [intAttr]);
    ShowModal;
    Free;
  end;
end;

end.

unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Unit2,
  Vcl.ComCtrls, System.Types;

type
  TForm1 = class(TForm)
    lvIP: TListView;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    btnStart: TButton;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure WMIPOK(var msg: TMessage); message WM_IPOK;
    procedure WMTHREADEND(var msg: TMessage); message WM_THREADEND;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnStartClick(Sender: TObject);
begin
  lvIP.Clear;

  ScanLanIP(Format('%s.%s.%s', [edt1.Text, edt2.Text, edt3.Text]));
  btnStart.Enabled := False;
end;

procedure TForm1.WMIPOK(var msg: TMessage);
var
  strMsg  : String;
  strIPDyn: TStringDynArray;
begin
  strMsg   := string(PChar(msg.WParam));
  strIPDyn := SplitString(strMsg, Chr(9));
  with lvIP.Items.Add do
  begin
    Caption := IntToStr(lvIP.Items.Count);
    SubItems.Add(strIPDyn[1]);
    SubItems.Add(strIPDyn[2]);
    SubItems.Add(strIPDyn[3]);
    SubItems.Add(strIPDyn[4]);
  end;
end;

procedure TForm1.WMTHREADEND(var msg: TMessage);
begin
  btnStart.Enabled := True;
  ShowMessage('…®√ËΩ· ¯');
end;

end.

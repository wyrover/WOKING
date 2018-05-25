unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TfrmPEInfo = class(TForm)
    btn1: TButton;
    mmo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowDllForm(var strTitle: PChar; var frm: TFormClass); stdcall;

implementation

{$R *.dfm}

procedure ShowDllForm(var strTitle: PChar; var frm: TFormClass); stdcall;
begin
  strTitle := 'PEInfo';
  frm      := TfrmPEInfo;
end;

procedure TfrmPEInfo.btn1Click(Sender: TObject);
begin
  ShowMessage('aaaaaaaaaa');
end;

procedure TfrmPEInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmWaitting = class(TForm)
    lbl1: TLabel;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowWaittingForm;
procedure EnableWaittingForm(const strTilte: String);
procedure CloseWaittingForm;

implementation

{$R *.dfm}

var
  frmWaitting: TfrmWaitting;

procedure EnableWaittingForm(const strTilte: String);
begin
  frmWaitting.lbl1.Caption := strTilte;
  frmWaitting.lbl1.Left    := (frmWaitting.Width - frmWaitting.lbl1.Width) div 2;
  frmWaitting.btn1.Enabled := True;
end;

procedure ShowWaittingForm;
begin
  frmWaitting           := TfrmWaitting.Create(nil);
  frmWaitting.FormStyle := fsStayOnTop;
  frmWaitting.lbl1.Left := (frmWaitting.Width - frmWaitting.lbl1.Width) div 2;
  SetWindowLong(frmWaitting.Handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);
  frmWaitting.Show;
end;

procedure CloseWaittingForm;
begin
  frmWaitting.Close;
end;

procedure TfrmWaitting.btn1Click(Sender: TObject);
begin
  CloseWaittingForm;
end;

procedure TfrmWaitting.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

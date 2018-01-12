unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmDB = class(TForm)
    lbl1: TLabel;
    lbl3: TLabel;
    lbl2: TLabel;
    img1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbl1MouseEnter(Sender: TObject);
    procedure lbl1MouseLeave(Sender: TObject);
    procedure lbl1Click(Sender: TObject);
    procedure lbl3Click(Sender: TObject);
    procedure lbl2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDB: TfrmDB;

implementation

{$R *.dfm}

procedure TfrmDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmDB.lbl1Click(Sender: TObject);
begin
  //
end;

procedure TfrmDB.lbl1MouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clRed;
end;

procedure TfrmDB.lbl1MouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlue;
end;

procedure TfrmDB.lbl3Click(Sender: TObject);
begin
  //
end;

procedure TfrmDB.lbl2Click(Sender: TObject);
begin
  //
end;

end.

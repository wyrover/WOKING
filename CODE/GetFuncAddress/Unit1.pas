unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Rtti;

type
  TForm1 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses untGetFuncName;

procedure TForm1.btn1Click(Sender: TObject);
begin
  GetEIP;
  btn1.Caption := GetCurrentFuncName(Self);
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  GetEIP;
  btn2.Caption := GetCurrentFuncName(Self);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  GetEIP;
  Caption := GetCurrentFuncName(Self);
end;

end.

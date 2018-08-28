unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Imaging.GIFImg, Vcl.Imaging.pngimage, Vcl.ExtDlgs;

type
  TForm1 = class(TForm)
    Image1: TImage;
    btn1: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function LoadCarImage(const strFileName: PAnsiChar): PAnsiChar; stdcall; external 'cp.dll';

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  strImageFileName: PAnsiChar;
  abc             : PAnsiChar;
begin
  with TOpenPictureDialog.Create(nil) do
  begin
    Filter := 'Í¼ÐÎÍ¼Ïñ(*.BMP;*.JPG;*.GIF;*.TIFF;*.PNG)|*.BMP;*.JPG;*.GIF;*.TIFF;*.PNG';
    if Execute() then
    begin
      Image1.Picture.LoadFromFile(FileName);
      strImageFileName := PAnsiChar(AnsiString(FileName));
      abc              := (LoadCarImage(strImageFileName));
      btn1.Caption     := string(abc);
    end;
    Free;
  end;
end;

end.

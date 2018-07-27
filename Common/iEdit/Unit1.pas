unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.Imaging.jpeg, Vcl.Imaging.GIFImg, Vcl.Imaging.pngimage,
  Vcl.ExtDlgs, uUltraBmp32;

type
  TForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    mniFile: TMenuItem;
    mniFileOpen: TMenuItem;
    mniTFColor: TMenuItem;
    mniTFMorp: TMenuItem;
    mniTFColorGray: TMenuItem;
    mniTFColorInvert: TMenuItem;
    mniTFGeometricHorMirror: TMenuItem;
    mniTFGeometricVerMirror: TMenuItem;
    mniTFGeometricRotate: TMenuItem;
    mniTFGeometricTransposition: TMenuItem;
    mniTFGeometricHorVerMirror: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    mniTFColorTwoValue: TMenuItem;
    mniTFGeometric: TMenuItem;
    mniRestore: TMenuItem;
    procedure mniFileOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mniTFColorGrayClick(Sender: TObject);
    procedure mniTFColorInvertClick(Sender: TObject);
    procedure mniRestoreClick(Sender: TObject);
  private
    { Private declarations }
    FBmpBack: TBitmap;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FBmpBack := TBitmap.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FBmpBack.Free;
end;

procedure TForm1.mniFileOpenClick(Sender: TObject);
var
  intST, intET: Cardinal;
begin
  if not OpenPictureDialog1.Execute then
    Exit;

  intST := GetTickCount;
  LoadPic(OpenPictureDialog1.FileName, FBmpBack);
  intET   := GetTickCount;
  Caption := Format('解码用时 %d 毫秒', [intET - intST]);
  Image1.Picture.Bitmap.Assign(FBmpBack);
end;

procedure TForm1.mniRestoreClick(Sender: TObject);
begin
  Image1.Picture.Bitmap.Assign(FBmpBack);
end;

procedure TForm1.mniTFColorGrayClick(Sender: TObject);
var
  intST, intET: Cardinal;
begin
  intST := GetTickCount;
  GrayColor(Image1.Picture.Bitmap);
  intET   := GetTickCount;
  Caption := Format('执行用时 %d 毫秒', [intET - intST]);

  Image1.Refresh;
end;

procedure TForm1.mniTFColorInvertClick(Sender: TObject);
var
  intST, intET: Cardinal;
begin
  intST := GetTickCount;
  InvertColor(Image1.Picture.Bitmap, itSSE2);
  intET   := GetTickCount;
  Caption := Format('执行用时 %d 毫秒', [intET - intST]);
  Image1.Refresh;
end;

end.

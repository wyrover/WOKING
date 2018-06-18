unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Math, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ExtDlgs, Vcl.Menus,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg, untOpenCV, untOpenCVType;

type
  TForm1 = class(TForm)
    img1: TImage;
    dlgOpenPic1: TOpenPictureDialog;
    mmMain: TMainMenu;
    mnuFile: TMenuItem;
    mnuFileOpen: TMenuItem;
    mnuFileSaveAs: TMenuItem;
    mnuCT: TMenuItem;
    mnuGT: TMenuItem;
    mnuMT: TMenuItem;
    mnuOR: TMenuItem;
    mnuHelp: TMenuItem;
    mnuHelpAbout: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mnuFileOpenClick(Sender: TObject);
    procedure mnuFileSaveAsClick(Sender: TObject);
    procedure mnuHelpAboutClick(Sender: TObject);
  private
    { Private declarations }
    OpenCV: TOpenCV;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenCV := TOpenCV.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  OpenCV.Free;
end;

procedure TForm1.mnuFileOpenClick(Sender: TObject);
var
  pImage: PIplImage;
  bmp   : TBitmap;
begin
  if not dlgOpenPic1.Execute then
    Exit;

  pImage := OpenCV.cvLoadImage(PChar(AnsiString(dlgOpenPic1.FileName)));
  if pImage = nil then
    Exit;

  bmp := TBitmap.Create;
  try
    bmp.PixelFormat := TPixelFormat(Integer(IfThen(pImage^.depth = 8, Integer(pf24bit), Integer(pf32bit))));
    bmp.Height      := pImage^.Height;
    bmp.Width       := pImage^.Width;
    SetBitmapBits(bmp.Handle, pImage^.imageSize, pImage^.imageData);
    img1.Picture.Bitmap.Assign(bmp);
    OpenCV.cvReleaseImage(pImage);
  finally
    bmp.Free;
  end;
end;

procedure TForm1.mnuFileSaveAsClick(Sender: TObject);
begin
  //
end;

procedure TForm1.mnuHelpAboutClick(Sender: TObject);
begin
  MessageBox(Handle, '调用 OpenCV::cv::getBuildInformation 函数，C++ 成员函数，未完待续', PWideChar(String(Form1.Caption)), 64);
end;

end.

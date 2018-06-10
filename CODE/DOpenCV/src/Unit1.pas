unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ExtDlgs,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg, System.Math, untOpenCV, untOpenCVType;

type
  TForm1 = class(TForm)
    img1: TImage;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    dlgOpenPic1: TOpenPictureDialog;
    mmo1: TMemo;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
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

procedure TForm1.btn1Click(Sender: TObject);
var
  pImage: PIplImage;
begin
  if not dlgOpenPic1.Execute then
    Exit;

  pImage := OpenCV.cvLoadImage(PChar(AnsiString(dlgOpenPic1.FileName)));
  if pImage <> nil then
  begin
    OpenCV.cvNamedWindow('Test01', CV_WINDOW_AUTOSIZE);
    OpenCV.cvShowImage('Test01', pImage);
    OpenCV.cvWaitKey(0);
    OpenCV.cvReleaseImage(pImage);
    OpenCV.cvDestroyWindow('Test01');
  end;
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  pImage: PIplImage;
  bmp   : TBitmap;
begin
  if not dlgOpenPic1.Execute then
    Exit;

  pImage := OpenCV.cvLoadImage(PChar(AnsiString(dlgOpenPic1.FileName)));
  if pImage <> nil then
  begin
    bmp             := TBitmap.Create;
    bmp.PixelFormat := TPixelFormat(Integer(IfThen(pImage^.depth = 8, Integer(pf24bit), Integer(pf32bit))));
    bmp.Height      := pImage^.Height;
    bmp.Width       := pImage^.Width;
    SetBitmapBits(bmp.Handle, pImage^.imageSize, pImage^.imageData);
    img1.Picture.Bitmap.Assign(bmp);
    bmp.Free;
    OpenCV.cvReleaseImage(pImage);
    img1.Visible := True;
    mmo1.Visible := False;
  end;
end;

procedure TForm1.btn3Click(Sender: TObject);
var
  strTemp: String;
begin
  strTemp := string(OpenCV.cv.getBuildInformation);
  strTemp := StringReplace(strTemp, #$A, #$D#$A, [rfReplaceAll]);
  mmo1.Lines.Add(strTemp);
  img1.Visible := False;
  mmo1.Visible := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenCV := TOpenCV.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  OpenCV.Free;
end;

end.

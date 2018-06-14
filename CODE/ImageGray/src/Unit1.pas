unit Unit1;
{$CODEALIGN 16}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.GIFImg, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtDlgs, Winapi.D3DX9, System.Math, System.Math.Vectors, Vcl.OleCtrls, untFastBmp;

type
  TForm1 = class(TForm)
    img1: TImage;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    btn7: TButton;
    btnOpenImageFile: TButton;
    dlgOpenPic1: TOpenPictureDialog;
    btnReset: TButton;
    btnInvert: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnOpenImageFileClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btnInvertClick(Sender: TObject);
  private
    { Private declarations }
    FPIC: TPicture;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ 加载图像，统一转化成32位BMP }
procedure LoadImageFromPic(const Pic: TPicture; img: TImage);
var
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  try
    bmp.PixelFormat := pf32bit;
    bmp.Width       := Pic.Width;
    bmp.Height      := Pic.Height;
    bmp.Canvas.Draw(0, 0, Pic.Graphic);
    img.Picture.Bitmap.Assign(bmp);
  finally
    bmp.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FPIC := TPicture.Create;

  { 当前目录下是否有 back.jpg 文件，有，加载文件 }
  if FileExists(ExtractFilePath(ParamStr(0)) + 'back.jpg') then
  begin
    FPIC.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'back.jpg');
    LoadImageFromPic(FPIC, img1);
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FPIC.Free;
end;

{ 打开图像，统一转化成32位BMP }
procedure TForm1.btnOpenImageFileClick(Sender: TObject);
begin
  if not dlgOpenPic1.Execute then
    Exit;

  FPIC.LoadFromFile(dlgOpenPic1.FileName);
  LoadImageFromPic(FPIC, img1);
end;

{ 恢复原来的图像 }
procedure TForm1.btnResetClick(Sender: TObject);
begin
  img1.Picture.Bitmap.Canvas.Draw(0, 0, FPIC.Graphic);
  img1.Invalidate;
end;

{ 1、Pixel }
procedure TForm1.btn1Click(Sender: TObject);
var
  intHeight   : Integer;
  intWidth    : Integer;
  BGRAValue   : TRGBQuad;
  byeGray     : Byte;
  intST, intET: Integer;
begin
  intST        := GetTickCount;
  for intWidth := 0 to img1.Picture.Bitmap.Width - 1 do
  begin
    for intHeight := 0 to img1.Picture.Bitmap.Height - 1 do
    begin
      BGRAValue                                              := TRGBQuad(img1.Picture.Bitmap.Canvas.Pixels[intWidth, intHeight]);                         // 取点颜色值
      byeGray                                                := Round(BGRAValue.rgbRed * 0.299 + BGRAValue.rgbGreen * 0.587 + BGRAValue.rgbBlue * 0.114); // 变灰度
      BGRAValue.rgbBlue                                      := byeGray;                                                                                  // B 值等于 byeGray
      BGRAValue.rgbGreen                                     := byeGray;                                                                                  // G 值等于 byeGray
      BGRAValue.rgbRed                                       := byeGray;                                                                                  // R 值等于 byeGray
      img1.Picture.Bitmap.Canvas.Pixels[intWidth, intHeight] := TColor(BGRAValue);                                                                        // 设置点颜色
    end;
  end;
  intET   := GetTickCount;
  Caption := Format('%s，用时 %d 毫秒；图像大小：%d*%d', [TButton(Sender).Caption, intET - intST, img1.Picture.Bitmap.Width, img1.Picture.Bitmap.Height]);
  img1.Invalidate;
end;

{ 2、 API }
procedure TForm1.btn2Click(Sender: TObject);
var
  III, Count  : Integer;
  pBmp        : TArray<TRGBQuad>;
  byeGray     : Byte;
  intST, intET: Integer;
begin
  intST := GetTickCount;
  Count := img1.Picture.Bitmap.Width * img1.Picture.Bitmap.Height;
  SetLength(pBmp, Count);
  GetBitmapBits(img1.Picture.Bitmap.Handle, Count * 4, pBmp);
  for III := 0 to Count - 1 do
  begin
    byeGray   := Round(pBmp[III].rgbRed * 0.299 + pBmp[III].rgbGreen * 0.587 + pBmp[III].rgbBlue * 0.114);
    pBmp[III] := TRGBQuad(RGB(byeGray, byeGray, byeGray));
  end;
  SetBitmapBits(img1.Picture.Bitmap.Handle, Count * 4, pBmp);
  intET   := GetTickCount;
  Caption := Format('%s，用时 %d 毫秒；图像大小：%d*%d', [TButton(Sender).Caption, intET - intST, img1.Picture.Bitmap.Width, img1.Picture.Bitmap.Height]);
  img1.Invalidate;
end;

{ 3、 ScanLine }
procedure TForm1.btn3Click(Sender: TObject);
var
  pLine       : PRGBQuad;
  intRow      : Integer;
  intCol      : Integer;
  byeGray     : Byte;
  intST, intET: Integer;
begin
  intST      := GetTickCount;
  for intRow := 0 to img1.Picture.Bitmap.Height - 1 do
  begin
    pLine      := img1.Picture.Bitmap.ScanLine[intRow];
    for intCol := 0 to img1.Picture.Bitmap.Width - 1 do
    begin
      byeGray := Round(pLine^.rgbRed * 0.299 + pLine^.rgbGreen * 0.587 + pLine^.rgbBlue * 0.114);
      pLine^  := TRGBQuad(RGB(byeGray, byeGray, byeGray));
      Inc(pLine);
    end;
  end;
  intET   := GetTickCount;
  Caption := Format('%s，用时 %d 毫秒；图像大小：%d*%d', [TButton(Sender).Caption, intET - intST, img1.Picture.Bitmap.Width, img1.Picture.Bitmap.Height]);
  img1.Invalidate;
end;

{ 4、浮点优化，在 3：ScanLine 的基础上；比 3 性能提高 30% 左右 }
procedure TForm1.btn4Click(Sender: TObject);
var
  pLine       : PRGBQuad;
  intRow      : Integer;
  intCol      : Integer;
  byeGray     : Byte;
  intST, intET: Integer;
begin
  intST      := GetTickCount;
  for intRow := 0 to img1.Picture.Bitmap.Height - 1 do
  begin
    pLine      := img1.Picture.Bitmap.ScanLine[intRow];
    for intCol := 0 to img1.Picture.Bitmap.Width - 1 do
    begin
      byeGray := (pLine^.rgbRed * 38 + pLine^.rgbGreen * 75 + pLine^.rgbBlue * 15) shr 7; // 1：* 15 将被编译器优化为 * 16 - 1，因此这里只有两次乘法运算
      { byeGray := (pLine^.rgbRed + pLine^.rgbGreen shl 1 + pLine^.rgbBlue) shr 2;        // 2：不太在意精度的情况下，可使用此代码，效率略有提高 }
      pLine^ := TRGBQuad(RGB(byeGray, byeGray, byeGray));
      Inc(pLine);
    end;
  end;
  intET   := GetTickCount;
  Caption := Format('%s，用时 %d 毫秒；图像大小：%d*%d', [TButton(Sender).Caption, intET - intST, img1.Picture.Bitmap.Width, img1.Picture.Bitmap.Height]);
  img1.Invalidate;
end;

{ 5、MMX 优化； 比4，性能又提高 50% 左右 }
procedure TForm1.btn5Click(Sender: TObject);
var
  Count       : Integer;
  pBmp        : array of Byte;
  intST, intET: Integer;
begin
  intST := GetTickCount;
  Count := img1.Picture.Bitmap.Width * img1.Picture.Bitmap.Height * 4;
  SetLength(pBmp, Count);
  GetBitmapBits(img1.Picture.Bitmap.Handle, Count, pBmp);
  GrayMMX(@pBmp[0], Count);
  intET := GetTickCount;
  SetBitmapBits(img1.Picture.Bitmap.Handle, Count, pBmp);
  Caption := Format('%s，用时 %d 毫秒；图像大小：%d*%d', [TButton(Sender).Caption, intET - intST, img1.Picture.Bitmap.Width, img1.Picture.Bitmap.Height]);
  img1.Invalidate;
end;


{ 6、SSE 优化 }
procedure TForm1.btn6Click(Sender: TObject);
var
  Count       : Integer;
  pBmp        : array of Byte;
  pDst        : array of Byte;
  intST, intET: Integer;
begin
  if TestSSE = 0 then
  begin
    ShowMessage('你的CPU不支持 SSE，杯具了');
    Exit;
  end;

  intST := GetTickCount;
  Count := img1.Picture.Bitmap.Width * img1.Picture.Bitmap.Height * 4;
  SetLength(pBmp, Count);
  SetLength(pDst, Count);
  GetBitmapBits(img1.Picture.Bitmap.Handle, Count, pBmp);
  GraySSE(@pBmp[0], @pDst[0], Count);
  intET := GetTickCount;
  SetBitmapBits(img1.Picture.Bitmap.Handle, Count, pDst);
  Caption := Format('%s，用时 %d 毫秒；图像大小：%d*%d', [TButton(Sender).Caption, intET - intST, img1.Picture.Bitmap.Width, img1.Picture.Bitmap.Height]);
  img1.Invalidate;
end;

{ 7、并行 优化 }
procedure TForm1.btn7Click(Sender: TObject);
begin
  //
end;

procedure TForm1.btnInvertClick(Sender: TObject);
var
  Count       : Integer;
  pBmp        : array of Byte;
  intST, intET: Integer;
begin
  Count := img1.Picture.Bitmap.Width * img1.Picture.Bitmap.Height * 4;
  SetLength(pBmp, Count);
  GetBitmapBits(img1.Picture.Bitmap.Handle, Count, pBmp);
  intST := GetTickCount;
  InvertMMX(@pBmp[0], Count);
  intET := GetTickCount;
  SetBitmapBits(img1.Picture.Bitmap.Handle, Count, pBmp);
  Caption := Format('%s，用时 %d 毫秒；图像大小：%d*%d', [TButton(Sender).Caption, intET - intST, img1.Picture.Bitmap.Width, img1.Picture.Bitmap.Height]);
  img1.Invalidate;
end;

end.

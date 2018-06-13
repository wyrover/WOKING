unit Unit1;
{$CODEALIGN 16}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.GIFImg, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtDlgs, Winapi.D3DX9, System.Math, System.Math.Vectors, Vcl.OleCtrls;

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
  private
    { Private declarations }
    FBMP: TBitmap;
    FPIC: TPicture;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FPIC             := TPicture.Create;
  FBMP             := TBitmap.Create;
  FBMP.PixelFormat := pf32bit;

  if FileExists(ExtractFilePath(ParamStr(0)) + 'back.jpg') then
  begin
    { 打开图像，统一转化成32位BMP }
    FPIC.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'back.jpg');
    FBMP.Width  := FPIC.Width;
    FBMP.Height := FPIC.Height;
    FBMP.Canvas.Draw(0, 0, FPIC.Graphic);
    img1.Picture.Bitmap.Assign(FBMP);
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FPIC.Free;
  FBMP.Free;
end;

{ 打开图像，统一转化成32位BMP }
procedure TForm1.btnOpenImageFileClick(Sender: TObject);
begin
  if not dlgOpenPic1.Execute then
    Exit;

  FPIC.LoadFromFile(dlgOpenPic1.FileName);
  FBMP.Width  := FPIC.Width;
  FBMP.Height := FPIC.Height;
  FBMP.Canvas.Draw(0, 0, FPIC.Graphic);
  img1.Picture.Bitmap.Assign(FBMP);
end;

{ 恢复原来的图像 }
procedure TForm1.btnResetClick(Sender: TObject);
begin
  FBMP.Canvas.Draw(0, 0, FPIC.Graphic);
  img1.Picture.Bitmap.Assign(FBMP);
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
  for intWidth := 0 to FBMP.Width - 1 do
  begin
    for intHeight := 0 to FBMP.Height - 1 do
    begin
      BGRAValue                               := TRGBQuad(FBMP.Canvas.Pixels[intWidth, intHeight]);                                        // 取点颜色值
      byeGray                                 := Round(BGRAValue.rgbRed * 0.299 + BGRAValue.rgbGreen * 0.587 + BGRAValue.rgbBlue * 0.114); // 变灰度
      BGRAValue.rgbBlue                       := byeGray;                                                                                  // B 值等于 byeGray
      BGRAValue.rgbGreen                      := byeGray;                                                                                  // G 值等于 byeGray
      BGRAValue.rgbRed                        := byeGray;                                                                                  // R 值等于 byeGray
      FBMP.Canvas.Pixels[intWidth, intHeight] := TColor(BGRAValue);                                                                        // 设置点颜色
    end;
  end;
  intET   := GetTickCount;
  Caption := Format('%s，用时 %d 毫秒；图像大小：%d*%d', [TButton(Sender).Caption, intET - intST, FBMP.Width, FBMP.Height]);

  img1.Picture.Bitmap.Assign(FBMP);
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
  Count := FBMP.Width * FBMP.Height;
  SetLength(pBmp, Count);
  GetBitmapBits(FBMP.Handle, Count * 4, pBmp);
  for III := 0 to Count - 1 do
  begin
    byeGray   := Round(pBmp[III].rgbRed * 0.299 + pBmp[III].rgbGreen * 0.587 + pBmp[III].rgbBlue * 0.114);
    pBmp[III] := TRGBQuad(RGB(byeGray, byeGray, byeGray));
  end;
  SetBitmapBits(FBMP.Handle, Count * 4, pBmp);
  intET   := GetTickCount;
  Caption := Format('%s，用时 %d 毫秒；图像大小：%d*%d', [TButton(Sender).Caption, intET - intST, FBMP.Width, FBMP.Height]);

  img1.Picture.Bitmap.Assign(FBMP);
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
  for intRow := 0 to FBMP.Height - 1 do
  begin
    pLine      := FBMP.ScanLine[intRow];
    for intCol := 0 to FBMP.Width - 1 do
    begin
      byeGray := Round(pLine^.rgbRed * 0.299 + pLine^.rgbGreen * 0.587 + pLine^.rgbBlue * 0.114);
      pLine^  := TRGBQuad(RGB(byeGray, byeGray, byeGray));
      Inc(pLine);
    end;
  end;
  intET   := GetTickCount;
  Caption := Format('%s，用时 %d 毫秒；图像大小：%d*%d', [TButton(Sender).Caption, intET - intST, FBMP.Width, FBMP.Height]);

  img1.Picture.Bitmap.Assign(FBMP);
end;

{ 4、浮点优化，在 3：ScanLine 的基础上；比 2 性能提高 30% 左右 }
procedure TForm1.btn4Click(Sender: TObject);
var
  pLine       : PRGBQuad;
  intRow      : Integer;
  intCol      : Integer;
  byeGray     : Byte;
  intST, intET: Integer;
begin
  intST      := GetTickCount;
  for intRow := 0 to FBMP.Height - 1 do
  begin
    pLine      := FBMP.ScanLine[intRow];
    for intCol := 0 to FBMP.Width - 1 do
    begin
      byeGray := (pLine^.rgbRed * 38 + pLine^.rgbGreen * 75 + pLine^.rgbBlue * 15) shr 7; // 1
      { byeGray := (pLine^.rgbRed + pLine^.rgbGreen shl 1 + pLine^.rgbBlue) shr 2;        // 2 不太在意精度的情况下，可使用此代码，效率略有提高 }
      pLine^ := TRGBQuad(RGB(byeGray, byeGray, byeGray));
      Inc(pLine);
    end;
  end;
  intET   := GetTickCount;
  Caption := Format('%s，用时 %d 毫秒；图像大小：%d*%d', [TButton(Sender).Caption, intET - intST, FBMP.Width, FBMP.Height]);

  img1.Picture.Bitmap.Assign(FBMP);
end;

{
  Unit1.pas.182: byeGray := (pLine^.rgbRed * 38 + pLine^.rgbGreen * 75 + pLine^.rgbBlue * 15) shr 7;
  00619BB6 8B45F4           mov eax,[ebp-$0c]    // pLine
  00619BB9 0FB64002         movzx eax,[eax+$02]  // pLine^.rgbRed   $02
  00619BBD 6BC026           imul eax,eax,$26     // pLine^.rgbRed * 38
  00619BC0 8B55F4           mov edx,[ebp-$0c]    // pLine
  00619BC3 0FB65201         movzx edx,[edx+$01]  // pLine^.rgbGreen   $01
  00619BC7 6BD24B           imul edx,edx,$4b     // pLine^.rgbGreen * 75
  00619BCA 03C2             add eax,edx          // 两者相加，值保存在 EAX 中
  00619BCC 8B55F4           mov edx,[ebp-$0c]    // pLine
  00619BCF 0FB612           movzx edx,[edx]      // pLine^.rgbBlue    $00
  00619BD2 8BCA             mov ecx,edx          // pLine^.rgbBlue  * 15 被编译器优化成 * 16 - 1，而 * 16，又被优化成 shl 4，移位操作，从而优化掉了耗时的乘法运算
  00619BD4 C1E204           shl edx,$04          // * 16 左移 4 位
  00619BD7 2BD1             sub edx,ecx          // - 结果保存在 EDX 中
  00619BD9 03C2             add eax,edx          // EAX + EDX  结果保存到 EAX 中
  00619BDB C1E807           shr eax,$07          // 右移 7 位
  00619BDE 8845EB           mov [ebp-$15],al     // 返回结果
}

{ 5、MMX 优化； }
procedure TForm1.btn5Click(Sender: TObject);
begin
  //
end;

{
  Intel SSE指令集支持的处理器有8个128位的寄存器，每一个寄存器可以存放4个（32位）单精度的浮点数

  将4个32位浮点数放进一个128位的存储单元。 movss 和 shufps _mm_set_ps1
  将4对32位浮点数同时进行相乘操作。这4对32位浮点数来自两个128位的存储单元，再把计算结果（乘积）赋给一个128位的存储单元。 mulps _mm_mul_ps
  将4对32位浮点数同时进行相加操作。这4对32位浮点数来自两个128位的存储单元，再把计算结果（相加之和）赋给一个128位的存储单元。 addps _mm_add_ps
  对一个128位存储单元中的4个32位浮点数同时进行求平方根操作。 sqrtps _mm_sqrt_ps
}
type
  TFourDWORD = array [0 .. 3] of DWORD;

const
  c_intRGBARate: TFourDWORD = (38, 75, 15, 1);

function SSEASM(const P1: TFourDWORD): TFourDWORD;
asm
  MOVUPS   XMM0, [P1]
  MOVUPS   XMM1, [C_INTRGBARATE]
  MULPS    XMM0, XMM1
  CVTPS2DQ XMM0, XMM1
  MOVUPS  [Result], XMM0
end;

procedure SSEScanLine(pLine: PRGBQuad; bmp: TBitmap);
var
  III     : Integer;
  tmp     : TFourDWORD;
  tmpPV   : TFourDWORD;
  intValue: Cardinal;
  byeGray : Byte;
begin
  for III := 0 to bmp.Width - 1 do
  begin
    tmpPV[0] := pLine^.rgbRed;
    tmpPV[1] := pLine^.rgbGreen;
    tmpPV[2] := pLine^.rgbBlue;
    tmpPV[3] := pLine^.rgbReserved;
    tmp      := SSEASM(tmpPV);
    intValue := (tmp[3]) or (tmp[0] shl 8) or (tmp[1] shl 16) or (tmp[2] shl 32);
    byeGray  := intValue shr 7;
    pLine^   := TRGBQuad(RGB(byeGray, byeGray, byeGray));
    Inc(pLine);
  end;
end;

{ 6、SSE 优化 }
procedure TForm1.btn6Click(Sender: TObject);
var
  pLine       : PRGBQuad;
  intRow      : Integer;
  intST, intET: Integer;
begin
  if TestSSE = 0 then
    Exit;

  intST      := GetTickCount;
  for intRow := 0 to FBMP.Height - 1 do
  begin
    pLine := FBMP.ScanLine[intRow];
    SSEScanLine(pLine, FBMP);
  end;
  intET   := GetTickCount;
  Caption := Format('%s，用时 %d 毫秒；图像大小：%d*%d', [TButton(Sender).Caption, intET - intST, FBMP.Width, FBMP.Height]);

  img1.Picture.Bitmap.Assign(FBMP);
end;

{ 7、并行 优化 }
procedure TForm1.btn7Click(Sender: TObject);
begin
  //
end;

end.

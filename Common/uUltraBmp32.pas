unit uUltraBmp32;
{
  Note: Fast Bitmap Pixel 32bit
  Name: dbyoung@sina.com
  Date: 2016-10-01
  Vers : DelphiXE10
}

interface

uses Winapi.Windows, System.Classes, System.SysUtils, Vcl.Graphics, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg;

type
  TInvertColorType = (itScanLine01, itScanLine02, itScanLine03, itAPI, itMMX, itMMX2, itSSE, itSSE2, itSSE3);
  TRotateType      = (rtScanLine01, rtScanLine02, rtMMX, rtSSE);

  { 从磁盘加载图片，转换成 32位 位图格式 }
procedure LoadPic(const strFileName: String; var bmp: TBitmap);

{ 反色 }
procedure InvertColor(bmp: TBitmap; const InvertColorType: TInvertColorType = itScanLine03);

implementation

const
  MASK: array [0 .. 3] of DWORD = ($FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF);

  { 从磁盘加载图片，转换成 32位 位图格式 }
procedure LoadPic(const strFileName: String; var bmp: TBitmap);
begin
  with TPicture.Create do
  begin
    LoadFromFile(strFileName);
    bmp.PixelFormat := pf32bit;
    bmp.Width       := Width;
    bmp.Height      := Height;
    bmp.Canvas.Draw(0, 0, Graphic);
    Free;
  end;
end;

{ 反色 InvertColor_ScanLine_01 }
procedure InvertColor_ScanLine_01(bmp: TBitmap);
var
  I    : Integer;
  J    : Integer;
  pLine: PRGBQuadArray;
begin
  for I := 0 to bmp.Height - 1 do
  begin
    pLine := bmp.ScanLine[I];
    for J := 0 to bmp.Width - 1 do
    begin
      pLine[J].rgbRed      := 255 - pLine[J].rgbRed;
      pLine[J].rgbGreen    := 255 - pLine[J].rgbGreen;
      pLine[J].rgbBlue     := 255 - pLine[J].rgbBlue;
      pLine[J].rgbReserved := 255 - pLine[J].rgbReserved;
    end;
  end;
end;

{ 反色 InvertColor_ScanLine_02 }
procedure InvertColor_ScanLine_02(bmp: TBitmap);
type
  PDWORDArray = ^TDWORDArray;
  TDWORDArray = array [0 .. $FFFF] of DWORD;
var
  I    : Integer;
  J    : Integer;
  pLine: PDWORDArray;
begin
  for I := 0 to bmp.Height - 1 do
  begin
    pLine := bmp.ScanLine[I];
    for J := 0 to bmp.Width - 1 do
    begin
      pLine[J] := $FFFFFFFF - pLine[J];
    end;
  end;
end;

{ 反色 InvertColor_ScanLine_03 }
procedure InvertColor_ScanLine_03(bmp: TBitmap);
type
  PDWORDArray = ^TDWORDArray;
  TDWORDArray = array [0 .. $FFFF] of DWORD;
var
  I      : Integer;
  J      : Integer;
  pLine01: PDWORDArray;
  pLine02: PDWORDArray;
  pLine03: PDWORDArray;
  pLine04: PDWORDArray;
begin
  for I := 0 to bmp.Height div 4 - 1 do
  begin
    pLine01 := bmp.ScanLine[4 * I + 0];
    pLine02 := bmp.ScanLine[4 * I + 1];
    pLine03 := bmp.ScanLine[4 * I + 2];
    pLine04 := bmp.ScanLine[4 * I + 3];
    for J   := 0 to bmp.Width - 1 do
    begin
      pLine01[J] := $FFFFFFFF - pLine01[J];
      pLine02[J] := $FFFFFFFF - pLine02[J];
      pLine03[J] := $FFFFFFFF - pLine03[J];
      pLine04[J] := $FFFFFFFF - pLine04[J];
    end;
  end;
end;

{ 反色 InvertColor_API }
procedure InvertColor_API(bmp: TBitmap);
var
  Count       : Integer;
  pImageBuffer: TArray<DWORD>;
  I           : Integer;
begin
  Count := bmp.Width * bmp.Height;
  SetLength(pImageBuffer, Count);
  GetBitmapBits(bmp.Handle, Count * 4, pImageBuffer);
  for I := 0 to Count - 1 do
  begin
    pImageBuffer[I] := $FFFFFFFF - pImageBuffer[I];
  end;
  SetBitmapBits(bmp.Handle, Count * 4, pImageBuffer);
end;

procedure InvertColorMMX(pSrc: PByte; var pDst: PByte; const intLen: Integer);
asm
  PCMPEQB MM4, MM4          // 64 位 BIT 置1；64 位 = 8 个字节 = 2 个像素
  {$IFDEF CPUX86}
  MOV     ESI, pSrc         // EAX   MOV  ESI, pSrc
  MOV     EDI, [pDst]       // EDX   MOV  EDI, [pDst]
  {$ELSE}
  MOV     RSI, pSrc         // EAX   MOV  ESI, pSrc
  MOV     RDI, [pDst]       // EDX   MOV  EDI, [pDst]
  {$ENDIF}
  MOV     ECX, intLen

@Loop:
  {$IFDEF CPUX86}
  MOVQ  MM0, [ESI+00]
  MOVQ  MM1, [ESI+08]
  MOVQ  MM2, [ESI+16]
  MOVQ  MM3, [ESI+24]
  {$ELSE}
  MOVQ  MM0, [RSI+00]
  MOVQ  MM1, [RSI+08]
  MOVQ  MM2, [RSI+16]
  MOVQ  MM3, [RSI+24]
  {$ENDIF}

  PANDN  MM0, MM4
  PANDN  MM1, MM4
  PANDN  MM2, MM4
  PANDN  MM3, MM4

  {$IFDEF CPUX86}
  MOVQ [EDI+00], MM0
  MOVQ [EDI+08], MM1
  MOVQ [EDI+16], MM2
  MOVQ [EDI+24], MM3
  ADD  ESI, 32
  ADD  EDI, 32
  {$ELSE}
  MOVQ [RDI+00], MM0
  MOVQ [RDI+08], MM1
  MOVQ [RDI+16], MM2
  MOVQ [RDI+24], MM3
  ADD  RSI, 32
  ADD  RDI, 32
  {$ENDIF}

  SUB ECX, 32
  JNZ @Loop
  EMMS
end;

{ 反色 MMX 版本 }
procedure InvertColor_MMX(bmp: TBitmap);
var
  pSrc, pDst: PByte;
  Count     : Integer;
begin
  Count := bmp.Width * bmp.Height * 4;
  GetMem(pSrc, Count);
  GetMem(pDst, Count);
  try
    GetBitmapBits(bmp.Handle, Count, pSrc);
    InvertColorMMX(pSrc, pDst, Count);
    SetBitmapBits(bmp.Handle, Count, pDst);
  finally
    FreeMem(pSrc);
    FreeMem(pDst);
  end;
end;

procedure InvertColorSSE(pSrc: PByte; var pDst: PByte; const intLen: Integer);
asm
  PCMPEQB XMM4, XMM4  // 128 位 BIT 置1；128 位 = 16 个字节 = 4 个像素
  MOV     ESI,  pSrc
  MOV     EDI,  [pDst]
  MOV     ECX,  intLen

@Loop:
  MOVDQA  XMM0, [ESI+00]
  MOVDQA  XMM1, [ESI+16]
  MOVDQA  XMM2, [ESI+32]
  MOVDQA  XMM3, [ESI+48]

  PANDN  XMM0, XMM4
  PANDN  XMM1, XMM4
  PANDN  XMM2, XMM4
  PANDN  XMM3, XMM4

  MOVDQA [EDI+00], XMM0
  MOVDQA [EDI+16], XMM1
  MOVDQA [EDI+32], XMM2
  MOVDQA [EDI+48], XMM3

  ADD ESI, 64
  ADD EDI, 64

  SUB ECX, 64
  JNZ @Loop
end;

{ 反色 SSE 版本 }
procedure InvertColor_SSE(bmp: TBitmap);
var
  pSrc, pDst: PByte;
  Count     : Integer;
begin
  Count := bmp.Width * bmp.Height * 4;
  GetMem(pSrc, Count);
  GetMem(pDst, Count);
  try
    GetBitmapBits(bmp.Handle, Count, pSrc);
    InvertColorSSE(pSrc, pDst, Count);
    SetBitmapBits(bmp.Handle, Count, pDst);
  finally
    FreeMem(pSrc);
    FreeMem(pDst);
  end;
end;

procedure InvertColorSSE2(pSrc: PByte; const intLen: Integer);
asm
  PCMPEQB XMM4, XMM4  // 128 位 BIT 置1；128 位 = 16 个字节 = 4 个像素
  MOV     ESI,  EAX
  MOV     ECX,  intLen

@Loop:
  MOVDQA  XMM0, [ESI+00]
  MOVDQA  XMM1, [ESI+16]
  MOVDQA  XMM2, [ESI+32]
  MOVDQA  XMM3, [ESI+48]

  PANDN  XMM0, XMM4
  PANDN  XMM1, XMM4
  PANDN  XMM2, XMM4
  PANDN  XMM3, XMM4

  MOVDQA [ESI+00], XMM0
  MOVDQA [ESI+16], XMM1
  MOVDQA [ESI+32], XMM2
  MOVDQA [ESI+48], XMM3

  ADD ESI, 64

  SUB ECX, 64
  JNZ @Loop
end;

{ 反色 SSE2 版本 }
procedure InvertColor_SSE2(bmp: TBitmap);
var
  pSrc : PByte;
  Count: Integer;
begin
  Count := bmp.Width * bmp.Height * 4;
  GetMem(pSrc, Count);
  try
    GetBitmapBits(bmp.Handle, Count, pSrc);
    InvertColorSSE2(pSrc, Count);
    SetBitmapBits(bmp.Handle, Count, pSrc);
  finally
    FreeMem(pSrc);
  end;
end;

procedure InvertColorSSE3(pSrc: PByte; const intLen: Integer);
asm
  PCMPEQB XMM4, XMM4  // 128 位 BIT 置1；128 位 = 16 个字节 = 4 个像素
  MOV     ESI,  EAX
  MOV     ECX,  intLen

@Loop:
  MOVDQA  XMM0, [ESI+00]
  MOVDQA  XMM1, [ESI+16]
  MOVDQA  XMM2, [ESI+32]
  MOVDQA  XMM3, [ESI+48]

  PANDN  XMM0, XMM4
  PANDN  XMM1, XMM4
  PANDN  XMM2, XMM4
  PANDN  XMM3, XMM4

  MOVDQA [ESI+00], XMM0
  MOVDQA [ESI+16], XMM1
  MOVDQA [ESI+32], XMM2
  MOVDQA [ESI+48], XMM3

  ADD ESI, 64

  SUB ECX, 64
  JNZ @Loop
end;

{ 反色 SSE3 版本 }
procedure InvertColor_SSE3(bmp: TBitmap);
var
  pSrc : PByte;
  Count: Integer;
begin
  Count := bmp.Width * bmp.Height * 4;
  GetMem(pSrc, Count);
  try
    GetBitmapBits(bmp.Handle, Count, pSrc);
    InvertColorSSE2(pSrc, Count);
    SetBitmapBits(bmp.Handle, Count, pSrc);
  finally
    FreeMem(pSrc);
  end;
end;

procedure InvertColorMMX2(pSrc: PByte; var pDst: PByte; const intLen: Integer);
asm
  PCMPEQB MM4, MM4         // 64 位 BIT 置1；64 位 = 8 个字节 = 2 个像素
  MOV     ESI, EAX
  MOV     EDI, [EDX]

@Loop:
  MOVQ  MM0, [ESI+00]
  MOVQ  MM1, [ESI+08]
  MOVQ  MM2, [ESI+16]
  MOVQ  MM3, [ESI+24]

  PANDN  MM0, MM4
  PANDN  MM1, MM4
  PANDN  MM2, MM4
  PANDN  MM3, MM4

  MOVNTQ  [EDI+00], MM0
  MOVNTQ  [EDI+08], MM1
  MOVNTQ  [EDI+16], MM2
  MOVNTQ  [EDI+24], MM3

  ADD ESI, 32
  ADD EDI, 32

  SUB ECX, 32
  JNZ @Loop

  EMMS
  sfence
end;

{ 反色 MMX2 版本 }
procedure InvertColor_MMX2(bmp: TBitmap);
var
  pSrc, pDst: PByte;
  Count     : Integer;
begin
  Count := bmp.Width * bmp.Height * 4;
  GetMem(pSrc, Count);
  GetMem(pDst, Count);
  try
    GetBitmapBits(bmp.Handle, Count, pSrc);
    InvertColorMMX2(pSrc, pDst, Count);
    SetBitmapBits(bmp.Handle, Count, pDst);
  finally
    FreeMem(pSrc);
    FreeMem(pDst);
  end;
end;

procedure InvertColor(bmp: TBitmap; const InvertColorType: TInvertColorType = itScanLine03);
begin
  if bmp.Width mod 16 <> 0 then
    Exit;
  case InvertColorType of
    itScanLine01:
      InvertColor_ScanLine_01(bmp);
    itScanLine02:
      InvertColor_ScanLine_02(bmp);
    itScanLine03:
      InvertColor_ScanLine_03(bmp);
    itAPI:
      InvertColor_API(bmp);
    itMMX:
      InvertColor_MMX(bmp);
    itMMX2:
      InvertColor_MMX2(bmp);
    itSSE:
      InvertColor_SSE(bmp);
    itSSE2:
      InvertColor_SSE2(bmp);
    itSSE3:
      InvertColor_SSE3(bmp);
  end;
end;

{
  假设对图片上任意点(x,y)，绕一个坐标点(rx0,ry0)逆时针旋转RotaryAngle角度后的新的坐标设为(x', y')，有公式：
  (x平移rx0,y平移ry0,角度a对应-RotaryAngle ， 带入方程(7)、(8)后有： )
  x'= (x - rx0)*cos(RotaryAngle) + (y - ry0)*sin(RotaryAngle) + rx0 ;
  y'=-(x - rx0)*sin(RotaryAngle) + (y - ry0)*cos(RotaryAngle) + ry0 ;

  那么，根据新的坐标点求源坐标点的公式为：
  x=(x'- rx0)*cos(RotaryAngle) - (y'- ry0)*sin(RotaryAngle) + rx0 ;
  y=(x'- rx0)*sin(RotaryAngle) + (y'- ry0)*cos(RotaryAngle) + ry0 ;

  旋转的时候还可以顺便加入x轴和y轴的缩放和平移，而不影响速度，那么完整的公式为:
  x=(x'- move_x-rx0)/ZoomX*cos(RotaryAngle) - (y'- move_y-ry0)/ZoomY*sin(RotaryAngle) + rx0 ;
  y=(x'- move_x-rx0)/ZoomX*sin(RotaryAngle) + (y'- move_y-ry0)/ZoomY*cos(RotaryAngle) + ry0 ;
  其中： RotaryAngle为逆时针旋转的角度;
  ZoomX,ZoomY为x轴y轴的缩放系数(支持负的系数,相当于图像翻转);
  move_x,move_y为x轴y轴的平移量;
}

procedure Rotate_ScanLine01(bmp: TBitmap; const Angle: Integer);
begin

end;

procedure Rotate_ScanLine02(bmp: TBitmap; const Angle: Integer);
begin

end;

procedure Rotate_MMX(bmp: TBitmap; const Angle: Integer);
begin

end;

procedure Rotate_SSE(bmp: TBitmap; const Angle: Integer);
begin

end;

{ 旋转 }
procedure Rotate(bmp: TBitmap; const Angle: Integer; const RotateType: TRotateType = rtSSE);
begin
  case RotateType of
    rtScanLine01:
      Rotate_ScanLine01(bmp, Angle);
    rtScanLine02:
      Rotate_ScanLine02(bmp, Angle);
    rtMMX:
      Rotate_MMX(bmp, Angle);
    rtSSE:
      Rotate_SSE(bmp, Angle);
  end;
end;

end.

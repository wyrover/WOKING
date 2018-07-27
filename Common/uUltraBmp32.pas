unit uUltraBmp32;
{
  Note: Fast Bitmap Pixel 32bit
  Name: dbyoung@sina.com
  Date: 2016-10-01
  Vers: DelphiXE10
}

interface

uses Winapi.Windows, System.Classes, System.SysUtils, Vcl.Graphics, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg, CL, CL_Platform, CL_GL, DelphiCL;

type
  TInvertColorType = (itScanLine01, itScanLine02, itScanLine03, itAPI, itMMX, itMMX2, itSSE, itSSE2, itSSE3);
  TRotateType      = (rtScanLine01, rtScanLine02, rtMMX, rtSSE);
  TGrayColorType   = (gtScanLine01, gtScanLine02, gtScanLine03, gtAPI, gtMMX, gtSSE, gtSSE2);

{ 从磁盘加载图片，转换成 32位 位图格式 }
procedure LoadPic(const strFileName: String; var bmp: TBitmap);

{ 反色 }
procedure InvertColor(bmp: TBitmap; const InvertColorType: TInvertColorType = itScanLine03);

{ 灰度 }
procedure GrayColor(bmp: TBitmap; const GrayColorType: TGrayColorType = gtScanLine03);

{ 旋转 }
procedure Rotate(bmp: TBitmap; const Angle: Integer; const RotateType: TRotateType = rtSSE);

implementation

const
  MASK: array [0 .. 3] of DWORD           = ($FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF);
  c_GrayMask: UInt64                      = $4B002F;
  c_GrayMask2: UInt64                     = $012B024B0072;
  kARGBToGray: array [0 .. 15] of Integer = (14, 76, 38, 0, 14, 76, 38, 0, 14, 76, 38, 0, 14, 76, 38, 0);
  c_intMask: UInt64                       = $FFFFFFFFFFFFFFFF;

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

procedure InvertColorMMX(pSrc: PByte; const Count: Integer);
asm
  EMMS                                        // 浮点寄存器复位
  MOV         ESI, pSrc                       // 起始地址 ESI
  MOV         ECX, Count                      // 循环次数 ECX
  SHR         ECX, 3                          // 循环次数除以 8，每64位，8字节，两个像素，一循环
@loop:                                        // 循环
  MOVQ        MM0, c_intMask                  // MM0 = $FFFFFFFFFFFFFFFF
  PSUBUSB     MM0, [ESI]                      // 相减(内存变量必须按16字节对齐)
  MOVQ        [ESI], MM0                      // 在 ESI 中返回结果，两个像素
  ADD         ESI, 8                          // 下一个64位，8字节，两个像素
  DEC         ECX                             // 循环次数减一
  JNZ         @loop                           // 重复
  EMMS                                        // 结束，浮点寄存器复位
end;

// procedure InvertColorMMX(pSrc: PByte; var pDst: PByte; const intLen: Integer);
// asm
// PCMPEQB MM4, MM4          // 64 位 BIT 置1；64 位 = 8 个字节 = 2 个像素
// {$IFDEF CPUX86}
// MOV     ESI, pSrc         // EAX   MOV  ESI, pSrc
// MOV     EDI, [pDst]       // EDX   MOV  EDI, [pDst]
// {$ELSE}
// MOV     RSI, pSrc         // EAX   MOV  ESI, pSrc
// MOV     RDI, [pDst]       // EDX   MOV  EDI, [pDst]
// {$ENDIF}
// MOV     ECX, intLen
//
// @Loop:
// {$IFDEF CPUX86}
// MOVQ  MM0, [ESI+00]
// MOVQ  MM1, [ESI+08]
// MOVQ  MM2, [ESI+16]
// MOVQ  MM3, [ESI+24]
// {$ELSE}
// MOVQ  MM0, [RSI+00]
// MOVQ  MM1, [RSI+08]
// MOVQ  MM2, [RSI+16]
// MOVQ  MM3, [RSI+24]
// {$ENDIF}
//
// PANDN  MM0, MM4
// PANDN  MM1, MM4
// PANDN  MM2, MM4
// PANDN  MM3, MM4
//
// {$IFDEF CPUX86}
// MOVQ [EDI+00], MM0
// MOVQ [EDI+08], MM1
// MOVQ [EDI+16], MM2
// MOVQ [EDI+24], MM3
// ADD  ESI, 32
// ADD  EDI, 32
// {$ELSE}
// MOVQ [RDI+00], MM0
// MOVQ [RDI+08], MM1
// MOVQ [RDI+16], MM2
// MOVQ [RDI+24], MM3
// ADD  RSI, 32
// ADD  RDI, 32
// {$ENDIF}
//
// SUB ECX, 32
// JNZ @Loop
// EMMS
// end;

{ 反色 MMX 版本 }
procedure InvertColor_MMX(bmp: TBitmap);
var
  pSrc : PByte;
  Count: Integer;
begin
  Count := bmp.Width * bmp.Height * 4;
  GetMem(pSrc, Count);
  try
    GetBitmapBits(bmp.Handle, Count, pSrc);
    InvertColorMMX(pSrc, Count);
    SetBitmapBits(bmp.Handle, Count, pSrc);
  finally
    FreeMem(pSrc);
  end;
end;

procedure InvertColorSSE(pSrc: PByte; var pDst: PByte; const intLen: Integer);
asm
  PCMPEQB XMM4, XMM4
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
  PCMPEQB XMM4, XMM4
  MOV     ESI,  pSrc
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
  PCMPEQB XMM4, XMM4
  MOV     ESI,  pSrc
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
  PCMPEQB MM4, MM4
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

{ 反色 }
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

{ 灰度 Scanline 01 }
procedure GrayColor_Scanline01(bmp: TBitmap);
var
  I, J   : Integer;
  pLine  : PRGBQuadArray;
  intGray: Byte;
begin
  for I := 0 to bmp.Height - 1 do
  begin
    pLine := bmp.ScanLine[I];
    for J := 0 to bmp.Width - 1 do
    begin
      intGray           := Integer(pLine[J].rgbRed + pLine[J].rgbGreen + pLine[J].rgbBlue) div 3;
      pLine[J].rgbRed   := intGray;
      pLine[J].rgbGreen := intGray;
      pLine[J].rgbBlue  := intGray;
    end;
  end;
end;

{ 灰度 Scanline 02 }
procedure GrayColor_Scanline02(bmp: TBitmap);
var
  I, J   : Integer;
  pLine  : PRGBQuadArray;
  intGray: Byte;
begin
  for I := 0 to bmp.Height - 1 do
  begin
    pLine := bmp.ScanLine[I];
    for J := 0 to bmp.Width - 1 do
    begin
      intGray           := Round(pLine[J].rgbRed * 0.299 + pLine[J].rgbGreen * 0.587 + pLine[J].rgbBlue * 0.114);
      pLine[J].rgbRed   := intGray;
      pLine[J].rgbGreen := intGray;
      pLine[J].rgbBlue  := intGray;
    end;
  end;
end;

{ 灰度 Scanline 03 }
procedure GrayColor_Scanline03(bmp: TBitmap);
var
  I, J   : Integer;
  pLine  : PRGBQuadArray;
  intGray: Byte;
begin
  for I := 0 to bmp.Height - 1 do
  begin
    pLine := bmp.ScanLine[I];
    for J := 0 to bmp.Width - 1 do
    begin
      intGray           := (pLine[J].rgbRed * 38 + pLine[J].rgbGreen * 75 + pLine[J].rgbBlue * 15) shr 7;
      pLine[J].rgbRed   := intGray;
      pLine[J].rgbGreen := intGray;
      pLine[J].rgbBlue  := intGray;
    end;
  end;
end;

{ 灰度 API }
procedure GrayColor_API(bmp: TBitmap);
var
  pBmp   : TArray<TRGBQuad>;
  Count  : Integer;
  I      : Integer;
  byeGray: Byte;
begin
  Count := bmp.Width * bmp.Height;
  SetLength(pBmp, Count);
  GetBitmapBits(bmp.Handle, Count * 4, pBmp);
  for I := 0 to Count - 1 do
  begin
    byeGray := Round(pBmp[I].rgbRed * 0.299 + pBmp[I].rgbGreen * 0.587 + pBmp[I].rgbBlue * 0.114);
    pBmp[I] := TRGBQuad(RGB(byeGray, byeGray, byeGray));
  end;
  SetBitmapBits(bmp.Handle, Count * 4, pBmp);
end;

procedure GrayMMX(pSrc: PByte; const Count: Integer);
asm
  EMMS                                              // 浮点寄存器复位
  PCMPEQB     MM4, MM4                              // FF  FF  FF  FF  FF  FF  FF  FF
  PCMPEQB     MM5, MM5                              // FF  FF  FF  FF  FF  FF  FF  FF
  PXOR        MM6, MM6                              // 00  00  00  00  00  00  00  00
  MOVQ        MM7, c_GrayMask                       // 00  00  00  00  00  4B  00  2F
  PSLLD       MM4, 24                               // FF  00  00  00  FF  00  00  00
  PSRLW       MM5, 15                               // 00  01  00  01  00  01  00  01
  MOV         EAX, pSrc                             // pSrc ---> EAX
  MOV         ECX, Count                            // 循环次数 ECX
  SHR         ECX, 2                                // 循环次数除以 4，每 4 行一循环
  LEA         EAX, [EAX+ECX*4]                      // 数据加载到 EAX 中
  NEG         ECX                                   // 求补
@loop:                                              // 循环
  MOVQ        MM0, [EAX+ECX*4]                      // A1  R1  G1  B1  A0  R0  G0  B0
  MOVQ        MM1, MM0                              //
  MOVQ        MM3, MM0                              //
  PUNPCKLBW   MM0, MM6                              // 00  A0  00  R0  00  G0  00  B0
  PUNPCKHBW   MM1, MM6                              // 00  A1  00  R1  00  G1  00  B1
  PMADDWD     MM0, MM7                              // R0*r_coeff      G0*g_coeff+B0*b_coeff
  PMADDWD     MM1, MM7                              // R1*r_coeff      G1*g_coeff+B1*b_coeff
  PAND        MM3, MM4                              // A1  00  00  00  A0  00  00  00
  PACKSSDW    MM0, MM1                              // sR1     sG1+sB1 sR0     sG0+sB0
  PMADDWD     MM0, MM5                              // sR1+sG1+sB1     sR0+sG0+sB0
  PSRLD       MM0, 7                                // 00 00 00 Gray1  00 00 00 Gray0
  MOVQ        MM1, MM0                              //
  MOVQ        MM2, MM0                              //
  PSLLD       MM1, 8                                // 00 00 Gray1 00  00 00 Gray0 00
  POR         MM0, MM3                              //
  PSLLD       MM2, 16                               // 00 Gray1 00 00  00 Gray0 00 00
  POR         MM0, MM1                              //
  POR         MM0, MM2                              // A1 Gray1 Gray1 Gray1  A0 Gray0 Gray0 Gray0
  MOVQ        [EAX+ECX*4], MM0                      // 返回结果
  ADD         ECX, 2                                // 计数器加 2
  JNZ         @loop                                 // 重复
  EMMS                                              // 结束，浮点寄存器复位
end;

{ 灰度 API }
procedure GrayColor_MMX(bmp: TBitmap);
var
  pBmp : TArray<Byte>;
  Count: Integer;
begin
  Count := bmp.Width * bmp.Height * 4;
  SetLength(pBmp, Count);
  GetBitmapBits(bmp.Handle, Count, pBmp);
  GrayMMX(@pBmp[0], Count);
  SetBitmapBits(bmp.Handle, Count, pBmp);
end;

procedure GraySSE(pSrc, pDst: PByte; const Count: Integer);
asm
  MOV    ESI,  pSrc
  MOV    EDI,  pDst
  MOV    ECX,  Count
  SHR    ECX,  2
  LEA    EAX,  c_GrayMask2
  MOVDQU XMM7, [EAX]
  PXOR   XMM6, XMM6
@LOOP:
  LDDQU   XMM0, [ESI]
  SUB  ECX, 4
  ADD  ESI, 16
  MOVDQU  XMM1, XMM0
  PUNPCKHBW  XMM0, XMM6
  PUNPCKLBW  XMM1, XMM6
  PMADDWD  XMM0, XMM7
  PMADDWD  XMM1, XMM7
  PSHUFD  XMM2, XMM0, $31
  PSHUFD  XMM3, XMM1, $31
  PADDD  XMM0, XMM2
  PADDD  XMM1, XMM3
  PSHUFD  XMM0, XMM0, 10001000B
  PSHUFD  XMM1, XMM1, 10001000B
  PUNPCKLQDQ  XMM1, XMM0
  PSRLD  XMM1, 10
  PACKUSWB	XMM1, XMM1
  PACKUSWB	XMM1, XMM1
  MOVSS  [EDI], XMM1

  ADD  EDI, 4
  CMP  ECX, 0
  JNZ  @LOOP
end;

{ 灰度 API }
procedure GrayColor_SSE(bmp: TBitmap);
var
  pBmp, pDst: TArray<Byte>;
  Count     : Integer;
begin
  Count := bmp.Width * bmp.Height * 4;
  SetLength(pBmp, Count);
  SetLength(pDst, Count);
  GetBitmapBits(bmp.Handle, Count, pBmp);
  GraySSE(@pBmp[0], @pDst[0], Count);
  SetBitmapBits(bmp.Handle, Count, pDst);
end;

procedure GraySSE2(const src_argb, dst_argb: PByte; const Width: Integer);
asm
  mov        eax, [esp + 4]   // src_argb */
  mov        edx, [esp + 8]   // dst_argb */
  mov        ecx, [esp + 12]  // width */
  shr ecx, 2

  lea ebx, kARGBToGray
  MOVDQU     xmm4, [ebx]

  sub        edx, eax
@loop:
  MOVDQU     xmm0, [eax]  // G
  MOVDQU     xmm1, [eax + 16]
  pmaddubsw  xmm0, xmm4
  pmaddubsw  xmm1, xmm4
  phaddw     xmm0, xmm1
  psrlw      xmm0, 7
  packuswb   xmm0, xmm0   // 8 G bytes
  MOVDQU     xmm2, [eax]  // A
  MOVDQU     xmm3, [eax + 16]
  psrld      xmm2, 24
  psrld      xmm3, 24
  packuswb   xmm2, xmm3
  packuswb   xmm2, xmm2   // 8 A bytes
  MOVDQU     xmm3, xmm0   // Weave into GG, GA, then GGGA
  punpcklbw  xmm0, xmm0   // 8 GG words
  punpcklbw  xmm3, xmm2   // 8 GA words
  MOVDQU     xmm1, xmm0
  punpcklwd  xmm0, xmm3   // GGGA first 4
  punpckhwd  xmm1, xmm3   // GGGA next 4
  sub        ecx, 8
  MOVDQU     [eax + edx], xmm0
  MOVDQU     [eax + edx + 16], xmm1
  lea        eax, [eax + 32]
  jg         @loop
  ret
end;

procedure GrayColor_SSE2(bmp: TBitmap);
begin

end;

{ 灰度 }
procedure GrayColor(bmp: TBitmap; const GrayColorType: TGrayColorType = gtScanLine03);
begin
  case GrayColorType of
    gtScanLine01:
      GrayColor_Scanline01(bmp);
    gtScanLine02:
      GrayColor_Scanline02(bmp);
    gtScanLine03:
      GrayColor_Scanline02(bmp);
    gtAPI:
      GrayColor_API(bmp);
    gtMMX:
      GrayColor_MMX(bmp);
    gtSSE:
      GrayColor_SSE(bmp);
    gtSSE2:
      GrayColor_SSE2(bmp);
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

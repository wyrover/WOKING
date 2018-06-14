unit untFastBmp;

interface

{ 反色 MMX 优化 }
procedure InvertMMX(pSrc: PByte; const Count: Integer);

procedure GrayMMX(pSrc: PByte; const Count: Integer);
procedure GraySSE(pSrc, pDst: PByte; const Count: Integer);

implementation

{ 反色 MMX 优化 }
const
  c_intMask: UInt64 = $FFFFFFFFFFFFFFFF; // 64位，8个字节，两个像素

procedure InvertMMX(pSrc: PByte; const Count: Integer);
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

const
  c_GrayMask: UInt64                       = $4B002F;
  c_GrayMaskArr: array [0 .. 7] of Integer = (117, 601, 306, 0, 117, 601, 306, 0);
  c_GrayMask2: UInt64                      = $012B024B0072;
  kARGBToGray: array [0 .. 15] of Integer  = (14, 76, 38, 0, 14, 76, 38, 0, 14, 76, 38, 0, 14, 76, 38, 0);

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

procedure GraySSE3(const src_argb, dst_argb: PByte; const Width: Integer);
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

end.

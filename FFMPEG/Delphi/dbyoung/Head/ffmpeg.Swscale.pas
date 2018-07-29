unit ffmpeg.Swscale;

interface

uses ffmpeg.Avcodec, ffmpeg.Avutil, ffmpeg.Common;

const
  LIBSWSCALE_MAX_VERSION_MAJOR   = 5;
  LIBSWSCALE_MAX_VERSION_MINOR   = 1;
  LIBSWSCALE_MAX_VERSION_RELEASE = 100;
  SWS_FAST_BILINEAR              = 1;
  SWS_BILINEAR                   = 2;
  SWS_BICUBIC                    = 4;
  SWS_X                          = 8;
  SWS_POINT                      = $10;
  SWS_AREA                       = $20;
  SWS_BICUBLIN                   = $40;
  SWS_GAUSS                      = $80;
  SWS_SINC                       = $100;
  SWS_LANCZOS                    = $200;
  SWS_SPLINE                     = $400;
  SWS_SRC_V_CHR_DROP_MASK        = $30000;
  SWS_SRC_V_CHR_DROP_SHIFT       = 16;
  SWS_PARAM_DEFAULT              = 123456;
  SWS_PRINT_INFO                 = $1000;
  SWS_FULL_CHR_H_INT             = $2000;
  SWS_FULL_CHR_H_INP             = $4000;
  SWS_DIRECT_BGR                 = $8000;
  SWS_ACCURATE_RND               = $40000;
  SWS_BITEXACT                   = $80000;
  SWS_ERROR_DIFFUSION            = $800000;
  SWS_MAX_REDUCE_CUTOFF          = 0.002;
  SWS_CS_ITU709                  = 1;
  SWS_CS_FCC                     = 4;
  SWS_CS_ITU601                  = 5;
  SWS_CS_ITU624                  = 5;
  SWS_CS_SMPTE170M               = 5;
  SWS_CS_SMPTE240M               = 7;
  SWS_CS_DEFAULT                 = 5;
  SWS_CS_BT2020                  = 9;
  SWS_MAX_FILTER_SIZE            = 256;
  MAX_FILTER_SIZE                = SWS_MAX_FILTER_SIZE;
  MAX_SLICE_PLANES               = 4;

type
  TQuadCintArray       = array [0 .. 3] of cint;
  PQuadCintArray       = ^TQuadCintArray;
  TCintArray           = array [0 .. 0] of cint;
  PCintArray           = ^TCintArray;
  TPCuint8Array        = array [0 .. 0] of PCuint8;
  PPCuint8Array        = ^TPCuint8Array;
  PSwsVector           = ^TSwsVector;
  PSwsFilter           = ^TSwsFilter;
  PSwsPlane            = ^TSwsPlane;
  PSwsSlice            = ^TSwsSlice;
  PSwsFilterDescriptor = ^TSwsFilterDescriptor;
  PSwsContext          = ^TSwsContext;
  arrThreeInt16        = array [0 .. 1] of pcint16;
  arrFourUint8         = array [0 .. 3] of UInt8;

  TSwsVector = record
    coeff: PCdouble;
    length: cint;
  end;

  TSwsFilter = record
    lumH: PSwsVector;
    lumV: PSwsVector;
    chrH: PSwsVector;
    chrV: PSwsVector;
  end;

  SwsPlane = record
    available_lines: Integer;
    sliceY: Integer;
    sliceH: Integer;
    line: ^puint8_t;
    tmp: ^puint8_t;
  end;

  TSwsPlane = SwsPlane;

  SwsSlice = record
    width: Integer;
    h_chr_sub_sample, v_chr_sub_sample, is_ring, should_free_lines: Integer;
    fmt: TAVPixelFormat;
    plane: array [0 .. MAX_SLICE_PLANES - 1] of SwsPlane;
  end;

  TSwsSlice = SwsSlice;

  SwsFilterDescriptor = record
    src: PSwsSlice;
    dst: PSwsSlice;
    alpha: Integer;
    instance: Pointer;
    process: function(c: PSwsContext; desc: PSwsFilterDescriptor; sliceY, sliceH: Int): Integer; cdecl;
  end;

  SwsDither = (          //
    SWS_DITHER_NONE = 0, //
    SWS_DITHER_AUTO,     //
    SWS_DITHER_BAYER,    //
    SWS_DITHER_ED,       //
    SWS_DITHER_A_DITHER, //
    SWS_DITHER_X_DITHER, //
    NB_SWS_DITHER);

  SwsAlphaBlend = (               //
    SWS_ALPHA_BLEND_NONE = 0,     //
    SWS_ALPHA_BLEND_UNIFORM,      //
    SWS_ALPHA_BLEND_CHECKERBOARD, //
    SWS_ALPHA_BLEND_NB            //
    );

  TSwsFilterDescriptor = SwsFilterDescriptor;

  SwsFunc             = function(context: PSwsContext; const src: TArray<puint8_t>; srcstride: TArray<Int>; srcSliceY, srcSliceH: Integer; dst: TArray<puint8_t>; dstStride: TArray<Int>)                                         : PInteger; cdecl;
  yuv2planar1_fn      = function(const src: pcint16; dest: puint8_t; dstw: Integer; const dither: puint8_t; offset: Integer)                                                                                               : Pointer; cdecl;
  yuv2planarX_fn      = function(const filter: pcint16; filterSize: Int; const src: pcint16; dest: puint8_t; dstw: Int; const dither: puint8_t; offset: Int)                                                               : Pointer; cdecl;
  yuv2interleavedX_fn = function(c: PSwsContext; const chrFilter: pcint16; chrFilterSIze: Int; const chrUSrc, chrVSrc: ppcint16; dest, dstw: puint8_t)                                                                : Pointer; cdecl;
  yuv2packed1_fn      = function(c: PSwsContext; const lumSrc: pcint16; const chrUSrc, chrVSrc: arrThreeInt16; const alpSrc, dest: pcint16; dstw, uvalpha, y: Int)                                                         : Pointer; cdecl;
  yuv2packed2_fn      = function(c: PSwsContext; const lumSrc, chrUSrc, chrVSrc, alpSrc: arrThreeInt16; const dest: pcint16; dstw, yalpha, uvalpha, y: Int)                                                                : Pointer; cdecl;
  yuv2packedX_fn      = function(c: PSwsContext; const lumFilter, lumSrc: pcint16; lumFilterSize: Integer; const chrFilter, chrUSrc, chrVSrc: ppcint16; chrFilterSIze: Int; alpSrc: ppcint16; dest: puint8_t; dstw, y: Int): Pointer; cdecl;
  yuv2anyX_fn         = function(c: PSwsContext; const lumFilter, lumSrc: pcint16; lumFilterSize: Integer; const chrFilter, chrUSrc, chrVSrc: ppcint16; chrFilterSIze: Int; alpSrc: ppcint16; dest: puint8_t; dstw, y: Int)   : Pointer; cdecl;

  TSwsContext = record
    av_class: TAVClass;
    Swscale: SwsFunc;
    srcW, srcH, dstH, chrSrcW, chrSrcH, chrDstW, chrDstH, lumXInc, chrXInc, lumYInc, chrYInc: Integer;
    dstFormat, srcFormat: TAVPixelFormat;
    dstFormatBpp, srcFormatBpp: Integer;
    dstBpc, srcBpc: Integer;
    chrSrcHSubSample, chrSrcVSubSample, chrDstHSubSample, chrDstVSubSample: Integer;
    vChrDrop: Integer;
    sliceDir: Integer;
    param: array [0 .. 1] of Double;
    cascaded_context: array [0 .. 2] of PSwsContext;
    cascaded_tmpStride: array [0 .. 3] of Integer;
    cascaded_tmp: array [0 .. 3] of puint8_t;
    cascaded1_tmpStride: array [0 .. 3] of Integer;
    cascaded1_tmp: array [0 .. 3] of puint8_t;
    cascaded_mainindex: Integer;
    gamma_value: Double;
    gamma_flag: Integer;
    is_internal_gamma: Integer;
    gamma, inv_gamma: pcuint16;
    numDesc: Integer;
    descIndex: array [0 .. 1] of Int;
    numSlice: Int;
    slice: PSwsSlice;
    desc: PSwsFilterDescriptor;
    pal_yuv, pal_rgb: array [0 .. 255] of UInt32;
    lastInLumBuf, lastInChrBuf, lumBufIndex, chrBufIndex: Integer;
    formatConvBuffer: puint8_t;
    needAlpha: Int;
    hLumFilter, hChrFilter, vLumFilter, vChrFilter: pcint16;
    hLumFilterPos, hChrFilterPos, vLumFilterPos, vChrFilterPos: pcint32;
    hLumFilterSize, hChrFilterSize, vLumFilterSize, vChrFilterSize: Int;
    lumMmxextFilterCodeSize, chrMmxextFilterCodeSize: Int;
    lumMmxextFilterCode, chrMmxextFilterCode: puint8_t;
    canMMXEXTBeUsed, warned_unuseable_bilinear: Int;
    dstY: Int;
    flags: Int;
    yuvTable: Pointer;
    dither_error: array [0 .. 3] of Int;
    contrast, brightness, saturation: Int;
    srcColorspaceTable, dstColorspaceTable: array [0 .. 3] of Int;
    srcRange: Int;
    dstRange: Int;
    src0Alpha: Int;
    dst0Alpha: Int;
    srcXYZ: Int;
    dstXYZ: Int;
    src_h_chr_pos: Int;
    dst_h_chr_pos: Int;
    src_v_chr_pos: Int;
    dst_v_chr_pos: Int;
    yuv2rgb_y_offset: Int;
    yuv2rgb_y_coeff: Int;
    yuv2rgb_v2r_coeff: Int;
    yuv2rgb_v2g_coeff: Int;
    yuv2rgb_u2g_coeff: Int;
    yuv2rgb_u2b_coeff: Int;
    lumMmxFilter: array [0 .. 4 * MAX_FILTER_SIZE - 1] of Integer;
    chrMmxFilter: array [0 .. 4 * MAX_FILTER_SIZE - 1] of Integer;
    dstw: Int;
    alpMmxFilter: array [0 .. 4 * MAX_FILTER_SIZE - 1] of Integer;
    chrDither8, lumDither8: puint8_t;
    use_mmx_vfilter: Integer;
    xyzgamma, rgbgamma, xyzgammainv, rgbgammainv: pcuint16;
    xyz2rgb_matrix, rgb2xyz_matrix: array [0 .. 2, 0 .. 3] of pcuint16;
    yuv2plane1: yuv2planar1_fn;
    yuv2planeX: yuv2planarX_fn;
    yuv2nv12cX: yuv2interleavedX_fn;
    yuv2packed1: yuv2packed1_fn;
    yuv2packed2: yuv2packed2_fn;
    yuv2packedX: yuv2packedX_fn;
    yuv2anyX: yuv2anyX_fn;
    lumToYV12: function(dst: puint8_t; const src, src2, src3: puint8_t; width: Integer; pal: pcuint32): Pointer; cdecl;
    alpToYV12: function(dst: puint8_t; const src, src2, src3: puint8_t; width: Integer; pal: pcuint32): Pointer; cdecl;
    chrToYV12: function(dstU, dstV: puint8_t; const src1, src2, src3: puint8_t; width: Integer; pal: pcuint32): Pointer; cdecl;
    readLumPlanar: function(dst: puint8_t; const src: arrFourUint8; width: Integer; rgb2yuv: Int32): Pointer; cdecl;
    readChrPlanar: function(dstU: puint8_t; dstV: puint8_t; const src: arrFourUint8; width: Int; rgb2yuv: pcint32): Pointer; cdecl;
    readAlpPlanar: function(dst: puint8_t; const src: arrFourUint8; width: Integer; rgb2yuv: pcint32): Pointer; cdecl;
    hyscale_fast: function(c: PSwsContext; dst: pcint16; dstwidth: Int; const src: puint8_t; srcW, xInc: Integer): Pointer; cdecl;
    hcscale_fast: function(c: PSwsContext; dst1, dst2: pcint16; dstwidth: Int; const src1, src2: puint8_t; srcW, xInc: Integer): Pointer; cdecl;
    hyScale: function(c: PSwsContext; dst, dstw: pcint16; const src: puint8_t; const filter: pcint16; const filterPos: pcint32; filterSize: Int): Pointer; cdecl;
    hcScale: function(c: PSwsContext; dst, dstw: pcint16; const src: puint8_t; const filter: pcint16; const filterPos: pcint32; filterSize: Int): Pointer; cdecl;
    lumConvertRange: function(dst: pcint16; width: Int): Pointer; cdecl;
    chrConvertRange: function(dst1, dst2: pcint16; width: Int): Pointer; cdecl;
    needs_hcscale: Integer;
    dither: SwsDither;
    alphablend: SwsAlphaBlend;
  end;

procedure sws_addVec(a: PSwsVector; b: PSwsVector); cdecl; external c_strFFmpegDllX64Name; deprecated;
function sws_allocVec(length: cint): PSwsVector; cdecl; external c_strFFmpegDllX64Name;
function sws_alloc_context(): PSwsContext; cdecl; external c_strFFmpegDllX64Name;
function sws_alloc_set_opts(srcW, srcH: Int; srcFormat: TAVPixelFormat; dstw, dstH: Integer; dstFormat: TAVPixelFormat; flags: Integer; const param: PDouble): PSwsContext; cdecl; external c_strFFmpegDllX64Name;
function sws_cloneVec(a: PSwsVector): PSwsVector; cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure sws_convVec(a: PSwsVector; b: PSwsVector); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure sws_convertPalette8ToPacked24(src: PPCuint8Array; dst: PPCuint8Array; num_pixels: cint; palette: PPCuint8Array); cdecl; external c_strFFmpegDllX64Name;
procedure sws_convertPalette8ToPacked32(src: PPCuint8Array; dst: PPCuint8Array; num_pixels: cint; palette: PPCuint8Array); cdecl; external c_strFFmpegDllX64Name;
procedure sws_freeContext(swsContext: PSwsContext); cdecl; external c_strFFmpegDllX64Name;
procedure sws_freeFilter(filter: PSwsFilter); cdecl; external c_strFFmpegDllX64Name;
procedure sws_freeVec(a: PSwsVector); cdecl; external c_strFFmpegDllX64Name;
function sws_getCachedContext(context: PSwsContext; srcW: cint; srcH: cint; srcFormat: TAVPixelFormat; dstw: cint; dstH: cint; dstFormat: TAVPixelFormat; flags: cint; srcFilter: PSwsFilter; dstFilter: PSwsFilter; param: PCdouble): PSwsContext; cdecl; external c_strFFmpegDllX64Name;
function sws_getCoefficients(colorspace: cint): Pcint; cdecl; external c_strFFmpegDllX64Name;
function sws_getColorspaceDetails(c: PSwsContext; var inv_table: PQuadCintArray; var srcRange: cint; var table: PQuadCintArray; var dstRange: cint; var brightness: cint; var contrast: cint; var saturation: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function sws_getConstVec(c: cdouble; length: cint): PSwsVector; cdecl; external c_strFFmpegDllX64Name; deprecated;
function sws_getContext(srcW: cint; srcH: cint; srcFormat: TAVPixelFormat; dstw: cint; dstH: cint; dstFormat: TAVPixelFormat; flags: cint; srcFilter: PSwsFilter; dstFilter: PSwsFilter; param: PCdouble): PSwsContext; cdecl; external c_strFFmpegDllX64Name;
function sws_getDefaultFilter(lumaGBlur: cfloat; chromaGBlur: cfloat; lumaSharpen: cfloat; chromaSharpen: cfloat; chromaHShift: cfloat; chromaVShift: cfloat; verbose: cint): PSwsFilter; cdecl; external c_strFFmpegDllX64Name;
function sws_getGaussianVec(variance: cdouble; quality: cdouble): PSwsVector; cdecl; external c_strFFmpegDllX64Name;
function sws_getIdentityVec: PSwsVector; cdecl; external c_strFFmpegDllX64Name; deprecated;
function sws_get_class(): PAVClass; cdecl; external c_strFFmpegDllX64Name;
function sws_init_context(sws_context: PSwsContext; srcFilter: PSwsFilter; dstFilter: PSwsFilter): cint; cdecl; external c_strFFmpegDllX64Name;
function sws_isSupportedEndiannessConversion(pix_fmt: TAVPixelFormat): cint; cdecl; external c_strFFmpegDllX64Name;
function sws_isSupportedInput(pix_fmt: TAVPixelFormat): cint; cdecl; external c_strFFmpegDllX64Name;
function sws_isSupportedOutput(pix_fmt: TAVPixelFormat): cint; cdecl; external c_strFFmpegDllX64Name;
procedure sws_normalizeVec(a: PSwsVector; height: cdouble); cdecl; external c_strFFmpegDllX64Name;
procedure sws_printVec2(a: PSwsVector; log_ctx: PAVClass; log_level: cint); cdecl; external c_strFFmpegDllX64Name; deprecated;
function sws_scale(c: PSwsContext; srcSlice: PPCuint8Array; srcstride: PCintArray; srcSliceY: cint; srcSliceH: cint; dst: PPCuint8Array; dstStride: PCintArray): cint; cdecl; external c_strFFmpegDllX64Name;
procedure sws_scaleVec(a: PSwsVector; scalar: cdouble); cdecl; external c_strFFmpegDllX64Name;
function sws_setColorspaceDetails(c: PSwsContext; inv_table: PQuadCintArray; srcRange: cint; table: PQuadCintArray; dstRange: cint; brightness: cint; contrast: cint; saturation: cint): cint; cdecl; external c_strFFmpegDllX64Name;
procedure sws_shiftVec(a: PSwsVector; shift: cint); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure sws_subVec(a: PSwsVector; b: PSwsVector); cdecl; external c_strFFmpegDllX64Name; deprecated;
function swscale_license(): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function swscale_version(): cuint; cdecl; external c_strFFmpegDllX64Name;

var
  LIBSWSCALE_MAX_VERSION: PAnsiChar;

implementation

initialization
  LIBSWSCALE_MAX_VERSION := AV_VERSION(LIBSWSCALE_MAX_VERSION_MAJOR, LIBSWSCALE_MAX_VERSION_MINOR, LIBSWSCALE_MAX_VERSION_RELEASE);

end.

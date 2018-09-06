unit ffmpeg.Avutil;

interface

uses System.SysUtils, ffmpeg.Common;

const
  VERSION_MAJOR                     = 1000000;
  VERSION_MINOR                     = 1000;
  VERSION_RELEASE                   = 1;
  LIBAVUTIL_MAX_VERSION_MAJOR       = 56;
  LIBAVUTIL_MAX_VERSION_MINOR       = 14;
  LIBAVUTIL_MAX_VERSION_RELEASE     = 100;
  LIBAVUTIL_MIN_VERSION_MAJOR       = 56;
  LIBAVUTIL_MIN_VERSION_MINOR       = 14;
  LIBAVUTIL_MIN_VERSION_RELEASE     = 100;
  LIBAVUTIL_MAX_VERSION             = (LIBAVUTIL_MAX_VERSION_MAJOR * VERSION_MAJOR) + (LIBAVUTIL_MAX_VERSION_MINOR * VERSION_MINOR) + (LIBAVUTIL_MAX_VERSION_RELEASE * VERSION_RELEASE);
  LIBAVUTIL_MIN_VERSION             = (LIBAVUTIL_MIN_VERSION_MAJOR * VERSION_MAJOR) + (LIBAVUTIL_MIN_VERSION_MINOR * VERSION_MINOR) + (LIBAVUTIL_MIN_VERSION_RELEASE * VERSION_RELEASE);
  AV_NUM_DATA_POINTERS              = 8;
  FF_LAMBDA_SHIFT                   = 7;
  FF_LAMBDA_SCALE                   = (1 shl FF_LAMBDA_SHIFT);
  FF_QP2LAMBDA                      = 118;
  FF_LAMBDA_MAX                     = (256 * 128 - 1);
  FF_QUALITY_SCALE                  = FF_LAMBDA_SCALE;
  AV_NOPTS_VALUE                    = $8000000000000000;
  AV_TIME_BASE                      = 1000000;
  AV_FOURCC_MAX_STRING_SIZE         = 32;
  AV_ERROR_MAX_STRING_SIZE          = 64;
  ENOENT                            = 2;
  EIO                               = 5;
  EAGAIN                            = 11;
  ENOMEM                            = 12;
  EINVAL                            = 22;
  EPIPE                             = 32;
  EDOM                              = 33;
  ENOSYS                            = 40;
  EILSEQ                            = 42;
  AVERROR_SIGN                      = (EINVAL shr 30) and $00000002 - 1;
  AV_OPT_FLAG_ENCODING_PARAM        = 1;
  AV_OPT_FLAG_DECODING_PARAM        = 2;
  AV_OPT_FLAG_AUDIO_PARAM           = 8;
  AV_OPT_FLAG_VIDEO_PARAM           = 16;
  AV_OPT_FLAG_SUBTITLE_PARAM        = 32;
  AV_OPT_FLAG_EXPORT                = 64;
  AV_OPT_FLAG_READONLY              = 128;
  AV_OPT_FLAG_BSF_PARAM             = 1 shl 8;
  AV_OPT_FLAG_FILTERING_PARAM       = 1 shl 16;
  AV_LOG_QUIET                      = -8;
  AV_LOG_PANIC                      = 0;
  AV_LOG_FATAL                      = 8;
  AV_LOG_ERROR                      = 16;
  AV_LOG_WARNING                    = 24;
  AV_LOG_INFO                       = 32;
  AV_LOG_VERBOSE                    = 40;
  AV_LOG_DEBUG                      = 48;
  AV_LOG_TRACE                      = 56;
  AV_LOG_MAX_OFFSET                 = (AV_LOG_DEBUG - AV_LOG_QUIET);
  AV_DICT_MATCH_CASE                = 1;
  AV_DICT_IGNORE_SUFFIX             = 2;
  AV_DICT_DONT_STRDUP_KEY           = 4;
  AV_DICT_DONT_STRDUP_VAL           = 8;
  AV_DICT_DONT_OVERWRITE            = 16;
  AV_DICT_APPEND                    = 32;
  AV_DICT_MULTIKEY                  = 64;
  AV_CPU_FLAG_FORCE                 = $80000000;
  AV_CPU_FLAG_MMX                   = $0001;
  AV_CPU_FLAG_MMXEXT                = $0002;
  AV_CPU_FLAG_MMX2                  = $0002;
  AV_CPU_FLAG_3DNOW                 = $0004;
  AV_CPU_FLAG_SSE                   = $0008;
  AV_CPU_FLAG_SSE2                  = $0010;
  AV_CPU_FLAG_SSE2SLOW              = $40000000;
  AV_CPU_FLAG_3DNOWEXT              = $0020;
  AV_CPU_FLAG_SSE3                  = $0040;
  AV_CPU_FLAG_SSE3SLOW              = $20000000;
  AV_CPU_FLAG_SSSE3                 = $0080;
  AV_CPU_FLAG_ATOM                  = $10000000;
  AV_CPU_FLAG_SSE4                  = $0100;
  AV_CPU_FLAG_SSE42                 = $0200;
  AV_CPU_FLAG_AESNI                 = $80000;
  AV_CPU_FLAG_AVX                   = $4000;
  AV_CPU_FLAG_AVXSLOW               = $8000000;
  AV_CPU_FLAG_XOP                   = $0400;
  AV_CPU_FLAG_FMA4                  = $0800;
  AV_CPU_FLAG_CMOV                  = $1000;
  AV_CPU_FLAG_AVX2                  = $8000;
  AV_CPU_FLAG_FMA3                  = $10000;
  AV_CPU_FLAG_BMI1                  = $20000;
  AV_CPU_FLAG_BMI2                  = $40000;
  AV_CPU_FLAG_AVX512                = $100000;
  AV_CPU_FLAG_ALTIVEC               = $0001;
  AV_CPU_FLAG_VSX                   = $0002;
  AV_CPU_FLAG_POWER8                = $0004;
  AV_CPU_FLAG_ARMV5TE               = (1 shl 0);
  AV_CPU_FLAG_ARMV6                 = (1 shl 1);
  AV_CPU_FLAG_ARMV6T2               = (1 shl 2);
  AV_CPU_FLAG_VFP                   = (1 shl 3);
  AV_CPU_FLAG_VFPV3                 = (1 shl 4);
  AV_CPU_FLAG_NEON                  = (1 shl 5);
  AV_CPU_FLAG_ARMV8                 = (1 shl 6);
  AV_CPU_FLAG_VFP_VM                = (1 shl 7);
  AV_CPU_FLAG_SETEND                = (1 shl 16);
  M_E                               = 2.7182818284590452354;
  M_LN2                             = 0.69314718055994530942;
  M_LN10                            = 2.30258509299404568402;
  M_LOG2_10                         = 3.32192809488736234787;
  M_PHI                             = 1.61803398874989484820;
  M_PI                              = 3.14159265358979323846;
  M_PI_2                            = 1.57079632679489661923;
  M_SQRT1_2                         = 0.70710678118654752440;
  M_SQRT2                           = 1.41421356237309504880;
  NAN                               = $7FC00000;
  INFINITY                          = $7F800000;
  AVPALETTE_SIZE                    = 1024;
  AVPALETTE_COUNT                   = 256;
  AV_BUFFER_FLAG_READONLY           = (1 shl 0);
  AV_OPT_FLAG_IMPLICIT_KEY          = 1;
  AV_FRAME_FLAG_CORRUPT             = (1 shl 0);
  AV_FRAME_FLAG_DISCARD             = (1 shl 2);
  FF_DECODE_ERROR_INVALID_BITSTREAM = 1;
  FF_DECODE_ERROR_MISSING_REFERENCE = 2;
  AV_FRAME_CROP_UNALIGNED           = 1 shl 0;

type
  PPAVFrame            = ^PAVFrame;
  PAVFrame             = ^TAVFrame;
  PTAVPixelFormat      = ^TAVPixelFormat;
  PAVPixelFormat       = ^TAVPixelFormat;
  PAVDictionaryEntry   = ^TAVDictionaryEntry;
  PAVDictionary        = ^AVDictionary;
  PPAVDictionary       = ^PAVDictionary;
  PPPAVDictionary      = ^PPAVDictionary;
  PAVSampleFormatArray = ^TAVSampleFormatArray;
  PAVFile              = Pointer;
  PAVRational          = ^TAVRational;
  PAVPanScan           = ^TAVPanScan;
  PPAVBufferRef        = ^PAVBufferRef;
  PAVBufferRef         = ^TAVBufferRef;
  PAVOption            = ^TAVOption;
  PAVClassCategory     = ^TAVClassCategory;
  PAVOptionRanges      = ^TAVOptionRanges;
  PPAVOptionRanges     = ^PAVOptionRanges;
  PAVOptionRange       = ^TAVOptionRange;
  PPAVOptionRange      = ^PAVOptionRange;
  PAVSampleFormat      = ^TAVSampleFormat;
  PAVClass             = ^TAVClass;
  PAVFrameSideData     = ^TAVFrameSideData;

  TAVDictionaryEntry = record
    key: PAnsiChar;
    value: PAnsiChar;
  end;

  AVDictionary = record
    count: cint;
    elems: PAVDictionaryEntry;
  end;

  TAVDictionary = AVDictionary;

  TAVPictureType = (          //
    AV_PICTURE_TYPE_NONE = 0, //
    AV_PICTURE_TYPE_I,        //
    AV_PICTURE_TYPE_P,        //
    AV_PICTURE_TYPE_B,        //
    AV_PICTURE_TYPE_S,        //
    AV_PICTURE_TYPE_SI,       //
    AV_PICTURE_TYPE_SP,       //
    AV_PICTURE_TYPE_BI);

  TAVRational = record
    num: cint;
    den: cint;
  end;

  TAVFrame = record
    data: array [0 .. AV_NUM_DATA_POINTERS - 1] of pbyte;
    linesize: array [0 .. AV_NUM_DATA_POINTERS - 1] of cint;
    extended_data: pbyte;
    width, height: cint;
    nb_samples: cint;
    format: cint;
    key_frame: cint;
    pict_type: TAVPictureType;
    base: array [0 .. AV_NUM_DATA_POINTERS - 1] of pbyte;
    sample_aspect_ratio: TAVRational;
    pts: cint64;
    pkt_pts: cint64;
    pkt_dts: cint64;
    coded_picture_number: cint;
    display_picture_number: cint;
    quality: cint;
    reference: cint;
    qscale_table: PShortint;
    qstride: cint;
    qscale_type: cint;
    mbskip_table: pbyte;
    motion_val: array [0 .. 1] of Pointer;
    mb_type: PCuint;
    dct_coeff: PsmallInt;
    ref_index: array [0 .. 1] of PShortint;
    opaque: Pointer;
    error: array [0 .. AV_NUM_DATA_POINTERS - 1] of cuint64;
    type_: cint;
    repeat_pict: cint;
    interlaced_frame: cint;
    top_field_first: cint;
    palette_has_changed: cint;
    buffer_hints: cint;
    pan_scan: PAVPanScan;
    reordered_opaque: cint64;
    hwaccel_picture_private: Pointer;
    owner: Pointer; // PAVCodecContext;
    thread_opaque: Pointer;
    motion_subsample_log2: cuint8;
    sample_rate: cint;
    channel_layout: cuint64;
    best_effort_timestamp: cint64;
    pkt_pos: cint64;
    pkt_duration: cint64;
    metadata: PAVDictionary;
    decode_error_flags: cint;
    channels: cint;
    pkt_size: cint;
  end;

  AVMatrixEncoding = (                 //
    AV_MATRIX_ENCODING_NONE,           //
    AV_MATRIX_ENCODING_DOLBY,          //
    AV_MATRIX_ENCODING_DPLII,          //
    AV_MATRIX_ENCODING_DPLIIX,         //
    AV_MATRIX_ENCODING_DPLIIZ,         //
    AV_MATRIX_ENCODING_DOLBYEX,        //
    AV_MATRIX_ENCODING_DOLBYHEADPHONE, //
    AV_MATRIX_ENCODING_NB              //
    );

  AVSampleFormat = (         //
    AV_SAMPLE_FMT_NONE = -1, //
    AV_SAMPLE_FMT_U8,        //
    AV_SAMPLE_FMT_S16,       //
    AV_SAMPLE_FMT_S32,       //
    AV_SAMPLE_FMT_FLT,       //
    AV_SAMPLE_FMT_DBL,       //
    AV_SAMPLE_FMT_U8P,       //
    AV_SAMPLE_FMT_S16P,      //
    AV_SAMPLE_FMT_S32P,      //
    AV_SAMPLE_FMT_FLTP,      //
    AV_SAMPLE_FMT_DBLP,      //
    AV_SAMPLE_FMT_S64,       //
    AV_SAMPLE_FMT_S64P,      //
    AV_SAMPLE_FMT_NB         //
    );
  TAVSampleFormat      = AVSampleFormat;
  TAVSampleFormatArray = array [0 .. MaxInt div SizeOf(TAVSampleFormat) - 1] of TAVSampleFormat;

  TAVMediaType = (             //
    AVMEDIA_TYPE_UNKNOWN = -1, //
    AVMEDIA_TYPE_VIDEO,        //
    AVMEDIA_TYPE_AUDIO,        //
    AVMEDIA_TYPE_DATA,         //
    AVMEDIA_TYPE_SUBTITLE,     //
    AVMEDIA_TYPE_ATTACHMENT,   //
    AVMEDIA_TYPE_NB            //
    );

  TAVColorRange = (              //
    AVCOL_RANGE_UNSPECIFIED = 0, //
    AVCOL_RANGE_MPEG = 1,        //
    AVCOL_RANGE_JPEG = 2,        //
    AVCOL_RANGE_NB               //
    );

  TAVColorPrimaries = (                          //
    AVCOL_PRI_RESERVED0 = 0,                     //
    AVCOL_PRI_BT709 = 1,                         //
    AVCOL_PRI_UNSPECIFIED = 2,                   //
    AVCOL_PRI_RESERVED = 3,                      //
    AVCOL_PRI_BT470M = 4,                        //
    AVCOL_PRI_BT470BG = 5,                       //
    AVCOL_PRI_SMPTE170M = 6,                     //
    AVCOL_PRI_SMPTE240M = 7,                     //
    AVCOL_PRI_FILM = 8,                          //
    AVCOL_PRI_BT2020 = 9,                        //
    AVCOL_PRI_SMPTE428 = 10,                     //
    AVCOL_PRI_SMPTEST428_1 = AVCOL_PRI_SMPTE428, //
    AVCOL_PRI_SMPTE431 = 11,                     //
    AVCOL_PRI_SMPTE432 = 12,                     //
    AVCOL_PRI_JEDEC_P22 = 22,                    //
    AVCOL_PRI_NB);

  TAVColorTransferCharacteristic = (             //
    AVCOL_TRC_RESERVED0 = 0,                     //
    AVCOL_TRC_BT709 = 1,                         //
    AVCOL_TRC_UNSPECIFIED = 2,                   //
    AVCOL_TRC_RESERVED = 3,                      //
    AVCOL_TRC_GAMMA22 = 4,                       //
    AVCOL_TRC_GAMMA28 = 5,                       //
    AVCOL_TRC_SMPTE170M = 6,                     //
    AVCOL_TRC_SMPTE240M = 7,                     //
    AVCOL_TRC_LINEAR = 8,                        //
    AVCOL_TRC_LOG = 9,                           //
    AVCOL_TRC_LOG_SQRT = 10,                     //
    AVCOL_TRC_IEC61966_2_4 = 11,                 //
    AVCOL_TRC_BT1361_ECG = 12,                   //
    AVCOL_TRC_IEC61966_2_1 = 13,                 //
    AVCOL_TRC_BT2020_10 = 14,                    //
    AVCOL_TRC_BT2020_12 = 15,                    //
    AVCOL_TRC_SMPTE2084 = 16,                    //
    AVCOL_TRC_SMPTEST2084 = AVCOL_TRC_SMPTE2084, //
    AVCOL_TRC_SMPTE428 = 17,                     //
    AVCOL_TRC_SMPTEST428_1 = AVCOL_TRC_SMPTE428, //
    AVCOL_TRC_ARIB_STD_B67 = 18,                 //
    AVCOL_TRC_NB                                 //
    );

  TAVColorSpace = (                    //
    AVCOL_SPC_RGB = 0,                 //
    AVCOL_SPC_BT709 = 1,               //
    AVCOL_SPC_UNSPECIFIED = 2,         //
    AVCOL_SPC_RESERVED = 3,            //
    AVCOL_SPC_FCC = 4,                 //
    AVCOL_SPC_BT470BG = 5,             //
    AVCOL_SPC_SMPTE170M = 6,           //
    AVCOL_SPC_SMPTE240M = 7,           //
    AVCOL_SPC_YCGCO = 8,               //
    AVCOL_SPC_YCOCG = AVCOL_SPC_YCGCO, //
    AVCOL_SPC_BT2020_NCL = 9,          //
    AVCOL_SPC_BT2020_CL = 10,          //
    AVCOL_SPC_SMPTE2085 = 11,          //
    AVCOL_SPC_CHROMA_DERIVED_NCL = 12, //
    AVCOL_SPC_CHROMA_DERIVED_CL = 13,  //
    AVCOL_SPC_ICTCP = 14,              //
    AVCOL_SPC_NB);

  TAVChromaLocation = (           //
    AVCHROMA_LOC_UNSPECIFIED = 0, //
    AVCHROMA_LOC_LEFT = 1,        //
    AVCHROMA_LOC_CENTER = 2,      //
    AVCHROMA_LOC_TOPLEFT = 3,     //
    AVCHROMA_LOC_TOP = 4,         //
    AVCHROMA_LOC_BOTTOMLEFT = 5,  //
    AVCHROMA_LOC_BOTTOM = 6,      //
    AVCHROMA_LOC_NB);

  TAVPixelFormat = (                         //
    AV_PIX_FMT_NONE = -1,                    //
    AV_PIX_FMT_YUV420P,                      //
    AV_PIX_FMT_YUYV422,                      //
    AV_PIX_FMT_RGB24,                        //
    AV_PIX_FMT_BGR24,                        //
    AV_PIX_FMT_YUV422P,                      //
    AV_PIX_FMT_YUV444P,                      //
    AV_PIX_FMT_YUV410P,                      //
    AV_PIX_FMT_YUV411P,                      //
    AV_PIX_FMT_GRAY8,                        //
    AV_PIX_FMT_MONOWHITE,                    //
    AV_PIX_FMT_MONOBLACK,                    //
    AV_PIX_FMT_PAL8,                         //
    AV_PIX_FMT_YUVJ420P,                     //
    AV_PIX_FMT_YUVJ422P,                     //
    AV_PIX_FMT_YUVJ444P,                     //
    AV_PIX_FMT_UYVY422,                      //
    AV_PIX_FMT_UYYVYY411,                    //
    AV_PIX_FMT_BGR8,                         //
    AV_PIX_FMT_BGR4,                         //
    AV_PIX_FMT_BGR4_BYTE,                    //
    AV_PIX_FMT_RGB8,                         //
    AV_PIX_FMT_RGB4,                         //
    AV_PIX_FMT_RGB4_BYTE,                    //
    AV_PIX_FMT_NV12,                         //
    AV_PIX_FMT_NV21,                         //
    AV_PIX_FMT_ARGB,                         //
    AV_PIX_FMT_RGBA,                         //
    AV_PIX_FMT_ABGR,                         //
    AV_PIX_FMT_BGRA,                         //
    AV_PIX_FMT_GRAY16BE,                     //
    AV_PIX_FMT_GRAY16LE,                     //
    AV_PIX_FMT_YUV440P,                      //
    AV_PIX_FMT_YUVJ440P,                     //
    AV_PIX_FMT_YUVA420P,                     //
    AV_PIX_FMT_RGB48BE,                      //
    AV_PIX_FMT_RGB48LE,                      //
    AV_PIX_FMT_RGB565BE,                     //
    AV_PIX_FMT_RGB565LE,                     //
    AV_PIX_FMT_RGB555BE,                     //
    AV_PIX_FMT_RGB555LE,                     //
    AV_PIX_FMT_BGR565BE,                     //
    AV_PIX_FMT_BGR565LE,                     //
    AV_PIX_FMT_BGR555BE,                     //
    AV_PIX_FMT_BGR555LE,                     //
{$IFDEF FF_API_VAAPI}                        //
    AV_PIX_FMT_VAAPI_MOCO,                   //
    AV_PIX_FMT_VAAPI_IDCT,                   //
    AV_PIX_FMT_VAAPI_VLD,                    //
    AV_PIX_FMT_VAAPI = AV_PIX_FMT_VAAPI_VLD, //
{$ELSE}                                      //
    AV_PIX_FMT_VAAPI,                        //
{$ENDIF}                                     //
    AV_PIX_FMT_YUV420P16LE,                  //
    AV_PIX_FMT_YUV420P16BE,                  //
    AV_PIX_FMT_YUV422P16LE,                  //
    AV_PIX_FMT_YUV422P16BE,                  //
    AV_PIX_FMT_YUV444P16LE,                  //
    AV_PIX_FMT_YUV444P16BE,                  //
    AV_PIX_FMT_DXVA2_VLD,                    //
    AV_PIX_FMT_RGB444LE,                     //
    AV_PIX_FMT_RGB444BE,                     //
    AV_PIX_FMT_BGR444LE,                     //
    AV_PIX_FMT_BGR444BE,                     //
    AV_PIX_FMT_YA8,                          //
    AV_PIX_FMT_BGR48BE,                      //
    AV_PIX_FMT_BGR48LE,                      //
    AV_PIX_FMT_YUV420P9BE,                   //
    AV_PIX_FMT_YUV420P9LE,                   //
    AV_PIX_FMT_YUV420P10BE,                  //
    AV_PIX_FMT_YUV420P10LE,                  //
    AV_PIX_FMT_YUV422P10BE,                  //
    AV_PIX_FMT_YUV422P10LE,                  //
    AV_PIX_FMT_YUV444P9BE,                   //
    AV_PIX_FMT_YUV444P9LE,                   //
    AV_PIX_FMT_YUV444P10BE,                  //
    AV_PIX_FMT_YUV444P10LE,                  //
    AV_PIX_FMT_YUV422P9BE,                   //
    AV_PIX_FMT_YUV422P9LE,                   //
    AV_PIX_FMT_GBRP,                         //
    AV_PIX_FMT_GBR24P = AV_PIX_FMT_GBRP,     //
    AV_PIX_FMT_GBRP9BE,                      //
    AV_PIX_FMT_GBRP9LE,                      //
    AV_PIX_FMT_GBRP10BE,                     //
    AV_PIX_FMT_GBRP10LE,                     //
    AV_PIX_FMT_GBRP16BE,                     //
    AV_PIX_FMT_GBRP16LE,                     //
    AV_PIX_FMT_YUVA422P,                     //
    AV_PIX_FMT_YUVA444P,                     //
    AV_PIX_FMT_YUVA420P9BE,                  //
    AV_PIX_FMT_YUVA420P9LE,                  //
    AV_PIX_FMT_YUVA422P9BE,                  //
    AV_PIX_FMT_YUVA422P9LE,                  //
    AV_PIX_FMT_YUVA444P9BE,                  //
    AV_PIX_FMT_YUVA444P9LE,                  //
    AV_PIX_FMT_YUVA420P10BE,                 //
    AV_PIX_FMT_YUVA420P10LE,                 //
    AV_PIX_FMT_YUVA422P10BE,                 //
    AV_PIX_FMT_YUVA422P10LE,                 //
    AV_PIX_FMT_YUVA444P10BE,                 //
    AV_PIX_FMT_YUVA444P10LE,                 //
    AV_PIX_FMT_YUVA420P16BE,                 //
    AV_PIX_FMT_YUVA420P16LE,                 //
    AV_PIX_FMT_YUVA422P16BE,                 //
    AV_PIX_FMT_YUVA422P16LE,                 //
    AV_PIX_FMT_YUVA444P16BE,                 //
    AV_PIX_FMT_YUVA444P16LE,                 //
    AV_PIX_FMT_VDPAU,                        //
    AV_PIX_FMT_XYZ12LE,                      //
    AV_PIX_FMT_XYZ12BE,                      //
    AV_PIX_FMT_NV16,                         //
    AV_PIX_FMT_NV20LE,                       //
    AV_PIX_FMT_NV20BE,                       //
    AV_PIX_FMT_RGBA64BE,                     //
    AV_PIX_FMT_RGBA64LE,                     //
    AV_PIX_FMT_BGRA64BE,                     //
    AV_PIX_FMT_BGRA64LE,                     //
    AV_PIX_FMT_YVYU422,                      //
    AV_PIX_FMT_YA16BE,                       //
    AV_PIX_FMT_YA16LE,                       //
    AV_PIX_FMT_GBRAP,                        //
    AV_PIX_FMT_GBRAP16BE,                    //
    AV_PIX_FMT_GBRAP16LE,                    //
    AV_PIX_FMT_QSV,                          //
    AV_PIX_FMT_MMAL,                         //
    AV_PIX_FMT_D3D11VA_VLD,                  //
    AV_PIX_FMT_CUDA,                         //
    AV_PIX_FMT_0RGB,                         //
    AV_PIX_FMT_RGB0,                         //
    AV_PIX_FMT_0BGR,                         //
    AV_PIX_FMT_BGR0,                         //
    AV_PIX_FMT_YUV420P12BE,                  //
    AV_PIX_FMT_YUV420P12LE,                  //
    AV_PIX_FMT_YUV420P14BE,                  //
    AV_PIX_FMT_YUV420P14LE,                  //
    AV_PIX_FMT_YUV422P12BE,                  //
    AV_PIX_FMT_YUV422P12LE,                  //
    AV_PIX_FMT_YUV422P14BE,                  //
    AV_PIX_FMT_YUV422P14LE,                  //
    AV_PIX_FMT_YUV444P12BE,                  //
    AV_PIX_FMT_YUV444P12LE,                  //
    AV_PIX_FMT_YUV444P14BE,                  //
    AV_PIX_FMT_YUV444P14LE,                  //
    AV_PIX_FMT_GBRP12BE,                     //
    AV_PIX_FMT_GBRP12LE,                     //
    AV_PIX_FMT_GBRP14BE,                     //
    AV_PIX_FMT_GBRP14LE,                     //
    AV_PIX_FMT_YUVJ411P,                     //
    AV_PIX_FMT_BAYER_BGGR8,                  //
    AV_PIX_FMT_BAYER_RGGB8,                  //
    AV_PIX_FMT_BAYER_GBRG8,                  //
    AV_PIX_FMT_BAYER_GRBG8,                  //
    AV_PIX_FMT_BAYER_BGGR16LE,               //
    AV_PIX_FMT_BAYER_BGGR16BE,               //
    AV_PIX_FMT_BAYER_RGGB16LE,               //
    AV_PIX_FMT_BAYER_RGGB16BE,               //
    AV_PIX_FMT_BAYER_GBRG16LE,               //
    AV_PIX_FMT_BAYER_GBRG16BE,               //
    AV_PIX_FMT_BAYER_GRBG16LE,               //
    AV_PIX_FMT_BAYER_GRBG16BE,               //
    AV_PIX_FMT_XVMC,                         //
    AV_PIX_FMT_YUV440P10LE,                  //
    AV_PIX_FMT_YUV440P10BE,                  //
    AV_PIX_FMT_YUV440P12LE,                  //
    AV_PIX_FMT_YUV440P12BE,                  //
    AV_PIX_FMT_AYUV64LE,                     //
    AV_PIX_FMT_AYUV64BE,                     //
    AV_PIX_FMT_VIDEOTOOLBOX,                 //
    AV_PIX_FMT_P010LE,                       //
    AV_PIX_FMT_P010BE,                       //
    AV_PIX_FMT_GBRAP12BE,                    //
    AV_PIX_FMT_GBRAP12LE,                    //
    AV_PIX_FMT_GBRAP10BE,                    //
    AV_PIX_FMT_GBRAP10LE,                    //
    AV_PIX_FMT_MEDIACODEC,                   //
    AV_PIX_FMT_GRAY12BE,                     //
    AV_PIX_FMT_GRAY12LE,                     //
    AV_PIX_FMT_GRAY10BE,                     //
    AV_PIX_FMT_GRAY10LE,                     //
    AV_PIX_FMT_P016LE,                       //
    AV_PIX_FMT_P016BE,                       //
    AV_PIX_FMT_D3D11,                        //
    AV_PIX_FMT_GRAY9BE,                      //
    AV_PIX_FMT_GRAY9LE,                      //
    AV_PIX_FMT_GBRPF32BE,                    //
    AV_PIX_FMT_GBRPF32LE,                    //
    AV_PIX_FMT_GBRAPF32BE,                   //
    AV_PIX_FMT_GBRAPF32LE,                   //
    AV_PIX_FMT_DRM_PRIME,                    //
    AV_PIX_FMT_OPENCL,                       //
    AV_PIX_FMT_NB                            //
    );

  TAVPanScan = record
    id: cint;
    width: cint;
    height: cint;
    position: array [0 .. 2] of array [0 .. 1] of cint16;
  end;

  TAVBuffer = record
    data: puint8_t;
    refcount: atomic_uint;
    free: function(opaque: Pointer; data: puint8_t): Pointer; cdecl;
    opaque: Pointer;
    flags: int;
  end;

  TAVBufferRef = record
    buffer: TAVBuffer;
    data: pbyte;
    size: cint;
  end;

  TAVOptionType = (             //
    AV_OPT_TYPE_FLAGS,          //
    AV_OPT_TYPE_INT,            //
    AV_OPT_TYPE_INT64,          //
    AV_OPT_TYPE_DOUBLE,         //
    AV_OPT_TYPE_FLOAT,          //
    AV_OPT_TYPE_STRING,         //
    AV_OPT_TYPE_RATIONAL,       //
    AV_OPT_TYPE_BINARY,         //
    AV_OPT_TYPE_DICT,           //
    AV_OPT_TYPE_UINT64,         //
    AV_OPT_TYPE_CONST,          //
    AV_OPT_TYPE_BOOL,           //
    AV_OPT_TYPE_CHANNEL_LAYOUT, //
    AV_OPT_TYPE_COLOR,          //
    AV_OPT_TYPE_DURATION,       //
    AV_OPT_TYPE_PIXEL_FMT,      //
    AV_OPT_TYPE_SAMPLE_FMT,     //
    AV_OPT_TYPE_IMAGE_SIZE,     //
    AV_OPT_TYPE_VIDEO_RATE      //
    );

  TAVOption = record
    name: PAnsiChar;
    help: PAnsiChar;
    offset: cint;
    type_: TAVOptionType;

    default_val: record
      case cint of
        0:
          (i64: cint64);
        1:
          (dbl: cdouble);
        2:
          (str: PAnsiChar);
        3:
          (q: TAVRational);
    end;

    min: cdouble;
    max: cdouble;
    flags: cint;
    unit_: PAnsiChar;
  end;

  TAVClassCategory = (                          //
    AV_CLASS_CATEGORY_NA = 0,                   //
    AV_CLASS_CATEGORY_INPUT,                    //
    AV_CLASS_CATEGORY_OUTPUT,                   //
    AV_CLASS_CATEGORY_MUXER,                    //
    AV_CLASS_CATEGORY_DEMUXER,                  //
    AV_CLASS_CATEGORY_ENCODER,                  //
    AV_CLASS_CATEGORY_DECODER,                  //
    AV_CLASS_CATEGORY_FILTER,                   //
    AV_CLASS_CATEGORY_BITSTREAM_FILTER,         //
    AV_CLASS_CATEGORY_SWSCALER,                 //
    AV_CLASS_CATEGORY_SWRESAMPLER,              //
    AV_CLASS_CATEGORY_DEVICE_VIDEO_OUTPUT = 40, //
    AV_CLASS_CATEGORY_DEVICE_VIDEO_INPUT,       //
    AV_CLASS_CATEGORY_DEVICE_AUDIO_OUTPUT,      //
    AV_CLASS_CATEGORY_DEVICE_AUDIO_INPUT,       //
    AV_CLASS_CATEGORY_DEVICE_OUTPUT,            //
    AV_CLASS_CATEGORY_DEVICE_INPUT,             //
    AV_CLASS_CATEGORY_NB                        //
    );

  TAVOptionRanges = record
    range: PPAVOptionRange;
    nb_ranges: cint;
    nb_components: cint;
  end;

  TAVOptionRange = record
    str: PAnsiChar;
    value_min, value_max: cdouble;
    component_min, component_max: cdouble;
    is_range: cint;
  end;

  va_list = Pointer;

  TAVClass = record
    class_name: PAnsiChar;
    item_name: function(ctx: Pointer): PAnsiChar; cdecl;
    option: PAVOption;
    version: cint;
    log_level_offset_offset: cint;
    parent_log_context_offset: cint;
    child_next: function(obj: Pointer; prev: Pointer): Pointer; cdecl;
    child_class_next: function(prev: PAVClass): PAVClass; cdecl;
    category: TAVClassCategory;
    get_category: function(ctx: Pointer): PAVClassCategory; cdecl;
    query_ranges: function(P: PPAVOptionRanges; obj: Pointer; key: PAnsiChar; flags: cint): cint; cdecl;
  end;

  TAVRounding = (               //
    AV_ROUND_ZERO = 0,          //
    AV_ROUND_INF = 1,           //
    AV_ROUND_DOWN = 2,          //
    AV_ROUND_UP = 3,            //
    AV_ROUND_NEAR_INF = 5,      //
    AV_ROUND_PASS_MINMAX = 8192 //
    );

  TFree     = procedure(opaque: Pointer; data: pbyte);
  TAlloc    = function(size: cint)                  : PAVBufferRef;
  TAlloc2   = function(opaque: Pointer; size: cint): PAVBufferRef;
  TPoolFree = procedure(opaque: Pointer);

  PPAVBufferPool   = ^PAVBufferPool;
  PAVBufferPool    = ^TAVBufferPool;
  AVMutex          = AnsiChar;
  PBufferPoolEntry = ^BufferPoolEntry;

  BufferPoolEntry = record
    data: puint8_t;
    opaque: Pointer;
    free: procedure(opaque: Pointer; data: puint8_t); cdecl;
    pool: PAVBufferRef;
  end;

  TAVBufferPool = record
    mutex: AVMutex;
    pool: PBufferPoolEntry;
    refcount: atomic_uint;
    size: int;
    opaque: Pointer;
    alloc: function(size: int): PAVBufferRef; cdecl;
    alloc2: function(opaque: Pointer; size: int): PAVBufferRef; cdecl;
    pool_free: function(opaque: Pointer): Pointer; cdecl;
  end;

  TAVFrameSideDataType = (                    //
    AV_FRAME_DATA_PANSCAN,                    //
    AV_FRAME_DATA_A53_CC,                     //
    AV_FRAME_DATA_STEREO3D,                   //
    AV_FRAME_DATA_MATRIXENCODING,             //
    AV_FRAME_DATA_DOWNMIX_INFO,               //
    AV_FRAME_DATA_REPLAYGAIN,                 //
    AV_FRAME_DATA_DISPLAYMATRIX,              //
    AV_FRAME_DATA_AFD,                        //
    AV_FRAME_DATA_MOTION_VECTORS,             //
    AV_FRAME_DATA_SKIP_SAMPLES,               //
    AV_FRAME_DATA_AUDIO_SERVICE_TYPE,         //
    AV_FRAME_DATA_MASTERING_DISPLAY_METADATA, //
    AV_FRAME_DATA_GOP_TIMECODE,               //
    AV_FRAME_DATA_SPHERICAL,                  //
    AV_FRAME_DATA_CONTENT_LIGHT_LEVEL,        //
    AV_FRAME_DATA_ICC_PROFILE                 //
{$IFDEF FF_API_FRAME_QP}                      //
    AV_FRAME_DATA_QP_TABLE_PROPERTIES,        //
    AV_FRAME_DATA_QP_TABLE_DATA               //
{$ENDIF}
    );

  TAVActiveFormatDescription = ( //
    AV_AFD_SAME = 8,             //
    AV_AFD_4_3 = 9,              //
    AV_AFD_16_9 = 10,            //
    AV_AFD_14_9 = 11,            //
    AV_AFD_4_3_SP_14_9 = 13,     //
    AV_AFD_16_9_SP_14_9 = 14,    //
    AV_AFD_SP_4_3 = 15           //
    );

  TAVFrameSideData = record
    type_: TAVFrameSideDataType;
    data: pbyte;
    size: cint;
    metadata: TAVDictionary;
    buf: PAVBufferRef;
  end; { TAVFrameSideData }

const
  AV_TIME_BASE_Q: TAVRational = (num: 1; den: AV_TIME_BASE);
  AV_PIX_FMT_Y400A            = AV_PIX_FMT_YA8;
  AV_PIX_FMT_GRAY8A           = AV_PIX_FMT_YA8;

{$IFDEF WORDS_BIGENDIAN}
  AV_PIX_FMT_RGB32   = AV_PIX_FMT_ARGB;
  AV_PIX_FMT_RGB32_1 = AV_PIX_FMT_RGBA;
  AV_PIX_FMT_BGR32   = AV_PIX_FMT_ABGR;
  AV_PIX_FMT_BGR32_1 = AV_PIX_FMT_BGRA;
  AV_PIX_FMT_0RGB32  = AV_PIX_FMT_0RGB;
  AV_PIX_FMT_0BGR32  = AV_PIX_FMT_0BGR;

  AV_PIX_FMT_GRAY9  = AV_PIX_FMT_GRAY9BE;
  AV_PIX_FMT_GRAY10 = AV_PIX_FMT_GRAY10BE;
  AV_PIX_FMT_GRAY12 = AV_PIX_FMT_GRAY12BE;
  AV_PIX_FMT_GRAY16 = AV_PIX_FMT_GRAY16BE;
  AV_PIX_FMT_YA16   = AV_PIX_FMT_YA16BE;
  AV_PIX_FMT_RGB48  = AV_PIX_FMT_RGB48BE;
  AV_PIX_FMT_RGB565 = AV_PIX_FMT_RGB565BE;
  AV_PIX_FMT_RGB555 = AV_PIX_FMT_RGB555BE;
  AV_PIX_FMT_RGB444 = AV_PIX_FMT_RGB444BE;
  AV_PIX_FMT_RGBA64 = AV_PIX_FMT_RGBA64BE;
  AV_PIX_FMT_BGR48  = AV_PIX_FMT_BGR48BE;
  AV_PIX_FMT_BGR565 = AV_PIX_FMT_BGR565BE;
  AV_PIX_FMT_BGR555 = AV_PIX_FMT_BGR555BE;
  AV_PIX_FMT_BGR444 = AV_PIX_FMT_BGR444BE;
  AV_PIX_FMT_BGRA64 = AV_PIX_FMT_BGRA64BE;

  AV_PIX_FMT_YUV420P9  = AV_PIX_FMT_YUV420P9BE;
  AV_PIX_FMT_YUV422P9  = AV_PIX_FMT_YUV422P9BE;
  AV_PIX_FMT_YUV444P9  = AV_PIX_FMT_YUV444P9BE;
  AV_PIX_FMT_YUV420P10 = AV_PIX_FMT_YUV420P10BE;
  AV_PIX_FMT_YUV422P10 = AV_PIX_FMT_YUV422P10BE;
  AV_PIX_FMT_YUV440P10 = AV_PIX_FMT_YUV440P10BE;
  AV_PIX_FMT_YUV444P10 = AV_PIX_FMT_YUV444P10BE;
  AV_PIX_FMT_YUV420P12 = AV_PIX_FMT_YUV420P12BE;
  AV_PIX_FMT_YUV422P12 = AV_PIX_FMT_YUV422P12BE;
  AV_PIX_FMT_YUV440P12 = AV_PIX_FMT_YUV440P12BE;
  AV_PIX_FMT_YUV444P12 = AV_PIX_FMT_YUV444P12BE;
  AV_PIX_FMT_YUV420P14 = AV_PIX_FMT_YUV420P14BE;
  AV_PIX_FMT_YUV422P14 = AV_PIX_FMT_YUV422P14BE;
  AV_PIX_FMT_YUV444P14 = AV_PIX_FMT_YUV444P14BE;
  AV_PIX_FMT_YUV420P16 = AV_PIX_FMT_YUV420P16BE;
  AV_PIX_FMT_YUV422P16 = AV_PIX_FMT_YUV422P16BE;
  AV_PIX_FMT_YUV444P16 = AV_PIX_FMT_YUV444P16BE;

  AV_PIX_FMT_GBRP9   = AV_PIX_FMT_GBRP9BE;
  AV_PIX_FMT_GBRP10  = AV_PIX_FMT_GBRP10BE;
  AV_PIX_FMT_GBRP12  = AV_PIX_FMT_GBRP12BE;
  AV_PIX_FMT_GBRP14  = AV_PIX_FMT_GBRP14BE;
  AV_PIX_FMT_GBRP16  = AV_PIX_FMT_GBRP16BE;
  AV_PIX_FMT_GBRAP10 = AV_PIX_FMT_GBRAP10BE;
  AV_PIX_FMT_GBRAP12 = AV_PIX_FMT_GBRAP12BE;
  AV_PIX_FMT_GBRAP16 = AV_PIX_FMT_GBRAP16BE;

  AV_PIX_FMT_BAYER_BGGR16 = AV_PIX_FMT_BAYER_BGGR16BE;
  AV_PIX_FMT_BAYER_RGGB16 = AV_PIX_FMT_BAYER_RGGB16BE;
  AV_PIX_FMT_BAYER_GBRG16 = AV_PIX_FMT_BAYER_GBRG16BE;
  AV_PIX_FMT_BAYER_GRBG16 = AV_PIX_FMT_BAYER_GRBG16BE;

  AV_PIX_FMT_GBRPF32  = AV_PIX_FMT_GBRPF32BE;
  AV_PIX_FMT_GBRAPF32 = AV_PIX_FMT_GBRAPF32BE;

  AV_PIX_FMT_YUVA420P9  = AV_PIX_FMT_YUVA420P9BE;
  AV_PIX_FMT_YUVA422P9  = AV_PIX_FMT_YUVA422P9BE;
  AV_PIX_FMT_YUVA444P9  = AV_PIX_FMT_YUVA444P9BE;
  AV_PIX_FMT_YUVA420P10 = AV_PIX_FMT_YUVA420P10BE;
  AV_PIX_FMT_YUVA422P10 = AV_PIX_FMT_YUVA422P10BE;
  AV_PIX_FMT_YUVA444P10 = AV_PIX_FMT_YUVA444P10BE;
  AV_PIX_FMT_YUVA420P16 = AV_PIX_FMT_YUVA420P16BE;
  AV_PIX_FMT_YUVA422P16 = AV_PIX_FMT_YUVA422P16BE;
  AV_PIX_FMT_YUVA444P16 = AV_PIX_FMT_YUVA444P16BE;

  AV_PIX_FMT_XYZ12  = AV_PIX_FMT_XYZ12BE;
  AV_PIX_FMT_NV20   = AV_PIX_FMT_NV20BE;
  AV_PIX_FMT_AYUV64 = AV_PIX_FMT_AYUV64BE;
  AV_PIX_FMT_P010   = AV_PIX_FMT_P010BE;
  AV_PIX_FMT_P016   = AV_PIX_FMT_P016BE;

{$ELSE}
  AV_PIX_FMT_RGB32   = AV_PIX_FMT_BGRA;
  AV_PIX_FMT_RGB32_1 = AV_PIX_FMT_ABGR;
  AV_PIX_FMT_BGR32   = AV_PIX_FMT_RGBA;
  AV_PIX_FMT_BGR32_1 = AV_PIX_FMT_ARGB;
  AV_PIX_FMT_0RGB32  = AV_PIX_FMT_BGR0;
  AV_PIX_FMT_0BGR32  = AV_PIX_FMT_RGB0;

  AV_PIX_FMT_GRAY9  = AV_PIX_FMT_GRAY9LE;
  AV_PIX_FMT_GRAY10 = AV_PIX_FMT_GRAY10LE;
  AV_PIX_FMT_GRAY12 = AV_PIX_FMT_GRAY12LE;
  AV_PIX_FMT_GRAY16 = AV_PIX_FMT_GRAY16LE;
  AV_PIX_FMT_YA16   = AV_PIX_FMT_YA16LE;
  AV_PIX_FMT_RGB48  = AV_PIX_FMT_RGB48LE;
  AV_PIX_FMT_RGB565 = AV_PIX_FMT_RGB565LE;
  AV_PIX_FMT_RGB555 = AV_PIX_FMT_RGB555LE;
  AV_PIX_FMT_RGB444 = AV_PIX_FMT_RGB444LE;
  AV_PIX_FMT_RGBA64 = AV_PIX_FMT_RGBA64LE;
  AV_PIX_FMT_BGR48  = AV_PIX_FMT_BGR48LE;
  AV_PIX_FMT_BGR565 = AV_PIX_FMT_BGR565LE;
  AV_PIX_FMT_BGR555 = AV_PIX_FMT_BGR555LE;
  AV_PIX_FMT_BGR444 = AV_PIX_FMT_BGR444LE;
  AV_PIX_FMT_BGRA64 = AV_PIX_FMT_BGRA64LE;

  AV_PIX_FMT_YUV420P9  = AV_PIX_FMT_YUV420P9LE;
  AV_PIX_FMT_YUV422P9  = AV_PIX_FMT_YUV422P9LE;
  AV_PIX_FMT_YUV444P9  = AV_PIX_FMT_YUV444P9LE;
  AV_PIX_FMT_YUV420P10 = AV_PIX_FMT_YUV420P10LE;
  AV_PIX_FMT_YUV422P10 = AV_PIX_FMT_YUV422P10LE;
  AV_PIX_FMT_YUV440P10 = AV_PIX_FMT_YUV440P10LE;
  AV_PIX_FMT_YUV444P10 = AV_PIX_FMT_YUV444P10LE;
  AV_PIX_FMT_YUV420P12 = AV_PIX_FMT_YUV420P12LE;
  AV_PIX_FMT_YUV422P12 = AV_PIX_FMT_YUV422P12LE;
  AV_PIX_FMT_YUV440P12 = AV_PIX_FMT_YUV440P12LE;
  AV_PIX_FMT_YUV444P12 = AV_PIX_FMT_YUV444P12LE;
  AV_PIX_FMT_YUV420P14 = AV_PIX_FMT_YUV420P14LE;
  AV_PIX_FMT_YUV422P14 = AV_PIX_FMT_YUV422P14LE;
  AV_PIX_FMT_YUV444P14 = AV_PIX_FMT_YUV444P14LE;
  AV_PIX_FMT_YUV420P16 = AV_PIX_FMT_YUV420P16LE;
  AV_PIX_FMT_YUV422P16 = AV_PIX_FMT_YUV422P16LE;
  AV_PIX_FMT_YUV444P16 = AV_PIX_FMT_YUV444P16LE;

  AV_PIX_FMT_GBRP9   = AV_PIX_FMT_GBRP9LE;
  AV_PIX_FMT_GBRP10  = AV_PIX_FMT_GBRP10LE;
  AV_PIX_FMT_GBRP12  = AV_PIX_FMT_GBRP12LE;
  AV_PIX_FMT_GBRP14  = AV_PIX_FMT_GBRP14LE;
  AV_PIX_FMT_GBRP16  = AV_PIX_FMT_GBRP16LE;
  AV_PIX_FMT_GBRAP10 = AV_PIX_FMT_GBRAP10LE;
  AV_PIX_FMT_GBRAP12 = AV_PIX_FMT_GBRAP12LE;
  AV_PIX_FMT_GBRAP16 = AV_PIX_FMT_GBRAP16LE;

  AV_PIX_FMT_BAYER_BGGR16 = AV_PIX_FMT_BAYER_BGGR16LE;
  AV_PIX_FMT_BAYER_RGGB16 = AV_PIX_FMT_BAYER_RGGB16LE;
  AV_PIX_FMT_BAYER_GBRG16 = AV_PIX_FMT_BAYER_GBRG16LE;
  AV_PIX_FMT_BAYER_GRBG16 = AV_PIX_FMT_BAYER_GRBG16LE;

  AV_PIX_FMT_GBRPF32  = AV_PIX_FMT_GBRPF32LE;
  AV_PIX_FMT_GBRAPF32 = AV_PIX_FMT_GBRAPF32LE;

  AV_PIX_FMT_YUVA420P9  = AV_PIX_FMT_YUVA420P9LE;
  AV_PIX_FMT_YUVA422P9  = AV_PIX_FMT_YUVA422P9LE;
  AV_PIX_FMT_YUVA444P9  = AV_PIX_FMT_YUVA444P9LE;
  AV_PIX_FMT_YUVA420P10 = AV_PIX_FMT_YUVA420P10LE;
  AV_PIX_FMT_YUVA422P10 = AV_PIX_FMT_YUVA422P10LE;
  AV_PIX_FMT_YUVA444P10 = AV_PIX_FMT_YUVA444P10LE;
  AV_PIX_FMT_YUVA420P16 = AV_PIX_FMT_YUVA420P16LE;
  AV_PIX_FMT_YUVA422P16 = AV_PIX_FMT_YUVA422P16LE;
  AV_PIX_FMT_YUVA444P16 = AV_PIX_FMT_YUVA444P16LE;

  AV_PIX_FMT_XYZ12  = AV_PIX_FMT_XYZ12LE;
  AV_PIX_FMT_NV20   = AV_PIX_FMT_NV20LE;
  AV_PIX_FMT_AYUV64 = AV_PIX_FMT_AYUV64LE;
  AV_PIX_FMT_P010   = AV_PIX_FMT_P010LE;
  AV_PIX_FMT_P016   = AV_PIX_FMT_P016LE;
{$ENDIF}

const
  AV_INTEGER_SIZE = 8;
  AES_BLOCK_SIZE  = 16;
  AV_BF_ROUNDS    = 16;

type
  PAVAES                     = ^AVAES;
  PAVAESCTR                  = ^AVAESCTR;
  PAVAudioFifo               = ^AVAudioFifo;
  PPAVFifoBuffer             = ^PAVFifoBuffer;
  PAVFifoBuffer              = ^AVFifoBuffer;
  PAVBlowfish                = ^AVBlowfish;
  PAVLFG                     = ^AVLFG;
  Ptm                        = ^tm;
  PAVCAMELLIA                = ^AVCAMELLIA;
  PAVCAST5                   = ^AVCAST5;
  PAVContentLightMetadata    = ^AVContentLightMetadata;
  PAVCRC                     = ^AVCRC;
  PAVDES                     = ^AVDES;
  PAVDownmixInfo             = ^AVDownmixInfo;
  PAVEncryptionInfo          = ^AVEncryptionInfo;
  PAVSubsampleEncryptionInfo = ^AVSubsampleEncryptionInfo;
  PAVEncryptionInitInfo      = ^AVEncryptionInitInfo;
  PAVExpr                    = ^AVExpr;
  PPAVExpr                   = ^PAVExpr;

  AVInteger = record
    v: array [0 .. AV_INTEGER_SIZE - 1] of uint16_t;
  end;

  av_aes_block = record
    u64: array [0 .. 1] of UInt64;
    u32: array [0 .. 3] of UInt32;
    u8x4: array [0 .. 3, 0 .. 3] of uint8_t;
    u8: array [0 .. 15] of UInt8;
  end;

  AVAES = record
    round_key: array [0 .. 14] of av_aes_block;
    state: array [0 .. 1] of av_aes_block;
  end;

  AVAESCTR = record
    aes: PAVAES;
    counter: array [0 .. AES_BLOCK_SIZE - 1] of uint8_t;
    encrypted_counter: array [0 .. AES_BLOCK_SIZE - 1] of uint8_t;
    block_offset: int;
  end;

  AVFifoBuffer = record
    buffer: puint8_t;
    rptr, wptr, _end: puint8_t;
    rndx, wndx: uint32_t;
  end;

  AVAudioFifo = record
    buf: PPAVFifoBuffer;
    nb_buffers: int;
    nb_samples: int;
    allocated_samples: int;
    channels: int;
    sample_fmt: TAVSampleFormat;
    sample_size: int;
  end;

  AVBlowfish = record
    P: array [0 .. AV_BF_ROUNDS + 1] of uint32_t;
    s: array [0 .. 3, 0 .. 255] of uint32_t;
  end;

  AVLFG = record
    state: array [0 .. 63] of unsigned_int;
    index: int;
  end;

  AVEscapeMode = (            //
    AV_ESCAPE_MODE_AUTO,      //
    AV_ESCAPE_MODE_BACKSLASH, //
    AV_ESCAPE_MODE_QUOTE      //
    );

  tm = record

  end;

  AVCAMELLIA = record
    Kw: array [0 .. 3] of uint64_t;
    Ke: array [0 .. 5] of uint64_t;
    K: array [0 .. 23] of uint64_t;
    key_bits: int;
  end;

  AVCAST5 = record
    Km: array [0 .. 16] of UInt32;
    Kr: array [0 .. 16] of UInt32;
    rounds: int;
  end;

  AVContentLightMetadata = record
    MaxCLL: unsigned;
    MaxFALL: unsigned;
  end;

  AVCRC = uint32_t;

  AVCRCId = (          //
    AV_CRC_8_ATM,      //
    AV_CRC_16_ANSI,    //
    AV_CRC_16_CCITT,   //
    AV_CRC_32_IEEE,    //
    AV_CRC_32_IEEE_LE, //
    AV_CRC_16_ANSI_LE, //
    AV_CRC_24_IEEE,    //
    AV_CRC_8_EBU,      //
    AV_CRC_MAX);

  AVDES = record
    round_keys: array [0 .. 2, 0 .. 15] of uint64_t;
    triple_des: int;
  end;

  nineArrInt32 = array [0 .. 8] of Int32;

  AVDownmixType = (          //
    AV_DOWNMIX_TYPE_UNKNOWN, //
    AV_DOWNMIX_TYPE_LORO,    //
    AV_DOWNMIX_TYPE_LTRT,    //
    AV_DOWNMIX_TYPE_DPLII,   //
    AV_DOWNMIX_TYPE_NB       //
    );

  AVDownmixInfo = record
    preferred_downmix_type: AVDownmixType;
    center_mix_level: Double;
    center_mix_level_ltrt: Double;
    surround_mix_level: Double;
    surround_mix_level_ltrt: Double;
    lfe_mix_level: Double;
  end;

  AVSubsampleEncryptionInfo = record
    bytes_of_clear_data: unsigned_int;
    bytes_of_protected_datav: unsigned_int;
  end;

  AVEncryptionInfo = record
    scheme, crypt_byte_block, skip_byte_block: uint32_t;
    key_id: puint8_t;
    key_id_size: uint32_t;
    iv: puint8_t;
    iv_size: uint32_t;
    subsamples: PAVSubsampleEncryptionInfo;
    subsample_count: uint32_t;
  end;

  AVEncryptionInitInfo = record
    system_id: puint8_t;
    system_id_size: uint32_t;
    key_ids: ppuint8_t;
    num_key_ids: uint32_t;
    key_id_size: uint32_t;
    data: puint8_t;
    data_size: uint32_t;
    next: PAVEncryptionInitInfo;
  end;

  enumtype = (                                                                    //
    e_value, e_const, e_func0, e_func1, e_func2,                                  //
    e_squish, e_gauss, e_ld, e_isnan, e_isinf,                                    //
    e_mod, e_max, e_min, e_eq, e_gt, e_gte, e_lte, e_lt,                          //
    e_pow, e_mul, e_div, e_add,                                                   //
    e_last, e_st, e_while, e_taylor, e_root, e_floor, e_ceil, e_trunc, e_round,   //
    e_sqrt, e_not, e_random, e_hypot, e_gcd,                                      //
    e_if, e_ifnot, e_print, e_bitand, e_bitor, e_between, e_clip, e_atan2, e_lerp //
    );

  Tuniona = record
    case Integer of
      0:
        (const_index: int
        );
      1:
        (func0:
                  function(): PDouble;
        cdecl);
  end;

  AVExpr = record
    _type: enumtype;
    value: Double;
    a: Tuniona;
    param: array [0 .. 2] of PAVExpr;
    _var: PDouble;
  end;

  Tfuncs1 = function(P: Pointer; d: Double)     : PDouble;
  Tfuncs2 = function(P: Pointer; d1, d2: Double): PDouble;

function av_add_i(a, b: AVInteger): AVInteger; cdecl; external c_strFFmpegDllX64Name;
function av_add_q(b, c: TAVRational): TAVRational; cdecl; external c_strFFmpegDllX64Name;
function av_add_stable(ts_tb: TAVRational; ts: cint64; inc_tb: TAVRational; inc: cint64): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_adler32_update(adler: unsigned; const buf: puint8_t; len: unsigned_int): unsigned; cdecl; external c_strFFmpegDllX64Name;
function av_aes_alloc(): PAVAES; cdecl; external c_strFFmpegDllX64Name;
procedure av_aes_crypt(a: PAVAES; dst: puint8_t; const src: puint8_t; count: int; iv: puint8_t; decrypt: int); cdecl; external c_strFFmpegDllX64Name;
function av_aes_ctr_alloc(): PAVAESCTR; cdecl; external c_strFFmpegDllX64Name;
procedure av_aes_ctr_crypt(a: PAVAESCTR; dst: puint8_t; const src: puint8_t; count: int); cdecl; external c_strFFmpegDllX64Name;
procedure av_aes_ctr_free(a: PAVAESCTR); cdecl; external c_strFFmpegDllX64Name;
function av_aes_ctr_get_iv(a: PAVAESCTR): puint8_t; cdecl; external c_strFFmpegDllX64Name;
procedure av_aes_ctr_increment_iv(a: PAVAESCTR); cdecl; external c_strFFmpegDllX64Name;
function av_aes_ctr_init(a: PAVAESCTR; const key: puint8_t): int; cdecl; external c_strFFmpegDllX64Name;
procedure av_aes_ctr_set_full_iv(a: PAVAESCTR; const iv: puint8_t); cdecl; external c_strFFmpegDllX64Name;
procedure av_aes_ctr_set_iv(a: PAVAESCTR; const iv: puint8_t); cdecl; external c_strFFmpegDllX64Name;
procedure av_aes_ctr_set_random_iv(a: PAVAESCTR); cdecl; external c_strFFmpegDllX64Name;
function av_aes_init(a: PAVAES; const key: puint8_t; key_bits: int; decrypt: int): int; cdecl; external c_strFFmpegDllX64Name;
function av_aes_size: int; cdecl; external c_strFFmpegDllX64Name;
function av_append_path_component(const path: PAnsiChar; const component: PAnsiChar): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_asprintf(const fmt: array of const): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
procedure av_assert0_fpu; cdecl; external c_strFFmpegDllX64Name;
function av_audio_fifo_alloc(sample_fmt: TAVSampleFormat; channels: int; nb_samples: int): PAVAudioFifo; cdecl; external c_strFFmpegDllX64Name;
function av_audio_fifo_drain(af: PAVAudioFifo; nb_samples: int): int; cdecl; external c_strFFmpegDllX64Name;
procedure av_audio_fifo_free(af: PAVAudioFifo); cdecl; external c_strFFmpegDllX64Name;
function av_audio_fifo_peek(af: PAVAudioFifo; data: PPointer; nb_samples: int): int; cdecl; external c_strFFmpegDllX64Name;
function av_audio_fifo_peek_at(af: PAVAudioFifo; data: PPointer; nb_samples, offset: int): int; cdecl; external c_strFFmpegDllX64Name;
function av_audio_fifo_read(af: PAVAudioFifo; data: PPointer; nb_samples: int): int; cdecl; external c_strFFmpegDllX64Name;
function av_audio_fifo_realloc(af: PAVAudioFifo; nb_samples: int): int; cdecl; external c_strFFmpegDllX64Name;
procedure av_audio_fifo_reset(af: PAVAudioFifo); cdecl; external c_strFFmpegDllX64Name;
function av_audio_fifo_size(af: PAVAudioFifo): int; cdecl; external c_strFFmpegDllX64Name;
function av_audio_fifo_space(af: PAVAudioFifo): int; cdecl; external c_strFFmpegDllX64Name;
function av_audio_fifo_write(af: PAVAudioFifo; data: PPointer; nb_samples: int): int; cdecl; external c_strFFmpegDllX64Name;
function av_base64_decode(_out: puint8_t; const in_str: PAnsiChar; out_size: int): int; cdecl; external c_strFFmpegDllX64Name;
function av_base64_encode(_out: PAnsiChar; out_size: int; const _in: puint8_t; in_size: int): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_basename(const path: PAnsiChar): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_blowfish_alloc(): PAVBlowfish; cdecl; external c_strFFmpegDllX64Name;
procedure av_blowfish_crypt(ctx: PAVBlowfish; dst: puint8_t; const src: puint8_t; count: int; iv: puint8_t; decrypt: int); cdecl; external c_strFFmpegDllX64Name;
procedure av_blowfish_crypt_ecb(ctx: PAVBlowfish; xl: pcuint32; xr: pcuint32; decrypt: int); cdecl; external c_strFFmpegDllX64Name;
procedure av_blowfish_init(ctx: PAVBlowfish; const key: puint8_t; key_len: int); cdecl; external c_strFFmpegDllX64Name;
procedure av_bmg_get(lfg: PAVLFG); cdecl; external c_strFFmpegDllX64Name;
procedure av_bprint_append_data(buf: PAVBPrint; const data: PAnsiChar; size: unsigned); cdecl; external c_strFFmpegDllX64Name;
procedure av_bprint_channel_layout(bp: PAVBPrint; nb_channels: int; channel_layout: uint64_t); cdecl; external c_strFFmpegDllX64Name;
procedure av_bprint_chars(buf: PAVBPrint; c: AnsiChar; n: unsigned); cdecl; external c_strFFmpegDllX64Name;
procedure av_bprint_clear(buf: PAVBPrint); cdecl; external c_strFFmpegDllX64Name;
procedure av_bprint_escape(dstbuf: PAVBPrint; const src: PAnsiChar; const special_chars: PAnsiChar; mode: AVEscapeMode; flas: int); cdecl; external c_strFFmpegDllX64Name;
function av_bprint_finalize(buf: PAVBPrint; ret_str: PPAnsiChar): int; cdecl; external c_strFFmpegDllX64Name;
procedure av_bprint_get_buffer(buf: PAVBPrint; size: unsigned; mem: PPAnsiChar; actual_size: PCardinal); cdecl; external c_strFFmpegDllX64Name;
procedure av_bprint_init(buf: PAVBPrint; size_init: unsigned; size_max: unsigned); cdecl; external c_strFFmpegDllX64Name;
procedure av_bprint_init_for_buffer(buf: PAVBPrint; buffer: PAnsiChar; size: unsigned); cdecl; external c_strFFmpegDllX64Name;
procedure av_bprint_strftime(buf: PAVBPrint; const fmt: PAnsiChar; const tm: Ptm); cdecl; external c_strFFmpegDllX64Name;
procedure av_bprintf(buf: PAVBPrint; const fmt: array of const); cdecl; external c_strFFmpegDllX64Name;
function av_buffer_alloc(size: int): PAVBufferRef; cdecl; external c_strFFmpegDllX64Name;
function av_buffer_allocz(size: int): PAVBufferRef; cdecl; external c_strFFmpegDllX64Name;
function av_buffer_create(data: pbyte; size: cint; free: TFree; opaque: Pointer; flags: cint): PAVBufferRef; cdecl; external c_strFFmpegDllX64Name;
procedure av_buffer_default_free(opaque: Pointer; data: pbyte); cdecl; external c_strFFmpegDllX64Name;
procedure av_buffer_get_opaque(buf: PAVBufferRef); cdecl; external c_strFFmpegDllX64Name;
function av_buffer_get_ref_count(buf: PAVBufferRef): cint; cdecl; external c_strFFmpegDllX64Name;
function av_buffer_is_writable(buf: PAVBufferRef): cint; cdecl; external c_strFFmpegDllX64Name;
function av_buffer_make_writable(buf: PPAVBufferRef): cint; cdecl; external c_strFFmpegDllX64Name;
function av_buffer_pool_get(pool: PAVBufferPool): PAVBufferRef; cdecl; external c_strFFmpegDllX64Name;
function av_buffer_pool_init(size: cint; alloc: TAlloc): PAVBufferPool; cdecl; external c_strFFmpegDllX64Name;
function av_buffer_pool_init2(size: cint; opaque: Pointer; alloc: TAlloc2; pool_free: TPoolFree): PAVBufferPool; cdecl; external c_strFFmpegDllX64Name;
procedure av_buffer_pool_uninit(pool: PPAVBufferPool); cdecl; external c_strFFmpegDllX64Name;
function av_buffer_realloc(buf: PPAVBufferRef; size: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_buffer_ref(buf: PAVBufferRef): PAVBufferRef; cdecl; external c_strFFmpegDllX64Name;
procedure av_buffer_unref(buf: PPAVBufferRef); cdecl; external c_strFFmpegDllX64Name;
function av_calloc(nmemb: size_t; size: size_t): Pointer; cdecl; external c_strFFmpegDllX64Name;
function av_camellia_alloc(): PAVCAMELLIA; cdecl; external c_strFFmpegDllX64Name;
procedure av_camellia_crypt(ctx: PAVCAMELLIA; dst: puint8_t; const src: puint8_t; count: int; iv: puint8_t; decrypt: int); cdecl; external c_strFFmpegDllX64Name;
function av_camellia_init(ctx: PAVCAMELLIA; const key: puint8_t; key_bits: int): int; cdecl; external c_strFFmpegDllX64Name;
function av_camellia_size: int; cdecl; external c_strFFmpegDllX64Name;
function av_cast5_alloc(): PAVCAST5; cdecl; external c_strFFmpegDllX64Name;
procedure av_cast5_crypt(ctx: PAVCAST5; dst: puint8_t; const src: puint8_t; count: int; decrypt: int); cdecl; external c_strFFmpegDllX64Name;
procedure av_cast5_crypt2(ctx: PAVCAST5; dst: puint8_t; const src: puint8_t; count: int; iv: puint8_t; decrypt: int); cdecl; external c_strFFmpegDllX64Name;
function av_cast5_init(ctx: PAVCAST5; const key: puint8_t; key_bits: int): int; cdecl; external c_strFFmpegDllX64Name;
function av_cast5_size: int; cdecl; external c_strFFmpegDllX64Name;
function av_channel_layout_extract_channel(channel_layout: cuint64; index: cint): cuint64; cdecl; external c_strFFmpegDllX64Name;
function av_chroma_location_from_name(const name: PAnsiChar): int; cdecl; external c_strFFmpegDllX64Name;
function av_chroma_location_name(location: TAVChromaLocation): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_cmp_i(a, b: AVInteger): int; cdecl; external c_strFFmpegDllX64Name;
function av_color_primaries_from_name(const name: PAnsiChar): int; cdecl; external c_strFFmpegDllX64Name;
function av_color_primaries_name(primaries: TAVColorPrimaries): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_color_range_from_name(const name: PAnsiChar): int; cdecl; external c_strFFmpegDllX64Name;
function av_color_range_name(range: TAVColorRange): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_color_space_from_name(const name: PAnsiChar): int; cdecl; external c_strFFmpegDllX64Name;
function av_color_space_name(space: TAVColorSpace): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_color_transfer_from_name(const name: PAnsiChar): int; cdecl; external c_strFFmpegDllX64Name;
function av_color_transfer_name(transfer: TAVColorTransferCharacteristic): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_compare_mod(a, b, modVar: cuint64): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_compare_ts(ts_a: cint64; tb_a: TAVRational; ts_b: cint64; tb_b: TAVRational): cint; cdecl; external c_strFFmpegDllX64Name;
function av_content_light_metadata_alloc(size: Psize_t): PAVContentLightMetadata; cdecl; external c_strFFmpegDllX64Name;
function av_content_light_metadata_create_side_data(): PAVContentLightMetadata; cdecl; external c_strFFmpegDllX64Name;
function av_cpu_count(): cint; cdecl; external c_strFFmpegDllX64Name;
function av_cpu_max_align(): size_t; cdecl; external c_strFFmpegDllX64Name;
function av_crc(ctx: PAVCRC; crc: UInt32; const buffer: puint8_t; lenth: size_t): UInt32; cdecl; external c_strFFmpegDllX64Name;
function av_crc_get_table(crc_id: AVCRCId): PAVCRC; cdecl; external c_strFFmpegDllX64Name;
function av_crc_init(ctx: PAVCRC; le: int; bits: int; poly: uint32_t; ctx_size: int): int; cdecl; external c_strFFmpegDllX64Name;
function av_d2q(d: Double; max: int): TAVRational; cdecl; external c_strFFmpegDllX64Name;
function av_d2str(d: Double): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_default_get_category(ptr: Pointer): TAVClassCategory; cdecl; external c_strFFmpegDllX64Name;
function av_default_item_name(ctx: Pointer): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_des_alloc(): PAVDES; cdecl; external c_strFFmpegDllX64Name;
procedure av_des_crypt(d: PAVDES; dst: puint8_t; const src: puint8_t; count: int; iv: puint8_t; decrypt: int); cdecl; external c_strFFmpegDllX64Name;
function av_des_init(d: PAVDES; const key: puint8_t; key_bits: int; decrypt: int): int; cdecl; external c_strFFmpegDllX64Name;
procedure av_des_mac(d: PAVDES; dst: puint8_t; const src: puint8_t; count: int); cdecl; external c_strFFmpegDllX64Name;
function av_dict_copy(var dst: PAVDictionary; src: PAVDictionary; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_dict_count(m: PAVDictionary): cint; cdecl; external c_strFFmpegDllX64Name;
procedure av_dict_free(var m: PAVDictionary); cdecl; external c_strFFmpegDllX64Name;
function av_dict_get(m: PAVDictionary; key: PAnsiChar; prev: PAVDictionaryEntry; flags: cint): PAVDictionaryEntry; cdecl; external c_strFFmpegDllX64Name;
function av_dict_get_string(m: PAVDictionary; buffer: PPAnsiChar; key_val_sep: AnsiChar; pairs_sep: AnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function av_dict_parse_string(var pm: PAVDictionary; str: PAnsiChar; key_val_sep: PAnsiChar; pairs_sep: PAnsiChar; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_dict_set(var pm: PAVDictionary; key: PAnsiChar; value: PAnsiChar; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_dict_set_int(var pm: PAVDictionary; key: PAnsiChar; value: cint64; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_dirname(path: PAnsiChar): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
procedure av_display_matrix_flip(matrix: nineArrInt32; hflip: int; vflip: int); cdecl; external c_strFFmpegDllX64Name;
function av_display_rotation_get(const matrix: nineArrInt32): Double; cdecl; external c_strFFmpegDllX64Name;
procedure av_display_rotation_set(matrix: Int32; angle: Double); cdecl; external c_strFFmpegDllX64Name;
function av_div_i(a, b: AVInteger): AVInteger; cdecl; external c_strFFmpegDllX64Name;
function av_div_q(b, c: TAVRational): TAVRational; cdecl; external c_strFFmpegDllX64Name;
function av_downmix_info_update_side_data(frame: PAVFrame): PAVDownmixInfo; cdecl; external c_strFFmpegDllX64Name;
function av_dynarray2_add(tab_ptr: PPointer; nb_ptr: PInteger; elem_size: size_t; const elem_data: puint8_t): Pointer; cdecl; external c_strFFmpegDllX64Name;
procedure av_dynarray_add(tab_ptr: Pointer; nb_ptr: Pcint; elem: Pointer); cdecl; external c_strFFmpegDllX64Name;
function av_dynarray_add_nofree(tab_ptr: Pointer; nb_ptr: Pcint; elem: Pointer): cint; cdecl; external c_strFFmpegDllX64Name;
function av_encryption_info_add_side_data(const info: PAVEncryptionInfo; size: size_t): puint8_t; cdecl; external c_strFFmpegDllX64Name;
function av_encryption_info_alloc(subsample_count: uint32_t; key_id_size: uint32_t; iv_size: uint32_t): PAVEncryptionInfo; cdecl; external c_strFFmpegDllX64Name;
function av_encryption_info_clone(const info: PAVEncryptionInfo): PAVEncryptionInfo; cdecl; external c_strFFmpegDllX64Name;
procedure av_encryption_info_free(info: PAVEncryptionInfo); cdecl; external c_strFFmpegDllX64Name;
function av_encryption_info_get_side_data(const side_data: puint8_t; side_data_size: size_t): PAVEncryptionInfo; cdecl; external c_strFFmpegDllX64Name;
function av_encryption_init_info_add_side_data(const info: PAVEncryptionInitInfo; side_data_size: size_t): puint8_t; cdecl; external c_strFFmpegDllX64Name;
function av_encryption_init_info_alloc(system_id_size, num_key_ids, key_id_size, data_size: uint32_t): PAVEncryptionInitInfo; cdecl; external c_strFFmpegDllX64Name;
procedure av_encryption_init_info_free(info: PAVEncryptionInitInfo); cdecl; external c_strFFmpegDllX64Name;
function av_encryption_init_info_get_side_data(const side_data: puint8_t; side_data_size: size_t): PAVEncryptionInitInfo; cdecl; external c_strFFmpegDllX64Name;
function av_escape(dst: PPAnsiChar; const src: PAnsiChar; const special_chars: PAnsiChar; mode: AVEscapeMode; flags: int): int; cdecl; external c_strFFmpegDllX64Name;
function av_expr_eval(e: PAVExpr; const const_values: PDouble; opaque: Pointer): Double; cdecl; external c_strFFmpegDllX64Name;
procedure av_expr_free(e: PAVExpr); cdecl; external c_strFFmpegDllX64Name;
function av_expr_parse(expr: PPAVExpr; const s: PAnsiChar; const const_names: PAnsiChar; const func1_name: PAnsiChar; funcs1: Tfuncs1): int; cdecl; external c_strFFmpegDllX64Name;
function av_expr_parse_and_eval(expr: PPAVExpr; const s: PAnsiChar; const const_names: PAnsiChar; const const_values: PDouble; const func1_name: PAnsiChar; funcs1: Tfuncs1; const func2_name: PAnsiChar; funcs2: Tfuncs2; opaque: Pointer; log_offset: int; log_ctx: Pointer): int; cdecl; external c_strFFmpegDllX64Name;
procedure av_fast_malloc(ptr: Pointer; size: PCuint; min_size: size_t); cdecl; external c_strFFmpegDllX64Name;
procedure av_fast_mallocz(ptr: Pointer; size: PCuint; min_size: size_t); cdecl; external c_strFFmpegDllX64Name;
function av_fast_realloc(ptr: Pointer; size: PCuint; min_size: size_t): Pointer; cdecl; external c_strFFmpegDllX64Name;
function av_fifo_alloc(nmemb: size_t; size: size_t): PAVFifoBuffer; cdecl; external c_strFFmpegDllX64Name;

function av_fourcc_make_string(buf: PAnsiChar; fourcc: cuint64): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_fourcc2str(fourcc: cuint64): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_frame_alloc(): PAVFrame; cdecl; external c_strFFmpegDllX64Name;
function av_frame_apply_cropping(frame: PAVFrame; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_frame_clone(src: PAVFrame): PAVFrame; cdecl; external c_strFFmpegDllX64Name;
function av_frame_copy(dst: PAVFrame; src: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function av_frame_copy_props(dst: PAVFrame; src: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_best_effort_timestamp(frame: PAVFrame): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_buffer(frame: PAVFrame; align: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_channel_layout(frame: PAVFrame): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_channels(frame: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_colorspace(frame: PAVFrame): TAVColorSpace; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_decode_error_flags(frame: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_metadata(frame: PAVFrame): PAVDictionary; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_pkt_duration(frame: PAVFrame): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_pkt_pos(frame: PAVFrame): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_pkt_size(frame: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_plane_buffer(frame: PAVFrame; plane: cint): PAVBufferRef; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_qp_table(f: PAVFrame; stride: Pcint; type_: Pcint): pbyte; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_sample_rate(frame: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function av_frame_get_side_data(frame: PAVFrame; type_: TAVFrameSideDataType): PAVFrameSideData; cdecl; external c_strFFmpegDllX64Name;
function av_frame_is_writable(frame: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function av_frame_make_writable(frame: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function av_frame_new_side_data(frame: PAVFrame; type_: TAVFrameSideDataType; size: cint): PAVFrameSideData; cdecl; external c_strFFmpegDllX64Name;
function av_frame_new_side_data_from_buf(frame: PAVFrame; type_: TAVFrameSideDataType; buf: PAVBufferRef): PAVFrameSideData; cdecl; external c_strFFmpegDllX64Name;
function av_frame_ref(dst: PAVFrame; src: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function av_frame_set_qp_table(f: PAVFrame; buf: PAVBufferRef; stride: cint; type_: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_frame_side_data_name(type_: TAVFrameSideDataType): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_gcd(a, b: cint64): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_get_alt_sample_fmt(sample_fmt: TAVSampleFormat; planar: cint): TAVSampleFormat; cdecl; external c_strFFmpegDllX64Name;
function av_get_bytes_per_sample(sample_fmt: TAVSampleFormat): cint; cdecl; external c_strFFmpegDllX64Name;
function av_get_colorspace_name(val: TAVColorSpace): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_get_channel_description(channel: cuint64): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_get_channel_layout(name: PAnsiChar): cuint64; cdecl; external c_strFFmpegDllX64Name;
function av_get_channel_layout_channel_index(channel_layout: cuint64; channel: cuint64): cint; cdecl; external c_strFFmpegDllX64Name;
function av_get_channel_layout_nb_channels(channel_layout: cuint64): cint; cdecl; external c_strFFmpegDllX64Name;
function av_get_channel_name(channel: cuint64): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
procedure av_get_channel_layout_string(buf: PAnsiChar; buf_size: cint; nb_channels: cint; channel_layout: cuint64); cdecl; external c_strFFmpegDllX64Name;
function av_get_default_channel_layout(nb_channels: cint): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_get_standard_channel_layout(index: cuint; layout: PCuint64; name: PPAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function av_get_cpu_flags(): cint; cdecl; external c_strFFmpegDllX64Name;
function av_get_media_type_string(media_type: TAVMediaType): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_get_packed_sample_fmt(sample_fmt: TAVSampleFormat): TAVSampleFormat; cdecl; external c_strFFmpegDllX64Name;
function av_get_picture_type_char(pict_type: TAVPictureType): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_get_planar_sample_fmt(sample_fmt: TAVSampleFormat): TAVSampleFormat; cdecl; external c_strFFmpegDllX64Name;
function av_get_sample_fmt(name: PAnsiChar): TAVSampleFormat; cdecl; external c_strFFmpegDllX64Name;
function av_get_sample_fmt_name(sample_fmt: TAVSampleFormat): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_get_sample_fmt_string(buf: PAnsiChar; buf_size: cint; sample_fmt: TAVSampleFormat): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_get_time_base_q: TAVRational; cdecl; external c_strFFmpegDllX64Name;
function av_gettime: Int64; cdecl; external c_strFFmpegDllX64Name;
function av_gettime_relative: Int64; cdecl; external c_strFFmpegDllX64Name;
function av_gettime_relative_is_monotonic: Integer; cdecl; external c_strFFmpegDllX64Name;
function av_int_list_length_for_size(elsize: cuint; list: Pointer; term: cuint64): cuint; cdecl; external c_strFFmpegDllX64Name;
function av_log_format_line2(ptr: Pointer; level: cint; fmt: PAnsiChar; vl: va_list; line: PAnsiChar; line_size: cint; print_prefix: Pcint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_log_get_flags: cint; cdecl; external c_strFFmpegDllX64Name;
function av_log_get_level(): cint; cdecl; external c_strFFmpegDllX64Name;
function av_malloc(size: size_t): Pointer; cdecl; external c_strFFmpegDllX64Name;
function av_malloc_array(nmemb: size_t; size: size_t): Pointer; cdecl; external c_strFFmpegDllX64Name;
function av_mallocz(size: size_t): Pointer; cdecl; external c_strFFmpegDllX64Name;
function av_mallocz_array(nmemb: size_t; size: size_t): Pointer; cdecl; external c_strFFmpegDllX64Name;
function av_memdup(P: Pointer; size: size_t): Pointer; cdecl; external c_strFFmpegDllX64Name;
function av_opt_child_class_next(parent: PAVClass; prev: PAVClass): PAVClass; cdecl; external c_strFFmpegDllX64Name;
function av_opt_child_next(obj: Pointer; prev: Pointer): Pointer; cdecl; external c_strFFmpegDllX64Name;
function av_opt_copy(dest: Pointer; src: Pointer): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_eval_double(obj: Pointer; o: PAVOption; val: PAnsiChar; double_out: Pcdouble): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_eval_flags(obj: Pointer; o: PAVOption; val: PAnsiChar; flags_out: Pcint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_eval_float(obj: Pointer; o: PAVOption; val: PAnsiChar; float_out: Pcfloat): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_eval_int(obj: Pointer; o: PAVOption; val: PAnsiChar; int_out: Pcint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_eval_int64(obj: Pointer; o: PAVOption; val: PAnsiChar; int64_out: Pcint64): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_eval_q(obj: Pointer; o: PAVOption; val: PAnsiChar; q_out: PAVRational): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_find(obj: Pointer; name: PAnsiChar; unit_: PAnsiChar; opt_flags: cint; search_flags: cint): PAVOption; cdecl; external c_strFFmpegDllX64Name;
function av_opt_find2(obj: Pointer; name: PAnsiChar; unit_: PAnsiChar; opt_flags: cint; search_flags: cint; out target_obj: Pointer): PAVOption; cdecl; external c_strFFmpegDllX64Name;
function av_opt_flag_is_set(obj: Pointer; field_name: PAnsiChar; flag_name: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_get(obj: Pointer; name: PAnsiChar; search_flags: cint; out out_val: Pcuint8): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_get_channel_layout(obj: Pointer; name: PAnsiChar; search_flags: cint; ch_layout: Pcint64): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_get_dict_val(obj: Pointer; name: PAnsiChar; search_flags: cint; out out_val: PAVDictionary): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_get_double(obj: Pointer; name: PAnsiChar; search_flags: cint; out_val: Pcdouble): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_get_image_size(obj: Pointer; name: PAnsiChar; search_flags: cint; w_out, h_out: Pcint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_get_int(obj: Pointer; name: PAnsiChar; search_flags: cint; out_val: Pcint64): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_get_key_value(ropts: PPAnsiChar; key_val_sep: PAnsiChar; pairs_sep: PAnsiChar; flags: byte; rkey, rval: PPAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_get_pixel_fmt(obj: Pointer; name: PAnsiChar; search_flags: cint; out_fmt: PAVPixelFormat): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_get_q(obj: Pointer; name: PAnsiChar; search_flags: cint; out_val: PAVRational): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_get_sample_fmt(obj: Pointer; name: PAnsiChar; search_flags: cint; out_fmt: PAVPixelFormat): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_get_video_rate(obj: Pointer; name: PAnsiChar; search_flags: cint; out_val: PAVRational): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_next(obj: Pointer; prev: PAVOption): PAVOption; cdecl; external c_strFFmpegDllX64Name;
function av_opt_ptr(avclass: PAVClass; obj: Pointer; name: PAnsiChar): Pointer; cdecl; external c_strFFmpegDllX64Name;
function av_opt_query_ranges(P: PPAVOptionRanges; obj: Pointer; key: PAnsiChar; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_query_ranges_default(P: PPAVOptionRanges; obj: Pointer; key: PAnsiChar; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set(obj: Pointer; name: PAnsiChar; val: PAnsiChar; search_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_bin(obj: Pointer; name: PAnsiChar; val: cuint8; search_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_channel_layout(obj: Pointer; name: PAnsiChar; ch_layout: cint64; search_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_dict(obj: Pointer; var options: PAVDictionary): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_dict_val(obj: Pointer; name: PAnsiChar; val: PAVDictionary; search_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_dict2(obj: Pointer; var options: PAVDictionary; search_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_double(obj: Pointer; name: PAnsiChar; val: cdouble; search_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_from_string(ctx: Pointer; opts: PAnsiChar; shorthand: PAnsiChar; key_val_sep: PAnsiChar; pairs_sep: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_image_size(obj: Pointer; name: PAnsiChar; w, h, search_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_int(obj: Pointer; name: PAnsiChar; val: cint64; search_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_pixel_fmt(obj: Pointer; name: PAnsiChar; fmt: TAVPixelFormat; search_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_q(obj: Pointer; name: PAnsiChar; val: TAVRational; search_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_sample_fmt(obj: Pointer; name: PAnsiChar; fmt: TAVSampleFormat; search_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_set_video_rate(obj: Pointer; name: PAnsiChar; val: TAVRational; search_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_opt_show2(obj: Pointer; av_log_obj: Pointer; req_flags: cint; rej_flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_parse_cpu_caps(flags: PCuint; s: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function av_parse_cpu_flags(s: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function av_realloc(ptr: Pointer; size: size_t): Pointer; cdecl; external c_strFFmpegDllX64Name;
function av_realloc_array(ptr: Pointer; nmemb, size: size_t): Pointer; cdecl; external c_strFFmpegDllX64Name;
function av_realloc_f(ptr: Pointer; nelem: size_t; elsize: size_t): Pointer; cdecl; external c_strFFmpegDllX64Name;
function av_reallocp(ptr: Pointer; elsize: size_t): cint; cdecl; external c_strFFmpegDllX64Name;
function av_reallocp_array(ptr: Pointer; nmemb, size: size_t): cint; cdecl; external c_strFFmpegDllX64Name;
function av_rescale(a, b, c: cint64): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_rescale_delta(in_tb: TAVRational; in_ts: cint64; fs_tb: TAVRational; duration: cint; last: Pcint64; out_tb: TAVRational): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_rescale_q(a: cint64; bq, cq: TAVRational): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_rescale_q_rnd(a: cint64; bq, cq: TAVRational; rnd: TAVRounding): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_rescale_rnd(a, b, c: cint64; rnd: TAVRounding): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_sample_fmt_is_planar(sample_fmt: TAVSampleFormat): cint; cdecl; external c_strFFmpegDllX64Name;
function av_samples_alloc(var audio_data: Pcuint8; linesize: Pcint; nb_channels: cint; nb_samples: cint; sample_fmt: TAVSampleFormat; align: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_samples_alloc_array_and_samples(var audio_data: Pcuint8; linesize: Pcint; nb_channels: cint; nb_samples: cint; sample_fmt: TAVSampleFormat; align: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_samples_copy(var dst: Pcuint8; src: Pcuint8; dst_offset: cint; src_offset: cint; nb_samples: cint; nb_channels: cint; sample_fmt: TAVSampleFormat): cint; cdecl; external c_strFFmpegDllX64Name;
function av_samples_fill_arrays(var audio_data: Pcuint8; linesize: Pcint; buf: Pcuint8; nb_channels: cint; nb_samples: cint; sample_fmt: TAVSampleFormat; align: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_samples_get_buffer_size(linesize: Pcint; nb_channels: cint; nb_samples: cint; sample_fmt: TAVSampleFormat; align: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_samples_set_silence(var audio_data: Pcuint8; offset: cint; nb_samples: cint; nb_channels: cint; sample_fmt: TAVSampleFormat): cint; cdecl; external c_strFFmpegDllX64Name;
function av_set_options_string(ctx: Pointer; opts: PAnsiChar; key_val_sep: PAnsiChar; pairs_sep: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function av_size_mult(a: size_t; b: size_t; r: Psize_t): size_t; cdecl; external c_strFFmpegDllX64Name;
function av_strdup(s: PAnsiChar): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_strerror(errnum: cint; errbuf: PAnsiChar; errbuf_size: size_t): cint; cdecl; external c_strFFmpegDllX64Name;
function av_strndup(s: PAnsiChar; len: size_t): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_usleep(usec: Cardinal): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_version_info(): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function avpriv_frame_get_metadatap(frame: PAVFrame): PPAVDictionary; cdecl; external c_strFFmpegDllX64Name;
function avutil_configuration(): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function avutil_license(): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function avutil_version(): cuint; cdecl; external c_strFFmpegDllX64Name;
procedure av_frame_free(frame: PPAVFrame); cdecl; external c_strFFmpegDllX64Name;
procedure av_frame_move_ref(dst, src: PAVFrame); cdecl; external c_strFFmpegDllX64Name;
procedure av_frame_remove_side_data(frame: PAVFrame; type_: TAVFrameSideDataType); cdecl; external c_strFFmpegDllX64Name;
procedure av_frame_set_best_effort_timestamp(frame: PAVFrame; val: cint64); cdecl; external c_strFFmpegDllX64Name;
procedure av_frame_set_channels(frame: PAVFrame; val: cint); cdecl; external c_strFFmpegDllX64Name;
procedure av_frame_set_color_range(frame: PAVFrame; val: TAVColorSpace); cdecl; external c_strFFmpegDllX64Name;
procedure av_frame_set_colorspace(frame: PAVFrame; val: TAVColorSpace); cdecl; external c_strFFmpegDllX64Name;
procedure av_frame_set_decode_error_flags(frame: PAVFrame; val: cint); cdecl; external c_strFFmpegDllX64Name;
procedure av_frame_set_metadata(frame: PAVFrame; val: PAVDictionary); cdecl; external c_strFFmpegDllX64Name;
procedure av_frame_set_pkt_size(frame: PAVFrame; val: cint); cdecl; external c_strFFmpegDllX64Name;
procedure av_frame_set_sample_rate(frame: PAVFrame; val: cint); cdecl; external c_strFFmpegDllX64Name;
procedure av_frame_unref(frame: PAVFrame); cdecl; external c_strFFmpegDllX64Name;
procedure av_opt_free(obj: Pointer); cdecl; external c_strFFmpegDllX64Name;
procedure av_opt_freep_ranges(ranges: PPAVOptionRanges); cdecl; external c_strFFmpegDllX64Name;
procedure av_opt_set_defaults(s: Pointer); cdecl; external c_strFFmpegDllX64Name;
procedure av_opt_set_defaults2(s: Pointer; mask: cint; flags: cint); cdecl; external c_strFFmpegDllX64Name;
procedure av_free(ptr: Pointer); cdecl; external c_strFFmpegDllX64Name;
procedure av_freep(ptr: Pointer); cdecl; external c_strFFmpegDllX64Name;
procedure av_max_alloc(max: size_t); cdecl; external c_strFFmpegDllX64Name;
procedure av_memcpy_backptr(dst: Pcuint8; back: cint; cnt: cint); cdecl; external c_strFFmpegDllX64Name;
procedure av_force_cpu_flags(flags: cint); cdecl; external c_strFFmpegDllX64Name;
procedure av_set_cpu_flags_mask(mask: cint); cdecl; external c_strFFmpegDllX64Name;
procedure av_log_format_line(ptr: Pointer; level: cint; fmt: PAnsiChar; vl: va_list; line: PAnsiChar; line_size: cint; print_prefix: Pcint); cdecl; external c_strFFmpegDllX64Name;

function AV_VERSION_INT(a, b, c: Cardinal): Cardinal;
function AV_VERSION_DOT(a, b, c: Integer): PAnsiChar;
function AV_VERSION(a, b, c: Integer): PAnsiChar;
function AV_TOSTRING(s: PAnsiChar): PAnsiChar;
function AV_STRINGIFY(s: PAnsiChar): PAnsiChar;
function MKTAG(a, b, c, d: AnsiChar): Integer; {$IFDEF HasInline}inline; {$ENDIF}
function MKBETAG(a, b, c, d: AnsiChar): Integer; {$IFDEF HasInline}inline; {$ENDIF}
function av_x_if_null(P: Pointer; x: Pointer): Pointer; {$IFDEF HasInline}inline; {$ENDIF}
function av_make_error_string(errbuf: PAnsiChar; errbuf_size: size_t; errnum: cint): PAnsiChar; {$IFDEF HasInline}inline; {$ENDIF}
function AVERROR(e: Integer): Integer;
function av_err2str(errnum: cint): PAnsiChar; {$IFDEF HasInline}inline; {$ENDIF}
function av_int_list_length(list: Pointer; term: cuint64): cuint;

implementation

function AV_VERSION_INT(a, b, c: Cardinal): Cardinal;
begin
  Result := ((a shl 16) or (b shl 8) or c);
end;

function AV_VERSION_DOT(a, b, c: Integer): PAnsiChar;
begin
  Result := PAnsiChar(AnsiString(format('%d.%02.2d.%02.2d', [a, b, c])));
end;

function AV_VERSION(a, b, c: Integer): PAnsiChar;
begin
  Result := AV_VERSION_DOT(a, b, c);
end;

function AV_TOSTRING(s: PAnsiChar): PAnsiChar;
begin
  Result := PAnsiChar(AnsiString('#' + string(Pchar(s))));
end;

function AV_STRINGIFY(s: PAnsiChar): PAnsiChar;
begin
  Result := AV_TOSTRING(s);
end;

function av_x_if_null(P: Pointer; x: Pointer): Pointer; {$IFDEF HasInline}inline; {$ENDIF}
begin
  if P = nil then
    Result := x
  else
    Result := P;
end;

function av_int_list_length(list: Pointer; term: cuint64): cuint;
begin
  Result := av_int_list_length_for_size(SizeOf(Pointer), list, term);
end;

function MKTAG(a, b, c, d: AnsiChar): Integer; {$IFDEF HasInline}inline; {$ENDIF}
begin
  Result := (ord(a) or (ord(b) shl 8) or (ord(c) shl 16) or (ord(d) shl 24));
end;

function MKBETAG(a, b, c, d: AnsiChar): Integer; {$IFDEF HasInline}inline; {$ENDIF}
begin
  Result := (ord(d) or (ord(c) shl 8) or (ord(b) shl 16) or (ord(a) shl 24));
end;

function av_make_error_string(errbuf: PAnsiChar; errbuf_size: size_t; errnum: cint): PAnsiChar; {$IFDEF HasInline}inline; {$ENDIF}
begin
  av_strerror(errnum, errbuf, errbuf_size);
  av_make_error_string := errbuf;
end;

function av_err2str(errnum: cint): PAnsiChar; {$IFDEF HasInline}inline; {$ENDIF}
var
  errbuf: PAnsiChar;
begin
  errbuf := PAnsiChar(stralloc(AV_ERROR_MAX_STRING_SIZE));
  av_make_error_string(errbuf, AV_ERROR_MAX_STRING_SIZE, errnum);
  av_err2str := errbuf;
end;

function AVERROR(e: Integer): Integer;
begin
  AVERROR := AVERROR_SIGN * e;
end;

end.

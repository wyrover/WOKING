unit ffmpeg.Avutil;

interface

uses System.SysUtils, ffmpeg.Common;

const
  AV_NUM_DATA_POINTERS = 8;

type
  PPAVFrame            = ^PAVFrame;
  PAVFrame             = ^TAVFrame;
  PTAVPixelFormat      = ^TAVPixelFormat;
  PAVDictionaryEntry   = ^TAVDictionaryEntry;
  PPAVDictionary       = ^PAVDictionary;
  PAVDictionary        = ^AVDictionary;
  PAVPixelFormat       = ^TAVPixelFormat;
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

  TAVDictionaryEntry = record
    key: PAnsiChar;
    value: PAnsiChar;
  end;

  AVDictionary = record
    count: cint;
    elems: PAVDictionaryEntry;
  end;

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

function AV_VERSION_INT(a, b, c: Cardinal): Cardinal;
function AV_VERSION_DOT(a, b, c: Integer): PAnsiChar;
function AV_VERSION(a, b, c: Integer): PAnsiChar;
function AV_TOSTRING(s: PAnsiChar): PAnsiChar;
function AV_STRINGIFY(s: PAnsiChar): PAnsiChar;

function av_gettime: Int64; cdecl; external c_strFFmpegDllX64Name;
function av_gettime_relative: Int64; cdecl; external c_strFFmpegDllX64Name;
function av_gettime_relative_is_monotonic: Integer; cdecl; external c_strFFmpegDllX64Name;
function av_usleep(usec: Cardinal): Integer; cdecl; external c_strFFmpegDllX64Name;

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
  Result := PAnsiChar(AnsiString('#' + string(PChar(s))));
end;

function AV_STRINGIFY(s: PAnsiChar): PAnsiChar;
begin
  Result := AV_TOSTRING(s);
end;

end.

unit ffmpeg.Avcodec;

interface

uses ffmpeg.Common, System.SysUtils, ffmpeg.Avutil, DX12.D3D11;

const
  FFMPEG_VERSION              = '3.4 git';
  AV_PARSER_PTS_NB            = 4;
  PARSER_FLAG_COMPLETE_FRAMES = $0001;
  PARSER_FLAG_ONCE            = $0002;
  PARSER_FLAG_FETCHED_OFFSET  = $0004;
  PARSER_FLAG_USE_CODEC_TS    = $1000;
  AV_CH_FRONT_LEFT            = $00000001;
  AV_CH_FRONT_RIGHT           = $00000002;
  AV_CH_FRONT_CENTER          = $00000004;
  AV_CH_LOW_FREQUENCY         = $00000008;
  AV_CH_BACK_LEFT             = $00000010;
  AV_CH_BACK_RIGHT            = $00000020;
  AV_CH_FRONT_LEFT_OF_CENTER  = $00000040;
  AV_CH_FRONT_RIGHT_OF_CENTER = $00000080;
  AV_CH_BACK_CENTER           = $00000100;
  AV_CH_SIDE_LEFT             = $00000200;
  AV_CH_SIDE_RIGHT            = $00000400;
  AV_CH_TOP_CENTER            = $00000800;
  AV_CH_TOP_FRONT_LEFT        = $00001000;
  AV_CH_TOP_FRONT_CENTER      = $00002000;
  AV_CH_TOP_FRONT_RIGHT       = $00004000;
  AV_CH_TOP_BACK_LEFT         = $00008000;
  AV_CH_TOP_BACK_CENTER       = $00010000;
  AV_CH_TOP_BACK_RIGHT        = $00020000;
  AV_CH_STEREO_LEFT           = $20000000;
  AV_CH_STEREO_RIGHT          = $40000000;
  AV_CH_WIDE_LEFT             = $0000000080000000;
  AV_CH_WIDE_RIGHT            = $0000000100000000;
  AV_CH_SURROUND_DIRECT_LEFT  = $0000000200000000;
  AV_CH_SURROUND_DIRECT_RIGHT = $0000000400000000;
  AV_CH_LOW_FREQUENCY_2       = $0000000800000000;
  AV_CH_LAYOUT_NATIVE         = $8000000000000000;
  AV_CH_LAYOUT_MONO           = (AV_CH_FRONT_CENTER);
  AV_CH_LAYOUT_STEREO         = (AV_CH_FRONT_LEFT or AV_CH_FRONT_RIGHT);
  AV_CH_LAYOUT_2POINT1        = (AV_CH_LAYOUT_STEREO or AV_CH_LOW_FREQUENCY);
  AV_CH_LAYOUT_2_1            = (AV_CH_LAYOUT_STEREO or AV_CH_BACK_CENTER);
  AV_CH_LAYOUT_SURROUND       = (AV_CH_LAYOUT_STEREO or AV_CH_FRONT_CENTER);
  AV_CH_LAYOUT_3POINT1        = (AV_CH_LAYOUT_SURROUND or AV_CH_LOW_FREQUENCY);
  AV_CH_LAYOUT_4POINT0        = (AV_CH_LAYOUT_SURROUND or AV_CH_BACK_CENTER);
  AV_CH_LAYOUT_4POINT1        = (AV_CH_LAYOUT_4POINT0 or AV_CH_LOW_FREQUENCY);
  AV_CH_LAYOUT_2_2            = (AV_CH_LAYOUT_STEREO or AV_CH_SIDE_LEFT or AV_CH_SIDE_RIGHT);
  AV_CH_LAYOUT_QUAD           = (AV_CH_LAYOUT_STEREO or AV_CH_BACK_LEFT or AV_CH_BACK_RIGHT);
  AV_CH_LAYOUT_5POINT0        = (AV_CH_LAYOUT_SURROUND or AV_CH_SIDE_LEFT or AV_CH_SIDE_RIGHT);
  AV_CH_LAYOUT_5POINT1        = (AV_CH_LAYOUT_5POINT0 or AV_CH_LOW_FREQUENCY);
  AV_CH_LAYOUT_5POINT0_BACK   = (AV_CH_LAYOUT_SURROUND or AV_CH_BACK_LEFT or AV_CH_BACK_RIGHT);
  AV_CH_LAYOUT_5POINT1_BACK   = (AV_CH_LAYOUT_5POINT0_BACK or AV_CH_LOW_FREQUENCY);
  AV_CH_LAYOUT_6POINT0        = (AV_CH_LAYOUT_5POINT0 or AV_CH_BACK_CENTER);
  AV_CH_LAYOUT_6POINT0_FRONT  = (AV_CH_LAYOUT_2_2 or AV_CH_FRONT_LEFT_OF_CENTER or AV_CH_FRONT_RIGHT_OF_CENTER);
  AV_CH_LAYOUT_HEXAGONAL      = (AV_CH_LAYOUT_5POINT0_BACK or AV_CH_BACK_CENTER);
  AV_CH_LAYOUT_6POINT1        = (AV_CH_LAYOUT_5POINT1 or AV_CH_BACK_CENTER);
  AV_CH_LAYOUT_6POINT1_BACK   = (AV_CH_LAYOUT_5POINT1_BACK or AV_CH_BACK_CENTER);
  AV_CH_LAYOUT_6POINT1_FRONT  = (AV_CH_LAYOUT_6POINT0_FRONT or AV_CH_LOW_FREQUENCY);
  AV_CH_LAYOUT_7POINT0        = (AV_CH_LAYOUT_5POINT0 or AV_CH_BACK_LEFT or AV_CH_BACK_RIGHT);
  AV_CH_LAYOUT_7POINT0_FRONT  = (AV_CH_LAYOUT_5POINT0 or AV_CH_FRONT_LEFT_OF_CENTER or AV_CH_FRONT_RIGHT_OF_CENTER);
  AV_CH_LAYOUT_7POINT1        = (AV_CH_LAYOUT_5POINT1 or AV_CH_BACK_LEFT or AV_CH_BACK_RIGHT);
  AV_CH_LAYOUT_7POINT1_WIDE   = (AV_CH_LAYOUT_5POINT1 or AV_CH_FRONT_LEFT_OF_CENTER or AV_CH_FRONT_RIGHT_OF_CENTER);
  AV_CH_LAYOUT_OCTAGONAL      = (AV_CH_LAYOUT_5POINT0 or AV_CH_BACK_LEFT or AV_CH_BACK_CENTER or AV_CH_BACK_RIGHT);
  AV_CH_LAYOUT_HEXADECAGONAL  = (AV_CH_LAYOUT_OCTAGONAL or AV_CH_WIDE_LEFT or AV_CH_WIDE_RIGHT or AV_CH_TOP_BACK_LEFT or AV_CH_TOP_BACK_RIGHT or AV_CH_TOP_BACK_CENTER or AV_CH_TOP_FRONT_CENTER or AV_CH_TOP_FRONT_LEFT or AV_CH_TOP_FRONT_RIGHT);
  AV_CH_LAYOUT_STEREO_DOWNMIX = (AV_CH_STEREO_LEFT or AV_CH_STEREO_RIGHT);

type
  PAVClass                  = ^TAVClass;
  PAVPacket                 = ^TAVPacket;
  PAVCodecID                = ^TAVCodecID;
  PAVPacketSideData         = ^TAVPacketSideData;
  PPAVCodecParameters       = ^PAVCodecParameters;
  PAVCodecParameters        = ^TAVCodecParameters;
  PAVCodecParserContext     = ^TAVCodecParserContext;
  PAVCodecParser            = ^TAVCodecParser;
  PAVCodecContext           = ^TAVCodecContext;
  PPAVCodec                 = ^PAVCodec;
  PAVCodec                  = ^TAVCodec;
  PAVProfile                = ^TAVProfile;
  PPAVSubtitle              = ^PAVSubtitle;
  PAVSubtitle               = ^TAVSubtitle;
  PPAVSubtitleRect          = ^PAVSubtitleRect;
  PAVSubtitleRect           = ^TAVSubtitleRect;
  PAVCodecInternal          = ^TAVCodecInternal;
  PAVNDPArray               = ^TAVNDPArray;
  TAVNDPArray               = array [0 .. AV_NUM_DATA_POINTERS - 1] of cint;
  PRcOverride               = ^TRcOverride;
  PAVHWAccel                = ^TAVHWAccel;
  PMpegEncContext           = ^TMpegEncContext;
  PAVCodecDescriptor        = ^TAVCodecDescriptor;
  PAVBitStreamFilterContext = ^TAVBitStreamFilterContext;
  PAVBitStreamFilter        = ^TAVBitStreamFilter;
  PPAVBSFContext            = ^PAVBSFContext;
  PAVBSFContext             = ^TAVBSFContext;
  PPAVBSFList               = ^PAVBSFList;
  PAVBSFList                = ^TAVBSFList;
  PAVCPBProperties          = ^TAVCPBProperties;
  PAVPicture                = ^TAVPicture;
  PAVCodecHWConfig          = ^TAVCodecHWConfig;
  PPAVPacket                = ^PAVPacket;
  TAVMatrixEncoding         = (AV_MATRIX_ENCODING_NONE, AV_MATRIX_ENCODING_DOLBY, AV_MATRIX_ENCODING_DPLII, AV_MATRIX_ENCODING_DPLIIX, AV_MATRIX_ENCODING_DPLIIZ, AV_MATRIX_ENCODING_DOLBYEX, AV_MATRIX_ENCODING_DOLBYHEADPHONE, AV_MATRIX_ENCODING_NB);
  PAVBPrint                 = ^TAVBPrint;
  PAVAudioConvert           = ^TAVAudioConvert;
  PAVBSFInternal            = ^TAVBSFInternal;
  PAVD3D11VAContext         = ^TAVD3D11VAContext;

  TAVAudioConvert = record
    in_channels, out_channels: cint;
    fmt_pair: cint;
  end;

  TAVBPrint = record
    case integer of
      0:
        (paddedRecord: array [1 .. 1024] of byte);
      1:
        (str: PAnsiChar;
          len: cuint;
          size: cuint;
          size_max: cuint;
          reserved_internal_buffer: Pchar
        );
  end;

  TMpegEncContext = record
  end;

  TRcOverride = record
    start_frame: cint;
    end_frame: cint;
    qscale: cint;
    quality_factor: cfloat;
  end;

  TAVCodecInternal = record
  end;

  TAVAudioServiceType = (                        //
    AV_AUDIO_SERVICE_TYPE_MAIN = 0,              //
    AV_AUDIO_SERVICE_TYPE_EFFECTS = 1,           //
    AV_AUDIO_SERVICE_TYPE_VISUALLY_IMPAIRED = 2, //
    AV_AUDIO_SERVICE_TYPE_HEARING_IMPAIRED = 3,  //
    AV_AUDIO_SERVICE_TYPE_DIALOGUE = 4,          //
    AV_AUDIO_SERVICE_TYPE_COMMENTARY = 5,        //
    AV_AUDIO_SERVICE_TYPE_EMERGENCY = 6,         //
    AV_AUDIO_SERVICE_TYPE_VOICE_OVER = 7,        //
    AV_AUDIO_SERVICE_TYPE_KARAOKE = 8,           //
    AV_AUDIO_SERVICE_TYPE_NB                     //
    );

  TAVPictureStructure = (              //
    AV_PICTURE_STRUCTURE_UNKNOWN,      //
    AV_PICTURE_STRUCTURE_TOP_FIELD,    //
    AV_PICTURE_STRUCTURE_BOTTOM_FIELD, //
    AV_PICTURE_STRUCTURE_FRAME         //
    );

  TAVPacket = record
    buf: PAVBufferRef;
    pts: cint64;
    dts: cint64;
    data: PByteArray;
    size: cint;
    stream_index: cint;
    flags: cint;
    side_data: PAVPacketSideData;
    side_data_elems: cint;
    duration: cint64;
    pos: cint64;
{$IFDEF FF_API_CONVERGENCE_DURATION}
    convergence_duration: cint64;
{$ENDIF}
  end;

  TAVClass = record
    class_name: PAnsiChar;
    item_name: function(ctx: pointer): PAnsiChar; cdecl;
    option: PAVOption;
    version: cint;
    log_level_offset_offset: cint;
    parent_log_context_offset: cint;
    child_next: function(obj: pointer; prev: pointer): pointer; cdecl;
    child_class_next: function(prev: PAVClass): PAVClass; cdecl;
    category: TAVClassCategory;
    get_category: function(ctx: pointer): PAVClassCategory; cdecl;
    query_ranges: function(P: PPAVOptionRanges; obj: pointer; key: PAnsiChar; flags: cint): cint; cdecl;
  end;

  TAVCodecID = (                                     //
    AV_CODEC_ID_NONE, AV_CODEC_ID_MPEG1VIDEO,        //
    AV_CODEC_ID_MPEG2VIDEO,                          //
    AV_CODEC_ID_H261,                                //
    AV_CODEC_ID_H263,                                //
    AV_CODEC_ID_RV10,                                //
    AV_CODEC_ID_RV20,                                //
    AV_CODEC_ID_MJPEG,                               //
    AV_CODEC_ID_MJPEGB,                              //
    AV_CODEC_ID_LJPEG,                               //
    AV_CODEC_ID_SP5X,                                //
    AV_CODEC_ID_JPEGLS,                              //
    AV_CODEC_ID_MPEG4,                               //
    AV_CODEC_ID_RAWVIDEO,                            //
    AV_CODEC_ID_MSMPEG4V1,                           //
    AV_CODEC_ID_MSMPEG4V2,                           //
    AV_CODEC_ID_MSMPEG4V3,                           //
    AV_CODEC_ID_WMV1,                                //
    AV_CODEC_ID_WMV2,                                //
    AV_CODEC_ID_H263P,                               //
    AV_CODEC_ID_H263I,                               //
    AV_CODEC_ID_FLV1,                                //
    AV_CODEC_ID_SVQ1,                                //
    AV_CODEC_ID_SVQ3,                                //
    AV_CODEC_ID_DVVIDEO,                             //
    AV_CODEC_ID_HUFFYUV,                             //
    AV_CODEC_ID_CYUV,                                //
    AV_CODEC_ID_H264,                                //
    AV_CODEC_ID_INDEO3,                              //
    AV_CODEC_ID_VP3,                                 //
    AV_CODEC_ID_THEORA,                              //
    AV_CODEC_ID_ASV1,                                //
    AV_CODEC_ID_ASV2,                                //
    AV_CODEC_ID_FFV1,                                //
    AV_CODEC_ID_4XM,                                 //
    AV_CODEC_ID_VCR1,                                //
    AV_CODEC_ID_CLJR,                                //
    AV_CODEC_ID_MDEC,                                //
    AV_CODEC_ID_ROQ,                                 //
    AV_CODEC_ID_INTERPLAY_VIDEO,                     //
    AV_CODEC_ID_XAN_WC3,                             //
    AV_CODEC_ID_XAN_WC4,                             //
    AV_CODEC_ID_RPZA,                                //
    AV_CODEC_ID_CINEPAK,                             //
    AV_CODEC_ID_WS_VQA,                              //
    AV_CODEC_ID_MSRLE,                               //
    AV_CODEC_ID_MSVIDEO1,                            //
    AV_CODEC_ID_IDCIN,                               //
    AV_CODEC_ID_8BPS,                                //
    AV_CODEC_ID_SMC,                                 //
    AV_CODEC_ID_FLIC,                                //
    AV_CODEC_ID_TRUEMOTION1,                         //
    AV_CODEC_ID_VMDVIDEO,                            //
    AV_CODEC_ID_MSZH,                                //
    AV_CODEC_ID_ZLIB,                                //
    AV_CODEC_ID_QTRLE,                               //
    AV_CODEC_ID_TSCC,                                //
    AV_CODEC_ID_ULTI,                                //
    AV_CODEC_ID_QDRAW,                               //
    AV_CODEC_ID_VIXL,                                //
    AV_CODEC_ID_QPEG,                                //
    AV_CODEC_ID_PNG,                                 //
    AV_CODEC_ID_PPM,                                 //
    AV_CODEC_ID_PBM,                                 //
    AV_CODEC_ID_PGM,                                 //
    AV_CODEC_ID_PGMYUV,                              //
    AV_CODEC_ID_PAM,                                 //
    AV_CODEC_ID_FFVHUFF,                             //
    AV_CODEC_ID_RV30,                                //
    AV_CODEC_ID_RV40,                                //
    AV_CODEC_ID_VC1,                                 //
    AV_CODEC_ID_WMV3,                                //
    AV_CODEC_ID_LOCO,                                //
    AV_CODEC_ID_WNV1,                                //
    AV_CODEC_ID_AASC,                                //
    AV_CODEC_ID_INDEO2,                              //
    AV_CODEC_ID_FRAPS,                               //
    AV_CODEC_ID_TRUEMOTION2,                         //
    AV_CODEC_ID_BMP,                                 //
    AV_CODEC_ID_CSCD,                                //
    AV_CODEC_ID_MMVIDEO,                             //
    AV_CODEC_ID_ZMBV,                                //
    AV_CODEC_ID_AVS,                                 //
    AV_CODEC_ID_SMACKVIDEO,                          //
    AV_CODEC_ID_NUV,                                 //
    AV_CODEC_ID_KMVC,                                //
    AV_CODEC_ID_FLASHSV,                             //
    AV_CODEC_ID_CAVS,                                //
    AV_CODEC_ID_JPEG2000,                            //
    AV_CODEC_ID_VMNC,                                //
    AV_CODEC_ID_VP5,                                 //
    AV_CODEC_ID_VP6,                                 //
    AV_CODEC_ID_VP6F,                                //
    AV_CODEC_ID_TARGA,                               //
    AV_CODEC_ID_DSICINVIDEO,                         //
    AV_CODEC_ID_TIERTEXSEQVIDEO,                     //
    AV_CODEC_ID_TIFF,                                //
    AV_CODEC_ID_GIF,                                 //
    AV_CODEC_ID_DXA,                                 //
    AV_CODEC_ID_DNXHD,                               //
    AV_CODEC_ID_THP,                                 //
    AV_CODEC_ID_SGI,                                 //
    AV_CODEC_ID_C93,                                 //
    AV_CODEC_ID_BETHSOFTVID,                         //
    AV_CODEC_ID_PTX,                                 //
    AV_CODEC_ID_TXD,                                 //
    AV_CODEC_ID_VP6A,                                //
    AV_CODEC_ID_AMV,                                 //
    AV_CODEC_ID_VB,                                  //
    AV_CODEC_ID_PCX,                                 //
    AV_CODEC_ID_SUNRAST,                             //
    AV_CODEC_ID_INDEO4,                              //
    AV_CODEC_ID_INDEO5,                              //
    AV_CODEC_ID_MIMIC,                               //
    AV_CODEC_ID_RL2,                                 //
    AV_CODEC_ID_ESCAPE124,                           //
    AV_CODEC_ID_DIRAC,                               //
    AV_CODEC_ID_BFI,                                 //
    AV_CODEC_ID_CMV,                                 //
    AV_CODEC_ID_MOTIONPIXELS,                        //
    AV_CODEC_ID_TGV,                                 //
    AV_CODEC_ID_TGQ,                                 //
    AV_CODEC_ID_TQI,                                 //
    AV_CODEC_ID_AURA,                                //
    AV_CODEC_ID_AURA2,                               //
    AV_CODEC_ID_V210X,                               //
    AV_CODEC_ID_TMV,                                 //
    AV_CODEC_ID_V210,                                //
    AV_CODEC_ID_DPX,                                 //
    AV_CODEC_ID_MAD,                                 //
    AV_CODEC_ID_FRWU,                                //
    AV_CODEC_ID_FLASHSV2,                            //
    AV_CODEC_ID_CDGRAPHICS,                          //
    AV_CODEC_ID_R210,                                //
    AV_CODEC_ID_ANM,                                 //
    AV_CODEC_ID_BINKVIDEO,                           //
    AV_CODEC_ID_IFF_ILBM,                            //
    AV_CODEC_ID_IFF_BYTERUN1 = AV_CODEC_ID_IFF_ILBM, //
    AV_CODEC_ID_KGV1,                                //
    AV_CODEC_ID_YOP,                                 //
    AV_CODEC_ID_VP8,                                 //
    AV_CODEC_ID_PICTOR,                              //
    AV_CODEC_ID_ANSI,                                //
    AV_CODEC_ID_A64_MULTI,                           //
    AV_CODEC_ID_A64_MULTI5,                          //
    AV_CODEC_ID_R10K,                                //
    AV_CODEC_ID_MXPEG,                               //
    AV_CODEC_ID_LAGARITH,                            //
    AV_CODEC_ID_PRORES,                              //
    AV_CODEC_ID_JV,                                  //
    AV_CODEC_ID_DFA,                                 //
    AV_CODEC_ID_WMV3IMAGE,                           //
    AV_CODEC_ID_VC1IMAGE,                            //
    AV_CODEC_ID_UTVIDEO,                             //
    AV_CODEC_ID_BMV_VIDEO,                           //
    AV_CODEC_ID_VBLE,                                //
    AV_CODEC_ID_DXTORY,                              //
    AV_CODEC_ID_V410,                                //
    AV_CODEC_ID_XWD,                                 //
    AV_CODEC_ID_CDXL,                                //
    AV_CODEC_ID_XBM,                                 //
    AV_CODEC_ID_ZEROCODEC,                           //
    AV_CODEC_ID_MSS1,                                //
    AV_CODEC_ID_MSA1,                                //
    AV_CODEC_ID_TSCC2,                               //
    AV_CODEC_ID_MTS2,                                //
    AV_CODEC_ID_CLLC,                                //
    AV_CODEC_ID_MSS2,                                //
    AV_CODEC_ID_VP9,                                 //
    AV_CODEC_ID_AIC,                                 //
    AV_CODEC_ID_ESCAPE130,                           //
    AV_CODEC_ID_G2M,                                 //
    AV_CODEC_ID_WEBP,                                //
    AV_CODEC_ID_HNM4_VIDEO,                          //
    AV_CODEC_ID_HEVC,                                //
    AV_CODEC_ID_FIC,                                 //
    AV_CODEC_ID_ALIAS_PIX,                           //
    AV_CODEC_ID_BRENDER_PIX,                         //
    AV_CODEC_ID_PAF_VIDEO,                           //
    AV_CODEC_ID_EXR,                                 //
    AV_CODEC_ID_VP7,                                 //
    AV_CODEC_ID_SANM,                                //
    AV_CODEC_ID_SGIRLE,                              //
    AV_CODEC_ID_MVC1,                                //
    AV_CODEC_ID_MVC2,                                //
    AV_CODEC_ID_HQX,                                 //
    AV_CODEC_ID_TDSC,                                //
    AV_CODEC_ID_HQ_HQA,                              //
    AV_CODEC_ID_HAP,                                 //
    AV_CODEC_ID_DDS,                                 //
    AV_CODEC_ID_DXV,                                 //
    AV_CODEC_ID_SCREENPRESSO,                        //
    AV_CODEC_ID_RSCC,                                //
    AV_CODEC_ID_Y41P = $8000,                        //
    AV_CODEC_ID_AVRP,                                //
    AV_CODEC_ID_012V,                                //
    AV_CODEC_ID_AVUI,                                //
    AV_CODEC_ID_AYUV,                                //
    AV_CODEC_ID_TARGA_Y216,                          //
    AV_CODEC_ID_V308,                                //
    AV_CODEC_ID_V408,                                //
    AV_CODEC_ID_YUV4,                                //
    AV_CODEC_ID_AVRN,                                //
    AV_CODEC_ID_CPIA,                                //
    AV_CODEC_ID_XFACE,                               //
    AV_CODEC_ID_SNOW,                                //
    AV_CODEC_ID_SMVJPEG,                             //
    AV_CODEC_ID_APNG,                                //
    AV_CODEC_ID_DAALA,                               //
    AV_CODEC_ID_CFHD,                                //
    AV_CODEC_ID_TRUEMOTION2RT,                       //
    AV_CODEC_ID_M101,                                //
    AV_CODEC_ID_MAGICYUV,                            //
    AV_CODEC_ID_SHEERVIDEO,                          //
    AV_CODEC_ID_YLC,                                 //
    AV_CODEC_ID_PSD,                                 //
    AV_CODEC_ID_PIXLET,                              //
    AV_CODEC_ID_SPEEDHQ,                             //
    AV_CODEC_ID_FMVC,                                //
    AV_CODEC_ID_SCPR,                                //
    AV_CODEC_ID_CLEARVIDEO,                          //
    AV_CODEC_ID_XPM,                                 //
    AV_CODEC_ID_AV1,                                 //
    AV_CODEC_ID_BITPACKED,                           //
    AV_CODEC_ID_MSCC,                                //
    AV_CODEC_ID_SRGC,                                //
    AV_CODEC_ID_SVG,                                 //
    AV_CODEC_ID_GDV,                                 //
    AV_CODEC_ID_FITS,                                //
    AV_CODEC_ID_FIRST_AUDIO = $10000,                //
    AV_CODEC_ID_PCM_S16LE = $10000,                  //
    AV_CODEC_ID_PCM_S16BE,                           //
    AV_CODEC_ID_PCM_U16LE,                           //
    AV_CODEC_ID_PCM_U16BE,                           //
    AV_CODEC_ID_PCM_S8,                              //
    AV_CODEC_ID_PCM_U8,                              //
    AV_CODEC_ID_PCM_MULAW,                           //
    AV_CODEC_ID_PCM_ALAW,                            //
    AV_CODEC_ID_PCM_S32LE,                           //
    AV_CODEC_ID_PCM_S32BE,                           //
    AV_CODEC_ID_PCM_U32LE,                           //
    AV_CODEC_ID_PCM_U32BE,                           //
    AV_CODEC_ID_PCM_S24LE,                           //
    AV_CODEC_ID_PCM_S24BE,                           //
    AV_CODEC_ID_PCM_U24LE,                           //
    AV_CODEC_ID_PCM_U24BE,                           //
    AV_CODEC_ID_PCM_S24DAUD,                         //
    AV_CODEC_ID_PCM_ZORK,                            //
    AV_CODEC_ID_PCM_S16LE_PLANAR,                    //
    AV_CODEC_ID_PCM_DVD,                             //
    AV_CODEC_ID_PCM_F32BE,                           //
    AV_CODEC_ID_PCM_F32LE,                           //
    AV_CODEC_ID_PCM_F64BE,                           //
    AV_CODEC_ID_PCM_F64LE,                           //
    AV_CODEC_ID_PCM_BLURAY,                          //
    AV_CODEC_ID_PCM_LXF,                             //
    AV_CODEC_ID_S302M,                               //
    AV_CODEC_ID_PCM_S8_PLANAR,                       //
    AV_CODEC_ID_PCM_S24LE_PLANAR,                    //
    AV_CODEC_ID_PCM_S32LE_PLANAR,                    //
    AV_CODEC_ID_PCM_S16BE_PLANAR,                    //
    AV_CODEC_ID_PCM_S64LE = $10800,                  //
    AV_CODEC_ID_PCM_S64BE,                           //
    AV_CODEC_ID_PCM_F16LE,                           //
    AV_CODEC_ID_PCM_F24LE,                           //
    AV_CODEC_ID_ADPCM_IMA_QT = $11000,               //
    AV_CODEC_ID_ADPCM_IMA_WAV,                       //
    AV_CODEC_ID_ADPCM_IMA_DK3,                       //
    AV_CODEC_ID_ADPCM_IMA_DK4,                       //
    AV_CODEC_ID_ADPCM_IMA_WS,                        //
    AV_CODEC_ID_ADPCM_IMA_SMJPEG,                    //
    AV_CODEC_ID_ADPCM_MS,                            //
    AV_CODEC_ID_ADPCM_4XM,                           //
    AV_CODEC_ID_ADPCM_XA,                            //
    AV_CODEC_ID_ADPCM_ADX,                           //
    AV_CODEC_ID_ADPCM_EA,                            //
    AV_CODEC_ID_ADPCM_G726,                          //
    AV_CODEC_ID_ADPCM_CT,                            //
    AV_CODEC_ID_ADPCM_SWF,                           //
    AV_CODEC_ID_ADPCM_YAMAHA,                        //
    AV_CODEC_ID_ADPCM_SBPRO_4,                       //
    AV_CODEC_ID_ADPCM_SBPRO_3,                       //
    AV_CODEC_ID_ADPCM_SBPRO_2,                       //
    AV_CODEC_ID_ADPCM_THP,                           //
    AV_CODEC_ID_ADPCM_IMA_AMV,                       //
    AV_CODEC_ID_ADPCM_EA_R1,                         //
    AV_CODEC_ID_ADPCM_EA_R3,                         //
    AV_CODEC_ID_ADPCM_EA_R2,                         //
    AV_CODEC_ID_ADPCM_IMA_EA_SEAD,                   //
    AV_CODEC_ID_ADPCM_IMA_EA_EACS,                   //
    AV_CODEC_ID_ADPCM_EA_XAS,                        //
    AV_CODEC_ID_ADPCM_EA_MAXIS_XA,                   //
    AV_CODEC_ID_ADPCM_IMA_ISS,                       //
    AV_CODEC_ID_ADPCM_G722,                          //
    AV_CODEC_ID_ADPCM_IMA_APC,                       //
    AV_CODEC_ID_ADPCM_VIMA,                          //
    AV_CODEC_ID_ADPCM_AFC = $11800,                  //
    AV_CODEC_ID_ADPCM_IMA_OKI,                       //
    AV_CODEC_ID_ADPCM_DTK,                           //
    AV_CODEC_ID_ADPCM_IMA_RAD,                       //
    AV_CODEC_ID_ADPCM_G726LE,                        //
    AV_CODEC_ID_ADPCM_THP_LE,                        //
    AV_CODEC_ID_ADPCM_PSX,                           //
    AV_CODEC_ID_ADPCM_AICA,                          //
    AV_CODEC_ID_ADPCM_IMA_DAT4,                      //
    AV_CODEC_ID_ADPCM_MTAF,                          //
    AV_CODEC_ID_AMR_NB = $12000,                     //
    AV_CODEC_ID_AMR_WB,                              //
    AV_CODEC_ID_RA_144 = $13000,                     //
    AV_CODEC_ID_RA_288,                              //
    AV_CODEC_ID_ROQ_DPCM = $14000,                   //
    AV_CODEC_ID_INTERPLAY_DPCM,                      //
    AV_CODEC_ID_XAN_DPCM,                            //
    AV_CODEC_ID_SOL_DPCM,                            //
    AV_CODEC_ID_SDX2_DPCM = $14800,                  //
    AV_CODEC_ID_GREMLIN_DPCM,                        //
    AV_CODEC_ID_MP2 = $15000,                        //
    AV_CODEC_ID_MP3,                                 //
    AV_CODEC_ID_AAC,                                 //
    AV_CODEC_ID_AC3,                                 //
    AV_CODEC_ID_DTS,                                 //
    AV_CODEC_ID_VORBIS,                              //
    AV_CODEC_ID_DVAUDIO,                             //
    AV_CODEC_ID_WMAV1,                               //
    AV_CODEC_ID_WMAV2,                               //
    AV_CODEC_ID_MACE3,                               //
    AV_CODEC_ID_MACE6,                               //
    AV_CODEC_ID_VMDAUDIO,                            //
    AV_CODEC_ID_FLAC,                                //
    AV_CODEC_ID_MP3ADU,                              //
    AV_CODEC_ID_MP3ON4,                              //
    AV_CODEC_ID_SHORTEN,                             //
    AV_CODEC_ID_ALAC,                                //
    AV_CODEC_ID_WESTWOOD_SND1,                       //
    AV_CODEC_ID_GSM,                                 //
    AV_CODEC_ID_QDM2,                                //
    AV_CODEC_ID_COOK,                                //
    AV_CODEC_ID_TRUESPEECH,                          //
    AV_CODEC_ID_TTA,                                 //
    AV_CODEC_ID_SMACKAUDIO,                          //
    AV_CODEC_ID_QCELP,                               //
    AV_CODEC_ID_WAVPACK,                             //
    AV_CODEC_ID_DSICINAUDIO,                         //
    AV_CODEC_ID_IMC,                                 //
    AV_CODEC_ID_MUSEPACK7,                           //
    AV_CODEC_ID_MLP,                                 //
    AV_CODEC_ID_GSM_MS,                              //
    AV_CODEC_ID_ATRAC3,                              //
    AV_CODEC_ID_APE,                                 //
    AV_CODEC_ID_NELLYMOSER,                          //
    AV_CODEC_ID_MUSEPACK8,                           //
    AV_CODEC_ID_SPEEX,                               //
    AV_CODEC_ID_WMAVOICE,                            //
    AV_CODEC_ID_WMAPRO,                              //
    AV_CODEC_ID_WMALOSSLESS,                         //
    AV_CODEC_ID_ATRAC3P,                             //
    AV_CODEC_ID_EAC3,                                //
    AV_CODEC_ID_SIPR,                                //
    AV_CODEC_ID_MP1,                                 //
    AV_CODEC_ID_TWINVQ,                              //
    AV_CODEC_ID_TRUEHD,                              //
    AV_CODEC_ID_MP4ALS,                              //
    AV_CODEC_ID_ATRAC1,                              //
    AV_CODEC_ID_BINKAUDIO_RDFT,                      //
    AV_CODEC_ID_BINKAUDIO_DCT,                       //
    AV_CODEC_ID_AAC_LATM,                            //
    AV_CODEC_ID_QDMC,                                //
    AV_CODEC_ID_CELT,                                //
    AV_CODEC_ID_G723_1,                              //
    AV_CODEC_ID_G729,                                //
    AV_CODEC_ID_8SVX_EXP,                            //
    AV_CODEC_ID_8SVX_FIB,                            //
    AV_CODEC_ID_BMV_AUDIO,                           //
    AV_CODEC_ID_RALF,                                //
    AV_CODEC_ID_IAC,                                 //
    AV_CODEC_ID_ILBC,                                //
    AV_CODEC_ID_OPUS,                                //
    AV_CODEC_ID_COMFORT_NOISE,                       //
    AV_CODEC_ID_TAK,                                 //
    AV_CODEC_ID_PAF_AUDIO,                           //
    AV_CODEC_ID_ON2AVC,                              //
    AV_CODEC_ID_DSS_SP,                              //
    AV_CODEC_ID_CODEC2,                              //
    AV_CODEC_ID_FFWAVESYNTH = $15800,                //
    AV_CODEC_ID_SONIC,                               //
    AV_CODEC_ID_SONIC_LS,                            //
    AV_CODEC_ID_EVRC,                                //
    AV_CODEC_ID_SMV,                                 //
    AV_CODEC_ID_DSD_LSBF,                            //
    AV_CODEC_ID_DSD_MSBF,                            //
    AV_CODEC_ID_DSD_LSBF_PLANAR,                     //
    AV_CODEC_ID_DSD_MSBF_PLANAR,                     //
    AV_CODEC_ID_4GV,                                 //
    AV_CODEC_ID_INTERPLAY_ACM,                       //
    AV_CODEC_ID_XMA1,                                //
    AV_CODEC_ID_XMA2,                                //
    AV_CODEC_ID_DST,                                 //
    AV_CODEC_ID_ATRAC3AL,                            //
    AV_CODEC_ID_ATRAC3PAL,                           //
    AV_CODEC_ID_DOLBY_E,                             //
    AV_CODEC_ID_APTX,                                //
    AV_CODEC_ID_APTX_HD,                             //
    AV_CODEC_ID_SBC,                                 //
    AV_CODEC_ID_FIRST_SUBTITLE = $17000,             //
    AV_CODEC_ID_DVD_SUBTITLE = $17000,               //
    AV_CODEC_ID_DVB_SUBTITLE,                        //
    AV_CODEC_ID_TEXT,                                //
    AV_CODEC_ID_XSUB,                                //
    AV_CODEC_ID_SSA,                                 //
    AV_CODEC_ID_MOV_TEXT,                            //
    AV_CODEC_ID_HDMV_PGS_SUBTITLE,                   //
    AV_CODEC_ID_DVB_TELETEXT,                        //
    AV_CODEC_ID_SRT,                                 //
    AV_CODEC_ID_MICRODVD = $17800,                   //
    AV_CODEC_ID_EIA_608,                             //
    AV_CODEC_ID_JACOSUB,                             //
    AV_CODEC_ID_SAMI,                                //
    AV_CODEC_ID_REALTEXT,                            //
    AV_CODEC_ID_STL,                                 //
    AV_CODEC_ID_SUBVIEWER1,                          //
    AV_CODEC_ID_SUBVIEWER,                           //
    AV_CODEC_ID_SUBRIP,                              //
    AV_CODEC_ID_WEBVTT,                              //
    AV_CODEC_ID_MPL2,                                //
    AV_CODEC_ID_VPLAYER,                             //
    AV_CODEC_ID_PJS,                                 //
    AV_CODEC_ID_ASS,                                 //
    AV_CODEC_ID_HDMV_TEXT_SUBTITLE,                  //
    AV_CODEC_ID_FIRST_UNKNOWN = $18000,              //
    AV_CODEC_ID_TTF = $18000,                        //
    AV_CODEC_ID_SCTE_35,                             //
    AV_CODEC_ID_BINTEXT = $18800,                    //
    AV_CODEC_ID_XBIN,                                //
    AV_CODEC_ID_IDF,                                 //
    AV_CODEC_ID_OTF,                                 //
    AV_CODEC_ID_SMPTE_KLV,                           //
    AV_CODEC_ID_DVD_NAV,                             //
    AV_CODEC_ID_TIMED_ID3,                           //
    AV_CODEC_ID_BIN_DATA,                            //
    AV_CODEC_ID_PROBE = $19000,                      //
    AV_CODEC_ID_MPEG2TS = $20000,                    //
    AV_CODEC_ID_MPEG4SYSTEMS = $20001,               //
    AV_CODEC_ID_FFMETADATA = $21000,                 //
    AV_CODEC_ID_WRAPPED_AVFRAME = $21001);

  TAVDiscard = (             //
    AVDISCARD_NONE = -16,    //
    AVDISCARD_DEFAULT = 0,   //
    AVDISCARD_NONREF = 8,    //
    AVDISCARD_BIDIR = 16,    //
    AVDISCARD_NONINTRA = 24, //
    AVDISCARD_NONKEY = 32,   //
    AVDISCARD_ALL = 48       //
    );

  TAVPacketSideDataType = (                 //
    AV_PKT_DATA_PALETTE,                    //
    AV_PKT_DATA_NEW_EXTRADATA,              //
    AV_PKT_DATA_PARAM_CHANGE,               //
    AV_PKT_DATA_H263_MB_INFO,               //
    AV_PKT_DATA_REPLAYGAIN,                 //
    AV_PKT_DATA_DISPLAYMATRIX,              //
    AV_PKT_DATA_STEREO3D,                   //
    AV_PKT_DATA_AUDIO_SERVICE_TYPE,         //
    AV_PKT_DATA_QUALITY_STATS,              //
    AV_PKT_DATA_FALLBACK_TRACK,             //
    AV_PKT_DATA_CPB_PROPERTIES,             //
    AV_PKT_DATA_SKIP_SAMPLES,               //
    AV_PKT_DATA_JP_DUALMONO,                //
    AV_PKT_DATA_STRINGS_METADATA,           //
    AV_PKT_DATA_SUBTITLE_POSITION,          //
    AV_PKT_DATA_MATROSKA_BLOCKADDITIONAL,   //
    AV_PKT_DATA_WEBVTT_IDENTIFIER,          //
    AV_PKT_DATA_WEBVTT_SETTINGS,            //
    AV_PKT_DATA_METADATA_UPDATE,            //
    AV_PKT_DATA_MPEGTS_STREAM_ID,           //
    AV_PKT_DATA_MASTERING_DISPLAY_METADATA, //
    AV_PKT_DATA_SPHERICAL,                  //
    AV_PKT_DATA_CONTENT_LIGHT_LEVEL,        //
    AV_PKT_DATA_A53_CC,                     //
    AV_PKT_DATA_NB);

  TAVPacketSideData = record
    data: PByte;
    size: cint;
    type_: TAVPacketSideDataType;
  end;

  TCodecType = TAVMediaType;

  TAVFieldOrder = (       //
    AV_FIELD_UNKNOWN,     //
    AV_FIELD_PROGRESSIVE, //
    AV_FIELD_TT,          //
    AV_FIELD_BB,          //
    AV_FIELD_TB,          //
    AV_FIELD_BT           //
    );

  TAVCodecParameters = record
    codec_type: TAVMediaType;
    codec_id: TAVCodecID;
    codec_tag: cuint32;
    extradata: Pcuint8;
    extradata_size: cint;
    format: cint;
    bit_rate: cint64;
    bits_per_coded_sample: cint;
    bits_per_raw_sample: cint;
    profile: cint;
    level: cint;
    width: cint;
    height: cint;
    sample_aspect_ratio: TAVRational;
    field_order: TAVFieldOrder;
    color_range: TAVColorRange;
    color_primaries: TAVColorPrimaries;
    color_trc: TAVColorTransferCharacteristic;
    color_space: TAVColorSpace;
    chroma_location: TAVChromaLocation;
    video_delay: cint;
    channel_layout: cuint64;
    channels: cint;
    sample_rate: cint;
    block_align: cint;
    frame_size: cint;
    initial_padding: cint;
    trailing_padding: cint;
    seek_preroll: cint;
  end;

  TAVCodecParserContext = record
    priv_data: pointer;
    parser: PAVCodecParser;
    frame_offset: cint64;
    cur_offset: cint64;
    next_frame_offset: cint64;
    pict_type: cint;
    repeat_pict: cint;
    pts: cint64;
    dts: cint64;
    last_pts: cint64;
    last_dts: cint64;
    fetch_timestamp: cint;
    cur_frame_start_index: cint;
    cur_frame_offset: array [0 .. AV_PARSER_PTS_NB - 1] of cint64;
    cur_frame_pts: array [0 .. AV_PARSER_PTS_NB - 1] of cint64;
    cur_frame_dts: array [0 .. AV_PARSER_PTS_NB - 1] of cint64;
    flags: cint;
    offset: cint64;
    cur_frame_end: array [0 .. AV_PARSER_PTS_NB - 1] of cint64;
    key_frame: cint;
{$IFDEF FF_API_CONVERGENCE_DURATION}
    convergence_duration: cint64;
{$ENDIF}
    dts_sync_point: cint;
    dts_ref_dts_delta: cint;
    pts_dts_delta: cint;
    cur_frame_pos: array [0 .. AV_PARSER_PTS_NB - 1] of cint64;
    pos: cint64;
    last_pos: cint64;
    duration: cint;
    field_order: TAVFieldOrder;
    picture_structure: TAVPictureStructure;
    output_picture_number: cint;
    width: cint;
    height: cint;
    coded_width: cint;
    format: cint;
  end;

  TExecuteFunc  = function(c2: PAVCodecContext; arg: pointer)                              : cint; cdecl;
  TExecute2Func = function(c2: PAVCodecContext; arg: pointer; jobnr: cint; threadnr: cint): cint; cdecl;

  TAVCodecContext = record
    av_class: PAVClass;
    log_level_offset: cint;
    codec_type: TAVMediaType;
    codec: PAVCodec;
    codec_id: TAVCodecID;
    codec_tag: cuint;
    priv_data: pointer;
    internal: PAVCodecInternal;
    opaque: pointer;
    bit_rate: cint64;
    bit_rate_tolerance: cint;
    global_quality: cint;
    compression_level: cint;
    flags: cint;
    flags2: cint;
    extradata: PByte;
    extradata_size: cint;
    time_base: TAVRational;
    ticks_per_frame: cint;
    delay: cint;
    width, height: cint;
    coded_width, coded_height: cint;
    gop_size: cint;
    pix_fmt: TAVPixelFormat;
    draw_horiz_band: procedure(s: PAVCodecContext; src: PAVFrame; offset: PAVNDPArray; y: cint; type_: cint; height: cint); cdecl;
    get_format: function(s: PAVCodecContext; fmt: PAVPixelFormat): TAVPixelFormat; cdecl;
    max_b_frames: cint;
    b_quant_factor: cfloat;
{$IFDEF FF_API_PRIVATE_OPT}
    b_frame_strategy: cint;
{$ENDIF}
    b_quant_offset: cfloat;
    has_b_frames: cint;
{$IFDEF FF_API_PRIVATE_OPT}
    mpeg_quant: cint;
{$ENDIF}
    i_quant_factor: cfloat;
    i_quant_offset: cfloat;
    lumi_masking: cfloat;
    temporal_cplx_masking: cfloat;
    spatial_cplx_masking: cfloat;
    p_masking: cfloat;
    dark_masking: cfloat;
    slice_count: cint;
{$IFDEF FF_API_PRIVATE_OPT}
    prediction_method: cint;
{$ENDIF}
    slice_offset: PCint;
    sample_aspect_ratio: TAVRational;
    me_cmp: cint;
    me_sub_cmp: cint;
    mb_cmp: cint;
    ildct_cmp: cint;
    dia_size: cint;
    last_predictor_count: cint;
{$IFDEF FF_API_PRIVATE_OPT}
    pre_me: cint;
{$ENDIF}
    me_pre_cmp: cint;
    pre_dia_size: cint;
    me_subpel_quality: cint;
{$IFDEF FF_API_AFD}
    dtg_active_format: cint;
{$IFEND}
    me_range: cint;
    slice_flags: cint;
    mb_decision: cint;
    intra_matrix: PWord;
    inter_matrix: PWord;
{$IFDEF FF_API_PRIVATE_OPT}
    scenechange_threshold: cint;
    noise_reduction: cint;
{$ENDIF}
    intra_dc_precision: cint;
    skip_top: cint;
    skip_bottom: cint;
    mb_lmin: cint;
    mb_lmax: cint;
{$IFDEF FF_API_PRIVATE_OPT}
    me_penalty_compensation: cint;
{$ENDIF}
    bidir_refine: cint;
{$IFDEF FF_API_PRIVATE_OPT}
    brd_scale: cint;
{$ENDIF}
    keyint_min: cint;
    refs: cint;
{$IFDEF FF_API_PRIVATE_OPT}
    chromaoffset: cint;
{$ENDIF}
    mv0_threshold: cint;
{$IFDEF FF_API_PRIVATE_OPT}
    b_sensitivity: cint;
{$ENDIF}
    color_primaries: TAVColorPrimaries;
    color_trc: TAVColorTransferCharacteristic;
    colorspace: TAVColorSpace;
    color_range: TAVColorRange;
    chroma_sample_location: TAVChromaLocation;
    slices: cint;
    field_order: TAVFieldOrder;
    sample_rate: cint;
    channels: cint;
    sample_fmt: TAVSampleFormat;
    frame_size: cint;
    frame_number: cint;
    block_align: cint;
    cutoff: cint;
    channel_layout: cuint64;
    request_channel_layout: cuint64;
    audio_service_type: TAVAudioServiceType;
    request_sample_fmt: TAVSampleFormat;
    get_buffer2: function(s: PAVCodecContext; frame: PAVFrame; flags: cint): cint; cdecl;
    refcounted_frames: cint;
    qcompress: cfloat;
    qblur: cfloat;
    qmin: cint;
    qmax: cint;
    max_qdiff: cint;
    rc_buffer_size: cint;
    rc_override_count: cint;
    rc_override: PRcOverride;
    rc_max_rate: cint64;
    rc_min_rate: cint64;
    rc_max_available_vbv_use: cfloat;
    rc_min_vbv_overflow_use: cfloat;
    rc_initial_buffer_occupancy: cint;
{$IFDEF FF_API_CODER_TYPE}
    coder_type: cint;
{$ENDIF}
{$IFDEF FF_API_PRIVATE_OPT}
    context_model: cint;
{$ENDIF}
{$IFDEF FF_API_PRIVATE_OPT}
    frame_skip_threshold: cint;
    frame_skip_factor: cint;
    frame_skip_exp: cint;
    frame_skip_cmp: cint;
{$ENDIF}
    trellis: cint;
{$IFDEF FF_API_PRIVATE_OPT}
    min_prediction_order: cint;
    max_prediction_order: cint;
    timecode_frame_start: cint64;
{$ENDIF}
{$IFDEF FF_API_RTP_CALLBACK}
    rtp_callback: procedure(avctx: PAVCodecContext; data: pointer; size: cint; mb_nb: cint); cdecl;
{$ENDIF}
{$IFDEF FF_API_PRIVATE_OPT}
    rtp_payload_size: cint;
{$ENDIF}
{$IFDEF FF_API_STAT_BITS}
    mv_bits: cint;
    header_bits: cint;
    i_tex_bits: cint;
    p_tex_bits: cint;
    i_count: cint;
    p_count: cint;
    skip_count: cint;
    misc_bits: cint;
    frame_bits: cint;
{$ENDIF}
    stats_out: PAnsiChar;
    stats_in: PAnsiChar;
    workaround_bugs: cint;
    strict_std_compliance: cint;
    error_concealment: cint;
    debug: cint;
{$IFDEF FF_API_DEBUG_MV}
    debug_mv: cint;
{$ENDIF}
    err_recognition: cint;
    reordered_opaque: cint64;
    hwaccel: PAVHWAccel;
    hwaccel_context: pointer;
    error: array [0 .. AV_NUM_DATA_POINTERS - 1] of cuint64;
    dct_algo: cint;
    idct_algo: cint;
    bits_per_coded_sample: cint;
    bits_per_raw_sample: cint;
{$IFDEF FF_API_LOWRES}
    lowres: cint;
{$ENDIF}
{$IFDEF FF_API_CODED_FRAME}
    coded_frame: PAVFrame;
{$ENDIF}
    thread_count: cint;
    thread_type: cint;
    active_thread_type: cint;
    thread_safe_callbacks: cint;
    execute: function(c: PAVCodecContext; func: TExecuteFunc; arg: pointer; ret: PCint; count: cint; size: cint): cint; cdecl;
    execute2: function(c: PAVCodecContext; func: TExecute2Func; arg2: pointer; ret: PCint; count: cint): cint; cdecl;
    nsse_weight: cint;
    profile: cint;
    level: cint;
    skip_loop_filter: TAVDiscard;
    skip_idct: TAVDiscard;
    skip_frame: TAVDiscard;
    subtitle_header: Pcuint8;
    subtitle_header_size: cint;
{$IFDEF FF_API_VBV_DELAY}
    vbv_delay: cuint64;
{$ENDIF}
{$IFDEF FF_API_SIDEDATA_ONLY_PKT}
    side_data_only_packets: cint;
{$ENDIF}
    initial_padding: cint;
    framerate: TAVRational;
    sw_pix_fmt: TAVPixelFormat;
    pkt_timebase: TAVRational;
    codec_descriptor: PAVCodecDescriptor;
{$IFNDEF FF_API_LOWRES}
    lowres: cint;
{$ENDIF}
    pts_correction_num_faulty_pts: cint64;
    pts_correction_num_faulty_dts: cint64;
    pts_correction_last_pts: cint64;
    pts_correction_last_dts: cint64;
    sub_charenc: PAnsiChar;
    sub_charenc_mode: cint;
    skip_alpha: cint;
    seek_preroll: cint;
{$IFNDEF FF_API_DEBUG_MV}
    debug_mv: cint;
{$ENDIF}
    chroma_intra_matrix: PWord;
    dump_separator: Pcuint8;
    codec_whitelist: PAnsiChar;
    properties: cuint;
    coded_side_data: PAVPacketSideData;
    nb_coded_side_data: cint;
    hw_frames_ctx: PAVBufferRef;
    sub_text_format: cint;
    trailing_padding: cint;
    max_pixels: cint64;
    hw_device_ctx: PAVBufferRef;
    hwaccel_flags: cint;
    apply_cropping: cint;
    extra_hw_frames: cint;
  end;

  TAVCodecParser = record
    codec_ids: array [0 .. 4] of cint;
    priv_data_size: cint;
    parser_init: function(s: PAVCodecParserContext): cint; cdecl;
    parser_parse: function(s: PAVCodecParserContext; avctx: PAVCodecContext; poutbuf: PPointer; poutbuf_size: PCint; buf: PByteArray; buf_size: cint): cint; cdecl;
    parser_close: procedure(s: PAVCodecParserContext); cdecl;
    split: function(avctx: PAVCodecContext; buf: PByteArray; buf_size: cint): cint; cdecl;
    next: PAVCodecParser;
  end;

  TAVCodec = record
    name: PAnsiChar;
    long_name: PAnsiChar;
    type_: TAVMediaType;
    id: TAVCodecID;
    capabilities: cint;
    supported_framerates: PAVRational;
    pix_fmts: PAVPixelFormat;
    supported_samplerates: PCint;
    sample_fmts: PAVSampleFormatArray;
    channel_layouts: PCuint64;
    max_lowres: byte;
    priv_class: PAVClass;
    profiles: PAVProfile;
    wrapper_name: PAnsiChar;
    priv_data_size: cint;
    next: PAVCodec;
    init_thread_copy: function(avctx: PAVCodecContext): PCint; cdecl;
    update_thread_context: function(dst: PAVCodecContext; src: PAVCodecContext): cint; cdecl;
    defaults: pointer;
    init_static_data: procedure(codec: PAVCodec); cdecl;
    init: function(avctx: PAVCodecContext): cint; cdecl;
    encode_sub: function(avctx: PAVCodecContext; buf: PByteArray; buf_size: cint; sub: PAVSubtitle): cint; cdecl;
    encode2: function(avctx: PAVCodecContext; avpkt: PAVPacket; frame: PAVFrame; got_packet_ptr: PCint): cint; cdecl;
    decode: function(avctx: PAVCodecContext; outdata: pointer; var outdata_size: cint; avpkt: PAVPacket): cint; cdecl;
    close: function(avctx: PAVCodecContext): cint; cdecl;
    send_frame: function(avctx: PAVCodecContext; frame: PAVFrame): cint; cdecl;
    receive_packet: function(avctx: PAVCodecContext; avpkt: PAVPacket): cint; cdecl;
    receive_frame: function(avctx: PAVCodecContext; frame: PAVFrame): cint; cdecl;
    flush: procedure(avctx: PAVCodecContext); cdecl;
    caps_internal: cint;
    bsfs: PAnsiChar;
    hw_configs: PPointer;
  end;

  TAVProfile = record
    profile: cint;
    name: PAnsiChar;
  end;

  TAVSubtitle = record
    format: cuint16;
    start_display_time: cuint32;
    end_display_time: cuint32;
    num_rects: cuint;
    rects: PPAVSubtitleRect;
    pts: cint64;
  end;

  TAVSubtitleType = ( //
    SUBTITLE_NONE,    //
    SUBTITLE_BITMAP,  //
    SUBTITLE_TEXT,    //
    SUBTITLE_ASS      //
    );

  TAVSubtitleRect = record
    x: cint;
    y: cint;
    w: cint;
    h: cint;
    nb_colors: cint;
{$IFDEF FF_API_AVPICTURE}
    pict: TAVPicture;
{$ENDIF}
    data: Array [0 .. 4] of PByte;
    linesize: Array [0 .. 4] of cint;
    type_: TAVSubtitleType;
    text: PAnsiChar;
    ass: PAnsiChar;
    flags: cint;
  end;

  TAVHWAccel = record
    name: PAnsiChar;
    type_: TAVMediaType;
    id: TAVCodecID;
    pix_fmt: PAVPixelFormat;
    capabilities: cint;
    alloc_frame: function(avctx: PAVCodecContext; frame: PAVFrame): cint; cdecl;
    start_frame: function(avctx: PAVCodecContext; buf: { const } PByteArray; buf_size: cuint): cint; cdecl;
    decode_params: function(avctx: PAVCodecContext; type_: cint; buf: Pcuint8 { const }; buf_size: cuint32): PCint;
    decode_slice: function(avctx: PAVCodecContext; buf: { const } PByteArray; buf_size: cuint): cint; cdecl;
    end_frame: function(avctx: PAVCodecContext): cint; cdecl;
    frame_priv_data_size: cint;
    decode_mb: procedure(s: PMpegEncContext); cdecl;
    init: function(avctx: PAVCodecContext): cint; cdecl;
    uninit: function(avctx: PAVCodecContext): cint; cdecl;
    priv_data_size: cint;
    caps_internal: cint;
    frame_params: function(avctx: PAVCodecContext; hw_frames_ctx: PAVBufferRef): PCint;
  end;

  TAVCodecDescriptor = record
    id: TAVCodecID;
    type_: TAVMediaType;
    name: PAnsiChar;
    long_name: PAnsiChar;
    props: cint;
    mime_types: PAnsiChar;
    profiles: PAVProfile;
  end;

  TAVBSFList = record
  end;

  TAVBitStreamFilterContext = Record
    priv_data: pointer;
    filter: PAVBitStreamFilter;
    parser: PAVCodecParserContext;
    next: PAVBitStreamFilterContext;
    args: Pchar;
  End;

  TAVBitStreamFilter = record
    name: PAnsiChar;
    codec_ids: PAVCodecID;
    priv_class: PAVClass;
    priv_data_size: cint;
    init: function(ctx: PAVBSFContext): cint; cdecl;
    filter: function(ctx: PAVBSFContext; pkt: PAVPacket): cint; cdecl;
    close: procedure(ctx: PAVBSFContext); cdecl;
  end;

  TAVBSFInternal = record
  end;

  TAVBSFContext = record
    av_class: PAVClass;
    filter: PAVBitStreamFilter;
    internal: PAVBSFInternal;
    priv_data: pointer;
    par_in: PAVCodecParameters;
    par_out: PAVCodecParameters;
    time_base_in: TAVRational;
    time_base_out: TAVRational;
  end;

  TAVCPBProperties = record
    max_bitrate: cint;
    min_bitrate: cint;
    avg_bitrate: cint;
    buffer_size: cint;
    vbv_delay: cuint64;
  end;

  TAVPicture = record
    data: array [0 .. AV_NUM_DATA_POINTERS - 1] of PByteArray;
    linesize: array [0 .. AV_NUM_DATA_POINTERS - 1] of cint;
  end;

  TAVCodecHWConfig = record
    pix_fmt: TAVPixelFormat;
    methods: cint;
    device_type: pointer;
  end;

  PID3D11VideoDecoder            = ^ID3D11VideoDecoder;
  PID3D11VideoContext            = ^ID3D11VideoContext;
  PID3D11VideoDecoderOutputView  = ^ID3D11VideoDecoderOutputView;
  PPID3D11VideoDecoderOutputView = ^PID3D11VideoDecoderOutputView;

  TAVD3D11VAContext = record
    decoder: PID3D11VideoDecoder;
    video_context: PID3D11VideoContext;
    cfg: PD3D11_VIDEO_DECODER_CONFIG;
    surface_count: unsigned;
    surface: PPID3D11VideoDecoderOutputView;
    workaround: uint64_t;
    report_id: unsigned;
    context_mutex: THandle;
  end;

  PDCTContext  = ^DCTContext;
  PFFTSample   = ^FFTSample;
  FFTSample    = float;
  PRDFTContext = ^RDFTContext;
  PFFTComplex  = ^FFTComplex;

  FFTComplex = record
    re, im: FFTSample;
  end;

  FFTContext = record
    nbits: Int;
    inverse: Int;
    revtab: pcuint16;
    tmp_buf: PFFTComplex;
    mdct_size: Int;
    mdct_bits: Int;
    tcos: PFFTSample;
    tsin: PFFTSample;
  end;

  RDFTContext = record
    nbits: Int;
    inverse: Int;
    sign_convention: Int;
    tcos: PFFTSample;
    tsin: PFFTSample;
    negative_sin: Int;
    fft: FFTContext;
    rdft_calc: function(s: PRDFTContext; z: PFFTSample): pointer; cdecl;
  end;

  DCTContext = record
    nbits: Int;
    inverse: Int;
    rdft: RDFTContext;
    costab: float;
    csc2: PFFTSample;
    dct_calc: function(s: PDCTContext; data: PFFTSample): pointer; cdecl;
    dct32: function(_out: FFTSample; const _in: PFFTSample): pointer; cdecl;
  end;

  DCTTransformType = ( //
    DCT_II = 0,        //
    DCT_III,           //
    DCT_I,             //
    DST_I              //
    );

{$IFDEF  FF_API_OLD_BSF}
function av_ac3_parse_header(const buf: puint8_t; size: size_t; bitstream_id: puint8_t; frame_size: pcuint16): integer; cdecl; external c_strFFmpegDllX64Name;
function av_adts_header_parse(const buf: puint8_t; samples: pcuint32; frames: puint8_t): integer; cdecl; external c_strFFmpegDllX64Name;
procedure av_bitstream_filter_close(bsf: PAVBitStreamFilterContext); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_bitstream_filter_filter(bsfc: PAVBitStreamFilterContext; avctx: PAVCodecContext; const args: PAnsiChar; poutbuf: ppuint8_t; poutbuf_size: PInteger; const buf: puint8_t; bufsize: integer; keyframe: integer); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure AVBitStreamFilterContext(const name: PAnsiChar); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_bitstream_filter_next(const f: PAVBitStreamFilter); cdecl; external c_strFFmpegDllX64Name; deprecated;
{$ENDIF}
function av_bsf_alloc(filter: PAVBitStreamFilter; ctx: PPAVBSFContext): cint; cdecl; external c_strFFmpegDllX64Name;
procedure av_bsf_free(ctx: PPAVBSFContext); cdecl; external c_strFFmpegDllX64Name;
function av_bsf_get_by_name(name: PAnsiChar): PAVBitStreamFilter; cdecl; external c_strFFmpegDllX64Name;
function av_bsf_get_class(): PAVClass; cdecl; external c_strFFmpegDllX64Name;
function av_bsf_get_null_filter(bsf: PPAVBSFContext): cint; cdecl; external c_strFFmpegDllX64Name;
function av_bsf_init(ctx: PAVBSFContext): cint; cdecl; external c_strFFmpegDllX64Name;
function av_bsf_iterate(opaque: pointer): PAVBitStreamFilter; cdecl; external c_strFFmpegDllX64Name;
function av_bsf_list_alloc(): PAVBSFList; cdecl; external c_strFFmpegDllX64Name;
function av_bsf_list_append(lst: PAVBSFList; bsf: PAVBSFContext): cint; cdecl; external c_strFFmpegDllX64Name;
function av_bsf_list_append2(lst: PAVBSFList; bsf_name: Pcchar; options: PPAVDictionary): cint; cdecl; external c_strFFmpegDllX64Name;
function av_bsf_list_finalize(lst: PPAVBSFList; bsf: PPAVBSFContext): cint; cdecl; external c_strFFmpegDllX64Name;
procedure av_bsf_list_free(lst: PPAVBSFList); cdecl; external c_strFFmpegDllX64Name;
function av_bsf_list_parse_str(str: Pcchar; bsf: PPAVBSFContext): cint; cdecl; external c_strFFmpegDllX64Name;
function av_bsf_next(opaque: pointer): PAVBitStreamFilter; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_bsf_receive_packet(ctx: PAVBSFContext; pkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name;
function av_bsf_send_packet(ctx: PAVBSFContext; pkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name;
function av_codec_get_chroma_intra_matrix(avctx: PAVCodecContext): PWord; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_codec_get_codec_descriptor(avctx: PAVCodecContext): PAVCodecDescriptor; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_codec_get_codec_properties(avctx: PAVCodecContext): cuint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_codec_get_lowres(avctx: PAVCodecContext): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_codec_get_max_lowres(codec: PAVCodec): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_codec_get_pkt_timebase(avctx: PAVCodecContext): TAVRational; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_codec_get_seek_preroll(avctx: PAVCodecContext): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_codec_is_decoder(codec: PAVCodec): cint; cdecl; external c_strFFmpegDllX64Name;
function av_codec_is_encoder(codec: PAVCodec): cint; cdecl; external c_strFFmpegDllX64Name;
function av_codec_iterate(opaque: pointer): PAVCodec; cdecl; external c_strFFmpegDllX64Name;
function av_codec_next(c: PAVCodec): PAVCodec; cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_codec_set_chroma_intra_matrix(avctx: PAVCodecContext; val: PWord); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_codec_set_codec_descriptor(avctx: PAVCodecContext; desc: PAVCodecDescriptor); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_codec_set_lowres(avctx: PAVCodecContext; val: cint); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_codec_set_pkt_timebase(avctx: PAVCodecContext; val: TAVRational); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_codec_set_seek_preroll(avctx: PAVCodecContext; val: cint); cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_copy_packet(dst: PAVPacket; src: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_copy_packet_side_data(dst: PAVPacket; src: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_cpb_properties_alloc(size: Psize_t): PAVCPBProperties; cdecl; external c_strFFmpegDllX64Name;
function av_d3d11va_alloc_context(): PAVD3D11VAContext; cdecl; external c_strFFmpegDllX64Name;
procedure av_dct_calc(s: PDCTContext; data: PFFTSample); cdecl; external c_strFFmpegDllX64Name;
procedure av_dct_end(s: PDCTContext); cdecl; external c_strFFmpegDllX64Name;
function av_dct_init(nbits: integer; _type: DCTTransformType): PDCTContext; cdecl; external c_strFFmpegDllX64Name;

// DCTContext *av_dct_init(int nbits, enum DCTTransformType type);

function av_audio_convert_alloc(out_fmt: TAVSampleFormat; out_channels: cint; in_fmt: TAVSampleFormat; in_channels: cint; matrix: Pcfloat; flags: cint): PAVAudioConvert; cdecl; external c_strFFmpegDllX64Name;
function av_bitstream_filter_filter(bsfc: PAVBitStreamFilterContext; avctx: PAVCodecContext; args: PAnsiChar; poutbuf: PPointer; poutbuf_size: PCint; buf: PByte; buf_size: cint; keyframe: cint): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_bitstream_filter_init(name: PAnsiChar): PAVBitStreamFilterContext; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_bitstream_filter_next(f: PAVBitStreamFilter): PAVBitStreamFilter; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_channel_layout_extract_channel(channel_layout: cuint64; index: cint): cuint64; cdecl; external c_strFFmpegDllX64Name;
function av_dup_packet(pkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_get_audio_frame_duration(avctx: PAVCodecContext; frame_bytes: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_get_audio_frame_duration2(par: PAVCodecParameters; frame_bytes: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_get_bits_per_sample(codec_id: TAVCodecID): cint; cdecl; external c_strFFmpegDllX64Name;
function av_get_channel_description(channel: cuint64): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_get_channel_layout(name: PAnsiChar): cuint64; cdecl; external c_strFFmpegDllX64Name;
function av_get_channel_layout_channel_index(channel_layout: cuint64; channel: cuint64): cint; cdecl; external c_strFFmpegDllX64Name;
function av_get_channel_layout_nb_channels(channel_layout: cuint64): cint; cdecl; external c_strFFmpegDllX64Name;
function av_get_channel_name(channel: cuint64): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_get_codec_tag_string(buf: PAnsiChar; buf_size: size_t; codec_tag: cuint): size_t; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_get_default_channel_layout(nb_channels: cint): cint64; cdecl; external c_strFFmpegDllX64Name;
function av_get_exact_bits_per_sample(codec_id: TAVCodecID): cint; cdecl; external c_strFFmpegDllX64Name;
function av_get_pcm_codec(fmt: TAVSampleFormat; be: cint): TAVCodecID; cdecl; external c_strFFmpegDllX64Name;
function av_get_profile_name(codec: PAVCodec; profile: cint): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_get_standard_channel_layout(index: cuint; layout: PCuint64; name: PPAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function av_grow_packet(pkt: PAVPacket; grow_by: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_hwaccel_next(hwaccel: PAVHWAccel): PAVHWAccel; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_new_packet(pkt: PAVPacket; size: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_packet_add_side_data(pkt: PAVPacket; type_: TAVPacketSideDataType; data: Pcuint8; size: size_t): cint; cdecl; external c_strFFmpegDllX64Name;
function av_packet_alloc(): PAVPacket; cdecl; external c_strFFmpegDllX64Name;
function av_packet_clone(src: PAVPacket): PAVPacket; cdecl; external c_strFFmpegDllX64Name;
function av_packet_copy_props(dst: PAVPacket; src: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name;
function av_packet_from_data(pkt: PAVPacket; data: PByte; size: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_packet_get_side_data(pkt: PAVPacket; type_: TAVPacketSideDataType; size: PCint): PByte; cdecl; external c_strFFmpegDllX64Name;
function av_packet_make_refcounted(pkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name;
function av_packet_make_writable(pkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name;
function av_packet_merge_side_data(pkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_packet_new_side_data(pkt: PAVPacket; type_: TAVPacketSideDataType; size: cint): PByte; cdecl; external c_strFFmpegDllX64Name;
function av_packet_pack_dictionary(dict: PAVDictionary; size: PCuint): PByte; cdecl; external c_strFFmpegDllX64Name;
function av_packet_ref(dst: PAVPacket; src: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name;
function av_packet_shrink_side_data(pkt: PAVPacket; type_: TAVPacketSideDataType; size: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_packet_side_data_name(type_: TAVPacketSideDataType): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_packet_split_side_data(pkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_packet_unpack_dictionary(data: PByte; size: cint; dict: PPAVDictionary): cint; cdecl; external c_strFFmpegDllX64Name;
function av_parser_change(s: PAVCodecParserContext; avctx: PAVCodecContext; poutbuf: PPointer; poutbuf_size: PCint; buf: PByteArray; buf_size: cint; keyframe: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_parser_init(codec_id: cint): PAVCodecParserContext; cdecl; external c_strFFmpegDllX64Name;
function av_parser_iterate(opaque: pointer): PAVCodecParser; cdecl; external c_strFFmpegDllX64Name;
function av_parser_next(c: PAVCodecParser): PAVCodecParser; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_parser_parse2(s: PAVCodecParserContext; avctx: PAVCodecContext; poutbuf: PPointer; poutbuf_size: PCint; buf: PByteArray; buf_size: cint; pts: cint64; dts: cint64; pos: cint64): cint; cdecl; external c_strFFmpegDllX64Name;
function av_picture_crop(dst: PAVPicture; src: PAVPicture; pix_fmt: TAVPixelFormat; top_band: cint; left_band: cint): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_picture_pad(dst: PAVPicture; src: PAVPicture; height: cint; width: cint; pix_fmt: TAVPixelFormat; padtop: cint; padbottom: cint; padleft: cint; padright: cint; color: PCint): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_xiphlacing(s: PByte; v: cuint): cuint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_alloc_context3(codec: PAVCodec): PAVCodecContext; cdecl; external c_strFFmpegDllX64Name;
function avcodec_close(avctx: PAVCodecContext): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_configuration(): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function avcodec_copy_context(dest: PAVCodecContext; src: PAVCodecContext): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function avcodec_decode_audio4(avctx: PAVCodecContext; frame: PAVFrame; got_frame_ptr: PCint; avpkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function avcodec_decode_subtitle2(avctx: PAVCodecContext; sub: PAVSubtitle; var got_sub_ptr: cint; avpkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_decode_video2(avctx: PAVCodecContext; picture: PAVFrame; var got_picture_ptr: cint; avpkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function avcodec_default_execute(s: PAVCodecContext; func: TExecuteFunc; arg: pointer; var ret: cint; count: cint; size: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_default_execute2(s: PAVCodecContext; func: TExecuteFunc; arg: pointer; var ret: cint; count: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_default_get_buffer2(s: PAVCodecContext; frame: PAVFrame; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_default_get_format(s: PAVCodecContext; fmt: PAVPixelFormat): TAVPixelFormat; cdecl; external c_strFFmpegDllX64Name;
function avcodec_descriptor_get(id: TAVCodecID): PAVCodecDescriptor; cdecl; external c_strFFmpegDllX64Name;
function avcodec_descriptor_get_by_name(name: PAnsiChar): PAVCodecDescriptor; cdecl; external c_strFFmpegDllX64Name;
function avcodec_descriptor_next(prev: PAVCodecDescriptor): PAVCodecDescriptor; cdecl; external c_strFFmpegDllX64Name;
function avcodec_encode_audio2(avctx: PAVCodecContext; avpkt: PAVPacket; frame: PAVFrame; got_packet_ptr: PCint): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function avcodec_encode_subtitle(avctx: PAVCodecContext; buf: PByteArray; buf_size: cint; sub: PAVSubtitle): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_encode_video2(avctx: PAVCodecContext; avpkt: PAVPacket; frame: PAVFrame; got_packet_ptr: PCint): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function avcodec_fill_audio_frame(frame: PAVFrame; nb_channels: cint; sample_fmt: TAVSampleFormat; buf: PByte; buf_size: cint; align: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_find_best_pix_fmt_of_2(dst_pix_fmt1: TAVPixelFormat; dst_pix_fmt2: TAVPixelFormat; src_pix_fmt: TAVPixelFormat; has_alpha: cint; loss_ptr: PCint): TAVPixelFormat; cdecl; external c_strFFmpegDllX64Name;
function avcodec_find_best_pix_fmt_of_list(pix_fmt_list: PAVPixelFormat; src_pix_fmt: TAVPixelFormat; has_alpha: cint; loss_ptr: PCint): TAVPixelFormat; cdecl; external c_strFFmpegDllX64Name;
function avcodec_find_best_pix_fmt2(dst_pix_fmt1: TAVPixelFormat; dst_pix_fmt2: TAVPixelFormat; src_pix_fmt: TAVPixelFormat; has_alpha: cint; loss_ptr: PCint): TAVPixelFormat; cdecl; external c_strFFmpegDllX64Name; deprecated;
function avcodec_find_decoder(id: TAVCodecID): PAVCodec; cdecl; external c_strFFmpegDllX64Name;
function avcodec_find_decoder_by_name(name: PAnsiChar): PAVCodec; cdecl; external c_strFFmpegDllX64Name;
function avcodec_find_encoder(id: TAVCodecID): PAVCodec; cdecl; external c_strFFmpegDllX64Name;
function avcodec_find_encoder_by_name(name: PAnsiChar): PAVCodec; cdecl; external c_strFFmpegDllX64Name;
function avcodec_get_class(): PAVClass; cdecl; external c_strFFmpegDllX64Name;
function avcodec_get_frame_class(): PAVClass; cdecl; external c_strFFmpegDllX64Name;
function avcodec_get_hw_config(codec: PAVCodec; index: cint): PAVCodecHWConfig; cdecl; external c_strFFmpegDllX64Name; deprecated;
function avcodec_get_hw_frames_parameters(avctx: PAVCodecContext; device_ref: PAVBufferRef; hw_pix_fmt: TAVPixelFormat; out_frames_ref: PPAVBufferRef): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_get_name(id: TAVCodecID): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function avcodec_get_pix_fmt_loss(dst_pix_fmt: TAVPixelFormat; src_pix_fmt: TAVPixelFormat; has_alpha: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_get_subtitle_rect_class(): PAVClass; cdecl; external c_strFFmpegDllX64Name;
function avcodec_get_type(codec_id: TAVCodecID): TAVMediaType; cdecl; external c_strFFmpegDllX64Name;
function avcodec_is_open(s: PAVCodecContext): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_license(): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function avcodec_open2(avctx: PAVCodecContext; codec: PAVCodec; options: PPAVDictionary): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_parameters_alloc(): PAVCodecParameters; cdecl; external c_strFFmpegDllX64Name;
function avcodec_parameters_copy(dst: PAVCodecParameters; src: PAVCodecParameters): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_parameters_from_context(par: PAVCodecParameters; codec: PAVCodecContext): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_parameters_to_context(codec: PAVCodecContext; par: PAVCodecParameters): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_pix_fmt_to_codec_tag(pix_fmt: TAVPixelFormat): cuint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_profile_name(codec_id: TAVCodecID; profile: cint): Pchar; cdecl; external c_strFFmpegDllX64Name;
function avcodec_receive_frame(avctx: PAVCodecContext; frame: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_receive_packet(avctx: PAVCodecContext; avpkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_send_frame(avctx: PAVCodecContext; frame: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_send_packet(avctx: PAVCodecContext; avpkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name;
function avcodec_version(): cuint; cdecl; external c_strFFmpegDllX64Name;
function avpicture_alloc(picture: PAVPicture; pix_fmt: TAVPixelFormat; width: cint; height: cint): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function avpicture_fill(picture: PAVPicture; ptr: Pcuint8; pix_fmt: TAVPixelFormat; width: cint; height: cint): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function avpicture_get_size(pix_fmt: TAVPixelFormat; width: cint; height: cint): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function avpicture_layout(src: PAVPicture; pix_fmt: TAVPixelFormat; width: cint; height: cint; dest: PByteArray; dest_size: cint): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_audio_convert_free(ctx: PAVAudioConvert); cdecl; external c_strFFmpegDllX64Name;
procedure av_bitstream_filter_close(bsf: PAVBitStreamFilterContext); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_bprint_channel_layout(bp: PAVBPrint; nb_channels: cint; channel_layout: cuint64); cdecl; external c_strFFmpegDllX64Name;
procedure av_fast_padded_malloc(ptr: pointer; size: PCuint; min_size: size_t); cdecl; external c_strFFmpegDllX64Name;
procedure av_fast_padded_mallocz(ptr: pointer; size: PCuint; min_size: size_t); cdecl; external c_strFFmpegDllX64Name;
procedure av_free_packet(pkt: PAVPacket); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_get_channel_layout_string(buf: PAnsiChar; buf_size: cint; nb_channels: cint; channel_layout: cuint64); cdecl; external c_strFFmpegDllX64Name;
procedure av_init_packet(var pkt: TAVPacket); cdecl; external c_strFFmpegDllX64Name;
procedure av_packet_free(pkt: PPAVPacket); cdecl; external c_strFFmpegDllX64Name;
procedure av_packet_free_side_data(pkt: PAVPacket); cdecl; external c_strFFmpegDllX64Name;
procedure av_packet_move_ref(dst: PAVPacket; src: PAVPacket); cdecl; external c_strFFmpegDllX64Name;
procedure av_packet_rescale_ts(pkt: PAVPacket; tb_src, tb_dst: TAVRational); cdecl; external c_strFFmpegDllX64Name;
procedure av_packet_unref(pkt: PAVPacket); cdecl; external c_strFFmpegDllX64Name;
procedure av_parser_close(s: PAVCodecParserContext); cdecl; external c_strFFmpegDllX64Name;
procedure av_picture_copy(dst: PAVPicture; src: PAVPicture; pix_fmt: TAVPixelFormat; width: cint; height: cint); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_register_bitstream_filter(bsf: PAVBitStreamFilter); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_register_codec_parser(parser: PAVCodecParser); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_register_hwaccel(hwaccel: PAVHWAccel)cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_shrink_packet(pkt: PAVPacket; size: cint); cdecl; external c_strFFmpegDllX64Name;
procedure avcodec_align_dimensions(s: PAVCodecContext; width: PCint; height: PCint); cdecl; external c_strFFmpegDllX64Name;
procedure avcodec_align_dimensions2(s: PAVCodecContext; width: PCint; height: PCint; linesize_align: PAVNDPArray); cdecl; external c_strFFmpegDllX64Name;
procedure avcodec_flush_buffers(avctx: PAVCodecContext); cdecl; external c_strFFmpegDllX64Name;
procedure avcodec_free_context(var avctx: PAVCodecContext); cdecl; external c_strFFmpegDllX64Name;
procedure avcodec_get_chroma_sub_sample(pix_fmt: TAVPixelFormat; var h_shift: cint; var v_shift: cint); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure avcodec_get_context_defaults3(s: PAVCodecContext; codec: PAVCodec); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure avcodec_parameters_free(par: PPAVCodecParameters); cdecl; external c_strFFmpegDllX64Name;
procedure avcodec_register(codec: PAVCodec); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure avcodec_register_all(); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure avcodec_string(buf: PAnsiChar; buf_size: cint; enc: PAVCodecContext; encode: cint); cdecl; external c_strFFmpegDllX64Name;
procedure avpicture_free(picture: PAVPicture); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure avsubtitle_free(sub: PAVSubtitle); cdecl; external c_strFFmpegDllX64Name;

function av_codec_ffversion(): PAnsiChar;

implementation

function av_codec_ffversion(): PAnsiChar;
begin
  Result := 'FFmpeg version' + FFMPEG_VERSION;
end;

end.

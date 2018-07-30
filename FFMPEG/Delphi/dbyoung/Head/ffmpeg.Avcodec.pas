unit ffmpeg.Avcodec;

interface

uses ffmpeg.Common, System.SysUtils, ffmpeg.Avutil;

const
  AV_PARSER_PTS_NB            = 4;
  PARSER_FLAG_COMPLETE_FRAMES = $0001;
  PARSER_FLAG_ONCE            = $0002;
  PARSER_FLAG_FETCHED_OFFSET  = $0004;
  PARSER_FLAG_USE_CODEC_TS    = $1000;

type
  PAVClass              = ^TAVClass;
  PAVPacket             = ^TAVPacket;
  PAVCodecID            = ^TAVCodecID;
  PAVPacketSideData     = ^TAVPacketSideData;
  PPAVCodecParameters   = ^PAVCodecParameters;
  PAVCodecParameters    = ^TAVCodecParameters;
  PAVCodecParserContext = ^TAVCodecParserContext;
  PAVCodecParser        = ^TAVCodecParser;
  PAVCodecContext       = ^TAVCodecContext;
  PPAVCodec             = ^PAVCodec;
  PAVCodec              = ^TAVCodec;
  PAVProfile            = ^TAVProfile;
  PPAVSubtitle          = ^PAVSubtitle;
  PAVSubtitle           = ^TAVSubtitle;
  PPAVSubtitleRect      = ^PAVSubtitleRect;
  PAVSubtitleRect       = ^TAVSubtitleRect;
  PAVCodecInternal      = ^TAVCodecInternal;
  PAVNDPArray           = ^TAVNDPArray;
  TAVNDPArray           = array [0 .. AV_NUM_DATA_POINTERS - 1] of cint;
  PRcOverride           = ^TRcOverride;
  PAVHWAccel            = ^TAVHWAccel;
  PMpegEncContext       = ^TMpegEncContext;
  PAVCodecDescriptor    = ^TAVCodecDescriptor;

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

implementation

end.

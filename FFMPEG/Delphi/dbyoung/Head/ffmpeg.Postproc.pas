unit ffmpeg.Postproc;

interface

uses
  ffmpeg.Common, ffmpeg.Avutil;

const
  LIBPOSTPROC_VERSION_MAJOR = 55;
  LIBPOSTPROC_VERSION_MINOR = 2;
  LIBPOSTPROC_VERSION_MICRO = 100;

  PP_CPU_CAPS_MMX     = $80000000;
  PP_CPU_CAPS_MMX2    = $20000000;
  PP_CPU_CAPS_3DNOW   = $40000000;
  PP_CPU_CAPS_ALTIVEC = $10000000;
  PP_CPU_CAPS_AUTO    = $00080000;
  PP_FORMAT           = $00000008;
  PP_FORMAT_420       = ($00000011 or PP_FORMAT);
  PP_FORMAT_422       = ($00000001 or PP_FORMAT);
  PP_FORMAT_411       = ($00000002 or PP_FORMAT);
  PP_FORMAT_444       = ($00000000 or PP_FORMAT);
  PP_FORMAT_440       = ($00000010 or PP_FORMAT);
  PP_PICT_TYPE_QP2    = $00000010;
  PP_QUALITY_MAX      = 6;

  pp_help =                                                                                      //
    'Available postprocessing filters:' + #$D#$A +                                               //
    'Filters                        Options' + #$D#$A +                                          //
    'short  long name       short   long option     Description' + #$D#$A +                      //
    '*      *               a       autoq           CPU power dependent enabler' + #$D#$A +      //
    '                       c       chrom           chrominance filtering enabled' + #$D#$A +    //
    '                       y       nochrom         chrominance filtering disabled' + #$D#$A +   //
    '                       n       noluma          luma filtering disabled' + #$D#$A +          //
    'hb     hdeblock        (2 threshold)           horizontal deblocking filter' + #$D#$A +     //
    '       1. difference factor: default=32, higher -> more deblocking' + #$D#$A +              //
    '       2. flatness threshold: default=39, lower -> more deblocking' + #$D#$A +              //
    '                       the h & v deblocking filters share these' + #$D#$A +                 //
    '                       so you cant set different thresholds for h / v' + #$D#$A +           //
    'vb     vdeblock        (2 threshold)           vertical deblocking filter' + #$D#$A +       //
    'ha     hadeblock       (2 threshold)           horizontal deblocking filter' + #$D#$A +     //
    'va     vadeblock       (2 threshold)           vertical deblocking filter' + #$D#$A +       //
    'h1     x1hdeblock                              experimental h deblock filter 1' + #$D#$A +  //
    'v1     x1vdeblock                              experimental v deblock filter 1' + #$D#$A +  //
    'dr     dering                                  deringing filter' + #$D#$A +                 //
    'al     autolevels                              automatic brightness / contrast' + #$D#$A +  //
    '                       f        fullyrange     stretch luminance to (0..255)' + #$D#$A +    //
    'lb     linblenddeint                           linear blend deinterlacer' + #$D#$A +        //
    'li     linipoldeint                            linear interpolating deinterlace' + #$D#$A + //
    'ci     cubicipoldeint                          cubic interpolating deinterlacer' + #$D#$A + //
    'md     mediandeint                             median deinterlacer' + #$D#$A +              //
    'fd     ffmpegdeint                             ffmpeg deinterlacer' + #$D#$A +              //
    'l5     lowpass5                                FIR lowpass deinterlacer' + #$D#$A +         //
    'de     default                                 hb:a,vb:a,dr:a' + #$D#$A +                   //
    'fa     fast                                    h1:a,v1:a,dr:a' + #$D#$A +                   //
    'ac                                             ha:a:128:7,va:a,dr:a' + #$D#$A +             //
    'tn     tmpnoise        (3 threshold)           temporal noise reducer' + #$D#$A +           //
    '                     1. <= 2. <= 3.            larger -> stronger filtering' + #$D#$A +     //
    'fq     forceQuant      <quantizer>             force quantizer' + #$D#$A +                  //
    'Usage:' + #$D#$A +                                                                          //
    '<filterName>[:<option>[:<option>...]][[,|/][-]<filterName>[:<option>...]]...' + #$D#$A +    //
    'long form example:' + #$D#$A +                                                              //
    'vdeblock:autoq/hdeblock:autoq/linblenddeint    default,-vdeblock' + #$D#$A +                //
    'short form example:' + #$D#$A +                                                             //
    'vb:a/hb:a/lb                                   de,-vb' + #$D#$A +                           //
    'more examples:' + #$D#$A +                                                                  //
    'tn:64:128:256' + #$D#$A +                                                                   //
    '' + #$D#$A;

type
  pp_context    = Pointer;
  pp_mode       = Pointer;
  ArrThreePByte = array [0 .. 2] of puint8_t;
  ArrThreeInt   = array [0 .. 2] of Integer;

var
  LIBPOSTPROC_VERSION_INT: Cardinal;
  LIBPOSTPROC_VERSION    : PAnsiChar;
  LIBPOSTPROC_BUILD      : Cardinal;
  LIBPOSTPROC_IDENT      : PAnsiChar;

function postproc_configuration(): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function postproc_ffversion(): UINT; cdecl; external c_strFFmpegDllX64Name;
function postproc_license(): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function postproc_version(): UINT; cdecl; external c_strFFmpegDllX64Name;
procedure pp_free_context(var ppContext: pp_context); cdecl; external c_strFFmpegDllX64Name;
procedure pp_free_mode(var mode: pp_mode); cdecl; external c_strFFmpegDllX64Name;
function pp_get_context(width: Integer; height: Integer; flags: Integer): pp_context; cdecl; external c_strFFmpegDllX64Name;
function pp_get_mode_by_name_and_quality(name: PAnsiChar; quality: Integer): pp_mode; cdecl; external c_strFFmpegDllX64Name;
procedure pp_postprocess(const src: ArrThreePByte; srcStride: ArrThreeInt; dst: ArrThreePByte; dstStride: ArrThreeInt; horizontalSize: Integer; verticalSize: Integer; QP_store: pint8_t; QP_stride: Integer; var mode: pp_mode; var ppContext: pp_context; pict_type: Integer); cdecl; external c_strFFmpegDllX64Name;

implementation

initialization
  LIBPOSTPROC_VERSION_INT := AV_VERSION_INT(LIBPOSTPROC_VERSION_MAJOR, LIBPOSTPROC_VERSION_MINOR, LIBPOSTPROC_VERSION_MICRO);
  LIBPOSTPROC_VERSION     := AV_VERSION(LIBPOSTPROC_VERSION_MAJOR, LIBPOSTPROC_VERSION_MINOR, LIBPOSTPROC_VERSION_MICRO);
  LIBPOSTPROC_BUILD       := LIBPOSTPROC_VERSION_INT;
  LIBPOSTPROC_IDENT       := PAnsiChar(AnsiString('postproc' + AV_STRINGIFY(LIBPOSTPROC_VERSION)));

end.

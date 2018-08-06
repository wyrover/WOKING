unit ffmpeg.Swresample;

interface

uses ffmpeg.Common, ffmpeg.Avutil, ffmpeg.Avcodec;

const
  LIBSWRESAMPLE_VERSION_MAJOR = 3;
  LIBSWRESAMPLE_VERSION_MINOR = 2;
  LIBSWRESAMPLE_VERSION_MICRO = 100;
  SWR_FLAG_RESAMPLE           = 1;
  NS_TAPS                     = 20;
  SWR_CH_MAX                  = 64;

type
  PAudioData       = ^AudioData;
  PAudioConvert    = ^TAudioConvert;
  Pconv_func_type  = ^conv_func_type;
  Psimd_func_type  = ^simd_func_type;
  PResampleContext = ^TResampleContext;
  PSwrContext      = ^SwrContext;
  PResampler       = ^TResampler;

  SwrDitherType = (                    //
    SWR_DITHER_NONE = 0,               //
    SWR_DITHER_RECTANGULAR,            //
    SWR_DITHER_TRIANGULAR,             //
    SWR_DITHER_TRIANGULAR_HIGHPASS,    //
    SWR_DITHER_NS = 64,                //
    SWR_DITHER_NS_LIPSHITZ,            //
    SWR_DITHER_NS_F_WEIGHTED,          //
    SWR_DITHER_NS_MODIFIED_E_WEIGHTED, //
    SWR_DITHER_NS_IMPROVED_E_WEIGHTED, //
    SWR_DITHER_NS_SHIBATA,             //
    SWR_DITHER_NS_LOW_SHIBATA,         //
    SWR_DITHER_NS_HIGH_SHIBATA,        //
    SWR_DITHER_NB                      //
    );

  SwrEngine = (      //
    SWR_ENGINE_SWR,  //
    SWR_ENGINE_SOXR, //
    SWR_ENGINE_NB);

  SwrFilterType = (                   //
    SWR_FILTER_TYPE_CUBIC,            //
    SWR_FILTER_TYPE_BLACKMAN_NUTTALL, //
    SWR_FILTER_TYPE_KAISER            //
    );

  AudioData = record
    ch: array [0 .. Pred(SWR_CH_MAX)] of puint8_t;
    data: puint8_t;
    ch_count: Integer;
    bps: Integer;
    count: Integer;
    planar: Integer;
    fmt: AVSampleFormat;
  end;

  DitherContext = record
    method: Integer;
    noise_pos: Integer;
    scale: float;
    noise_scale: float;
    NS_TAPS: Integer;
    ns_scale: float;
    ns_scale_1: float;
    ns_pos: Integer;
    ns_coeffs: array [0 .. Pred(NS_TAPS)] of float;
    ns_errors: array [0 .. Pred(SWR_CH_MAX), 0 .. Pred(2 * NS_TAPS)] of float;
    noise: AudioData;
    temp: AudioData;
    output_sample_bits: Integer;
  end;

  simd_func_type = procedure(po: puint8_t; const _pi: puint8_t; _is, _os: Int; _end: puint8_t); cdecl;
  conv_func_type = procedure(dst: ppuint8_t; const src: ppuint8_t; len: Int); cdecl;

  TResampleContext = record
    av_class: PAVClass;
    filter_bank: puint8_t;
    filter_length: Integer;
    filter_alloc: Integer;
    ideal_dst_incr: Integer;
    dst_incr: Integer;
    dst_incr_div: Integer;
    dst_incr_mod: Integer;
    index: Integer;
    frac: Integer;
    src_incr: Integer;
    compensation_distance: Integer;
    phase_count: Integer;
    linear: Integer;
    filter_type: SwrFilterType;
    kaiser_beta: double;
    factor: double;
    format: AVSampleFormat;
    felem_size: Integer;
    filter_shift: Integer;
    phase_count_compensation: Integer;
  end;

  TAudioConvert = record
    channels: Int;
    in_simd_align_mask, out_simd_align_mask: Int;
    conv_f: conv_func_type;
    simd_f: simd_func_type;
    ch_map: PInteger;
    silence: array [0 .. 7] of UInt8;
  end;

  resample_init_func         = function(c: PResampleContext; out_rate: Integer; in_rate: Integer; filter_size: Integer; phase_shift: Integer; linear: Integer; cutoff: double; format: AVSampleFormat; filter_type: SwrFilterType; kaiser_beta: double; precision: double; cheby: Integer; exact_rational: Integer): PResampleContext;
  resample_free_func         = procedure(var c: PResampleContext);
  multiple_resample_func     = function(c: PResampleContext; dst: PAudioData; dst_size: Integer; src: PAudioData; src_size: Integer; consumed: PInteger)     : Integer;
  resample_flush_func        = function(c: PSwrContext)                                                                                                         : Integer;
  set_compensation_func      = function(c: PResampleContext; sample_delta: Integer; compensation_distance: Integer)                                           : Integer;
  get_delay_func             = function(s: PSwrContext; base: int64_t)                                                                                               : int64_t;
  invert_initial_buffer_func = function(c: PResampleContext; dst: PAudioData; src: PAudioData; src_size: Integer; dst_idx: PInteger; dst_count: PInteger): Integer;
  get_out_samples_func       = function(s: PSwrContext; in_samples: Integer)                                                                                   : int64_t;

  TResampler = record
    init: resample_init_func;
    free: resample_free_func;
    multiple_resample: multiple_resample_func;
    flush: resample_flush_func;
    set_compensation: set_compensation_func;
    get_delay: get_delay_func;
    invert_initial_buffer: invert_initial_buffer_func;
    get_out_samples: get_out_samples_func;
  end;

  pmix_1_1_func_type = function(_out: Pointer; _in: Pointer; coeffp: Pointer; index: Integer; len: Integer): Pointer; cdecl;
  pmix_2_1_func_type = function(_out: Pointer; _in: Pointer; coeffp: Pointer; index: Integer; len: Integer): Pointer; cdecl;
  pmix_any_func_type = function(var _out: puint8_t; const _in1: ppuint8_t; coeffp: Pointer; len: Integer)  : Pointer; cdecl;

  SwrContext = record
    av_class: PAVClass;
    log_level_offset: Integer;
    log_ctx: PInteger;
    in_sample_fmt: AVSampleFormat;
    int_sample_fmt: AVSampleFormat;
    out_sample_fmt: AVSampleFormat;
    in_ch_layout: int64_t;
    out_ch_layout: int64_t;
    in_sample_rate: Integer;
    out_sample_rate: Integer;
    flags: Integer;
    slev: float;
    clev: float;
    lfe_mix_level: float;
    rematrix_volume: float;
    rematrix_maxval: float;
    matrix_encoding: Integer;
    channel_map: PInteger;
    used_ch_count: Integer;
    engine: Integer;
    user_in_ch_count: Integer;
    user_out_ch_count: Integer;
    user_used_ch_count: Integer;
    user_in_ch_layout: int64_t;
    user_out_ch_layout: int64_t;
    user_int_sample_fmt: AVSampleFormat;
    user_dither_method: Integer;
    dither: DitherContext;
    filter_size: Integer;
    phase_shift: Integer;
    linear_interp: Integer;
    exact_rational: Integer;
    cutoff: double;
    filter_type: Integer;
    kaiser_beta: double;
    precision: double;
    cheby: Integer;
    min_compensation: float;
    min_hard_compensation: float;
    soft_compensation_duration: float;
    max_soft_compensation: float;
    async: float;
    firstpts_in_samples: int64_t;
    resample_first: Integer;
    rematrix: Integer;
    rematrix_custom: Integer;
    _in: AudioData;
    postin: AudioData;
    midbuf: AudioData;
    preout: AudioData;
    _out: AudioData;
    in_buffer: AudioData;
    silence: AudioData;
    drop_temp: AudioData;
    in_buffer_index: Integer;
    in_buffer_count: Integer;
    resample_in_constraint: Integer;
    flushed: Integer;
    outpts: int64_t;
    firstpts: int64_t;
    drop_output: Integer;
    delayed_samples_fixup: double;
    in_convert: PAudioConvert;
    out_convert: PAudioConvert;
    full_convert: PAudioConvert;
    resample: PResampleContext;
    Resampler: PResampler;
    matrix: array [0 .. Pred(SWR_CH_MAX), 0 .. Pred(SWR_CH_MAX)] of double;
    matrix_flt: array [0 .. Pred(SWR_CH_MAX), 0 .. Pred(SWR_CH_MAX)] of float;
    native_matrix: puint8_t;
    native_one: puint8_t;
    native_simd_one: puint8_t;
    native_simd_matrix: puint8_t;
    matrix32: array [0 .. Pred(SWR_CH_MAX), 0 .. Pred(SWR_CH_MAX)] of int32_t;
    matrix_ch: array [0 .. Pred(SWR_CH_MAX), 0 .. Pred(SWR_CH_MAX + 1)] of uint8_t;
    mix_1_1_f: pmix_1_1_func_type;
    mix_1_1_simd: pmix_1_1_func_type;
    mix_2_1_f: pmix_2_1_func_type;
    mix_2_1_simd: pmix_2_1_func_type;
    mix_any_f: pmix_any_func_type;
  end;

function swr_get_class(): PAVClass; external c_strFFmpegDllX64Name;
function swr_init(s: PSwrContext): Integer; external c_strFFmpegDllX64Name;
function swr_is_initialized(s: PSwrContext): Integer; external c_strFFmpegDllX64Name;
procedure swr_free; external c_strFFmpegDllX64Name;
procedure swr_close(s: PSwrContext); external c_strFFmpegDllX64Name;
function swr_convert(s: PSwrContext): Integer; external c_strFFmpegDllX64Name;
function swr_next_pts(s: PSwrContext; pts: int64_t): int64_t; external c_strFFmpegDllX64Name;
function swr_set_compensation(s: PSwrContext; sample_delta: Integer; compensation_distance: Integer): Integer; external c_strFFmpegDllX64Name;
function swr_set_channel_mapping(s: PSwrContext; channel_map: PInteger): Integer; external c_strFFmpegDllX64Name;
function swr_build_matrix(in_layout: uint64_t; out_layout: uint64_t; center_mix_level: double; surround_mix_level: double; lfe_mix_level: double; rematrix_maxval: double; rematrix_volume: double; matrix: pdouble; stride: Integer; matrix_encoding: AVMatrixEncoding; log_ctx: PInteger): Integer; external c_strFFmpegDllX64Name;
function swr_set_matrix(s: PSwrContext; matrix: pdouble; stride: Integer): Integer; external c_strFFmpegDllX64Name;
function swr_drop_output(s: PSwrContext; count: Integer): Integer; external c_strFFmpegDllX64Name;
function swr_inject_silence(s: PSwrContext; count: Integer): Integer; external c_strFFmpegDllX64Name;
function swr_get_delay(s: PSwrContext; base: int64_t): int64_t; external c_strFFmpegDllX64Name;
function swr_get_out_samples(s: PSwrContext; in_samples: Integer): Integer; external c_strFFmpegDllX64Name;
function swresample_version(): UINT; external c_strFFmpegDllX64Name;
function swresample_configuration(): pchar; external c_strFFmpegDllX64Name;
function swresample_license(): pchar; external c_strFFmpegDllX64Name;
function swr_convert_frame(swr: PSwrContext; output: PAVFrame; input: PAVFrame): Integer; external c_strFFmpegDllX64Name;
function swr_config_frame(swr: PSwrContext; _out: PAVFrame; _in: PAVFrame): Integer; external c_strFFmpegDllX64Name;

var
  LIBSWRESAMPLE_VERSION_INT: Integer;
  LIBSWRESAMPLE_VERSION    : PAnsiChar;
  LIBSWRESAMPLE_BUILD      : Integer;
  LIBSWRESAMPLE_IDENT      : PAnsiChar;

implementation

initialization
  LIBSWRESAMPLE_VERSION_INT := AV_VERSION_INT(LIBSWRESAMPLE_VERSION_MAJOR, LIBSWRESAMPLE_VERSION_MINOR, LIBSWRESAMPLE_VERSION_MICRO);
  LIBSWRESAMPLE_VERSION     := AV_VERSION(LIBSWRESAMPLE_VERSION_MAJOR, LIBSWRESAMPLE_VERSION_MINOR, LIBSWRESAMPLE_VERSION_MICRO);
  LIBSWRESAMPLE_BUILD       := LIBSWRESAMPLE_VERSION_INT;
  LIBSWRESAMPLE_IDENT       := PAnsiChar(AnsiString('SwR' + string(AV_STRINGIFY(LIBSWRESAMPLE_VERSION))));

end.

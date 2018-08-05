unit ffmpeg.Avfilter;

interface

uses ffmpeg.Common, ffmpeg.Avutil, ffmpeg.Avcodec;

const
  AVFILTER_FLAG_DYNAMIC_INPUTS            = (1 shl 0);
  AVFILTER_FLAG_DYNAMIC_OUTPUTS           = (1 shl 1);
  AVFILTER_FLAG_SLICE_THREADS             = (1 shl 2);
  AVFILTER_FLAG_SUPPORT_TIMELINE_GENERIC  = (1 shl 16);
  AVFILTER_FLAG_SUPPORT_TIMELINE_INTERNAL = (1 shl 17);
  AVFILTER_FLAG_SUPPORT_TIMELINE          = (AVFILTER_FLAG_SUPPORT_TIMELINE_GENERIC or AVFILTER_FLAG_SUPPORT_TIMELINE_INTERNAL);
  AVFILTER_THREAD_SLICE                   = (1 shl 0);
  AVFILTER_CMD_FLAG_ONE                   = 1;
  AVFILTER_CMD_FLAG_FAST                  = 2;
  AVFILTER_AUTO_CONVERT_NONE              = -1;
  AVFILTER_AUTO_CONVERT_ALL               = 0;
  AV_BUFFERSINK_FLAG_PEEK                 = 1;
  AV_BUFFERSINK_FLAG_NO_REQUEST           = 2;
  AV_BUFFERSRC_FLAG_NO_CHECK_FORMAT       = 1;
  AV_BUFFERSRC_FLAG_PUSH                  = 4;
  AV_BUFFERSRC_FLAG_KEEP_REF              = 8;

type
  PAVFilterFormats        = ^TAVFilterFormats;
  PPAVFilterInOut         = ^PAVFilterInOut;
  PAVFilterInOut          = ^TAVFilterInOut;
  PAVBufferSinkParams     = ^TAVBufferSinkParams;
  PAVFilterChannelLayouts = ^TAVFilterChannelLayouts;
  PAVFilterPad            = ^TAVFilterPad;
  PPPAVFilterLink         = ^PPAVFilterLink;
  PPAVFilterLink          = ^PAVFilterLink;
  PAVFilterLink           = ^TAVFilterLink;
  PPAVFilterGraph         = ^PAVFilterGraph;
  PAVFilterGraph          = ^TAVFilterGraph;
  PAVFilterInternal       = ^TAVFilterInternal;
  PAVFilterGraphInternal  = ^TAVFilterGraphInternal;
  PAVABufferSinkParams    = ^TAVABufferSinkParams;
  PAVBufferSrcParameters  = ^TAVBufferSrcParameters;

  TAVBufferSrcParameters = record
    format: Integer;
    time_base: TAVRational;
    width, height: Integer;
    sample_aspect_ratio: TAVRational;
    frame_rate: TAVRational;
    hw_frames_ctx: PAVBufferRef;
    sample_rate: Integer;
    channel_layout: Int64;
  end;

  TAVFilterFormats = record
  end;

  TAVFilterChannelLayouts = record
  end;

  TAVFilterPad = record
  end;

  PPAVFilterContext = ^PAVFilterContext;
  PAVFilterContext  = ^TAVFilterContext;
  PPAVFilter        = ^PAVFilter;
  PAVFilter         = ^TAVFilter;

  TAVFilter = record
    name: PAnsiChar;
    description: PAnsiChar;
    inputs: PAVFilterPad;
    outputs: PAVFilterPad;
    priv_class: PAVClass;
    flags: Integer;
    preinit: function(ctx: PAVFilterContext): Integer; cdecl;
    init: function(ctx: PAVFilterContext): Integer; cdecl;
    init_dict: function(ctx: PAVFilterContext; options: PPAVDictionary): Integer; cdecl;
    uninit: procedure(ctx: PAVFilterContext); cdecl;
    query_formats: function(ctx: PAVFilterContext): Integer; cdecl;
    priv_size: Integer;
    flags_internal: Integer;
    next: PAVFilter;
    process_command: function(ctx: PAVFilterContext; const cmd, arg: PAnsiChar; res: PAnsiChar; res_len, flags: Integer): Integer; cdecl;
    init_opaque: function(ctx: PAVFilterContext; opaque: Pointer): Integer; cdecl;
    activate: function(ctx: PAVFilterContext): Integer; cdecl;
  end;

  TAVFilterInternal = record
  end;

  TAVFilterContext = record
    av_class: PAVClass;
    filter: PAVFilter;
    name: PAnsiChar;
    input_pads: PAVFilterPad;
    inputs: PPAVFilterLink;
    nb_inputs: Cardinal;
    output_pads: PAVFilterPad;
    outputs: PPAVFilterLink;
    nb_outputs: Cardinal;
    priv: Pointer;
    graph: PAVFilterGraph;
    thread_type: Integer;
    internal: PAVFilterInternal;
    command_queue: Pointer;
    enable_str: PAnsiChar;
    enable: Pointer;
    var_values: PDouble;
    is_disabled: Integer;
    hw_device_ctx: PAVBufferRef;
    nb_threads: Integer;
    ready: Cardinal;
  end;

  Tinit_state = (AVLINK_UNINIT = 0, AVLINK_STARTINIT, AVLINK_INIT);

  TAVFilterLink = record
    src: PAVFilterContext;
    srcpad: PAVFilterPad;
    dst: PAVFilterContext;
    dstpad: PAVFilterPad;
    type_: TAVMediaType;
    w: Integer;
    h: Integer;
    sample_aspect_ratio: TAVRational;
    channel_layout: Int64;
    sample_rate: Integer;
    format: Integer;
    time_base: TAVRational;
    in_formats: PAVFilterFormats;
    out_formats: PAVFilterFormats;
    in_samplerates: PAVFilterFormats;
    out_samplerates: PAVFilterFormats;
    in_channel_layouts: PAVFilterChannelLayouts;
    out_channel_layouts: PAVFilterChannelLayouts;
    request_samples: Integer;
    init_state: Tinit_state;
    graph: PAVFilterGraph;
    current_pts: Int64;
    current_pts_us: Int64;
    age_index: Integer;
    frame_rate: TAVRational;
    partial_buf: PAVFrame;
    partial_buf_size: Integer;
    min_samples: Integer;
    max_samples: Integer;
    channels: Integer;
    flags: Cardinal;
    frame_count_in, frame_count_out: Int64;
    frame_pool: Pointer;
    frame_wanted_out: Integer;
    hw_frames_ctx: PAVBufferRef;
{$IFNDEF FF_INTERNAL_FIELDS}
    reserved: array [0 .. $F000 - 1] of AnsiChar;
{$ELSE}
    fifo: TFFFrameQueue;
    frame_blocked_in: Integer;
    status_in: Integer;
    status_in_pts: Int64;
    status_out: Integer;
{$ENDIF}
  end;

  TAVFilterGraphInternal = record
  end;

  Tavfilter_action_func  = function(ctx: PAVFilterContext; arg: Pointer; jobnr, nb_jobs: Integer)                                      : Integer; cdecl;
  Tavfilter_execute_func = function(ctx: PAVFilterContext; func: Tavfilter_action_func; arg: Pointer; ret: PInteger; nb_jobs: Integer): Integer; cdecl;

  TAVFilterGraph = record
    av_class: PAVClass;
    filters: PPAVFilterContext;
    nb_filters: Cardinal;
    scale_sws_opts: PAnsiChar;
{$IFDEF FF_API_LAVR_OPTS}
    resample_lavr_opts: PAnsiChar;
{$ENDIF}
    thread_type: Integer;
    nb_threads: Integer;
    internal: PAVFilterGraphInternal;
    opaque: Pointer;
    execute: Tavfilter_execute_func;
    aresample_swr_opts: PAnsiChar;
    sink_links: PPAVFilterLink;
    sink_links_count: Integer;
    disable_auto_convert: Cardinal;
  end;

  TAVFilterInOut = record
    name: PAnsiChar;
    filter_ctx: PAVFilterContext;
    pad_idx: Integer;
    next: PAVFilterInOut;
  end;

  TAVBufferSinkParams = record
    pixel_fmts: PAVPixelFormat;
  end;

  TAVABufferSinkParams = record
    sample_fmts: PAVSampleFormat;
    channel_layouts: PInt64;
    channel_counts: PInteger;
    all_channel_counts: Integer;
    sample_rates: PInteger;
  end;

  InterpolateMethod = (      //
    INTERPOLATE_NEAREST,     //
    INTERPOLATE_BILINEAR,    //
    INTERPOLATE_BIQUADRATIC, //
    INTERPOLATE_COUNT        //
    );

  FillMethod = (   //
    FILL_BLANK,    //
    FILL_ORIGINAL, //
    FILL_CLAMP,    //
    FILL_MIRROR,   //
    FILL_COUNT     //
    );

function av_abuffersink_params_alloc: PAVABufferSinkParams; cdecl; external c_strFFmpegDllX64Name;
function av_buffersink_get_channel_layout(const ctx: PAVFilterContext): Int64; cdecl; external c_strFFmpegDllX64Name;
function av_buffersink_get_channels(const ctx: PAVFilterContext): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_buffersink_get_format(const ctx: PAVFilterContext): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_buffersink_get_frame(ctx: PAVFilterContext; frame: PAVFrame): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_buffersink_get_frame_rate(const ctx: PAVFilterContext): TAVRational;
function av_buffersink_get_frame_flags(ctx: PAVFilterContext; frame: PAVFrame; flags: Integer): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_buffersink_get_h(const ctx: PAVFilterContext): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_buffersink_get_hw_frames_ctx(const ctx: PAVFilterContext): PAVBufferRef; cdecl; external c_strFFmpegDllX64Name;
function av_buffersink_get_sample_aspect_ratio(const ctx: PAVFilterContext): TAVRational;
function av_buffersink_get_sample_rate(const ctx: PAVFilterContext): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_buffersink_get_samples(ctx: PAVFilterContext; frame: PAVFrame; nb_samples: Integer): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_buffersink_get_time_base(const ctx: PAVFilterContext): TAVRational;
function av_buffersink_get_type(const ctx: PAVFilterContext): TAVMediaType; cdecl; external c_strFFmpegDllX64Name;
function av_buffersink_get_w(const ctx: PAVFilterContext): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_buffersink_params_alloc: PAVBufferSinkParams; cdecl; external c_strFFmpegDllX64Name;
procedure av_buffersink_set_frame_size(ctx: PAVFilterContext; frame_size: Cardinal); cdecl; external c_strFFmpegDllX64Name;
function av_buffersrc_add_frame(ctx: PAVFilterContext; frame: PAVFrame): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_buffersrc_add_frame_flags(buffer_src: PAVFilterContext; frame: PAVFrame; flags: Integer): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_buffersrc_close(ctx: PAVFilterContext; pts: Int64; flags: Cardinal): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_buffersrc_get_nb_failed_requests(buffer_src: PAVFilterContext): Cardinal; cdecl; external c_strFFmpegDllX64Name;
function av_buffersrc_parameters_alloc(): PAVBufferSrcParameters; cdecl; external c_strFFmpegDllX64Name;
function av_buffersrc_parameters_set(ctx: PAVFilterContext; param: PAVBufferSrcParameters): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_buffersrc_write_frame(ctx: PAVFilterContext; const frame: PAVFrame): Integer; cdecl; external c_strFFmpegDllX64Name;
function av_filter_ffversion(): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_filter_iterate(opaque: PPointer): PAVFilter; cdecl; external c_strFFmpegDllX64Name;
procedure avfilter_add_matrix(const m1, m2: pcfloat; var result: float); cdecl; external c_strFFmpegDllX64Name;
function avfilter_config_links(filter: PAVFilterContext): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_configuration: PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
procedure avfilter_free(filter: PAVFilterContext); cdecl; external c_strFFmpegDllX64Name;
function avfilter_get_by_name(const name: PAnsiChar): PAVFilter; cdecl; external c_strFFmpegDllX64Name;
function avfilter_get_class: PAVClass; cdecl; external c_strFFmpegDllX64Name;
procedure avfilter_get_matrix(x_shift, y_shift, angle, zoom: float; var matrix: float); cdecl; external c_strFFmpegDllX64Name;
function avfilter_graph_alloc: PAVFilterGraph; cdecl; external c_strFFmpegDllX64Name;
function avfilter_graph_alloc_filter(graph: PAVFilterGraph; const filter: PAVFilter; const name: PAnsiChar): PAVFilterContext; cdecl; external c_strFFmpegDllX64Name;
function avfilter_graph_config(graphctx: PAVFilterGraph; log_ctx: Pointer): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_graph_create_filter(filt_ctx: PPAVFilterContext; const filt: PAVFilter; const name: PAnsiChar; const args: PAnsiChar; opaque: Pointer; graph_ctx: PAVFilterGraph): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_graph_dump(graph: PAVFilterGraph; const options: PAnsiChar): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
procedure avfilter_graph_free(graph: PPAVFilterGraph); cdecl; external c_strFFmpegDllX64Name;
function avfilter_graph_get_filter(graph: PAVFilterGraph; const name: PAnsiChar): PAVFilterContext; cdecl; external c_strFFmpegDllX64Name;
function avfilter_graph_parse(graph: PAVFilterGraph; const filters: PAnsiChar; inputs, outputs: PAVFilterInOut; log_ctx: Pointer): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_graph_parse2(graph: PAVFilterGraph; const filters: PAnsiChar; inputs, outputs: PPAVFilterInOut): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_graph_parse_ptr(graph: PAVFilterGraph; const filters: PAnsiChar; inputs, outputs: PPAVFilterInOut; log_ctx: Pointer): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_graph_queue_command(graph: PAVFilterGraph; const target, cmd, arg: PAnsiChar; flags: Integer; ts: Double): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_graph_request_oldest(graph: PAVFilterGraph): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_graph_send_command(graph: PAVFilterGraph; const target, cmd, arg: PAnsiChar; res: PAnsiChar; res_len, flags: Integer): Integer; cdecl; external c_strFFmpegDllX64Name;
procedure avfilter_graph_set_auto_convert(graph: PAVFilterGraph; flags: Integer); cdecl; external c_strFFmpegDllX64Name;
function avfilter_init_dict(ctx: PAVFilterContext; options: PPAVDictionary): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_init_str(ctx: PAVFilterContext; const args: PAnsiChar): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_inout_alloc: PAVFilterInOut; cdecl; external c_strFFmpegDllX64Name;
procedure avfilter_inout_free(inout: PPAVFilterInOut); cdecl; external c_strFFmpegDllX64Name;
function avfilter_insert_filter(link: PAVFilterLink; filt: PAVFilterContext; filt_srcpad_idx, filt_dstpad_idx: Cardinal): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_license: PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function avfilter_link(src: PAVFilterContext; srcpad: Cardinal; dst: PAVFilterContext; dstpad: Cardinal): Integer; cdecl; external c_strFFmpegDllX64Name;
procedure avfilter_link_free(link: PPAVFilterLink); cdecl; external c_strFFmpegDllX64Name;
function avfilter_link_get_channels(link: PAVFilterLink): Integer; cdecl; external c_strFFmpegDllX64Name;
procedure avfilter_link_set_closed(link: PAVFilterLink; closed: Integer); cdecl; external c_strFFmpegDllX64Name;
function avfilter_make_format64_list(const fmts: PInt64): PAVFilterChannelLayouts; cdecl; external c_strFFmpegDllX64Name;
procedure avfilter_mul_matrix(const m1: pcfloat; scalar: float; var result: float); cdecl; external c_strFFmpegDllX64Name;
function avfilter_next(const prev: PAVFilter): PAVFilter; cdecl; external c_strFFmpegDllX64Name;
function avfilter_pad_count(const pads: PAVFilterPad): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_pad_get_name(const pads: PAVFilterPad; pad_idx: Integer): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function avfilter_pad_get_type(const pads: PAVFilterPad; pad_idx: Integer): TAVMediaType; cdecl; external c_strFFmpegDllX64Name;
function avfilter_process_command(filter: PAVFilterContext; const cmd, arg: PAnsiChar; res: PAnsiChar; res_len, flags: Integer): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_register(filter: PAVFilter): Integer; cdecl; external c_strFFmpegDllX64Name;
procedure avfilter_register_all; cdecl; external c_strFFmpegDllX64Name;
procedure avfilter_sub_matrix(const m1, m2: pcfloat; var result: float); cdecl; external c_strFFmpegDllX64Name;
function avfilter_transform(const src, dst: puint8_t; src_stride, dst_stride, width, height: Integer; const matrix: pcfloat; interpolate: InterpolateMethod; fill: FillMethod): Integer; cdecl; external c_strFFmpegDllX64Name;
function avfilter_version: Cardinal; cdecl; external c_strFFmpegDllX64Name;

implementation

function av_buffersink_get_time_base(const ctx: PAVFilterContext): TAVRational;
begin
  result := ctx.inputs^^.time_base;
end;

function av_buffersink_get_frame_rate(const ctx: PAVFilterContext): TAVRational;
begin
  result := ctx.inputs^^.frame_rate;
end;

function av_buffersink_get_sample_aspect_ratio(const ctx: PAVFilterContext): TAVRational;
begin
  result := ctx.inputs^^.sample_aspect_ratio;
end;

end.

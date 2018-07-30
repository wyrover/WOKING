unit ffmpeg.Avformat;

interface

uses System.SysUtils, ffmpeg.Common, ffmpeg.Avutil, ffmpeg.Avcodec;

const
  LIBAVFORMAT_VERSION_MAJOR        = 58;
  LIBAVFORMAT_VERSION_MINOR        = 17;
  LIBAVFORMAT_VERSION_MICRO        = 101;
  LIBAVFORMAT_MAX_VERSION_MAJOR    = 58;
  LIBAVFORMAT_MAX_VERSION_MINOR    = 12;
  LIBAVFORMAT_MAX_VERSION_RELEASE  = 100;
  LIBAVFORMAT_MIN_VERSION_MAJOR    = 58;
  LIBAVFORMAT_MIN_VERSION_MINOR    = 12;
  LIBAVFORMAT_MIN_VERSION_RELEASE  = 100;
  FF_API_URL_CLASS                 = (LIBAVFORMAT_VERSION_MAJOR >= 53);
  AVIO_SEEKABLE_NORMAL             = (1 shl 0);
  AVIO_SEEKABLE_TIME               = (1 shl 1);
  AVSEEK_SIZE                      = $10000;
  AVSEEK_FORCE                     = $20000;
  AVIO_FLAG_READ                   = 1;
  AVIO_FLAG_WRITE                  = 2;
  AVIO_FLAG_READ_WRITE             = 3;
  AVIO_FLAG_NONBLOCK               = 8;
  AVIO_FLAG_DIRECT                 = $8000;
  SEEK_SET                         = 0;
  SEEK_CUR                         = 1;
  SEEK_END                         = 2;
  AVSEEK_FLAG_BACKWARD             = 1;
  AVSEEK_FLAG_BYTE                 = 2;
  AVSEEK_FLAG_ANY                  = 4;
  AVSEEK_FLAG_FRAME                = 8;
  AVSTREAM_INIT_IN_WRITE_HEADER    = 0;
  AVSTREAM_INIT_IN_INIT_OUTPUT     = 1;
  AV_FRAME_FILENAME_FLAGS_MULTIPLE = 1;
  AVPROBE_SCORE_EXTENSION          = 50;
  AVPROBE_SCORE_MIME               = 75;
  AVPROBE_SCORE_MAX                = 100;
  AVPROBE_SCORE_RETRY              = (AVPROBE_SCORE_MAX DIV 4);
  AVPROBE_SCORE_STREAM_RETRY       = (AVPROBE_SCORE_MAX DIV 4 - 1);
  AVPROBE_PADDING_SIZE             = 32;
  AVFMT_NOFILE                     = $0001;
  AVFMT_NEEDNUMBER                 = $0002;
  AVFMT_SHOW_IDS                   = $0008;
  AVFMT_GLOBALHEADER               = $0040;
  AVFMT_NOTIMESTAMPS               = $0080;
  AVFMT_GENERIC_INDEX              = $0100;
  AVFMT_TS_DISCONT                 = $0200;
  AVFMT_VARIABLE_FPS               = $0400;
  AVFMT_NODIMENSIONS               = $0800;
  AVFMT_NOSTREAMS                  = $1000;
  AVFMT_NOBINSEARCH                = $2000;
  AVFMT_NOGENSEARCH                = $4000;
  AVFMT_NO_BYTE_SEEK               = $8000;
  AVFMT_ALLOW_FLUSH                = $10000;
  AVFMT_TS_NONSTRICT               = $20000;
  AVFMT_TS_NEGATIVE                = $40000;
  AVFMT_SEEK_TO_PTS                = $4000000;
  AVINDEX_KEYFRAME                 = $0001;
  AVINDEX_DISCARD_FRAME            = $0002;
  AVFMTCTX_NOHEADER                = $0001;
  AVFMTCTX_UNSEEKABLE              = $0002;
  MAX_STREAMS                      = 20;
  AVFMT_FLAG_GENPTS                = $0001;
  AVFMT_FLAG_IGNIDX                = $0002;
  AVFMT_FLAG_NONBLOCK              = $0004;
  AVFMT_FLAG_IGNDTS                = $0008;
  AVFMT_FLAG_NOFILLIN              = $0010;
  AVFMT_FLAG_NOPARSE               = $0020;
  AVFMT_FLAG_NOBUFFER              = $0040;
  AVFMT_FLAG_CUSTOM_IO             = $0080;
  AVFMT_FLAG_DISCARD_CORRUPT       = $0100;
  AVFMT_FLAG_FLUSH_PACKETS         = $0200;
  AVFMT_FLAG_BITEXACT              = $0400;
  AVFMT_FLAG_MP4A_LATM             = $8000;
  AVFMT_FLAG_SORT_DTS              = $10000;
  AVFMT_FLAG_PRIV_OPT              = $20000;
{$IFDEF FF_API_LAVF_KEEPSIDE_FLAG}
  AVFMT_FLAG_KEEP_SIDE_DATA = $40000;
{$ENDIF}
  AVFMT_FLAG_FAST_SEEK                 = $80000;
  AVFMT_FLAG_SHORTEST                  = $100000;
  AVFMT_FLAG_AUTO_BSF                  = $200000;
  AVSTREAM_EVENT_FLAG_METADATA_UPDATED = $0001;
  MAX_STD_TIMEBASES                    = (30 * 12 + 30 + 3 + 6);
  MAX_REORDER_DELAY                    = 16;
  AV_PROGRAM_RUNNING                   = 1;
  AV_DISPOSITION_DEFAULT               = $0001;
  AV_DISPOSITION_DUB                   = $0002;
  AV_DISPOSITION_ORIGINAL              = $0004;
  AV_DISPOSITION_COMMENT               = $0008;
  AV_DISPOSITION_LYRICS                = $0010;
  AV_DISPOSITION_KARAOKE               = $0020;
  AV_DISPOSITION_FORCED                = $0040;
  AV_DISPOSITION_HEARING_IMPAIRED      = $0080;
  AV_DISPOSITION_VISUAL_IMPAIRED       = $0100;
  AV_DISPOSITION_CLEAN_EFFECTS         = $0200;
  AV_DISPOSITION_ATTACHED_PIC          = $0400;
  AV_DISPOSITION_TIMED_THUMBNAILS      = $0800;
  AV_DISPOSITION_CAPTIONS              = $10000;
  AV_DISPOSITION_DESCRIPTIONS          = $20000;
  AV_DISPOSITION_METADATA              = $40000;
  AV_DISPOSITION_DEPENDENT             = $80000;
  AV_PTS_WRAP_IGNORE                   = 0;
  AV_PTS_WRAP_ADD_OFFSET               = 1;
  AV_PTS_WRAP_SUB_OFFSET               = -1;
  FF_FDEBUG_TS                         = 0001;
  AVFMT_EVENT_FLAG_METADATA_UPDATED    = 0001;
  RAW_PACKET_BUFFER_SIZE               = 2500000;
  AVFMT_AVOID_NEG_TS_AUTO              = -1;
  AVFMT_AVOID_NEG_TS_MAKE_NON_NEGATIVE = 1;
  AVFMT_AVOID_NEG_TS_MAKE_ZERO         = 2;

type
  PAVBPrint                  = ^TAVBPrint;
  PAVIOInterruptCB           = ^TAVIOInterruptCB;
  PPAVIODirContext           = ^PAVIODirContext;
  PAVIODirContext            = ^TAVIODirContext;
  PPAVIOContext              = ^PAVIOContext;
  PAVIOContext               = ^TAVIOContext;
  TReadWriteFunc             = function(opaque: Pointer; buf: PByteArray; buf_size: cint): cint; cdecl;
  TSeekFunc                  = function(opaque: Pointer; offset: cint64; whence: cint)        : cint64; cdecl;
  Tcallback                  = function(p: Pointer)                                           : cint; cdecl;
  PPAVFormatContext          = ^PAVFormatContext;
  PAVFormatContext           = ^TAVFormatContext;
  PAVOutputFormat            = ^TAVOutputFormat;
  PAVDeviceCapabilitiesQuery = ^TAVDeviceCapabilitiesQuery;
  PPAVCodecTag               = ^PAVCodecTag;
  PAVCodecTag                = Pointer;
  PAVProbeData               = ^TAVProbeData;
  PAVInputFormat             = ^TAVInputFormat;
  PAVIndexEntry              = ^TAVIndexEntry;
  PPAVStream                 = ^PAVStream;
  PAVStream                  = ^TAVStream;
  PAVPacketList              = ^TAVPacketList;
  PPAVProgram                = ^PAVProgram;
  PAVProgram                 = ^TAVProgram;
  PAVMetadataConv            = ^TAVMetadataConv;
  PPAVDeviceInfo             = ^PAVDeviceInfo;
  PAVDeviceInfo              = ^TAVDeviceInfo;
  PAVDeviceInfoList          = ^TAVDeviceInfoList;


  TAVDeviceCapabilitiesQuery = record
    av_class: pAVClass;
    device_context: PAVFormatContext;
    codec: TAVCodecID;
    sample_format: TAVSampleFormat;
    pixel_format: TAVPixelFormat;
    sample_rate: Integer;
    channels: Integer;
    channel_layout: int64_t;
    window_width: Integer;
    window_height: Integer;
    frame_width: Integer;
    frame_height: Integer;
    fps: TAVRational;
  end;

  TAVIOInterruptCB = record
    callback: Tcallback;
    opaque: Pointer;
  end;

  TAVIODirEntryType   = (AVIO_ENTRY_UNKNOWN, AVIO_ENTRY_BLOCK_DEVICE, AVIO_ENTRY_CHARACTER_DEVICE, AVIO_ENTRY_DIRECTORY, AVIO_ENTRY_NAMED_PIPE, AVIO_ENTRY_SYMBOLIC_LINK, AVIO_ENTRY_SOCKET, AVIO_ENTRY_FILE, AVIO_ENTRY_SERVER, AVIO_ENTRY_SHARE, AVIO_ENTRY_WORKGROUP);
  TAVIODataMarkerType = (AVIO_DATA_MARKER_HEADER, AVIO_DATA_MARKER_SYNC_POINT, AVIO_DATA_MARKER_BOUNDARY_POINT, AVIO_DATA_MARKER_UNKNOWN, AVIO_DATA_MARKER_TRAILER, AVIO_DATA_MARKER_FLUSH_POINT);
  PPAVIODirEntry      = ^PAVIODirEntry;
  PAVIODirEntry       = ^TAVIODirEntry;

  TAVIODirEntry = record
    name: PAnsiChar;
    type_: cint;
    utf8: cint;
    size: cint64;
    modification_timestamp: cint64;
    access_timestamp: cint64;
    status_change_timestamp: cint64;
    user_id: cint64;
    group_id: cint64;
    filemode: cint64;
  end;

  TAVIODirContext = record
    url_context: Pointer;
  end;

  TAVIOContext = record
    av_class: pAVClass;
    buffer: PByteArray;
    buffer_size: cint;
    buf_ptr: PByteArray;
    buf_end: PByteArray;
    opaque: Pointer;
    read_packet: TReadWriteFunc;
    write_packet: TReadWriteFunc;
    seek: TSeekFunc;
    pos: cint64;
    must_flush: cint;
    eof_reached: cint;
    write_flag: cint;
    max_packet_size: cint;
    checksum: culong;
    checksum_ptr: PByteArray;
    update_checksum: function(checksum: culong; buf: PAnsiChar; size: cuint): culong; cdecl;
    error: cint;
    read_pause: function(opaque: Pointer; pause: cint): cint; cdecl;
    read_seek: function(opaque: Pointer; stream_index: cint; timestamp: cint64; flags: cint): cint64; cdecl;
    seekable: cint;
    maxsize: cint64;
    direct: cint;
    bytes_read: cint64;
    seek_count: cint;
    writeout_count: cint;
    orig_buffer_size: cint;
    short_seek_threshold: cint;
    protocol_whitelist: PAnsiChar;
    write_data_type: function(opaque: Pointer; buf: Pcuint8; buf_size: cint; type_: TAVIODataMarkerType; time: cint64): cint; cdecl;
    ignore_boundary_point: cint;
    current_type: TAVIODataMarkerType;
    last_time: cint64;
    short_seek_get: function(opaque: Pointer): cint; cdecl;
    written: cint64;
    buf_ptr_max: PByteArray;
    min_packet_size: cint;
  end;

  TAVBPrint = record
  end;

  TAVProbeData = record
    filename: PAnsiChar;
    buf: PByteArray;
    buf_size: cint;
    mime_type: PAnsiChar;
  end;

  TAVPacketList = record
    pkt: TAVPacket;
    next: PAVPacketList;
  end;

  TAVMetadataConv = record
    ctx: PAVFormatContext;
    d_conv: PAVMetadataConv;
    s_conv: PAVMetadataConv;
  end;

  TAVDeviceInfo = record
    device_name: PAnsiChar;
    device_description: PAnsiChar;
  end;

  TAVDeviceInfoList = record
    devices: PPAVDeviceInfo;
    nb_devices: cint;
    default_device: cint;
  end;

  PFFFrac = ^TFFFrac;

  TFFFrac = record
    val: cint64;
    num: cint64;
    den: cint64;
  end;

  TAVOutputFormat = record
    name: PAnsiChar;
    long_name: PAnsiChar;
    mime_type: PAnsiChar;
    extensions: PAnsiChar;
    audio_codec: TAVCodecID;
    video_codec: TAVCodecID;
    subtitle_codec: TAVCodecID;
    flags: cint;
    codec_tag: PPAVCodecTag;
    priv_class: pAVClass;
    next: PAVOutputFormat;
    priv_data_size: cint;
    write_header: function(c: PAVFormatContext): cint; cdecl;
    write_packet: function(c: PAVFormatContext; pkt: PAVPacket): cint; cdecl;
    write_trailer: function(c: PAVFormatContext): cint; cdecl;
    interleave_packet: function(s: PAVFormatContext; out_: PAVPacket; in_: PAVPacket; flush: cint): cint; cdecl;
    query_codec: function(id: TAVCodecID; std_compliance: cint): cint; cdecl;
    get_output_timestamp: procedure(s: PAVFormatContext; stream: cint; dts: Pcint64; wall: Pcint64); cdecl;
    control_message: function(s: PAVFormatContext; type_: cint; data: Pointer; data_size: size_t): cint; cdecl;
    write_uncodec_frame: function(s: PAVFormatContext; stream_index: cint; frame: PPAVFrame; flags: cuint): cint; cdecl;
    get_device_list: function(s: PAVFormatContext; device_list: PAVDeviceInfoList): cint; cdecl;
    create_device_capabilities: function(s: PAVFormatContext; caps: PAVDeviceCapabilitiesQuery): cint; cdecl;
    free_device_capabilities: function(s: PAVFormatContext; caps: PAVDeviceCapabilitiesQuery): cint; cdecl;
    data_codec: TAVCodecID;
    init: function(s: PAVFormatContext): cint; cdecl;
    deinit: procedure(s: PAVFormatContext);
    check_bitstream: function(s: PAVFormatContext; pkt: PAVPacket): cint; cdecl;
  end;

  TAVInputFormat = record
    name: PAnsiChar;
    long_name: PAnsiChar;
    flags: cint;
    extensions: PAnsiChar;
    codec_tag: PPAVCodecTag;
    priv_class: pAVClass;
    mime_type: PAnsiChar;
    next: PAVInputFormat;
    raw_codec_id: cint;
    priv_data_size: cint;
    read_probe: function(p: PAVProbeData): cint; cdecl;
    read_header: function(c: PAVFormatContext): cint; cdecl;
    read_packet: function(c: PAVFormatContext; var pkt: TAVPacket): cint; cdecl;
    read_close: function(c: PAVFormatContext): cint; cdecl;
    read_seek: function(c: PAVFormatContext; stream_index: cint; timestamp: cint64; flags: cint): cint; cdecl;
    read_timestamp: function(s: PAVFormatContext; stream_index: cint; pos: pint64; pos_limit: cint64): cint64; cdecl;
    read_play: function(c: PAVFormatContext): cint; cdecl;
    read_pause: function(c: PAVFormatContext): cint; cdecl;
    read_seek2: function(s: PAVFormatContext; stream_index: cint; min_ts: cint64; ts: cint64; max_ts: cint64; flags: cint): cint; cdecl;
    get_device_list: function(s: PAVFormatContext; device_list: PAVDeviceInfoList): cint; cdecl;
    create_device_capabilities: function(s: PAVFormatContext; caps: PAVDeviceCapabilitiesQuery): cint; cdecl;
    free_device_capabilities: function(s: PAVFormatContext; caps: PAVDeviceCapabilitiesQuery): cint; cdecl;
  end;

  TAVStreamParseType = (AVSTREAM_PARSE_NONE, AVSTREAM_PARSE_FULL, AVSTREAM_PARSE_HEADERS, AVSTREAM_PARSE_TIMESTAMPS, AVSTREAM_PARSE_FULL_ONCE, AVSTREAM_PARSE_FULL_RAW);

  TAVIndexEntry = record
    pos: cint64;
    timestamp: cint64;
    flags_size: cint;
    min_distance: cint;
  end;

  Tduration_error = array [0 .. 1] of array [0 .. MAX_STD_TIMEBASES - 1] of cdouble;
  PStreamInfo     = ^TStreamInfo;

  TStreamInfo = record
    last_dts: cint64;
    duration_gcd: cint64;
    duration_count: cint;
    rfps_duration_sum: cint64;
    duration_error: ^Tduration_error;
    codec_info_duration: cint64;
    codec_info_duration_fields: cint64;
    frame_delay_evidence: cint;
    found_decoder: cint;
    fps_first_dts: cint64;
    fps_first_dts_idx: cint;
    fps_last_dts: cint64;
    fps_last_dts_idx: cint;
  end;

  TAVStream = record
    index: cint;
    id: cint;
{$IFDEF FF_API_LAVF_AVCTX}
    codec: PAVCodecContext;
{$ENDIF}
    priv_data: Pointer;
    time_base: TAVRational;
    start_time: cint64;
    duration: cint64;
    nb_frames: cint64;
    disposition: cint;
    discard: TAVDiscard;
    sample_aspect_ratio: TAVRational;
    metadata: PAVDictionary;
    avg_frame_rate: TAVRational;
    attached_pic: TAVPacket;
    side_data: PAVPacketSideData;
    nb_side_data: cint;
    event_flags: cint;
    r_frame_rate: TAVRational;
{$IFDEF FF_API_LAVF_FFSERVER}
    recommended_encoder_configuration: PAnsiChar;
{$ENDIF}
    codecpar: PAVCodecParameters;
    info: PStreamInfo;
    pts_wrap_bits: cint;
    first_dts: cint64;
    cur_dts: cint64;
    last_IP_pts: cint64;
    last_IP_duration: cint;
    probe_packets: cint;
    codec_info_nb_frames: cint;
    need_parsing: TAVStreamParseType;
    parser: PAVCodecParserContext;
    last_in_packet_buffer: PAVPacketList;
    probe_data: TAVProbeData;
    pts_buffer: array [0 .. MAX_REORDER_DELAY] of cint64;
    index_entries: PAVIndexEntry;
    nb_index_entries: cint;
    index_entries_allocated_size: cuint;
    stream_identifier: cint;
    interleaver_chunk_size: cint64;
    interleaver_chunk_duration: cint64;
    request_probe: cint;
    skip_to_keyframe: cint;
    skip_samples: cint;
    start_skip_samples: cint64;
    first_discard_sample: cint64;
    last_discard_sample: cint64;
    nb_decoded_frames: cint;
    mux_ts_offset: cint64;
    pts_wrap_reference: cint64;
    pts_wrap_behavior: cint;
    update_initial_durations_done: cint;
    pts_reorder_error: array [0 .. MAX_REORDER_DELAY] of cint64;
    pts_reorder_error_count: array [0 .. MAX_REORDER_DELAY] of byte;
    last_dts_for_order_check: cint64;
    dts_ordered: byte;
    dts_misordered: byte;
    inject_global_side_data: cint;
    display_aspect_ratio: TAVRational;
    internal: Pointer;
  end;

  TAVProgram = record
    id: cint;
    flags: cint;
    discard: TAVDiscard;
    stream_index: Pcuint;
    nb_stream_indexes: cuint;
    metadata: PAVDictionary;
    program_num: cint;
    pmt_pid: cint;
    pcr_pid: cint;
    start_time: cint64;
    end_time: cint64;
    pts_wrap_reference: cint64;
    pts_wrap_behavior: cint;
  end;

  PAVChapter = ^TAVChapter;

  TAVChapter = record
    id: cint;
    time_base: TAVRational;
    start, end_: cint64;
    metadata: PAVDictionary;
  end;

  TAVChapterArray             = array [0 .. (MaxInt div SizeOf(TAVChapter)) - 1] of TAVChapter;
  PAVChapterArray             = ^TAVChapterArray;
  TAVDurationEstimationMethod = (AVFMT_DURATION_FROM_PTS, AVFMT_DURATION_FROM_STREAM, AVFMT_DURATION_FROM_BITRATE);
  PAVFormatInternal           = ^TAVFormatInternal;

  TAVFormatInternal = record
    nb_interleaved_streams: cint;
    inject_global_side_data: cint;
  end;

  TAv_format_control_message = function(s: PAVFormatContext; type_: cint; data: Pointer; data_size: size_t)                                         : cint; cdecl;
  TAVOpenCallback            = function(s: PAVFormatContext; pb: PPAVIOContext; url: PAnsiChar; flags: cint; int_cb: PAVIOInterruptCB; options: PPAVDictionary): cint; cdecl;

  TAVFormatContext = record
    av_class: pAVClass;
    iformat: PAVInputFormat;
    oformat: PAVOutputFormat;
    priv_data: Pointer;
    pb: PAVIOContext;
    ctx_flags: cint;
    nb_streams: cuint;
    streams: PPAVStream;
{$IFDEF FF_API_FORMAT_FILENAME}
    filename: array [0 .. 1023] of AnsiChar;
{$ENDIF}
    url: PAnsiChar;
    start_time: cint64;
    duration: cint64;
    bit_rate: cint64;
    packet_size: cuint;
    max_delay: cint;
    flags: cint;
    probesize: cint64;
    max_analyze_duration: cint64;
    key: pbyte;
    keylen: cint;
    nb_programs: cuint;
    programs: PPAVProgram;
    video_codec_id: TAVCodecID;
    audio_codec_id: TAVCodecID;
    subtitle_codec_id: TAVCodecID;
    max_index_size: cuint;
    max_picture_buffer: cuint;
    nb_chapters: cuint;
    chapters: PAVChapterArray;
    metadata: PAVDictionary;
    start_time_realtime: cint64;
    fps_probe_size: cint;
    error_recognition: cint;
    interrupt_callback: TAVIOInterruptCB;
    debug: cint;
    max_interleave_delta: cint64;
    strict_std_compliance: cint;
    event_flags: cint;
    max_ts_probe: cint;
    avoid_negative_ts: cint;
    ts_id: cint;
    audio_preload: cint;
    max_chunk_duration: cint;
    max_chunk_size: cint;
    use_wallclock_as_timestamps: cint;
    avio_flags: cint;
    duration_estimation_method: TAVDurationEstimationMethod;
    skip_initial_bytes: cint64;
    correct_ts_overflow: cuint;
    seek2any: cint;
    flush_packets: cint;
    probe_score: cint;
    format_probesize: cint;
    codec_whitelist: PAnsiChar;
    format_whitelist: PAnsiChar;
    internal: PAVFormatInternal;
    io_repositioned: cint;
    video_codec: PAVCodec;
    audio_codec: PAVCodec;
    subtitle_codec: PAVCodec;
    data_codec: PAVCodec;
    metadata_header_padding: cint;
    opaque: Pointer;
    control_message_cb: TAv_format_control_message;
    output_ts_offset: cint64;
    dump_separator: Pcuint8;
    data_codec_id: TAVCodecID;
{$IFDEF FF_API_OLD_OPEN_CALLBACKS}
    open_cb: function(s: PAVFormatContext; p: PPAVIOContext; url: PAnsiChar; flags: cint; int_cb: PAVIOInterruptCB; options: PPAVDictionary): cint; cdecl;
{$ENDIF}
    protocol_whitelist: pchar;
    io_open: function(s: PAVFormatContext; pb: PPAVIOContext; url: pchar; flags: cint; options: PPAVDictionary): cint; cdecl;
    io_close: procedure(s: PAVFormatContext; pb: PAVIOContext); cdecl;
    protocol_blacklist: PAnsiChar;
    MAX_STREAMS: cint;
  end;

  TAVTimebaseSource = (AVFMT_TBCF_AUTO = -1, AVFMT_TBCF_DECODER, AVFMT_TBCF_DEMUXER, AVFMT_TBCF_R_FRAMERATE);

{$IFDEF FF_API_FORMAT_GET_SET}
function av_format_get_probe_score(s: PAVFormatContext): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_format_get_video_codec(s: PAVFormatContext): PAVCodec; cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_format_set_video_codec(s: PAVFormatContext; c: PAVCodec); cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_format_get_audio_codec(s: PAVFormatContext): PAVCodec; cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_format_set_audio_codec(s: PAVFormatContext; c: PAVCodec); cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_format_get_subtitle_codec(s: PAVFormatContext): PAVCodec; cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_format_set_subtitle_codec(s: PAVFormatContext; c: PAVCodec); cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_format_get_data_codec(s: PAVFormatContext): PAVCodec; cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_format_set_data_codec(s: PAVFormatContext; c: PAVCodec); cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_format_get_metadata_header_padding(s: PAVFormatContext): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_format_set_metadata_header_padding(s: PAVFormatContext; c: cint); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_format_get_opaque(s: PAVFormatContext); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_format_set_opaque(s: PAVFormatContext; opaque: Pointer); cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_format_get_control_message_cb(s: PAVFormatContext): TAv_format_control_message; cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_format_set_control_message_cb(s: PAVFormatContext; callback: TAv_format_control_message); cdecl; external c_strFFmpegDllX64Name; deprecated;
{$IFDEF FF_API_OLD_OPEN_CALLBACKS}
function av_format_get_open_cb(s: PAVFormatContext): TAVOpenCallback; cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_format_set_open_cb(s: PAVFormatContext; callback: TAVOpenCallback); cdecl; external c_strFFmpegDllX64Name; deprecated;
{$ENDIF}
{$ENDIF}
function av_get_packet(s: PAVIOContext; var pkt: TAVPacket; size: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_append_packet(s: PAVIOContext; var pkt: TAVPacket; size: cint): cint; cdecl; external c_strFFmpegDllX64Name;
procedure av_format_inject_global_side_data(s: PAVFormatContext); cdecl; external c_strFFmpegDllX64Name;
function av_fmt_ctx_get_duration_estimation_method(ctx: PAVFormatContext): TAVDurationEstimationMethod; cdecl; external c_strFFmpegDllX64Name;
{$IFDEF FF_API_FORMAT_GET_SET}
function av_stream_get_r_frame_rate(s: PAVStream): TAVRational; cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_stream_set_r_frame_rate(s: PAVStream; r: TAVRational); cdecl; external c_strFFmpegDllX64Name; deprecated;
{$IFDEF FF_API_LAVF_FFSERVER}
function av_stream_get_recommended_encoder_configuration(s: PAVStream): PAnsiChar; cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_stream_set_recommended_encoder_configuration(s: PAVStream; configuration: PAnsiChar); cdecl; external c_strFFmpegDllX64Name; deprecated;
{$ENDIF}
{$ENDIF}
function av_stream_get_parser(s: PAVStream): PAVCodecParserContext; cdecl; external c_strFFmpegDllX64Name;
function av_stream_get_end_pts(st: PAVStream): cint64; cdecl; external c_strFFmpegDllX64Name;
function avformat_version(): cuint; cdecl; external c_strFFmpegDllX64Name;
function avformat_configuration(): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function avformat_license(): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
{$IFDEF FF_API_NEXT}
procedure av_register_all(); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_register_input_format(format: PAVInputFormat); cdecl; external c_strFFmpegDllX64Name; deprecated;
procedure av_register_output_format(format: PAVOutputFormat); cdecl; external c_strFFmpegDllX64Name; deprecated;
{$ENDIF}
function avformat_network_init(): cint; cdecl; external c_strFFmpegDllX64Name;
function avformat_network_deinit(): cint; cdecl; external c_strFFmpegDllX64Name;
{$IFDEF FF_API_NEXT}
function av_iformat_next(f: PAVInputFormat): PAVInputFormat; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_oformat_next(f: PAVOutputFormat): PAVOutputFormat; cdecl; external c_strFFmpegDllX64Name; deprecated;
{$ENDIF}
function av_muxer_iterate(opaque: Pointer): PAVOutputFormat; cdecl; external c_strFFmpegDllX64Name; deprecated;
function av_demuxer_iterate(opaque: Pointer): PAVInputFormat; cdecl; external c_strFFmpegDllX64Name; deprecated;
function avformat_alloc_context(): PAVFormatContext; cdecl; external c_strFFmpegDllX64Name;
procedure avformat_free_context(s: PAVFormatContext); cdecl; external c_strFFmpegDllX64Name;
function avformat_get_class(): pAVClass; cdecl; external c_strFFmpegDllX64Name;
function avformat_new_stream(s: PAVFormatContext; c: PAVCodec): PAVStream; cdecl; external c_strFFmpegDllX64Name;
function av_stream_add_side_data(st: PAVStream; type_: TAVPacketSideDataType; data: Pcuint8; size: size_t): cint; cdecl; external c_strFFmpegDllX64Name;
function av_stream_new_side_data(stream: PAVStream; type_: TAVPacketSideDataType; size: cint): Pcuint8; cdecl; external c_strFFmpegDllX64Name;
function av_stream_get_side_data(stream: PAVStream; type_: TAVPacketSideDataType; size: Pcint): Pcuint8; cdecl; external c_strFFmpegDllX64Name;
function av_new_program(s: PAVFormatContext; id: cint): PAVProgram; cdecl; external c_strFFmpegDllX64Name;
{$IFDEF FF_API_PKT_DUMP}
procedure av_pkt_dump(f: PAVFile; pkt: PAVPacket; dump_payload: cint); cdecl; external c_strFFmpegDllX64Name;
procedure av_pkt_dump_log(avcl: Pointer; level: cint; pkt: PAVPacket; dump_payload: cint); cdecl; external c_strFFmpegDllX64Name;
{$IFEND}
function avformat_alloc_output_context2(ctx: PPAVFormatContext; oformat: PAVOutputFormat; format_name: PAnsiChar; filename: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function av_find_input_format(short_name: PAnsiChar): PAVInputFormat; cdecl; external c_strFFmpegDllX64Name;
function av_probe_input_format(pd: PAVProbeData; is_opened: cint): PAVInputFormat; cdecl; external c_strFFmpegDllX64Name;
function av_probe_input_format2(pd: PAVProbeData; is_opened: cint; score_max: Pcint): PAVInputFormat; cdecl; external c_strFFmpegDllX64Name;
function av_probe_input_format3(pd: PAVProbeData; is_opened: cint; score_ret: Pcint): PAVInputFormat; cdecl; external c_strFFmpegDllX64Name;
function av_probe_input_buffer2(pb: PAVIOContext; var fmt: PAVInputFormat; url: PAnsiChar; logctx: Pointer; offset: cuint; max_probe_size: cuint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_probe_input_buffer(pb: PAVIOContext; var fmt: PAVInputFormat; url: PAnsiChar; logctx: Pointer; offset: cuint; max_probe_size: cuint): cint; cdecl; external c_strFFmpegDllX64Name;
function avformat_open_input(ps: PPAVFormatContext; url: PAnsiChar; fmt: PAVInputFormat; options: PPAVDictionary): cint; cdecl; external c_strFFmpegDllX64Name;
function av_demuxer_open(ic: PAVFormatContext): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
function avformat_find_stream_info(ic: PAVFormatContext; options: PPAVDictionary): cint; cdecl; external c_strFFmpegDllX64Name;
function av_find_program_from_stream(ic: PAVFormatContext; last: PAVProgram; s: cint): PAVProgram; cdecl; external c_strFFmpegDllX64Name;
procedure av_program_add_stream_index(ac: PAVFormatContext; progid: cint; idx: cuint); cdecl; external c_strFFmpegDllX64Name;
function av_find_best_stream(ic: PAVFormatContext; type_: TAVMediaType; wanted_stream_nb: cint; related_stream: cint; decoder_ret: PPAVCodec; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_read_frame(s: PAVFormatContext; var pkt: TAVPacket): cint; cdecl; external c_strFFmpegDllX64Name;
function av_seek_frame(s: PAVFormatContext; stream_index: cint; timestamp: cint64; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avformat_seek_file(s: PAVFormatContext; stream_index: cint; min_ts, ts, max_ts: cint64; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avformat_flush(s: PAVFormatContext): cint; cdecl; external c_strFFmpegDllX64Name;
function av_read_play(s: PAVFormatContext): cint; cdecl; external c_strFFmpegDllX64Name;
function av_read_pause(s: PAVFormatContext): cint; cdecl; external c_strFFmpegDllX64Name;
procedure avformat_close_input(s: PPAVFormatContext); cdecl; external c_strFFmpegDllX64Name;
function avformat_write_header(s: PAVFormatContext; options: Pointer): cint; cdecl; external c_strFFmpegDllX64Name;
function avformat_init_output(s: PAVFormatContext; options: PPAVDictionary): cint; cdecl; external c_strFFmpegDllX64Name;
function av_write_frame(s: PAVFormatContext; pkt: PAVPacket): cint; cdecl; external c_strFFmpegDllX64Name;
function av_interleaved_write_frame(s: PAVFormatContext; var pkt: TAVPacket): cint; cdecl; external c_strFFmpegDllX64Name;
function av_write_uncoded_frame(s: PAVFormatContext; stream_index: cint; frame: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function av_interleaved_write_uncoded_frame(s: PAVFormatContext; stream_index: cint; frame: PAVFrame): cint; cdecl; external c_strFFmpegDllX64Name;
function av_write_uncoded_frame_query(s: PAVFormatContext; stream_index: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_write_trailer(s: PAVFormatContext): cint; cdecl; external c_strFFmpegDllX64Name;
function av_guess_format(short_name: PAnsiChar; filename: PAnsiChar; mime_type: PAnsiChar): PAVOutputFormat; cdecl; external c_strFFmpegDllX64Name;
function av_guess_codec(fmt: PAVOutputFormat; short_name: PAnsiChar; filename: PAnsiChar; mime_type: PAnsiChar; type_: TCodecType): TAVCodecID; cdecl; external c_strFFmpegDllX64Name;
function av_get_output_timestamp(s: PAVFormatContext; stream: cint; dts: Pcint64; wall: Pcint64): cint; cdecl; external c_strFFmpegDllX64Name;
procedure av_hex_dump(f: PAVFile; buf: PByteArray; size: cint); cdecl; external c_strFFmpegDllX64Name;
procedure av_hex_dump_log(avcl: Pointer; level: cint; buf: PByteArray; size: cint); cdecl; external c_strFFmpegDllX64Name;
procedure av_pkt_dump2(f: PAVFile; pkt: PAVPacket; dump_payload: cint; st: PAVStream); cdecl; external c_strFFmpegDllX64Name;
procedure av_pkt_dump_log2(avcl: Pointer; level: cint; pkt: PAVPacket; dump_payload: cint; st: PAVStream); cdecl; external c_strFFmpegDllX64Name;
function av_codec_get_id(var tags: PAVCodecTag; tag: cuint): TAVCodecID; cdecl; external c_strFFmpegDllX64Name;
function av_codec_get_tag(var tags: PAVCodecTag; id: TAVCodecID): cuint; cdecl; external c_strFFmpegDllX64Name;
function av_codec_get_tag2(var tags: PAVCodecTag; id: TAVCodecID; tag: Pcuint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_find_default_stream_index(s: PAVFormatContext): cint; cdecl; external c_strFFmpegDllX64Name;
function av_index_search_timestamp(st: PAVStream; timestamp: cint64; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_add_index_entry(st: PAVStream; pos: cint64; timestamp: cint64; size: cint; distance: cint; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
procedure av_url_split(proto: PAnsiChar; proto_size: cint; authorization: PAnsiChar; authorization_size: cint; hostname: PAnsiChar; hostname_size: cint; port_ptr: Pcint; path: PAnsiChar; path_size: cint; url: PAnsiChar); cdecl; external c_strFFmpegDllX64Name;
procedure av_dump_format(ic: PAVFormatContext; index: cint; url: PAnsiChar; is_output: cint); cdecl; external c_strFFmpegDllX64Name;
function av_get_frame_filename2(buf: PAnsiChar; buf_size: cint; path: PAnsiChar; number: cint; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_get_frame_filename(buf: PAnsiChar; buf_size: cint; path: PAnsiChar; number: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_filename_number_test(filename: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function av_sdp_create(ac: Pointer; n_files: cint; buf: PAnsiChar; size: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function av_match_ext(filename: pchar; extensions: pchar): cint; cdecl; external c_strFFmpegDllX64Name;
function avformat_query_codec(ofmt: PAVOutputFormat; codec_id: TAVCodecID; std_compliance: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avformat_get_riff_video_tags(): PAVCodecTag; cdecl; external c_strFFmpegDllX64Name;
function avformat_get_riff_audio_tags(): PAVCodecTag; cdecl; external c_strFFmpegDllX64Name;
function avformat_get_mov_video_tags(): PAVCodecTag; cdecl; external c_strFFmpegDllX64Name;
function avformat_get_mov_audio_tags(): PAVCodecTag; cdecl; external c_strFFmpegDllX64Name;
function av_guess_sample_aspect_ratio(format: PAVFormatContext; stream: PAVStream; frame: PAVFrame): TAVRational; cdecl; external c_strFFmpegDllX64Name;
function av_guess_frame_rate(ctx: PAVFormatContext; stream: PAVStream; frame: PAVFrame): TAVRational; cdecl; external c_strFFmpegDllX64Name;
function avformat_match_stream_specifier(s: PAVFormatContext; st: PAVStream; spec: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function avformat_queue_attached_pictures(s: PAVFormatContext): cint; cdecl; external c_strFFmpegDllX64Name;
{$IFDEF FF_API_OLD_BSF}
function av_apply_bitstream_filters(codec: PAVCodecContext; pkt: PAVPacket; bsfc: PAVBitStreamFilterContext): cint; cdecl; external c_strFFmpegDllX64Name; deprecated;
{$ENDIF}
function avformat_transfer_internal_stream_timing_info(ofmt: PAVOutputFormat; ost: PAVStream; ist: PAVStream; copy_tb: TAVTimebaseSource): cint; cdecl; external c_strFFmpegDllX64Name;
function av_stream_get_codec_timebase(st: PAVStream): TAVRational; cdecl; external c_strFFmpegDllX64Name;
function avio_find_protocol_name(url: PAnsiChar): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function avio_check(url: PAnsiChar; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avpriv_io_move(url_src: PAnsiChar; url_dst: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function avpriv_io_delete(url: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_open_dir(s: PPAVIODirContext; url: PAnsiChar; options: PPAVDictionary): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_read_dir(s: PAVIODirContext; next: PPAVIODirEntry): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_close_dir(s: PPAVIODirContext): cint; cdecl; external c_strFFmpegDllX64Name;
procedure avio_free_directory_entry(entry: PPAVIODirEntry); cdecl; external c_strFFmpegDllX64Name;
function avio_alloc_context(buffer: PAnsiChar; buffer_size: cint; write_flag: cint; opaque: Pointer; read_packet: TReadWriteFunc; write_packet: TReadWriteFunc; seek: TSeekFunc): PAVIOContext; cdecl; external c_strFFmpegDllX64Name;
procedure avio_context_free(s: PAVIOContext); cdecl; external c_strFFmpegDllX64Name;
procedure avio_w8(s: PAVIOContext; b: cint); cdecl; external c_strFFmpegDllX64Name;
procedure avio_write(s: PAVIOContext; buf: PAnsiChar; size: cint); cdecl; external c_strFFmpegDllX64Name;
procedure avio_wl64(s: PAVIOContext; val: cuint64); cdecl; external c_strFFmpegDllX64Name;
procedure avio_wb64(s: PAVIOContext; val: cuint64); cdecl; external c_strFFmpegDllX64Name;
procedure avio_wl32(s: PAVIOContext; val: cuint); cdecl; external c_strFFmpegDllX64Name;
procedure avio_wb32(s: PAVIOContext; val: cuint); cdecl; external c_strFFmpegDllX64Name;
procedure avio_wl24(s: PAVIOContext; val: cuint); cdecl; external c_strFFmpegDllX64Name;
procedure avio_wb24(s: PAVIOContext; val: cuint); cdecl; external c_strFFmpegDllX64Name;
procedure avio_wl16(s: PAVIOContext; val: cuint); cdecl; external c_strFFmpegDllX64Name;
procedure avio_wb16(s: PAVIOContext; val: cuint); cdecl; external c_strFFmpegDllX64Name;
function avio_put_str(s: PAVIOContext; str: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_put_str16le(s: PAVIOContext; str: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_put_str16be(s: PAVIOContext; str: PAnsiChar): cint; cdecl; external c_strFFmpegDllX64Name;
procedure avio_write_marker(s: PAVIOContext; time: cint64; type_: TAVIODataMarkerType); cdecl; external c_strFFmpegDllX64Name;
function avio_seek(s: PAVIOContext; offset: cint64; whence: cint): cint64; cdecl; external c_strFFmpegDllX64Name;
function avio_skip(s: PAVIOContext; offset: cint64): cint64; cdecl; external c_strFFmpegDllX64Name;
function avio_size(s: PAVIOContext): cint64; cdecl; external c_strFFmpegDllX64Name;
function avio_feof(s: PAVIOContext): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_printf(s: PAVIOContext; fmt: PAnsiChar; args: array of const): cint; cdecl; external c_strFFmpegDllX64Name;
procedure avio_flush(s: PAVIOContext); cdecl; external c_strFFmpegDllX64Name;
function avio_read(s: PAVIOContext; buf: pbyte; size: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_read_partial(s: PAVIOContext; buf: pbyte; size: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_r8(s: PAVIOContext): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_rl16(s: PAVIOContext): cuint; cdecl; external c_strFFmpegDllX64Name;
function avio_rl24(s: PAVIOContext): cuint; cdecl; external c_strFFmpegDllX64Name;
function avio_rl32(s: PAVIOContext): cuint; cdecl; external c_strFFmpegDllX64Name;
function avio_rl64(s: PAVIOContext): cuint64; cdecl; external c_strFFmpegDllX64Name;
function avio_rb16(s: PAVIOContext): cuint; cdecl; external c_strFFmpegDllX64Name;
function avio_rb24(s: PAVIOContext): cuint; cdecl; external c_strFFmpegDllX64Name;
function avio_rb32(s: PAVIOContext): cuint; cdecl; external c_strFFmpegDllX64Name;
function avio_rb64(s: PAVIOContext): cuint64; cdecl; external c_strFFmpegDllX64Name;
function avio_get_str(pb: PAVIOContext; maxlen: cint; buf: PAnsiChar; buflen: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_get_str16le(pb: PAVIOContext; maxlen: cint; buf: PAnsiChar; buflen: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_get_str16be(pb: PAVIOContext; maxlen: cint; buf: PAnsiChar; buflen: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_open(s: PPAVIOContext; url: PAnsiChar; flags: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_open2(s: PPAVIOContext; url: PAnsiChar; flags: cint; int_cb: PAVIOInterruptCB; options: PPAVDictionary): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_close(s: PAVIOContext): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_closep(s: PPAVIOContext): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_open_dyn_buf(s: PPAVIOContext): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_get_dyn_buf(s: PAVIOContext; var pbuffer: Pcuint8): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_close_dyn_buf(s: PAVIOContext; var pbuffer: Pcuint8): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_enum_protocols(var opaque: Pointer; output: cint): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function avio_pause(h: PAVIOContext; pause: cint): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_seek_time(h: PAVIOContext; stream_index: cint; timestamp: cint64; flags: cint): cint64; cdecl; external c_strFFmpegDllX64Name;
function avio_read_to_bprint(h: PAVIOContext; pb: PAVBPrint; max_size: size_t): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_accept(s: PAVIOContext; c: PPAVIOContext): cint; cdecl; external c_strFFmpegDllX64Name;
function avio_handshake(c: PAVIOContext): cint; cdecl; external c_strFFmpegDllX64Name;

var
  LIBAVFORMAT_VERSION_INT: Integer;
  LIBAVFORMAT_VERSION    : PAnsiChar;
  LIBAVFORMAT_BUILD      : Integer;
  LIBAVFORMAT_IDENT      : PAnsiChar;

implementation

function avio_tell(s: PAVIOContext): cint64; {$IFDEF HasInline}inline; {$ENDIF}
begin
  Result := avio_seek(s, 0, SEEK_CUR);
end;

initialization
  LIBAVFORMAT_VERSION_INT := AV_VERSION_INT(LIBAVFORMAT_VERSION_MAJOR, LIBAVFORMAT_VERSION_MINOR, LIBAVFORMAT_VERSION_MICRO);
  LIBAVFORMAT_VERSION     := AV_VERSION(LIBAVFORMAT_VERSION_MAJOR, LIBAVFORMAT_VERSION_MINOR, LIBAVFORMAT_VERSION_MICRO);
  LIBAVFORMAT_BUILD       := LIBAVFORMAT_VERSION_INT;
  LIBAVFORMAT_IDENT       := PAnsiChar(AnsiString('Lavf' + AV_STRINGIFY(LIBAVFORMAT_VERSION)));

end.

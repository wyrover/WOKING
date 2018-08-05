const

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

  AV_CH_LAYOUT_NATIVE = $8000000000000000;

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
  TAVMatrixEncoding = (AV_MATRIX_ENCODING_NONE, AV_MATRIX_ENCODING_DOLBY, AV_MATRIX_ENCODING_DPLII, AV_MATRIX_ENCODING_DPLIIX, AV_MATRIX_ENCODING_DPLIIZ, AV_MATRIX_ENCODING_DOLBYEX, AV_MATRIX_ENCODING_DOLBYHEADPHONE, AV_MATRIX_ENCODING_NB);

function av_get_channel_layout(name: PAnsiChar): cuint64; cdecl; external av__util;

procedure av_get_channel_layout_string(buf: PAnsiChar; buf_size: cint; nb_channels: cint; channel_layout: cuint64); cdecl; external av__util;

type

  PAVBPrint = ^TAVBPrint;

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

procedure av_bprint_channel_layout(bp: PAVBPrint; nb_channels: cint; channel_layout: cuint64); cdecl; external av__util;

function av_get_channel_layout_nb_channels(channel_layout: cuint64): cint; cdecl; external av__util;

function av_get_default_channel_layout(nb_channels: cint): cint64; cdecl; external av__util;

function av_get_channel_layout_channel_index(channel_layout: cuint64; channel: cuint64): cint; cdecl; external av__util;

function av_channel_layout_extract_channel(channel_layout: cuint64; index: cint): cuint64; cdecl; external av__util;

function av_get_channel_name(channel: cuint64): PAnsiChar; cdecl; external av__util;

function av_get_channel_description(channel: cuint64): PAnsiChar; cdecl; external av__util;

function av_get_standard_channel_layout(index: cuint; layout: Pcuint64; name: PPAnsiChar): cint; cdecl; external av__util;

{$IFDEF FF_API_AUDIO_CONVERT}

type
  PAVAudioConvert = ^TAVAudioConvert;

  TAVAudioConvert = record
    in_channels, out_channels: cint;
    fmt_pair: cint;
  end;

function av_audio_convert_alloc(out_fmt: TAVSampleFormat; out_channels: cint; in_fmt: TAVSampleFormat; in_channels: cint; matrix: Pcfloat; flags: cint): PAVAudioConvert; cdecl; external av__codec;

procedure av_audio_convert_free(ctx: PAVAudioConvert); cdecl; external av__codec;

type
  P6 = array [1 .. 6] of pointer;
  I6 = array [1 .. 6] of cint;

function av_audio_convert(ctx: PAVAudioConvert; out [6]: P6; out_stride[6]: I6; in [6]: P6; in_stride[6]: I6; len: cint): cint; cdecl; external av__codec;

{$IFEND}

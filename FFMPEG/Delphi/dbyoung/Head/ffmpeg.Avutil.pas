unit ffmpeg.Avutil;

interface

uses System.SysUtils, ffmpeg.Common;

type
  PAVFrame        = ^TAVFrame;
  PTAVPixelFormat = ^TAVPixelFormat;

  TAVPixelFormat = record

  end;

  TAVFrame = record

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
  Result := PAnsiChar(AnsiString(Format('%d.%02.2d.%02.2d', [a, b, c])));
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

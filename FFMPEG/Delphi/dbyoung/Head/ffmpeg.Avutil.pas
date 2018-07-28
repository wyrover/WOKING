unit ffmpeg.Avutil;

interface

uses ffmpeg.Common;

function av_gettime: Int64; cdecl; external c_strFFmpegDllX64Name;

function av_gettime_relative: Int64; cdecl; external c_strFFmpegDllX64Name;

function av_gettime_relative_is_monotonic: Integer; cdecl; external c_strFFmpegDllX64Name;

function av_usleep(usec: Cardinal): Integer; cdecl; external c_strFFmpegDllX64Name;

implementation

end.

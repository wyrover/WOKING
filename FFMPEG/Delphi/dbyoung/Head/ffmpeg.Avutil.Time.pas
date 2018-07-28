unit ffmpeg.Avutil.Time;

interface

uses ffmpeg.Common;

{
  * Get the current time in microseconds.
}

function av_gettime: Int64; cdecl; external c_strFFmpegDllX64Name;

{
  * Get the current time in microseconds since some unspecified starting point.
  * On platforms that support it, the time comes from a monotonic clock
  * This property makes this time source ideal for measuring relative time.
  * The returned values may not be monotonic on platforms where a monotonic
  * clock is not available.
}

function av_gettime_relative: Int64; cdecl; external c_strFFmpegDllX64Name;

function av_gettime_relative_is_monotonic: Integer; cdecl; external c_strFFmpegDllX64Name;

function av_usleep(usec: Cardinal): Integer; cdecl; external c_strFFmpegDllX64Name;

implementation

end.

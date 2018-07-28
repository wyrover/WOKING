unit ffmpeg.Avutil;

interface

uses System.SysUtils, ffmpeg.Common;

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

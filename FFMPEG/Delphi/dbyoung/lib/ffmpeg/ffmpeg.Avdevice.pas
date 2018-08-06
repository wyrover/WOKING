unit ffmpeg.Avdevice;

interface

uses ffmpeg.Common, ffmpeg.Avutil, ffmpeg.Avcodec, ffmpeg.Avformat;

const
  LIBAVDEVICE_VERSION_MAJOR = 58;
  LIBAVDEVICE_VERSION_MINOR = 4;
  LIBAVDEVICE_VERSION_MICRO = 101;

type
  AVDeviceRect = record
    x: Integer;
    y: Integer;
    width: Integer;
    height: Integer;
  end;

  AVAppToDevMessageType = (                                                                                //
    AV_APP_TO_DEV_NONE = (Ord('N') shl 24) or (Ord('O') shl 16) or (Ord('N') shl 8) or Ord('E'),           //
    AV_APP_TO_DEV_WINDOW_SIZE = (Ord('G') shl 24) or (Ord('E') shl 16) or (Ord('O') shl 8) or Ord('M'),    //
    AV_APP_TO_DEV_WINDOW_REPAINT = (Ord('R') shl 24) or (Ord('E') shl 16) or (Ord('P') shl 8) or Ord('A'), //
    AV_APP_TO_DEV_PAUSE = (Ord('P') shl 24) or (Ord('A') shl 16) or (Ord('U') shl 8) or Ord(' '),          //
    AV_APP_TO_DEV_PLAY = (Ord('P') shl 24) or (Ord('L') shl 16) or (Ord('A') shl 8) or Ord('Y'),           //
    AV_APP_TO_DEV_TOGGLE_PAUSE = (Ord('P') shl 24) or (Ord('A') shl 16) or (Ord('U') shl 8) or Ord('T'),   //
    AV_APP_TO_DEV_SET_VOLUME = (Ord('S') shl 24) or (Ord('V') shl 16) or (Ord('O') shl 8) or Ord('L'),     //
    AV_APP_TO_DEV_MUTE = (Ord(' ') shl 24) or (Ord('M') shl 16) or (Ord('U') shl 8) or Ord('T'),           //
    AV_APP_TO_DEV_UNMUTE = (Ord('U') shl 24) or (Ord('M') shl 16) or (Ord('U') shl 8) or Ord('T'),         //
    AV_APP_TO_DEV_TOGGLE_MUTE = (Ord('T') shl 24) or (Ord('M') shl 16) or (Ord('U') shl 8) or Ord('T'),    //
    AV_APP_TO_DEV_GET_VOLUME = (Ord('G') shl 24) or (Ord('V') shl 16) or (Ord('O') shl 8) or Ord('L'),     //
    AV_APP_TO_DEV_GET_MUTE = (Ord('G') shl 24) or (Ord('M') shl 16) or (Ord('U') shl 8) or Ord('T')        //
    );

  AVDevToAppMessageType = (                                                                                       //
    AV_DEV_TO_APP_NONE = (Ord('N') shl 24) or (Ord('O') shl 16) or (Ord('N') shl 8) or Ord('E'),                  //
    AV_DEV_TO_APP_CREATE_WINDOW_BUFFER = (Ord('B') shl 24) or (Ord('C') shl 16) or (Ord('R') shl 8) or Ord('E'),  //
    AV_DEV_TO_APP_PREPARE_WINDOW_BUFFER = (Ord('B') shl 24) or (Ord('P') shl 16) or (Ord('R') shl 8) or Ord('E'), //
    AV_DEV_TO_APP_DISPLAY_WINDOW_BUFFER = (Ord('B') shl 24) or (Ord('D') shl 16) or (Ord('I') shl 8) or Ord('S'), //
    AV_DEV_TO_APP_DESTROY_WINDOW_BUFFER = (Ord('B') shl 24) or (Ord('D') shl 16) or (Ord('E') shl 8) or Ord('S'), //
    AV_DEV_TO_APP_BUFFER_OVERFLOW = (Ord('B') shl 24) or (Ord('O') shl 16) or (Ord('F') shl 8) or Ord('L'),       //
    AV_DEV_TO_APP_BUFFER_UNDERFLOW = (Ord('B') shl 24) or (Ord('U') shl 16) or (Ord('F') shl 8) or Ord('L'),      //
    AV_DEV_TO_APP_BUFFER_READABLE = (Ord('B') shl 24) or (Ord('R') shl 16) or (Ord('D') shl 8) or Ord(' '),       //
    AV_DEV_TO_APP_BUFFER_WRITABLE = (Ord('B') shl 24) or (Ord('W') shl 16) or (Ord('R') shl 8) or Ord(' '),       //
    AV_DEV_TO_APP_MUTE_STATE_CHANGED = (Ord('C') shl 24) or (Ord('M') shl 16) or (Ord('U') shl 8) or Ord('T'),    //
    AV_DEV_TO_APP_VOLUME_LEVEL_CHANGED = (Ord('C') shl 24) or (Ord('V') shl 16) or (Ord('O') shl 8) or Ord('L')   //
    );

function av_device_capabilities(): TAVOption; cdecl; external c_strFFmpegDllX64Name;
function av_device_ffversion(): PAnsiChar; cdecl; external c_strFFmpegDllX64Name;
function av_fopen_utf8(const path: PAnsiChar; const mode: PAnsiChar): THandle; cdecl; external c_strFFmpegDllX64Name;
function av_input_audio_device_next(d: PAVInputFormat): PAVInputFormat; cdecl; external c_strFFmpegDllX64Name;
function av_input_video_device_next(d: PAVInputFormat): PAVInputFormat; cdecl; external c_strFFmpegDllX64Name;
function av_output_audio_device_next(d: pAVOutputFormat): pAVOutputFormat; cdecl; external c_strFFmpegDllX64Name;
function av_output_video_device_next(d: pAVOutputFormat): pAVOutputFormat; cdecl; external c_strFFmpegDllX64Name;
function avdevice_app_to_dev_control_message(s: PAVFormatContext; _type: AVAppToDevMessageType; data: pinteger; data_size: size_t): Integer; cdecl; external c_strFFmpegDllX64Name;
function avdevice_capabilities_create: Integer; cdecl; external c_strFFmpegDllX64Name;
procedure avdevice_capabilities_free; cdecl; external c_strFFmpegDllX64Name;
function avdevice_configuration(): pchar; cdecl; external c_strFFmpegDllX64Name;
function avdevice_dev_to_app_control_message(s: PAVFormatContext; _type: AVDevToAppMessageType; data: pinteger; data_size: size_t): Integer; cdecl; external c_strFFmpegDllX64Name;
procedure avdevice_free_list_devices(var device_list: PAVDeviceInfoList); cdecl; external c_strFFmpegDllX64Name;
function avdevice_license(): pchar; cdecl; external c_strFFmpegDllX64Name;
function avdevice_list_devices(s: PAVFormatContext; device_list: TAVDeviceInfoList): Integer; cdecl; external c_strFFmpegDllX64Name;
function avdevice_list_input_sources(device: PAVInputFormat; device_name: pchar; device_options: pAVDictionary; var device_list: PAVDeviceInfoList): Integer; cdecl; external c_strFFmpegDllX64Name;
function avdevice_list_output_sinks(device: pAVOutputFormat; device_name: pchar; device_options: pAVDictionary; var device_list: PAVDeviceInfoList): Integer; cdecl; external c_strFFmpegDllX64Name;
procedure avdevice_register_all(); cdecl; external c_strFFmpegDllX64Name;
function avdevice_version(): UINT; cdecl; cdecl; external c_strFFmpegDllX64Name;

var
  LIBAVDEVICE_VERSION_INT: Integer;
  LIBAVDEVICE_VERSION    : PAnsiChar;
  LIBAVDEVICE_BUILD      : Integer;
  LIBAVDEVICE_IDENT      : PAnsiChar;

implementation

initialization
  LIBAVDEVICE_VERSION_INT := AV_VERSION_INT(LIBAVDEVICE_VERSION_MAJOR, LIBAVDEVICE_VERSION_MINOR, LIBAVDEVICE_VERSION_MICRO);
  LIBAVDEVICE_VERSION     := AV_VERSION(LIBAVDEVICE_VERSION_MAJOR, LIBAVDEVICE_VERSION_MINOR, LIBAVDEVICE_VERSION_MICRO);
  LIBAVDEVICE_BUILD       := LIBAVDEVICE_VERSION_INT;
  LIBAVDEVICE_IDENT       := PAnsiChar(AnsiString('Lavd' + AV_STRINGIFY(LIBAVDEVICE_VERSION)));

end.

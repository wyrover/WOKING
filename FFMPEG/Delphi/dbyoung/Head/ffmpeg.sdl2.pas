unit ffmpeg.sdl2;

interface

uses Windows;

const
  SDL_INIT_TIMER = $00000001;
{$EXTERNALSYM SDL_INIT_TIMER}
  SDL_INIT_AUDIO = $00000010;
{$EXTERNALSYM SDL_INIT_AUDIO}
  SDL_INIT_VIDEO = $00000020;
{$EXTERNALSYM SDL_INIT_VIDEO}
  SDL_INIT_JOYSTICK = $00000200;
{$EXTERNALSYM SDL_INIT_JOYSTICK}
  SDL_INIT_HAPTIC = $00001000;
{$EXTERNALSYM SDL_INIT_HAPTIC}
  SDL_INIT_GAMECONTROLLER = $00002000;
{$EXTERNALSYM SDL_INIT_GAMECONTROLLER}
  SDL_INIT_EVENTS = $00004000;
{$EXTERNALSYM SDL_INIT_EVENTS}
  SDL_INIT_NOPARACHUTE = $00100000;
{$EXTERNALSYM SDL_INIT_NOPARACHUTE}
  SDL_INIT_EVERYTHING      = SDL_INIT_TIMER or SDL_INIT_AUDIO or SDL_INIT_VIDEO or SDL_INIT_EVENTS or SDL_INIT_JOYSTICK or SDL_INIT_HAPTIC or SDL_INIT_GAMECONTROLLER;
  SDL2_GFXPRIMITIVES_MAJOR = 1;
  SDL2_GFXPRIMITIVES_MINOR = 0;
  SDL2_GFXPRIMITIVES_MICRO = 1;
  FPS_UPPER_LIMIT          = 200;
  FPS_LOWER_LIMIT          = 1;
  FPS_DEFAULT              = 30;
  SMOOTHING_OFF            = 0;
  SMOOTHING_ON             = 1;
  SDL_IMAGE_MAJOR_VERSION  = 2;
  SDL_IMAGE_MINOR_VERSION  = 0;
  SDL_IMAGE_PATCHLEVEL     = 0;
  IMG_INIT_JPG             = $00000001;
  IMG_INIT_PNG             = $00000002;
  IMG_INIT_TIF             = $00000004;
  IMG_INIT_WEBP            = $00000008;
  SDL_MIXER_MAJOR_VERSION  = 2;
  SDL_MIXER_MINOR_VERSION  = 0;
  SDL_MIXER_PATCHLEVEL     = 0;
  MIX_MAJOR_VERSION        = SDL_MIXER_MAJOR_VERSION;
  MIX_MINOR_VERSION        = SDL_MIXER_MINOR_VERSION;
  MIX_PATCHLEVEL           = SDL_MIXER_PATCHLEVEL;
  MIX_INIT_FLAC            = $00000001;
  MIX_INIT_MOD             = $00000002;
  MIX_INIT_MODPLUG         = $00000004;
  MIX_INIT_MP3             = $00000008;
  MIX_INIT_OGG             = $00000010;
  MIX_INIT_FLUIDSYNTH      = $00000020;
{$IFNDEF MIX_CHANNELS}
  MIX_CHANNELS = 8;
{$ENDIF}
  MIX_DEFAULT_FREQUENCY = 22050;
  MIX_DEFAULT_CHANNELS  = 2;
  MIX_MAX_VOLUME        = 128;
{$IFDEF FPC}
{$IF DEFINED(ENDIAN_LITTLE)}
  MIX_DEFAULT_FORMAT = AUDIO_S16LSB;
{$ELSEIF DEFINED(ENDIAN_BIG)}
  MIX_DEFAULT_FORMAT = AUDIO_S16MSB;
{$ELSE}
{$FATAL Unable to determine endianness.}
{$IFEND}
{$ENDIF}
  MIX_CHANNEL_POST        = -2;
  MIX_EFFECTSMAXSPEED     = 'MIX_EFFECTSMAXSPEED';
  SDL_NET_MAJOR_VERSION   = 2;
  SDL_NET_MINOR_VERSION   = 0;
  SDL_NET_PATCHLEVEL      = 0;
  SDLNET_MAX_UDPCHANNELS  = 32;
  SDLNET_MAX_UDPADDRESSES = 4;
  INADDR_ANY              = $00000000;
  INADDR_NONE             = $FFFFFFFF;
  INADDR_LOOPBACK         = $7F000001;
  SDL_TTF_MAJOR_VERSION   = 2;
  SDL_TTF_MINOR_VERSION   = 0;
  SDL_TTF_PATCHLEVEL      = 12;
  INADDR_BROADCAST        = $FFFFFFFF;
  TTF_MAJOR_VERSION       = SDL_TTF_MAJOR_VERSION;
  TTF_MINOR_VERSION       = SDL_TTF_MINOR_VERSION;
  TTF_PATCHLEVEL          = SDL_TTF_PATCHLEVEL;
  UNICODE_BOM_NATIVE      = $FEFF;
  UNICODE_BOM_SWAPPED     = $FFFE;
  TTF_STYLE_NORMAL        = $00;
  TTF_STYLE_BOLD          = $01;
  TTF_STYLE_ITALIC        = $02;
  TTF_STYLE_UNDERLINE     = $04;
  TTF_STYLE_STRIKETHROUGH = $08;
  TTF_HINTING_NORMAL      = 0;
  TTF_HINTING_LIGHT       = 1;
  TTF_HINTING_MONO        = 2;
  TTF_HINTING_NONE        = 3;
  SDL_AUDIO_MASK_BITSIZE  = ($FF);
  SDL_AUDIO_MASK_DATATYPE = (1 shl 8);
  SDL_AUDIO_MASK_ENDIAN   = (1 shl 12);
  SDL_AUDIO_MASK_SIGNED   = (1 shl 15);
  AUDIO_U8                = $0008;
  AUDIO_S8                = $8008;
  AUDIO_U16LSB            = $0010;
  AUDIO_S16LSB            = $8010;
  AUDIO_U16MSB            = $1010;
  AUDIO_S16MSB            = $9010;
  AUDIO_U16               = AUDIO_U16LSB;
  AUDIO_S16               = AUDIO_S16LSB;
  AUDIO_S32LSB            = $8020;
  AUDIO_S32MSB            = $9020;
  AUDIO_S32               = AUDIO_S32LSB;
  AUDIO_F32LSB            = $8120;
  AUDIO_F32MSB            = $9120;
  AUDIO_F32               = AUDIO_F32LSB;
{$IFDEF FPC}
{$IF DEFINED(ENDIAN_LITTLE)}
  AUDIO_U16SYS = AUDIO_U16LSB;
  AUDIO_S16SYS = AUDIO_S16LSB;
  AUDIO_S32SYS = AUDIO_S32LSB;
  AUDIO_F32SYS = AUDIO_F32LSB;
{$ELSEIF DEFINED(ENDIAN_BIG)}
  AUDIO_U16SYS = AUDIO_U16MSB;
  AUDIO_S16SYS = AUDIO_S16MSB;
  AUDIO_S32SYS = AUDIO_S32MSB;
  AUDIO_F32SYS = AUDIO_F32MSB;
{$ELSE}
{$FATAL Cannot determine endianness.}
{$IFEND}
{$ENDIF}
  SDL_AUDIO_ALLOW_FREQUENCY_CHANGE                  = $00000001;
  SDL_AUDIO_ALLOW_FORMAT_CHANGE                     = $00000002;
  SDL_AUDIO_ALLOW_CHANNELS_CHANGE                   = $00000004;
  SDL_AUDIO_ALLOW_ANY_CHANGE                        = (SDL_AUDIO_ALLOW_FREQUENCY_CHANGE or SDL_AUDIO_ALLOW_FORMAT_CHANGE or SDL_AUDIO_ALLOW_CHANNELS_CHANGE);
  SDL_MIX_MAXVOLUME                                 = 128;
  SDL_BLENDMODE_NONE                                = $00000000;
  SDL_BLENDMODE_BLEND                               = $00000001;
  SDL_BLENDMODE_ADD                                 = $00000002;
  SDL_CACHELINE_SIZE                                = 128;
  SDL_BLENDMODE_MOD                                 = $00000004;
  ERR_MAX_STRLEN                                    = 128;
  ERR_MAX_ARGS                                      = 5;
  SDL_RELEASED                                      = 0;
  SDL_PRESSED                                       = 1;
  SDL_FIRSTEVENT                                    = 0;
  SDL_COMMONEVENT                                   = 1;
  SDL_QUITEV                                        = $100;
  SDL_APP_TERMINATING                               = $101;
  SDL_APP_LOWMEMORY                                 = $102;
  SDL_APP_WILLENTERBACKGROUND                       = $103;
  SDL_APP_DIDENTERBACKGROUND                        = $104;
  SDL_APP_WILLENTERFOREGROUND                       = $105;
  SDL_APP_DIDENTERFOREGROUND                        = $106;
  SDL_WINDOWEVENT                                   = $200;
  SDL_SYSWMEVENT                                    = $201;
  SDL_KEYDOWN                                       = $300;
  SDL_KEYUP                                         = $301;
  SDL_TEXTEDITING                                   = $302;
  SDL_TEXTINPUT                                     = $303;
  SDL_KEYMAPCHANGED                                 = $304;
  SDL_MOUSEMOTION                                   = $400;
  SDL_MOUSEBUTTONDOWN                               = $401;
  SDL_MOUSEBUTTONUP                                 = $402;
  SDL_MOUSEWHEEL                                    = $403;
  SDL_JOYAXISMOTION                                 = $600;
  SDL_JOYBALLMOTION                                 = $601;
  SDL_JOYHATMOTION                                  = $602;
  SDL_JOYBUTTONDOWN                                 = $603;
  SDL_JOYBUTTONUP                                   = $604;
  SDL_JOYDEVICEADDED                                = $605;
  SDL_JOYDEVICEREMOVED                              = $606;
  SDL_CONTROLLERAXISMOTION                          = $650;
  SDL_CONTROLLERBUTTONDOWN                          = $651;
  SDL_CONTROLLERBUTTONUP                            = $652;
  SDL_CONTROLLERDEVICEADDED                         = $653;
  SDL_CONTROLLERDEVICEREMOVED                       = $654;
  SDL_CONTROLLERDEVICEREMAPPED                      = $655;
  SDL_FINGERDOWN                                    = $700;
  SDL_FINGERUP                                      = $701;
  SDL_FINGERMOTION                                  = $702;
  SDL_DOLLARGESTURE                                 = $800;
  SDL_DOLLARRECORD                                  = $801;
  SDL_MULTIGESTURE                                  = $802;
  SDL_CLIPBOARDUPDATE                               = $900;
  SDL_DROPFILE                                      = $1000;
  SDL_DROPTEXT                                      = $1001;
  SDL_DROPBEGIN                                     = $1002;
  SDL_DROPCOMPLETE                                  = $1003;
  SDL_AUDIODEVICEADDED                              = $1100;
  SDL_AUDIODEVICEREMOVED                            = $1101;
  SDL_RENDER_TARGETS_RESET                          = $2000;
  SDL_RENDER_DEVICE_RESET                           = $2001;
  SDL_USEREVENT                                     = $8000;
  SDL_LASTEVENT                                     = $FFFF;
  SDL_TEXTEDITINGEVENT_TEXT_SIZE                    = 32;
  SDL_TEXTINPUTEVENT_TEXT_SIZE                      = 32;
  SDL_ADDEVENT                                      = 0;
  SDL_PEEKEVENT                                     = 1;
  SDL_GETEVENT                                      = 2;
  SDL_QUERY                                         = -1;
  SDL_IGNORE                                        = 0;
  SDL_DISABLE                                       = 0;
  SDL_ENABLE                                        = 1;
  SDL_CONTROLLER_AXIS_INVALID                       = -1;
  SDL_CONTROLLER_AXIS_LEFTX                         = 0;
  SDL_CONTROLLER_AXIS_LEFTY                         = 1;
  SDL_CONTROLLER_AXIS_RIGHTX                        = 2;
  SDL_CONTROLLER_AXIS_RIGHTY                        = 3;
  SDL_CONTROLLER_AXIS_TRIGGERLEFT                   = 4;
  SDL_CONTROLLER_AXIS_TRIGGERRIGHT                  = 5;
  SDL_CONTROLLER_AXIS_MAX                           = 6;
  SDL_CONTROLLER_BUTTON_INVALID                     = -1;
  SDL_CONTROLLER_BUTTON_A                           = 0;
  SDL_CONTROLLER_BUTTON_B                           = 1;
  SDL_CONTROLLER_BUTTON_X                           = 2;
  SDL_CONTROLLER_BUTTON_Y                           = 3;
  SDL_CONTROLLER_BUTTON_BACK                        = 4;
  SDL_CONTROLLER_BUTTON_GUIDE                       = 5;
  SDL_CONTROLLER_BUTTON_START                       = 6;
  SDL_CONTROLLER_BUTTON_LEFTSTICK                   = 7;
  SDL_CONTROLLER_BUTTON_RIGHTSTICK                  = 8;
  SDL_CONTROLLER_BUTTON_LEFTSHOULDER                = 9;
  SDL_CONTROLLER_BUTTON_RIGHTSHOULDER               = 10;
  SDL_CONTROLLER_BUTTON_DPAD_UP                     = 11;
  SDL_CONTROLLER_BUTTON_DPAD_DOWN                   = 12;
  SDL_CONTROLLER_BUTTON_DPAD_LEFT                   = 13;
  SDL_CONTROLLER_BUTTON_DPAD_RIGHT                  = 14;
  SDL_CONTROLLER_BUTTON_MAX                         = 15;
  SDL_HAPTIC_CONSTANT                               = (1 shl 0);
  SDL_HAPTIC_SINE                                   = (1 shl 1);
  SDL_HAPTIC_SQUARE                                 = (1 shl 2);
  SDL_HAPTIC_TRIANGLE                               = (1 shl 3);
  SDL_HAPTIC_SAWTOOTHUP                             = (1 shl 4);
  SDL_HAPTIC_SAWTOOTHDOWN                           = (1 shl 5);
  SDL_HAPTIC_RAMP                                   = (1 shl 6);
  SDL_HAPTIC_SPRING                                 = (1 shl 7);
  SDL_HAPTIC_DAMPER                                 = (1 shl 8);
  SDL_HAPTIC_INERTIA                                = (1 shl 9);
  SDL_HAPTIC_FRICTION                               = (1 shl 10);
  SDL_HAPTIC_CUSTOM                                 = (1 shl 11);
  SDL_HAPTIC_GAIN                                   = (1 shl 12);
  SDL_HAPTIC_AUTOCENTER                             = (1 shl 13);
  SDL_HAPTIC_STATUS                                 = (1 shl 14);
  SDL_HAPTIC_PAUSE                                  = (1 shl 15);
  SDL_HAPTIC_POLAR                                  = 0;
  SDL_HAPTIC_CARTESIAN                              = 1;
  SDL_HAPTIC_SPHERICAL                              = 2;
  SDL_HAPTIC_INFINITY                               = 4294967295;
  SDL_HINT_FRAMEBUFFER_ACCELERATION                 = 'SDL_FRAMEBUFFER_ACCELERATION';
  SDL_HINT_RENDER_DRIVER                            = 'SDL_RENDER_DRIVER';
  SDL_HINT_RENDER_OPENGL_SHADERS                    = 'SDL_RENDER_OPENGL_SHADERS';
  SDL_HINT_RENDER_DIRECT3D_THREADSAFE               = 'SDL_RENDER_DIRECT3D_THREADSAFE';
  SDL_HINT_RENDER_DIRECT3D11_DEBUG                  = 'SDL_RENDER_DIRECT3D11_DEBUG';
  SDL_HINT_RENDER_SCALE_QUALITY                     = 'SDL_RENDER_SCALE_QUALITY';
  SDL_HINT_RENDER_VSYNC                             = 'SDL_RENDER_VSYNC';
  SDL_HINT_VIDEO_ALLOW_SCREENSAVER                  = 'SDL_VIDEO_ALLOW_SCREENSAVER';
  SDL_HINT_VIDEO_X11_XVIDMODE                       = 'SDL_VIDEO_X11_XVIDMODE';
  SDL_HINT_VIDEO_X11_XINERAMA                       = 'SDL_VIDEO_X11_XINERAMA';
  SDL_HINT_VIDEO_X11_XRANDR                         = 'SDL_VIDEO_X11_XRANDR';
  SDL_HINT_VIDEO_X11_NET_WM_PING                    = 'SDL_VIDEO_X11_NET_WM_PING';
  SDL_HINT_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN  = 'SDL_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN';
  SDL_HINT_WINDOWS_ENABLE_MESSAGELOOP               = 'SDL_WINDOWS_ENABLE_MESSAGELOOP';
  SDL_HINT_GRAB_KEYBOARD                            = 'SDL_GRAB_KEYBOARD';
  SDL_HINT_MOUSE_RELATIVE_MODE_WARP                 = 'SDL_MOUSE_RELATIVE_MODE_WARP';
  SDL_HINT_MOUSE_FOCUS_CLICKTHROUGH                 = 'SDL_MOUSE_FOCUS_CLICKTHROUGH';
  SDL_HINT_VIDEO_MINIMIZE_ON_FOCUS_LOSS             = 'SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS';
  SDL_HINT_IDLE_TIMER_DISABLED                      = 'SDL_IOS_IDLE_TIMER_DISABLED';
  SDL_HINT_ORIENTATIONS                             = 'SDL_IOS_ORIENTATIONS';
  SDL_HINT_APPLE_TV_CONTROLLER_UI_EVENTS            = 'SDL_APPLE_TV_CONTROLLER_UI_EVENTS';
  SDL_HINT_APPLE_TV_REMOTE_ALLOW_ROTATION           = 'SDL_APPLE_TV_REMOTE_ALLOW_ROTATION';
  SDL_HINT_ACCELEROMETER_AS_JOYSTICK                = 'SDL_ACCELEROMETER_AS_JOYSTICK';
  SDL_HINT_XINPUT_ENABLED                           = 'SDL_XINPUT_ENABLED';
  SDL_HINT_XINPUT_USE_OLD_JOYSTICK_MAPPING          = 'SDL_XINPUT_USE_OLD_JOYSTICK_MAPPING';
  SDL_HINT_GAMECONTROLLERCONFIG                     = 'SDL_GAMECONTROLLERCONFIG';
  SDL_HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS         = 'SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS';
  SDL_HINT_ALLOW_TOPMOST                            = 'SDL_ALLOW_TOPMOST';
  SDL_HINT_TIMER_RESOLUTION                         = 'SDL_TIMER_RESOLUTION';
  SDL_HINT_THREAD_STACK_SIZE                        = 'SDL_THREAD_STACK_SIZE';
  SDL_HINT_VIDEO_HIGHDPI_DISABLED                   = 'SDL_VIDEO_HIGHDPI_DISABLED';
  SDL_HINT_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK       = 'SDL_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK';
  SDL_HINT_VIDEO_WIN_D3DCOMPILER                    = 'SDL_VIDEO_WIN_D3DCOMPILER';
  SDL_HINT_VIDEO_WINDOW_SHARE_PIXEL_FORMAT          = 'SDL_VIDEO_WINDOW_SHARE_PIXEL_FORMAT';
  SDL_HINT_WINRT_PRIVACY_POLICY_URL                 = 'SDL_WINRT_PRIVACY_POLICY_URL';
  SDL_HINT_WINRT_PRIVACY_POLICY_LABEL               = 'SDL_WINRT_PRIVACY_POLICY_LABEL';
  SDL_HINT_WINRT_HANDLE_BACK_BUTTON                 = 'SDL_WINRT_HANDLE_BACK_BUTTON';
  SDL_HINT_VIDEO_MAC_FULLSCREEN_SPACES              = 'SDL_VIDEO_MAC_FULLSCREEN_SPACES';
  SDL_HINT_MAC_BACKGROUND_APP                       = 'SDL_MAC_BACKGROUND_APP';
  SDL_HINT_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION  = 'SDL_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION';
  SDL_HINT_ANDROID_APK_EXPANSION_PATCH_FILE_VERSION = 'SDL_ANDROID_APK_EXPANSION_PATCH_FILE_VERSION';
  SDL_HINT_IME_INTERNAL_EDITING                     = 'SDL_IME_INTERNAL_EDITING';
  SDL_HINT_ANDROID_SEPARATE_MOUSE_AND_TOUCH         = 'SDL_ANDROID_SEPARATE_MOUSE_AND_TOUCH';
  SDL_HINT_EMSCRIPTEN_KEYBOARD_ELEMENT              = 'SDL_EMSCRIPTEN_KEYBOARD_ELEMENT';
  SDL_HINT_NO_SIGNAL_HANDLERS                       = 'SDL_NO_SIGNAL_HANDLERS';
  SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4               = 'SDL_WINDOWS_NO_CLOSE_ON_ALT_F4';
  SDL_HINT_BMP_SAVE_LEGACY_FORMAT                   = 'SDL_BMP_SAVE_LEGACY_FORMAT';
  SDL_HINT_WINDOWS_DISABLE_THREAD_NAMING            = 'SDL_WINDOWS_DISABLE_THREAD_NAMING';
  SDL_HINT_RPI_VIDEO_LAYER                          = 'SDL_RPI_VIDEO_LAYER';
  SDL_HAT_CENTERED                                  = $00;
  SDL_HAT_UP                                        = $01;
  SDL_HAT_RIGHT                                     = $02;
  SDL_HAT_DOWN                                      = $04;
  SDL_HAT_LEFT                                      = $08;
  SDL_HAT_RIGHTUP                                   = SDL_HAT_RIGHT or SDL_HAT_UP;
  SDL_HAT_RIGHTDOWN                                 = SDL_HAT_RIGHT or SDL_HAT_DOWN;
  SDL_HAT_LEFTUP                                    = SDL_HAT_LEFT or SDL_HAT_UP;
  SDL_HAT_LEFTDOWN                                  = SDL_HAT_LEFT or SDL_HAT_DOWN;

const
  SDL_MAX_LOG_MESSAGE                     = 4096;
  SDL_LOG_PRIORITY_VERBOSE                = 1;
  SDL_LOG_PRIORITY_DEBUG                  = 2;
  SDL_LOG_PRIORITY_INFO                   = 3;
  SDL_LOG_PRIORITY_WARN                   = 4;
  SDL_LOG_PRIORITY_ERROR                  = 5;
  SDL_LOG_PRIORITY_CRITICAL               = 6;
  SDL_NUM_LOG_PRIORITIES                  = 7;
  SDL_ALPHA_OPAQUE                        = 255;
  SDL_ALPHA_TRANSPARENT                   = 0;
  SDL_PIXELTYPE_UNKNOWN                   = 0;
  SDL_PIXELTYPE_INDEX1                    = 1;
  SDL_PIXELTYPE_INDEX4                    = 2;
  SDL_PIXELTYPE_INDEX8                    = 3;
  SDL_PIXELTYPE_PACKED8                   = 4;
  SDL_PIXELTYPE_PACKED16                  = 5;
  SDL_PIXELTYPE_PACKED32                  = 6;
  SDL_PIXELTYPE_ARRAYU8                   = 7;
  SDL_PIXELTYPE_ARRAYU16                  = 8;
  SDL_PIXELTYPE_ARRAYU32                  = 9;
  SDL_PIXELTYPE_ARRAYF16                  = 10;
  SDL_PIXELTYPE_ARRAYF32                  = 11;
  SDL_BITMAPORDER_NONE                    = 0;
  SDL_BITMAPORDER_4321                    = 1;
  SDL_BITMAPORDER_1234                    = 2;
  SDL_PACKEDORDER_NONE                    = 0;
  SDL_PACKEDORDER_XRGB                    = 1;
  SDL_PACKEDORDER_RGBX                    = 2;
  SDL_PACKEDORDER_ARGB                    = 3;
  SDL_PACKEDORDER_RGBA                    = 4;
  SDL_PACKEDORDER_XBGR                    = 5;
  SDL_PACKEDORDER_BGRX                    = 6;
  SDL_PACKEDORDER_ABGR                    = 7;
  SDL_PACKEDORDER_BGRA                    = 8;
  SDL_ARRAYORDER_NONE                     = 0;
  SDL_ARRAYORDER_RGB                      = 1;
  SDL_ARRAYORDER_RGBA                     = 2;
  SDL_ARRAYORDER_ARGB                     = 3;
  SDL_ARRAYORDER_BGR                      = 4;
  SDL_ARRAYORDER_BGRA                     = 5;
  SDL_ARRAYORDER_ABGR                     = 6;
  SDL_PACKEDLAYOUT_NONE                   = 0;
  SDL_PACKEDLAYOUT_332                    = 1;
  SDL_PACKEDLAYOUT_4444                   = 2;
  SDL_PACKEDLAYOUT_1555                   = 3;
  SDL_PACKEDLAYOUT_5551                   = 4;
  SDL_PACKEDLAYOUT_565                    = 5;
  SDL_PACKEDLAYOUT_8888                   = 6;
  SDL_PACKEDLAYOUT_2101010                = 7;
  SDL_PACKEDLAYOUT_1010102                = 8;
  SDL_MESSAGEBOX_ERROR                    = $00000010;
  SDL_MESSAGEBOX_WARNING                  = $00000020;
  SDL_MESSAGEBOX_INFORMATION              = $00000040;
  SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = $00000001;
  SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = $00000002;
  SDL_SYSTEM_CURSOR_ARROW                 = 0;
  SDL_SYSTEM_CURSOR_IBEAM                 = 1;
  SDL_SYSTEM_CURSOR_WAIT                  = 2;
  SDL_SYSTEM_CURSOR_CROSSHAIR             = 3;
  SDL_SYSTEM_CURSOR_WAITARROW             = 4;
  SDL_SYSTEM_CURSOR_SIZENWSE              = 5;
  SDL_SYSTEM_CURSOR_SIZENESW              = 6;
  SDL_SYSTEM_CURSOR_SIZEWE                = 7;
  SDL_SYSTEM_CURSOR_SIZENS                = 8;
  SDL_SYSTEM_CURSOR_SIZEALL               = 9;
  SDL_SYSTEM_CURSOR_NO                    = 10;
  SDL_SYSTEM_CURSOR_HAND                  = 11;
  SDL_NUM_SYSTEM_CURSORS                  = 12;
  SDL_BUTTON_LEFT                         = 1;
  SDL_BUTTON_MIDDLE                       = 2;
  SDL_BUTTON_RIGHT                        = 3;
  SDL_BUTTON_X1                           = 4;
  SDL_BUTTON_X2                           = 5;
  SDL_BUTTON_LMASK                        = 1 shl ((SDL_BUTTON_LEFT) - 1);
  SDL_BUTTON_MMASK                        = 1 shl ((SDL_BUTTON_MIDDLE) - 1);
  SDL_BUTTON_RMASK                        = 1 shl ((SDL_BUTTON_RIGHT) - 1);
  SDL_BUTTON_X1MASK                       = 1 shl ((SDL_BUTTON_X1) - 1);
  SDL_BUTTON_X2MASK                       = 1 shl ((SDL_BUTTON_X2) - 1);
  SDL_MUTEX_TIMEDOUT                      = 1;
  SDL_PIXELFORMAT_UNKNOWN                 = 0;
  SDL_PIXELFORMAT_INDEX1LSB               = (1 shl 28) or (SDL_PIXELTYPE_INDEX1 shl 24) or (SDL_BITMAPORDER_4321 shl 20) or (0 shl 16) or (1 shl 8) or (0 shl 0);
  SDL_PIXELFORMAT_INDEX1MSB               = (1 shl 28) or (SDL_PIXELTYPE_INDEX1 shl 24) or (SDL_BITMAPORDER_1234 shl 20) or (0 shl 16) or (1 shl 8) or (0 shl 0);
  SDL_PIXELFORMAT_INDEX4LSB               = (1 shl 28) or (SDL_PIXELTYPE_INDEX4 shl 24) or (SDL_BITMAPORDER_4321 shl 20) or (0 shl 16) or (4 shl 8) or (0 shl 0);
  SDL_PIXELFORMAT_INDEX4MSB               = (1 shl 28) or (SDL_PIXELTYPE_INDEX4 shl 24) or (SDL_BITMAPORDER_1234 shl 20) or (0 shl 16) or (4 shl 8) or (0 shl 0);
  SDL_PIXELFORMAT_INDEX8                  = (1 shl 28) or (SDL_PIXELTYPE_PACKED8 shl 24) or (0 shl 20) or (0 shl 16) or (8 shl 8) or (1 shl 0);
  SDL_PIXELFORMAT_RGB332                  = (1 shl 28) or (SDL_PIXELTYPE_PACKED8 shl 24) or (SDL_PACKEDORDER_XRGB shl 20) or (SDL_PACKEDLAYOUT_332 shl 16) or (8 shl 8) or (1 shl 0);
  SDL_PIXELFORMAT_RGB444                  = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_XRGB shl 20) or (SDL_PACKEDLAYOUT_4444 shl 16) or (12 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_RGB555                  = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_XRGB shl 20) or (SDL_PACKEDLAYOUT_1555 shl 16) or (15 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_BGR555                  = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_XBGR shl 20) or (SDL_PACKEDLAYOUT_1555 shl 16) or (15 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_ARGB4444                = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_ARGB shl 20) or (SDL_PACKEDLAYOUT_4444 shl 16) or (16 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_RGBA4444                = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_RGBA shl 20) or (SDL_PACKEDLAYOUT_4444 shl 16) or (16 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_ABGR4444                = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_ABGR shl 20) or (SDL_PACKEDLAYOUT_4444 shl 16) or (16 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_BGRA4444                = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_BGRA shl 20) or (SDL_PACKEDLAYOUT_4444 shl 16) or (16 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_ARGB1555                = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_ARGB shl 20) or (SDL_PACKEDLAYOUT_1555 shl 16) or (16 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_RGBA5551                = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_RGBA shl 20) or (SDL_PACKEDLAYOUT_5551 shl 16) or (16 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_ABGR1555                = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_ABGR shl 20) or (SDL_PACKEDLAYOUT_1555 shl 16) or (16 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_BGRA5551                = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_BGRA shl 20) or (SDL_PACKEDLAYOUT_5551 shl 16) or (16 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_RGB565                  = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_XRGB shl 20) or (SDL_PACKEDLAYOUT_565 shl 16) or (16 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_BGR565                  = (1 shl 28) or (SDL_PIXELTYPE_PACKED16 shl 24) or (SDL_PACKEDORDER_XBGR shl 20) or (SDL_PACKEDLAYOUT_1555 shl 16) or (16 shl 8) or (2 shl 0);
  SDL_PIXELFORMAT_RGB24                   = (1 shl 28) or (SDL_PIXELTYPE_ARRAYU8 shl 24) or (SDL_ARRAYORDER_RGB shl 20) or (0 shl 16) or (24 shl 8) or (3 shl 0);
  SDL_PIXELFORMAT_BGR24                   = (1 shl 28) or (SDL_PIXELTYPE_ARRAYU8 shl 24) or (SDL_ARRAYORDER_BGR shl 20) or (0 shl 16) or (24 shl 8) or (3 shl 0);
  SDL_PIXELFORMAT_RGB888                  = (1 shl 28) or (SDL_PIXELTYPE_PACKED32 shl 24) or (SDL_PACKEDORDER_XRGB shl 20) or (SDL_PACKEDLAYOUT_8888 shl 16) or (24 shl 8) or (4 shl 0);
  SDL_PIXELFORMAT_RGBX8888                = (1 shl 28) or (SDL_PIXELTYPE_PACKED32 shl 24) or (SDL_PACKEDORDER_RGBX shl 20) or (SDL_PACKEDLAYOUT_8888 shl 16) or (24 shl 8) or (4 shl 0);
  SDL_PIXELFORMAT_BGR888                  = (1 shl 28) or (SDL_PIXELTYPE_PACKED32 shl 24) or (SDL_PACKEDORDER_XBGR shl 20) or (SDL_PACKEDLAYOUT_8888 shl 16) or (24 shl 8) or (4 shl 0);
  SDL_PIXELFORMAT_BGRX8888                = (1 shl 28) or (SDL_PIXELTYPE_PACKED32 shl 24) or (SDL_PACKEDORDER_BGRX shl 20) or (SDL_PACKEDLAYOUT_8888 shl 16) or (24 shl 8) or (4 shl 0);
  SDL_PIXELFORMAT_ARGB8888                = (1 shl 28) or (SDL_PIXELTYPE_PACKED32 shl 24) or (SDL_PACKEDORDER_ARGB shl 20) or (SDL_PACKEDLAYOUT_8888 shl 16) or (32 shl 8) or (4 shl 0);
  SDL_PIXELFORMAT_RGBA8888                = (1 shl 28) or (SDL_PIXELTYPE_PACKED32 shl 24) or (SDL_PACKEDORDER_RGBA shl 20) or (SDL_PACKEDLAYOUT_8888 shl 16) or (32 shl 8) or (4 shl 0);
  SDL_PIXELFORMAT_ABGR8888                = (1 shl 28) or (SDL_PIXELTYPE_PACKED32 shl 24) or (SDL_PACKEDORDER_ABGR shl 20) or (SDL_PACKEDLAYOUT_8888 shl 16) or (32 shl 8) or (4 shl 0);
  SDL_PIXELFORMAT_BGRA8888                = (1 shl 28) or (SDL_PIXELTYPE_PACKED32 shl 24) or (SDL_PACKEDORDER_RGBX shl 20) or (SDL_PACKEDLAYOUT_8888 shl 16) or (32 shl 8) or (4 shl 0);
  SDL_PIXELFORMAT_ARGB2101010             = (1 shl 28) or (SDL_PIXELTYPE_PACKED32 shl 24) or (SDL_PACKEDORDER_ARGB shl 20) or (SDL_PACKEDLAYOUT_2101010 shl 16) or (32 shl 8) or (4 shl 0);
{$IFDEF FPC}
{$IF DEFINED(ENDIAN_LITTLE)}
  SDL_PIXELFORMAT_RGBA32 = SDL_PIXELFORMAT_ABGR8888;
  SDL_PIXELFORMAT_ARGB32 = SDL_PIXELFORMAT_BGRA8888;
  SDL_PIXELFORMAT_BGRA32 = SDL_PIXELFORMAT_ARGB8888;
  SDL_PIXELFORMAT_ABGR32 = SDL_PIXELFORMAT_RGBA8888;
{$ELSEIF DEFINED(ENDIAN_BIG)}
  SDL_PIXELFORMAT_RGBA32 = SDL_PIXELFORMAT_RGBA8888;
  SDL_PIXELFORMAT_ARGB32 = SDL_PIXELFORMAT_ARGB8888;
  SDL_PIXELFORMAT_BGRA32 = SDL_PIXELFORMAT_BGRA8888;
  SDL_PIXELFORMAT_ABGR32 = SDL_PIXELFORMAT_ABGR8888;
{$ELSE}
{$FATAL Cannot determine endianness.}
{$IFEND}
{$ENDIF}
  SDL_PIXELFORMAT_YV12        = (Integer('Y')) or (Integer('V') shl 8) or (Integer('1') shl 16) or (Integer('2') shl 24);
  SDL_PIXELFORMAT_IYUV        = (Integer('I')) or (Integer('Y') shl 8) or (Integer('U') shl 16) or (Integer('V') shl 24);
  SDL_PIXELFORMAT_YUY2        = (Integer('Y')) or (Integer('U') shl 8) or (Integer('Y') shl 16) or (Integer('2') shl 24);
  SDL_PIXELFORMAT_UYVY        = (Integer('U')) or (Integer('Y') shl 8) or (Integer('V') shl 16) or (Integer('Y') shl 24);
  SDL_PIXELFORMAT_YVYU        = (Integer('Y')) or (Integer('V') shl 8) or (Integer('Y') shl 16) or (Integer('U') shl 24);
  SDL_RENDERER_SOFTWARE       = $00000001;
  SDL_RENDERER_ACCELERATED    = $00000002;
  SDL_RENDERER_PRESENTVSYNC   = $00000004;
  SDL_RENDERER_TARGETTEXTURE  = $00000008;
  SDL_TEXTUREACCESS_STATIC    = 0;
  SDL_TEXTUREACCESS_STREAMING = 1;
  SDL_TEXTUREACCESS_TARGET    = 2;
  SDL_FLIP_NONE               = $0;
  SDL_FLIP_HORIZONTAL         = $1;
  SDL_FLIP_VERTICAL           = $2;
  SDL_RWOPS_UNKNOWN           = 0;
  SDL_RWOPS_WINFILE           = 1;
  SDL_RWOPS_STDFILE           = 2;
  SDL_RWOPS_JNIFILE           = 3;
  SDL_RWOPS_MEMORY            = 4;
  SDL_RWOPS_MEMORY_RO         = 5;
  RW_SEEK_SET                 = 0;
  RW_SEEK_CUR                 = 1;
  RW_SEEK_END                 = 2;

const
  SDL_SCANCODE_UNKNOWN                   = 0;
  SDL_SCANCODE_A                         = 4;
  SDL_SCANCODE_B                         = 5;
  SDL_SCANCODE_C                         = 6;
  SDL_SCANCODE_D                         = 7;
  SDL_SCANCODE_E                         = 8;
  SDL_SCANCODE_F                         = 9;
  SDL_SCANCODE_G                         = 10;
  SDL_SCANCODE_H                         = 11;
  SDL_SCANCODE_I                         = 12;
  SDL_SCANCODE_J                         = 13;
  SDL_SCANCODE_K                         = 14;
  SDL_SCANCODE_L                         = 15;
  SDL_SCANCODE_M                         = 16;
  SDL_SCANCODE_N                         = 17;
  SDL_SCANCODE_O                         = 18;
  SDL_SCANCODE_P                         = 19;
  SDL_SCANCODE_Q                         = 20;
  SDL_SCANCODE_R                         = 21;
  SDL_SCANCODE_S                         = 22;
  SDL_SCANCODE_T                         = 23;
  SDL_SCANCODE_U                         = 24;
  SDL_SCANCODE_V                         = 25;
  SDL_SCANCODE_W                         = 26;
  SDL_SCANCODE_X                         = 27;
  SDL_SCANCODE_Y                         = 28;
  SDL_SCANCODE_Z                         = 29;
  SDL_SCANCODE_1                         = 30;
  SDL_SCANCODE_2                         = 31;
  SDL_SCANCODE_3                         = 32;
  SDL_SCANCODE_4                         = 33;
  SDL_SCANCODE_5                         = 34;
  SDL_SCANCODE_6                         = 35;
  SDL_SCANCODE_7                         = 36;
  SDL_SCANCODE_8                         = 37;
  SDL_SCANCODE_9                         = 38;
  SDL_SCANCODE_0                         = 39;
  SDL_SCANCODE_RETURN                    = 40;
  SDL_SCANCODE_ESCAPE                    = 41;
  SDL_SCANCODE_BACKSPACE                 = 42;
  SDL_SCANCODE_TAB                       = 43;
  SDL_SCANCODE_SPACE                     = 44;
  SDL_SCANCODE_MINUS                     = 45;
  SDL_SCANCODE_EQUALS                    = 46;
  SDL_SCANCODE_LEFTBRACKET               = 47;
  SDL_SCANCODE_RIGHTBRACKET              = 48;
  SDL_SCANCODE_BACKSLASH                 = 49;
  SDL_SCANCODE_NONUSHASH                 = 50;
  SDL_SCANCODE_SEMICOLON                 = 51;
  SDL_SCANCODE_APOSTROPHE                = 52;
  SDL_SCANCODE_GRAVE                     = 53;
  SDL_SCANCODE_COMMA                     = 54;
  SDL_SCANCODE_PERIOD                    = 55;
  SDL_SCANCODE_SLASH                     = 56;
  SDL_SCANCODE_CAPSLOCK                  = 57;
  SDL_SCANCODE_F1                        = 58;
  SDL_SCANCODE_F2                        = 59;
  SDL_SCANCODE_F3                        = 60;
  SDL_SCANCODE_F4                        = 61;
  SDL_SCANCODE_F5                        = 62;
  SDL_SCANCODE_F6                        = 63;
  SDL_SCANCODE_F7                        = 64;
  SDL_SCANCODE_F8                        = 65;
  SDL_SCANCODE_F9                        = 66;
  SDL_SCANCODE_F10                       = 67;
  SDL_SCANCODE_F11                       = 68;
  SDL_SCANCODE_F12                       = 69;
  SDL_SCANCODE_PRINTSCREEN               = 70;
  SDL_SCANCODE_SCROLLLOCK                = 71;
  SDL_SCANCODE_PAUSE                     = 72;
  SDL_SCANCODE_INSERT                    = 73;
  SDL_SCANCODE_HOME                      = 74;
  SDL_SCANCODE_PAGEUP                    = 75;
  SDL_SCANCODE_DELETE                    = 76;
  SDL_SCANCODE_END                       = 77;
  SDL_SCANCODE_PAGEDOWN                  = 78;
  SDL_SCANCODE_RIGHT                     = 79;
  SDL_SCANCODE_LEFT                      = 80;
  SDL_SCANCODE_DOWN                      = 81;
  SDL_SCANCODE_UP                        = 82;
  SDL_SCANCODE_NUMLOCKCLEAR              = 83;
  SDL_SCANCODE_KP_DIVIDE                 = 84;
  SDL_SCANCODE_KP_MULTIPLY               = 85;
  SDL_SCANCODE_KP_MINUS                  = 86;
  SDL_SCANCODE_KP_PLUS                   = 87;
  SDL_SCANCODE_KP_ENTER                  = 88;
  SDL_SCANCODE_KP_1                      = 89;
  SDL_SCANCODE_KP_2                      = 90;
  SDL_SCANCODE_KP_3                      = 91;
  SDL_SCANCODE_KP_4                      = 92;
  SDL_SCANCODE_KP_5                      = 93;
  SDL_SCANCODE_KP_6                      = 94;
  SDL_SCANCODE_KP_7                      = 95;
  SDL_SCANCODE_KP_8                      = 96;
  SDL_SCANCODE_KP_9                      = 97;
  SDL_SCANCODE_KP_0                      = 98;
  SDL_SCANCODE_KP_PERIOD                 = 99;
  SDL_SCANCODE_NONUSBACKSLASH            = 100;
  SDL_SCANCODE_APPLICATION               = 101;
  SDL_SCANCODE_POWER                     = 102;
  SDL_SCANCODE_KP_EQUALS                 = 103;
  SDL_SCANCODE_F13                       = 104;
  SDL_SCANCODE_F14                       = 105;
  SDL_SCANCODE_F15                       = 106;
  SDL_SCANCODE_F16                       = 107;
  SDL_SCANCODE_F17                       = 108;
  SDL_SCANCODE_F18                       = 109;
  SDL_SCANCODE_F19                       = 110;
  SDL_SCANCODE_F20                       = 111;
  SDL_SCANCODE_F21                       = 112;
  SDL_SCANCODE_F22                       = 113;
  SDL_SCANCODE_F23                       = 114;
  SDL_SCANCODE_F24                       = 115;
  SDL_SCANCODE_EXECUTE                   = 116;
  SDL_SCANCODE_HELP                      = 117;
  SDL_SCANCODE_MENU                      = 118;
  SDL_SCANCODE_SELECT                    = 119;
  SDL_SCANCODE_STOP                      = 120;
  SDL_SCANCODE_AGAIN                     = 121;
  SDL_SCANCODE_UNDO                      = 122;
  SDL_SCANCODE_CUT                       = 123;
  SDL_SCANCODE_COPY                      = 124;
  SDL_SCANCODE_PASTE                     = 125;
  SDL_SCANCODE_FIND                      = 126;
  SDL_SCANCODE_MUTE                      = 127;
  SDL_SCANCODE_VOLUMEUP                  = 128;
  SDL_SCANCODE_VOLUMEDOWN                = 129;
  SDL_SCANCODE_KP_COMMA                  = 133;
  SDL_SCANCODE_KP_EQUALSAS400            = 134;
  SDL_SCANCODE_INTERNATIONAL1            = 135;
  SDL_SCANCODE_INTERNATIONAL2            = 136;
  SDL_SCANCODE_INTERNATIONAL3            = 137;
  SDL_SCANCODE_INTERNATIONAL4            = 138;
  SDL_SCANCODE_INTERNATIONAL5            = 139;
  SDL_SCANCODE_INTERNATIONAL6            = 140;
  SDL_SCANCODE_INTERNATIONAL7            = 141;
  SDL_SCANCODE_INTERNATIONAL8            = 142;
  SDL_SCANCODE_INTERNATIONAL9            = 143;
  SDL_SCANCODE_LANG1                     = 144;
  SDL_SCANCODE_LANG2                     = 145;
  SDL_SCANCODE_LANG3                     = 146;
  SDL_SCANCODE_LANG4                     = 147;
  SDL_SCANCODE_LANG5                     = 148;
  SDL_SCANCODE_LANG6                     = 149;
  SDL_SCANCODE_LANG7                     = 150;
  SDL_SCANCODE_LANG8                     = 151;
  SDL_SCANCODE_LANG9                     = 152;
  SDL_SCANCODE_ALTERASE                  = 153;
  SDL_SCANCODE_SYSREQ                    = 154;
  SDL_SCANCODE_CANCEL                    = 155;
  SDL_SCANCODE_CLEAR                     = 156;
  SDL_SCANCODE_PRIOR                     = 157;
  SDL_SCANCODE_RETURN2                   = 158;
  SDL_SCANCODE_SEPARATOR                 = 159;
  SDL_SCANCODE_OUT                       = 160;
  SDL_SCANCODE_OPER                      = 161;
  SDL_SCANCODE_CLEARAGAIN                = 162;
  SDL_SCANCODE_CRSEL                     = 163;
  SDL_SCANCODE_EXSEL                     = 164;
  SDL_SCANCODE_KP_00                     = 176;
  SDL_SCANCODE_KP_000                    = 177;
  SDL_SCANCODE_THOUSANDSSEPARATOR        = 178;
  SDL_SCANCODE_DECIMALSEPARATOR          = 179;
  SDL_SCANCODE_CURRENCYUNIT              = 180;
  SDL_SCANCODE_CURRENCYSUBUNIT           = 181;
  SDL_SCANCODE_KP_LEFTPAREN              = 182;
  SDL_SCANCODE_KP_RIGHTPAREN             = 183;
  SDL_SCANCODE_KP_LEFTBRACE              = 184;
  SDL_SCANCODE_KP_RIGHTBRACE             = 185;
  SDL_SCANCODE_KP_TAB                    = 186;
  SDL_SCANCODE_KP_BACKSPACE              = 187;
  SDL_SCANCODE_KP_A                      = 188;
  SDL_SCANCODE_KP_B                      = 189;
  SDL_SCANCODE_KP_C                      = 190;
  SDL_SCANCODE_KP_D                      = 191;
  SDL_SCANCODE_KP_E                      = 192;
  SDL_SCANCODE_KP_F                      = 193;
  SDL_SCANCODE_KP_XOR                    = 194;
  SDL_SCANCODE_KP_POWER                  = 195;
  SDL_SCANCODE_KP_PERCENT                = 196;
  SDL_SCANCODE_KP_LESS                   = 197;
  SDL_SCANCODE_KP_GREATER                = 198;
  SDL_SCANCODE_KP_AMPERSAND              = 199;
  SDL_SCANCODE_KP_DBLAMPERSAND           = 200;
  SDL_SCANCODE_KP_VERTICALBAR            = 201;
  SDL_SCANCODE_KP_DBLVERTICALBAR         = 202;
  SDL_SCANCODE_KP_COLON                  = 203;
  SDL_SCANCODE_KP_HASH                   = 204;
  SDL_SCANCODE_KP_SPACE                  = 205;
  SDL_SCANCODE_KP_AT                     = 206;
  SDL_SCANCODE_KP_EXCLAM                 = 207;
  SDL_SCANCODE_KP_MEMSTORE               = 208;
  SDL_SCANCODE_KP_MEMRECALL              = 209;
  SDL_SCANCODE_KP_MEMCLEAR               = 210;
  SDL_SCANCODE_KP_MEMADD                 = 211;
  SDL_SCANCODE_KP_MEMSUBTRACT            = 212;
  SDL_SCANCODE_KP_MEMMULTIPLY            = 213;
  SDL_SCANCODE_KP_MEMDIVIDE              = 214;
  SDL_SCANCODE_KP_PLUSMINUS              = 215;
  SDL_SCANCODE_KP_CLEAR                  = 216;
  SDL_SCANCODE_KP_CLEARENTRY             = 217;
  SDL_SCANCODE_KP_BINARY                 = 218;
  SDL_SCANCODE_KP_OCTAL                  = 219;
  SDL_SCANCODE_KP_DECIMAL                = 220;
  SDL_SCANCODE_KP_HEXADECIMAL            = 221;
  SDL_SCANCODE_LCTRL                     = 224;
  SDL_SCANCODE_LSHIFT                    = 225;
  SDL_SCANCODE_LALT                      = 226;
  SDL_SCANCODE_LGUI                      = 227;
  SDL_SCANCODE_RCTRL                     = 228;
  SDL_SCANCODE_RSHIFT                    = 229;
  SDL_SCANCODE_RALT                      = 230;
  SDL_SCANCODE_RGUI                      = 231;
  SDL_SCANCODE_MODE                      = 257;
  SDL_SCANCODE_AUDIONEXT                 = 258;
  SDL_SCANCODE_AUDIOPREV                 = 259;
  SDL_SCANCODE_AUDIOSTOP                 = 260;
  SDL_SCANCODE_AUDIOPLAY                 = 261;
  SDL_SCANCODE_AUDIOMUTE                 = 262;
  SDL_SCANCODE_MEDIASELECT               = 263;
  SDL_SCANCODE_WWW                       = 264;
  SDL_SCANCODE_MAIL                      = 265;
  SDL_SCANCODE_CALCULATOR                = 266;
  SDL_SCANCODE_COMPUTER                  = 267;
  SDL_SCANCODE_AC_SEARCH                 = 268;
  SDL_SCANCODE_AC_HOME                   = 269;
  SDL_SCANCODE_AC_BACK                   = 270;
  SDL_SCANCODE_AC_FORWARD                = 271;
  SDL_SCANCODE_AC_STOP                   = 272;
  SDL_SCANCODE_AC_REFRESH                = 273;
  SDL_SCANCODE_AC_BOOKMARKS              = 274;
  SDL_SCANCODE_BRIGHTNESSDOWN            = 275;
  SDL_SCANCODE_BRIGHTNESSUP              = 276;
  SDL_SCANCODE_DISPLAYSWITCH             = 277;
  SDL_SCANCODE_KBDILLUMTOGGLE            = 278;
  SDL_SCANCODE_KBDILLUMDOWN              = 279;
  SDL_SCANCODE_KBDILLUMUP                = 280;
  SDL_SCANCODE_EJECT                     = 281;
  SDL_SCANCODE_SLEEP                     = 282;
  SDL_SCANCODE_APP1                      = 283;
  SDL_SCANCODE_APP2                      = 284;
  SDL_NUM_SCANCODES                      = 512;
  SDLK_SCANCODE_MASK                     = 1 shl 30;
  SDLK_UNKNOWN                           = 0;
  SDLK_RETURN                            = SInt32(#13);
  SDLK_ESCAPE                            = SInt32(#27);
  SDLK_BACKSPACE                         = SInt32(#8);
  SDLK_TAB                               = SInt32(#9);
  SDLK_SPACE                             = SInt32(' ');
  SDLK_EXCLAIM                           = SInt32('!');
  SDLK_QUOTEDBL                          = SInt32('"');
  SDLK_HASH                              = SInt32('#');
  SDLK_PERCENT                           = SInt32('%');
  SDLK_DOLLAR                            = SInt32('$');
  SDLK_AMPERSAND                         = SInt32('&');
  SDLK_QUOTE                             = SInt32('\');
  SDLK_LEFTPAREN                         = SInt32('(');
  SDLK_RIGHTPAREN                        = SInt32(')');
  SDLK_ASTERISK                          = SInt32('*');
  SDLK_PLUS                              = SInt32('+');
  SDLK_COMMA                             = SInt32(',');
  SDLK_MINUS                             = SInt32('-');
  SDLK_PERIOD                            = SInt32('.');
  SDLK_SLASH                             = SInt32('/');
  SDLK_0                                 = SInt32('0');
  SDLK_1                                 = SInt32('1');
  SDLK_2                                 = SInt32('2');
  SDLK_3                                 = SInt32('3');
  SDLK_4                                 = SInt32('4');
  SDLK_5                                 = SInt32('5');
  SDLK_6                                 = SInt32('6');
  SDLK_7                                 = SInt32('7');
  SDLK_8                                 = SInt32('8');
  SDLK_9                                 = SInt32('9');
  SDLK_COLON                             = SInt32(':');
  SDLK_SEMICOLON                         = SInt32(';');
  SDLK_LESS                              = SInt32('<');
  SDLK_EQUALS                            = SInt32('=');
  SDLK_GREATER                           = SInt32('>');
  SDLK_QUESTION                          = SInt32('?');
  SDLK_AT                                = SInt32('@');
  SDLK_LEFTBRACKET                       = SInt32('[');
  SDLK_BACKSLASH                         = SInt32('\');
  SDLK_RIGHTBRACKET                      = SInt32(']');
  SDLK_CARET                             = SInt32('^');
  SDLK_UNDERSCORE                        = SInt32('_');
  SDLK_BACKQUOTE                         = SInt32('`');
  SDLK_a                                 = SInt32('a');
  SDLK_b                                 = SInt32('b');
  SDLK_c                                 = SInt32('c');
  SDLK_d                                 = SInt32('d');
  SDLK_e                                 = SInt32('e');
  SDLK_f                                 = SInt32('f');
  SDLK_g                                 = SInt32('g');
  SDLK_h                                 = SInt32('h');
  SDLK_i                                 = SInt32('i');
  SDLK_j                                 = SInt32('j');
  SDLK_k                                 = SInt32('k');
  SDLK_l                                 = SInt32('l');
  SDLK_m                                 = SInt32('m');
  SDLK_n                                 = SInt32('n');
  SDLK_o                                 = SInt32('o');
  SDLK_p                                 = SInt32('p');
  SDLK_q                                 = SInt32('q');
  SDLK_r                                 = SInt32('r');
  SDLK_s                                 = SInt32('s');
  SDLK_t                                 = SInt32('t');
  SDLK_u                                 = SInt32('u');
  SDLK_v                                 = SInt32('v');
  SDLK_w                                 = SInt32('w');
  SDLK_x                                 = SInt32('x');
  SDLK_y                                 = SInt32('y');
  SDLK_z                                 = SInt32('z');
  SDLK_CAPSLOCK                          = SDL_SCANCODE_CAPSLOCK or SDLK_SCANCODE_MASK;
  SDLK_F1                                = SDL_SCANCODE_F1 or SDLK_SCANCODE_MASK;
  SDLK_F2                                = SDL_SCANCODE_F2 or SDLK_SCANCODE_MASK;
  SDLK_F3                                = SDL_SCANCODE_F3 or SDLK_SCANCODE_MASK;
  SDLK_F4                                = SDL_SCANCODE_F4 or SDLK_SCANCODE_MASK;
  SDLK_F5                                = SDL_SCANCODE_F5 or SDLK_SCANCODE_MASK;
  SDLK_F6                                = SDL_SCANCODE_F6 or SDLK_SCANCODE_MASK;
  SDLK_F7                                = SDL_SCANCODE_F7 or SDLK_SCANCODE_MASK;
  SDLK_F8                                = SDL_SCANCODE_F8 or SDLK_SCANCODE_MASK;
  SDLK_F9                                = SDL_SCANCODE_F9 or SDLK_SCANCODE_MASK;
  SDLK_F10                               = SDL_SCANCODE_F10 or SDLK_SCANCODE_MASK;
  SDLK_F11                               = SDL_SCANCODE_F11 or SDLK_SCANCODE_MASK;
  SDLK_F12                               = SDL_SCANCODE_F12 or SDLK_SCANCODE_MASK;
  SDLK_PRINTSCREEN                       = SDL_SCANCODE_PRINTSCREEN or SDLK_SCANCODE_MASK;
  SDLK_SCROLLLOCK                        = SDL_SCANCODE_SCROLLLOCK or SDLK_SCANCODE_MASK;
  SDLK_PAUSE                             = SDL_SCANCODE_PAUSE or SDLK_SCANCODE_MASK;
  SDLK_INSERT                            = SDL_SCANCODE_INSERT or SDLK_SCANCODE_MASK;
  SDLK_HOME                              = SDL_SCANCODE_HOME or SDLK_SCANCODE_MASK;
  SDLK_PAGEUP                            = SDL_SCANCODE_PAGEUP or SDLK_SCANCODE_MASK;
  SDLK_DELETE                            = SInt32(#127);
  SDLK_END                               = SDL_SCANCODE_END or SDLK_SCANCODE_MASK;
  SDLK_PAGEDOWN                          = SDL_SCANCODE_PAGEDOWN or SDLK_SCANCODE_MASK;
  SDLK_RIGHT                             = SDL_SCANCODE_RIGHT or SDLK_SCANCODE_MASK;
  SDLK_LEFT                              = SDL_SCANCODE_LEFT or SDLK_SCANCODE_MASK;
  SDLK_DOWN                              = SDL_SCANCODE_DOWN or SDLK_SCANCODE_MASK;
  SDLK_UP                                = SDL_SCANCODE_UP or SDLK_SCANCODE_MASK;
  SDLK_NUMLOCKCLEAR                      = SDL_SCANCODE_NUMLOCKCLEAR or SDLK_SCANCODE_MASK;
  SDLK_KP_DIVIDE                         = SDL_SCANCODE_KP_DIVIDE or SDLK_SCANCODE_MASK;
  SDLK_KP_MULTIPLY                       = SDL_SCANCODE_KP_MULTIPLY or SDLK_SCANCODE_MASK;
  SDLK_KP_MINUS                          = SDL_SCANCODE_KP_MINUS or SDLK_SCANCODE_MASK;
  SDLK_KP_PLUS                           = SDL_SCANCODE_KP_PLUS or SDLK_SCANCODE_MASK;
  SDLK_KP_ENTER                          = SDL_SCANCODE_KP_ENTER or SDLK_SCANCODE_MASK;
  SDLK_KP_1                              = SDL_SCANCODE_KP_1 or SDLK_SCANCODE_MASK;
  SDLK_KP_2                              = SDL_SCANCODE_KP_2 or SDLK_SCANCODE_MASK;
  SDLK_KP_3                              = SDL_SCANCODE_KP_3 or SDLK_SCANCODE_MASK;
  SDLK_KP_4                              = SDL_SCANCODE_KP_4 or SDLK_SCANCODE_MASK;
  SDLK_KP_5                              = SDL_SCANCODE_KP_5 or SDLK_SCANCODE_MASK;
  SDLK_KP_6                              = SDL_SCANCODE_KP_6 or SDLK_SCANCODE_MASK;
  SDLK_KP_7                              = SDL_SCANCODE_KP_7 or SDLK_SCANCODE_MASK;
  SDLK_KP_8                              = SDL_SCANCODE_KP_8 or SDLK_SCANCODE_MASK;
  SDLK_KP_9                              = SDL_SCANCODE_KP_9 or SDLK_SCANCODE_MASK;
  SDLK_KP_0                              = SDL_SCANCODE_KP_0 or SDLK_SCANCODE_MASK;
  SDLK_KP_PERIOD                         = SDL_SCANCODE_KP_PERIOD or SDLK_SCANCODE_MASK;
  SDLK_APPLICATION                       = SDL_SCANCODE_APPLICATION or SDLK_SCANCODE_MASK;
  SDLK_POWER                             = SDL_SCANCODE_POWER or SDLK_SCANCODE_MASK;
  SDLK_KP_EQUALS                         = SDL_SCANCODE_KP_EQUALS or SDLK_SCANCODE_MASK;
  SDLK_F13                               = SDL_SCANCODE_F13 or SDLK_SCANCODE_MASK;
  SDLK_F14                               = SDL_SCANCODE_F14 or SDLK_SCANCODE_MASK;
  SDLK_F15                               = SDL_SCANCODE_F15 or SDLK_SCANCODE_MASK;
  SDLK_F16                               = SDL_SCANCODE_F16 or SDLK_SCANCODE_MASK;
  SDLK_F17                               = SDL_SCANCODE_F17 or SDLK_SCANCODE_MASK;
  SDLK_F18                               = SDL_SCANCODE_F18 or SDLK_SCANCODE_MASK;
  SDLK_F19                               = SDL_SCANCODE_F19 or SDLK_SCANCODE_MASK;
  SDLK_F20                               = SDL_SCANCODE_F20 or SDLK_SCANCODE_MASK;
  SDLK_F21                               = SDL_SCANCODE_F21 or SDLK_SCANCODE_MASK;
  SDLK_F22                               = SDL_SCANCODE_F22 or SDLK_SCANCODE_MASK;
  SDLK_F23                               = SDL_SCANCODE_F23 or SDLK_SCANCODE_MASK;
  SDLK_F24                               = SDL_SCANCODE_F24 or SDLK_SCANCODE_MASK;
  SDLK_EXECUTE                           = SDL_SCANCODE_EXECUTE or SDLK_SCANCODE_MASK;
  SDLK_HELP                              = SDL_SCANCODE_HELP or SDLK_SCANCODE_MASK;
  SDLK_MENU                              = SDL_SCANCODE_MENU or SDLK_SCANCODE_MASK;
  SDLK_SELECT                            = SDL_SCANCODE_SELECT or SDLK_SCANCODE_MASK;
  SDLK_STOP                              = SDL_SCANCODE_STOP or SDLK_SCANCODE_MASK;
  SDLK_AGAIN                             = SDL_SCANCODE_AGAIN or SDLK_SCANCODE_MASK;
  SDLK_UNDO                              = SDL_SCANCODE_UNDO or SDLK_SCANCODE_MASK;
  SDLK_CUT                               = SDL_SCANCODE_CUT or SDLK_SCANCODE_MASK;
  SDLK_COPY                              = SDL_SCANCODE_COPY or SDLK_SCANCODE_MASK;
  SDLK_PASTE                             = SDL_SCANCODE_PASTE or SDLK_SCANCODE_MASK;
  SDLK_FIND                              = SDL_SCANCODE_FIND or SDLK_SCANCODE_MASK;
  SDLK_MUTE                              = SDL_SCANCODE_MUTE or SDLK_SCANCODE_MASK;
  SDLK_VOLUMEUP                          = SDL_SCANCODE_VOLUMEUP or SDLK_SCANCODE_MASK;
  SDLK_VOLUMEDOWN                        = SDL_SCANCODE_VOLUMEDOWN or SDLK_SCANCODE_MASK;
  SDLK_KP_COMMA                          = SDL_SCANCODE_KP_COMMA or SDLK_SCANCODE_MASK;
  SDLK_KP_EQUALSAS400                    = SDL_SCANCODE_KP_EQUALSAS400 or SDLK_SCANCODE_MASK;
  SDLK_ALTERASE                          = SDL_SCANCODE_ALTERASE or SDLK_SCANCODE_MASK;
  SDLK_SYSREQ                            = SDL_SCANCODE_SYSREQ or SDLK_SCANCODE_MASK;
  SDLK_CANCEL                            = SDL_SCANCODE_CANCEL or SDLK_SCANCODE_MASK;
  SDLK_CLEAR                             = SDL_SCANCODE_CLEAR or SDLK_SCANCODE_MASK;
  SDLK_PRIOR                             = SDL_SCANCODE_PRIOR or SDLK_SCANCODE_MASK;
  SDLK_RETURN2                           = SDL_SCANCODE_RETURN2 or SDLK_SCANCODE_MASK;
  SDLK_SEPARATOR                         = SDL_SCANCODE_SEPARATOR or SDLK_SCANCODE_MASK;
  SDLK_OUT                               = SDL_SCANCODE_OUT or SDLK_SCANCODE_MASK;
  SDLK_OPER                              = SDL_SCANCODE_OPER or SDLK_SCANCODE_MASK;
  SDLK_CLEARAGAIN                        = SDL_SCANCODE_CLEARAGAIN or SDLK_SCANCODE_MASK;
  SDLK_CRSEL                             = SDL_SCANCODE_CRSEL or SDLK_SCANCODE_MASK;
  SDLK_EXSEL                             = SDL_SCANCODE_EXSEL or SDLK_SCANCODE_MASK;
  SDLK_KP_00                             = SDL_SCANCODE_KP_00 or SDLK_SCANCODE_MASK;
  SDLK_KP_000                            = SDL_SCANCODE_KP_000 or SDLK_SCANCODE_MASK;
  SDLK_THOUSANDSSEPARATOR                = SDL_SCANCODE_THOUSANDSSEPARATOR or SDLK_SCANCODE_MASK;
  SDLK_DECIMALSEPARATOR                  = SDL_SCANCODE_DECIMALSEPARATOR or SDLK_SCANCODE_MASK;
  SDLK_CURRENCYUNIT                      = SDL_SCANCODE_CURRENCYUNIT or SDLK_SCANCODE_MASK;
  SDLK_CURRENCYSUBUNIT                   = SDL_SCANCODE_CURRENCYSUBUNIT or SDLK_SCANCODE_MASK;
  SDLK_KP_LEFTPAREN                      = SDL_SCANCODE_KP_LEFTPAREN or SDLK_SCANCODE_MASK;
  SDLK_KP_RIGHTPAREN                     = SDL_SCANCODE_KP_RIGHTPAREN or SDLK_SCANCODE_MASK;
  SDLK_KP_LEFTBRACE                      = SDL_SCANCODE_KP_LEFTBRACE or SDLK_SCANCODE_MASK;
  SDLK_KP_RIGHTBRACE                     = SDL_SCANCODE_KP_RIGHTBRACE or SDLK_SCANCODE_MASK;
  SDLK_KP_TAB                            = SDL_SCANCODE_KP_TAB or SDLK_SCANCODE_MASK;
  SDLK_KP_BACKSPACE                      = SDL_SCANCODE_KP_BACKSPACE or SDLK_SCANCODE_MASK;
  SDLK_KP_A                              = SDL_SCANCODE_KP_A or SDLK_SCANCODE_MASK;
  SDLK_KP_B                              = SDL_SCANCODE_KP_B or SDLK_SCANCODE_MASK;
  SDLK_KP_C                              = SDL_SCANCODE_KP_C or SDLK_SCANCODE_MASK;
  SDLK_KP_D                              = SDL_SCANCODE_KP_D or SDLK_SCANCODE_MASK;
  SDLK_KP_E                              = SDL_SCANCODE_KP_E or SDLK_SCANCODE_MASK;
  SDLK_KP_F                              = SDL_SCANCODE_KP_F or SDLK_SCANCODE_MASK;
  SDLK_KP_XOR                            = SDL_SCANCODE_KP_XOR or SDLK_SCANCODE_MASK;
  SDLK_KP_POWER                          = SDL_SCANCODE_KP_POWER or SDLK_SCANCODE_MASK;
  SDLK_KP_PERCENT                        = SDL_SCANCODE_KP_PERCENT or SDLK_SCANCODE_MASK;
  SDLK_KP_LESS                           = SDL_SCANCODE_KP_LESS or SDLK_SCANCODE_MASK;
  SDLK_KP_GREATER                        = SDL_SCANCODE_KP_GREATER or SDLK_SCANCODE_MASK;
  SDLK_KP_AMPERSAND                      = SDL_SCANCODE_KP_AMPERSAND or SDLK_SCANCODE_MASK;
  SDLK_KP_DBLAMPERSAND                   = SDL_SCANCODE_KP_DBLAMPERSAND or SDLK_SCANCODE_MASK;
  SDLK_KP_VERTICALBAR                    = SDL_SCANCODE_KP_VERTICALBAR or SDLK_SCANCODE_MASK;
  SDLK_KP_DBLVERTICALBAR                 = SDL_SCANCODE_KP_DBLVERTICALBAR or SDLK_SCANCODE_MASK;
  SDLK_KP_COLON                          = SDL_SCANCODE_KP_COLON or SDLK_SCANCODE_MASK;
  SDLK_KP_HASH                           = SDL_SCANCODE_KP_HASH or SDLK_SCANCODE_MASK;
  SDLK_KP_SPACE                          = SDL_SCANCODE_KP_SPACE or SDLK_SCANCODE_MASK;
  SDLK_KP_AT                             = SDL_SCANCODE_KP_AT or SDLK_SCANCODE_MASK;
  SDLK_KP_EXCLAM                         = SDL_SCANCODE_KP_EXCLAM or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMSTORE                       = SDL_SCANCODE_KP_MEMSTORE or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMRECALL                      = SDL_SCANCODE_KP_MEMRECALL or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMCLEAR                       = SDL_SCANCODE_KP_MEMCLEAR or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMADD                         = SDL_SCANCODE_KP_MEMADD or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMSUBTRACT                    = SDL_SCANCODE_KP_MEMSUBTRACT or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMMULTIPLY                    = SDL_SCANCODE_KP_MEMMULTIPLY or SDLK_SCANCODE_MASK;
  SDLK_KP_MEMDIVIDE                      = SDL_SCANCODE_KP_MEMDIVIDE or SDLK_SCANCODE_MASK;
  SDLK_KP_PLUSMINUS                      = SDL_SCANCODE_KP_PLUSMINUS or SDLK_SCANCODE_MASK;
  SDLK_KP_CLEAR                          = SDL_SCANCODE_KP_CLEAR or SDLK_SCANCODE_MASK;
  SDLK_KP_CLEARENTRY                     = SDL_SCANCODE_KP_CLEARENTRY or SDLK_SCANCODE_MASK;
  SDLK_KP_BINARY                         = SDL_SCANCODE_KP_BINARY or SDLK_SCANCODE_MASK;
  SDLK_KP_OCTAL                          = SDL_SCANCODE_KP_OCTAL or SDLK_SCANCODE_MASK;
  SDLK_KP_DECIMAL                        = SDL_SCANCODE_KP_DECIMAL or SDLK_SCANCODE_MASK;
  SDLK_KP_HEXADECIMAL                    = SDL_SCANCODE_KP_HEXADECIMAL or SDLK_SCANCODE_MASK;
  SDLK_LCTRL                             = SDL_SCANCODE_LCTRL or SDLK_SCANCODE_MASK;
  SDLK_LSHIFT                            = SDL_SCANCODE_LSHIFT or SDLK_SCANCODE_MASK;
  SDLK_LALT                              = SDL_SCANCODE_LALT or SDLK_SCANCODE_MASK;
  SDLK_LGUI                              = SDL_SCANCODE_LGUI or SDLK_SCANCODE_MASK;
  SDLK_RCTRL                             = SDL_SCANCODE_RCTRL or SDLK_SCANCODE_MASK;
  SDLK_RSHIFT                            = SDL_SCANCODE_RSHIFT or SDLK_SCANCODE_MASK;
  SDLK_RALT                              = SDL_SCANCODE_RALT or SDLK_SCANCODE_MASK;
  SDLK_RGUI                              = SDL_SCANCODE_RGUI or SDLK_SCANCODE_MASK;
  SDLK_MODE                              = SDL_SCANCODE_MODE or SDLK_SCANCODE_MASK;
  SDLK_AUDIONEXT                         = SDL_SCANCODE_AUDIONEXT or SDLK_SCANCODE_MASK;
  SDLK_AUDIOPREV                         = SDL_SCANCODE_AUDIOPREV or SDLK_SCANCODE_MASK;
  SDLK_AUDIOSTOP                         = SDL_SCANCODE_AUDIOSTOP or SDLK_SCANCODE_MASK;
  SDLK_AUDIOPLAY                         = SDL_SCANCODE_AUDIOPLAY or SDLK_SCANCODE_MASK;
  SDLK_AUDIOMUTE                         = SDL_SCANCODE_AUDIOMUTE or SDLK_SCANCODE_MASK;
  SDLK_MEDIASELECT                       = SDL_SCANCODE_MEDIASELECT or SDLK_SCANCODE_MASK;
  SDLK_WWW                               = SDL_SCANCODE_WWW or SDLK_SCANCODE_MASK;
  SDLK_MAIL                              = SDL_SCANCODE_MAIL or SDLK_SCANCODE_MASK;
  SDLK_CALCULATOR                        = SDL_SCANCODE_CALCULATOR or SDLK_SCANCODE_MASK;
  SDLK_COMPUTER                          = SDL_SCANCODE_COMPUTER or SDLK_SCANCODE_MASK;
  SDLK_AC_SEARCH                         = SDL_SCANCODE_AC_SEARCH or SDLK_SCANCODE_MASK;
  SDLK_AC_HOME                           = SDL_SCANCODE_AC_HOME or SDLK_SCANCODE_MASK;
  SDLK_AC_BACK                           = SDL_SCANCODE_AC_BACK or SDLK_SCANCODE_MASK;
  SDLK_AC_FORWARD                        = SDL_SCANCODE_AC_FORWARD or SDLK_SCANCODE_MASK;
  SDLK_AC_STOP                           = SDL_SCANCODE_AC_STOP or SDLK_SCANCODE_MASK;
  SDLK_AC_REFRESH                        = SDL_SCANCODE_AC_REFRESH or SDLK_SCANCODE_MASK;
  SDLK_AC_BOOKMARKS                      = SDL_SCANCODE_AC_BOOKMARKS or SDLK_SCANCODE_MASK;
  SDLK_BRIGHTNESSDOWN                    = SDL_SCANCODE_BRIGHTNESSDOWN or SDLK_SCANCODE_MASK;
  SDLK_BRIGHTNESSUP                      = SDL_SCANCODE_BRIGHTNESSUP or SDLK_SCANCODE_MASK;
  SDLK_DISPLAYSWITCH                     = SDL_SCANCODE_DISPLAYSWITCH or SDLK_SCANCODE_MASK;
  SDLK_KBDILLUMTOGGLE                    = SDL_SCANCODE_KBDILLUMTOGGLE or SDLK_SCANCODE_MASK;
  SDLK_KBDILLUMDOWN                      = SDL_SCANCODE_KBDILLUMDOWN or SDLK_SCANCODE_MASK;
  SDLK_KBDILLUMUP                        = SDL_SCANCODE_KBDILLUMUP or SDLK_SCANCODE_MASK;
  SDLK_EJECT                             = SDL_SCANCODE_EJECT or SDLK_SCANCODE_MASK;
  SDLK_SLEEP                             = SDL_SCANCODE_SLEEP or SDLK_SCANCODE_MASK;
  KMOD_NONE                              = $0000;
  KMOD_LSHIFT                            = $0001;
  KMOD_RSHIFT                            = $0002;
  KMOD_LCTRL                             = $0040;
  KMOD_RCTRL                             = $0080;
  KMOD_LALT                              = $0100;
  KMOD_RALT                              = $0200;
  KMOD_LGUI                              = $0400;
  KMOD_RGUI                              = $0800;
  KMOD_NUM                               = $1000;
  KMOD_CAPS                              = $2000;
  KMOD_MODE                              = $4000;
  KMOD_RESERVED                          = $8000;
  KMOD_CTRL                              = KMOD_LCTRL or KMOD_RCTRL;
  KMOD_SHIFT                             = KMOD_LSHIFT or KMOD_RSHIFT;
  KMOD_ALT                               = KMOD_LALT or KMOD_RALT;
  KMOD_GUI                               = KMOD_LGUI or KMOD_RGUI;
  SDL_NONSHAPEABLE_WINDOW                = -1;
  SDL_INVALID_SHAPE_ARGUMENT             = -2;
  SDL_WINDOW_LACKS_SHAPE                 = -3;
  SDL_SWSURFACE                          = 0;
  SDL_PREALLOC                           = $00000001;
  SDL_RLEACCEL                           = $00000002;
  SDL_DONTFREE                           = $00000004;
  SDL_TOUCH_MOUSEID                      = UInt32(-1);
  SDL_MAJOR_VERSION                      = 2;
  SDL_MINOR_VERSION                      = 0;
  SDL_PATCHLEVEL                         = 4;
  SDL_WINDOW_FULLSCREEN                  = $00000001;
  SDL_WINDOW_OPENGL                      = $00000002;
  SDL_WINDOW_SHOWN                       = $00000004;
  SDL_WINDOW_HIDDEN                      = $00000008;
  SDL_WINDOW_BORDERLESS                  = $00000010;
  SDL_WINDOW_RESIZABLE                   = $00000020;
  SDL_WINDOW_MINIMIZED                   = $00000040;
  SDL_WINDOW_MAXIMIZED                   = $00000080;
  SDL_WINDOW_INPUT_GRABBED               = $00000100;
  SDL_WINDOW_INPUT_FOCUS                 = $00000200;
  SDL_WINDOW_MOUSE_FOCUS                 = $00000400;
  SDL_WINDOW_FULLSCREEN_DESKTOP          = SDL_WINDOW_FULLSCREEN or $00001000;
  SDL_WINDOW_FOREIGN                     = $00000800;
  SDL_WINDOW_ALLOW_HIGHDPI               = $00002000;
  SDL_WINDOW_ALWAYS_ON_TOP               = $00008000;
  SDL_WINDOW_SKIP_TASKBAR                = $00010000;
  SDL_WINDOW_UTILITY                     = $00020000;
  SDL_WINDOW_TOOLTIP                     = $00040000;
  SDL_WINDOW_POPUP_MENU                  = $00080000;
  SDL_WINDOWPOS_UNDEFINED_MASK           = $1FFF0000;
  SDL_WINDOWPOS_UNDEFINED                = SDL_WINDOWPOS_UNDEFINED_MASK or 0;
  SDL_WINDOWPOS_CENTERED_MASK            = $2FFF0000;
  SDL_WINDOWPOS_CENTERED                 = SDL_WINDOWPOS_CENTERED_MASK or 0;
  SDL_WINDOWEVENT_NONE                   = 0;
  SDL_WINDOWEVENT_SHOWN                  = 1;
  SDL_WINDOWEVENT_HIDDEN                 = 2;
  SDL_WINDOWEVENT_EXPOSED                = 3;
  SDL_WINDOWEVENT_MOVED                  = 4;
  SDL_WINDOWEVENT_RESIZED                = 5;
  SDL_WINDOWEVENT_SIZE_CHANGED           = 6;
  SDL_WINDOWEVENT_MINIMIZED              = 7;
  SDL_WINDOWEVENT_MAXIMIZED              = 8;
  SDL_WINDOWEVENT_RESTORED               = 9;
  SDL_WINDOWEVENT_ENTER                  = 10;
  SDL_WINDOWEVENT_LEAVE                  = 11;
  SDL_WINDOWEVENT_FOCUS_GAINED           = 12;
  SDL_WINDOWEVENT_FOCUS_LOST             = 13;
  SDL_WINDOWEVENT_CLOSE                  = 14;
  SDL_WINDOWEVENT_TAKE_FOCUS             = 15;
  SDL_WINDOWEVENT_HIT_TEST               = 16;
  SDL_GL_RED_SIZE                        = 0;
  SDL_GL_GREEN_SIZE                      = 1;
  SDL_GL_BLUE_SIZE                       = 2;
  SDL_GL_ALPHA_SIZE                      = 3;
  SDL_GL_BUFFER_SIZE                     = 4;
  SDL_GL_DOUBLEBUFFER                    = 5;
  SDL_GL_DEPTH_SIZE                      = 6;
  SDL_GL_STENCIL_SIZE                    = 7;
  SDL_GL_ACCUM_RED_SIZE                  = 8;
  SDL_GL_ACCUM_GREEN_SIZE                = 9;
  SDL_GL_ACCUM_BLUE_SIZE                 = 10;
  SDL_GL_ACCUM_ALPHA_SIZE                = 11;
  SDL_GL_STEREO                          = 12;
  SDL_GL_MULTISAMPLEBUFFERS              = 13;
  SDL_GL_MULTISAMPLESAMPLES              = 14;
  SDL_GL_ACCELERATED_VISUAL              = 15;
  SDL_GL_RETAINED_BACKING                = 16;
  SDL_GL_CONTEXT_MAJOR_VERSION           = 17;
  SDL_GL_CONTEXT_MINOR_VERSION           = 18;
  SDL_GL_CONTEXT_EGL                     = 19;
  SDL_GL_CONTEXT_FLAGS                   = 20;
  SDL_GL_CONTEXT_PROFILE_MASK            = 21;
  SDL_GL_SHARE_WITH_CURRENT_CONTEXT      = 22;
  SDL_GL_FRAMEBUFFER_SRGB_CAPABLE        = 23;
  SDL_GL_CONTEXT_RELEASE_BEHAVIOR        = 24;
  SDL_GL_CONTEXT_DEBUG_FLAG              = $0001;
  SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG = $0002;
  SDL_GL_CONTEXT_ROBUST_ACCESS_FLAG      = $0004;
  SDL_GL_CONTEXT_RESET_ISOLATION_FLAG    = $0008;
  SDL_GL_CONTEXT_PROFILE_CORE            = $0001;
  SDL_GL_CONTEXT_PROFILE_COMPATIBILITY   = $0002;
  SDL_GL_CONTEXT_PROFILE_ES              = $0004;
  SDL_GL_CONTEXT_RELEASE_BEHAVIOR_NONE   = $0000;
  SDL_GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH  = $0001;

type
  TMIX_InitFlags = Byte;
  PFPSManager    = ^TFPSManager;
  PMix_Chunk     = ^TMix_Chunk;

  TFPSManager = record
    framecount: UInt32;
    rateticks: Single;
    baseticks: UInt32;
    lastticks: UInt32;
    rate: UInt32;
  end;

  TIMG_InitFlags = DWord;

  TMix_Chunk = record
    allocated: Integer;
    abuf: PuInt8;
    alen: UInt32;
    volume: UInt8;
  end;

  TMix_Fading    = (MIX_NO_FADING, MIX_FADING_OUT, MIX_FADING_IN);
  TMix_MusicType = (MUS_NONE, MUS_CMD, MUS_WAV, MUS_MOD, MUS_MID, MUS_OGG, MUS_MP3, MUS_MP3_MAD, MUS_FLAC, MUS_MODPLUG);
  PMix_Music     = ^TMix_Music;

  TMix_Music = record
  end;

  TMix_Func = procedure(udata: Pointer; stream: PuInt8; len: Integer);

  PMix_Music_Finished   = ^TMix_Music_Finished;
  TMix_Music_Finished   = procedure();
  TMix_Channel_Finished = procedure(channel: Integer);

  TMix_EffectFunc_t = procedure(chan: Integer; stream: Pointer; len: Integer; udata: Pointer);

  TMix_EffectDone_t = procedure(chan: Integer; udata: Pointer);

  TSDLNet_Version = TSDL_Version;
  TMix_SoundFunc  = function(c: PAnsiChar; p: Pointer): Integer;

  TIPaddress = record
    host: UInt32;
    port: UInt16;
  end;

  _TCPSocket = record
  end;

  TTCPSocket = ^_TCPSocket;

  PIPaddress = ^TIPaddress;

  TUDPSocket = record
  end;

  PUDPSocket = ^TUDPSocket;

  TUDPPacket = record
    channel: Integer;
    data: PuInt8;
    len: Integer;
    maxlen: Integer;
    status: Integer;
    address: TIPaddress;
  end;

  PUDPPacket  = ^TUDPPacket;
  PPUDPPacket = ^PUDPPacket;

  TSDLNet_SocketSet = record
  end;

  PSDLNet_SocketSet = ^TSDLNet_SocketSet;

  TSDLNet_GenericSocket = record
    ready: Integer;
  end;

  PSDLNet_GenericSocket = ^TSDLNet_GenericSocket;

  PTTF_Font = ^TTTF_Font;

  TTTF_Font = record
  end;

  TSDL_AudioFormat = UInt16;

  TSDL_AudioCallback = procedure(userdata: Pointer; stream: PuInt8; len: Integer)cdecl;

  PSDL_AudioSpec = ^TSDL_AudioSpec;

  TSDL_AudioSpec = record
    freq: Integer;
    format: TSDL_AudioFormat;
    channels: UInt8;
    silence: UInt8;
    samples: UInt16;
    padding: UInt16;
    size: UInt32;
    callback: TSDL_AudioCallback;
    userdata: Pointer;
  end;

  PSDL_AudioCVT    = ^TSDL_AudioCVT;
  TSDL_AudioFilter = procedure(cvt: PSDL_AudioCVT; format: TSDL_AudioFormat)cdecl;

  TSDL_AudioCVT = record
    needed: Integer;
    src_format: TSDL_AudioFormat;
    dst_format: TSDL_AudioFormat;
    rate_incr: Double;
    buf: PuInt8;
    len: Integer;
    len_cvt: Integer;
    len_mult: Integer;
    len_ratio: Double;
    filters: array [0 .. 9] of TSDL_AudioFilter;
    filter_index: Integer;
  end;

  PSDL_BlendMode = ^TSDL_BlendMode;
  TSDL_BlendMode = DWord;

  TSDL_AudioDeviceID = UInt32;
  TSDL_AudioStatus   = (SDL_AUDIO_STOPPED, SDL_AUDIO_PLAYING, SDL_AUDIO_PAUSED);

  TSDL_ErrorCode = (SDL_ENOMEM, SDL_EFREAD, SDL_EFWRITE, SDL_EFSEEK, SDL_UNSUPPORTED, SDL_LASTERROR);

  TSDL_Error = record
    error: SInt32;
    key: String[ERR_MAX_STRLEN];
    argc: SInt32;
    case SInt32 of
      0:
        (value_c: Byte;);
      1:
        (value_ptr: Pointer;);
      2:
        (value_i: SInt32;);
      3:
        (value_f: Double;);
      4:
        (buf: String[ERR_MAX_STRLEN];);
  end;

  TSDL_EventType = Word;

  TSDL_CommonEvent = record
    type_: UInt32;
    timestamp: UInt32;
  end;

  TSDL_WindowEvent = record
    type_: UInt32;
    timestamp: UInt32;
    windowID: UInt32;
    event: UInt8;
    padding1: UInt8;
    padding2: UInt8;
    padding3: UInt8;
    data1: SInt32;
    data2: SInt32;
  end;

  TSDL_KeyboardEvent = record
    type_: UInt32;
    timestamp: UInt32;
    windowID: UInt32;
    state: UInt8;
    _repeat: UInt8;
    padding2: UInt8;
    padding3: UInt8;
    keysym: TSDL_KeySym;
  end;

  TSDL_TextEditingEvent = record
    type_: UInt32;
    timestamp: UInt32;
    windowID: UInt32;
    text: array [0 .. SDL_TEXTEDITINGEVENT_TEXT_SIZE] of Char;
    start: SInt32;
    Length: SInt32;
  end;

  TSDL_TextInputEvent = record
    type_: UInt32;
    timestamp: UInt32;
    windowID: UInt32;
    text: array [0 .. SDL_TEXTINPUTEVENT_TEXT_SIZE] of Char;
  end;

  TSDL_MouseMotionEvent = record
    type_: UInt32;
    timestamp: UInt32;
    windowID: UInt32;
    which: UInt32;
    state: UInt8;
    padding1: UInt8;
    padding2: UInt8;
    padding3: UInt8;
    x: SInt32;
    Y: SInt32;
    xrel: SInt32;
    yrel: SInt32;
  end;

  TSDL_MouseButtonEvent = record
    type_: UInt32;
    timestamp: UInt32;
    windowID: UInt32;
    which: UInt32;
    button: UInt8;
    state: UInt8;
    clicks: UInt8;
    padding1: UInt8;
    x: SInt32;
    Y: SInt32;
  end;

  TSDL_MouseWheelEvent = record
    type_: UInt32;
    timestamp: UInt32;
    windowID: UInt32;
    which: UInt32;
    x: SInt32;
    Y: SInt32;
    direction: UInt32;
  end;

  TSDL_JoyAxisEvent = record
    type_: UInt32;
    timestamp: UInt32;
    which: TSDL_JoystickID;
    axis: UInt8;
    padding1: UInt8;
    padding2: UInt8;
    padding3: UInt8;
    value: sInt16;
    padding4: UInt16;
  end;

  TSDL_JoyBallEvent = record
    type_: UInt32;
    timestamp: UInt32;
    which: TSDL_JoystickID;
    ball: UInt8;
    padding1: UInt8;
    padding2: UInt8;
    padding3: UInt8;
    xrel: sInt16;
    yrel: sInt16;
  end;

  TSDL_JoyHatEvent = record
    type_: UInt32;
    timestamp: UInt32;
    which: TSDL_JoystickID;
    hat: UInt8;
    value: UInt8;
    padding1: UInt8;
    padding2: UInt8;
  end;

  TSDL_JoyButtonEvent = record
    type_: UInt32;
    timestamp: UInt32;
    which: TSDL_JoystickID;
    button: UInt8;
    state: UInt8;
    padding1: UInt8;
    padding2: UInt8;
  end;

  TSDL_JoyDeviceEvent = record
    type_: UInt32;
    timestamp: UInt32;
    which: SInt32;
  end;

  TSDL_ControllerAxisEvent = record
    type_: UInt32;
    timestamp: UInt32;
    which: TSDL_JoystickID;
    axis: UInt8;
    padding1: UInt8;
    padding2: UInt8;
    padding3: UInt8;
    value: sInt16;
    padding4: UInt16;
  end;

  TSDL_ControllerButtonEvent = record
    type_: UInt32;
    timestamp: UInt32;
    which: TSDL_JoystickID;
    button: UInt8;
    state: UInt8;
    padding1: UInt8;
    padding2: UInt8;
  end;

  TSDL_ControllerDeviceEvent = record
    type_: UInt32;
    timestamp: UInt32;
    which: SInt32;
  end;

  TSDL_AudioDeviceEvent = record
    type_: UInt32;
    timestamp: UInt32;
    which: UInt32;
    iscapture: UInt8;
    padding1: UInt8;
    padding2: UInt8;
    padding3: UInt8;
  end;

  TSDL_TouchFingerEvent = record
    type_: UInt32;
    timestamp: UInt32;
    touchId: TSDL_TouchID;
    fingerId: TSDL_FingerID;
    x: Float;
    Y: Float;
    dx: Float;
    dy: Float;
    pressure: Float;
  end;

  TSDL_MultiGestureEvent = record
    type_: UInt32;
    timestamp: UInt32;
    touchId: TSDL_TouchID;
    dTheta: Float;
    dDist: Float;
    x: Float;
    Y: Float;
    numFingers: UInt16;
    padding: UInt16;
  end;

  TSDL_DollarGestureEvent = record
    type_: UInt32;
    timestamp: UInt32;
    touchId: TSDL_TouchID;
    gestureId: TSDL_GestureID;
    numFingers: UInt32;
    error: Float;
    x: Float;
    Y: Float;
  end;

  TSDL_DropEvent = record
    type_: UInt32;
    timestamp: UInt32;
    _file: PAnsiChar;
  end;

  TSDL_QuitEvent = record
    type_: UInt32;
    timestamp: UInt32;
  end;

  TSDL_UserEvent = record
    type_: UInt32;
    timestamp: UInt32;
    windowID: UInt32;
    code: SInt32;
    data1: Pointer;
    data2: Pointer;
  end;

  PSDL_SysWMEvent = ^TSDL_SysWMEvent;

  TSDL_SysWMEvent = record
    type_: UInt32;
    timestamp: UInt32;
    msg: PSDL_SysWMmsg;
  end;

  PSDL_Event = ^TSDL_Event;

  TSDL_Event = record
    case Integer of
      0:
        (type_: UInt32);
      SDL_COMMONEVENT:
        (common: TSDL_CommonEvent);
      SDL_WINDOWEVENT:
        (window: TSDL_WindowEvent);
      SDL_KEYUP, SDL_KEYDOWN:
        (key: TSDL_KeyboardEvent);
      SDL_TEXTEDITING:
        (edit: TSDL_TextEditingEvent);
      SDL_TEXTINPUT:
        (text: TSDL_TextInputEvent);
      SDL_MOUSEMOTION:
        (motion: TSDL_MouseMotionEvent);
      SDL_MOUSEBUTTONUP, SDL_MOUSEBUTTONDOWN:
        (button: TSDL_MouseButtonEvent);
      SDL_MOUSEWHEEL:
        (wheel: TSDL_MouseWheelEvent);
      SDL_JOYAXISMOTION:
        (jaxis: TSDL_JoyAxisEvent);
      SDL_JOYBALLMOTION:
        (jball: TSDL_JoyBallEvent);
      SDL_JOYHATMOTION:
        (jhat: TSDL_JoyHatEvent);
      SDL_JOYBUTTONDOWN, SDL_JOYBUTTONUP:
        (jbutton: TSDL_JoyButtonEvent);
      SDL_JOYDEVICEADDED, SDL_JOYDEVICEREMOVED:
        (jdevice: TSDL_JoyDeviceEvent);
      SDL_CONTROLLERAXISMOTION:
        (caxis: TSDL_ControllerAxisEvent);
      SDL_CONTROLLERBUTTONUP, SDL_CONTROLLERBUTTONDOWN:
        (cbutton: TSDL_ControllerButtonEvent);
      SDL_CONTROLLERDEVICEADDED, SDL_CONTROLLERDEVICEREMOVED, SDL_CONTROLLERDEVICEREMAPPED:
        (cdevice: TSDL_ControllerDeviceEvent);
      SDL_AUDIODEVICEADDED, SDL_AUDIODEVICEREMOVED:
        (adevice: TSDL_AudioDeviceEvent);
      SDL_QUITEV:
        (quit: TSDL_QuitEvent);
      SDL_USEREVENT:
        (user: TSDL_UserEvent);
      SDL_SYSWMEVENT:
        (syswm: TSDL_SysWMEvent);
      SDL_FINGERDOWN, SDL_FINGERUP, SDL_FINGERMOTION:
        (tfinger: TSDL_TouchFingerEvent);
      SDL_MULTIGESTURE:
        (mgesture: TSDL_MultiGestureEvent);
      SDL_DOLLARGESTURE, SDL_DOLLARRECORD:
        (dgesture: TSDL_DollarGestureEvent);
      SDL_DROPFILE:
        (drop: TSDL_DropEvent);
  end;

  TSDL_GameControllerButton = Byte;

  TSDL_GameControllerAxis = Byte;

  TSDL_EventAction = Word;

  PSDL_EventFilter = ^TSDL_EventFilter;
{$IFNDEF GPC}
  TSDL_EventFilter = function(userdata: Pointer; event: PSDL_Event): Integer; cdecl;
{$ELSE}
  TSDL_EventFilter = function(userdata: Pointer; event: PSDL_Event): Integer;
{$ENDIF}
  PSDL_GameController         = ^TSDL_GameController;
  TSDL_GameController         = Pointer;
  TSDL_GameControllerBindType = (SDL_CONTROLLER_BINDTYPE_NONE, SDL_CONTROLLER_BINDTYPE_BUTTON, SDL_CONTROLLER_BINDTYPE_AXIS, SDL_CONTROLLER_BINDTYPE_HAT);

  THat = record
    hat: Integer;
    hat_mask: Integer;
  end;

  TSDL_GameControllerButtonBind = record
    bindType: TSDL_GameControllerBindType;
    case Integer of
      0:
        (button: Integer;);
      1:
        (axis: Integer;);
      2:
        (hat: THat;);
  end;

  TSDL_GestureID = SInt64;
  PSDL_Haptic    = ^TSDL_Haptic;

  TSDL_Haptic = record
  end;

  TSDL_HapticDirection = record
    _type: UInt8;
    dir: array [0 .. 2] of SInt32;
  end;

  TSDL_HapticConstant = record
    _type: UInt16;
    direction: TSDL_HapticDirection;
    Length: UInt32;
    delay: UInt16;
    button: UInt16;
    interval: UInt16;
    level: sInt16;
    attack_length: UInt16;
    attack_level: UInt16;
    fade_length: UInt16;
    fade_level: UInt16;
  end;

  TSDL_HapticPeriodic = record
    _type: UInt16;
    direction: TSDL_HapticDirection;
    Length: UInt32;
    delay: UInt16;
    button: UInt16;
    interval: UInt16;
    period: UInt16;
    magnitude: sInt16;
    offset: sInt16;
    phase: UInt16;
    attack_length: UInt16;
    attack_level: UInt16;
    fade_length: UInt16;
    fade_level: UInt16;
  end;

  TSDL_HapticCondition = record
    _type: UInt16;
    direction: TSDL_HapticDirection;
    Length: UInt32;
    delay: UInt16;
    button: UInt16;
    interval: UInt16;
    right_sat: array [0 .. 2] of UInt16;
    left_sat: array [0 .. 2] of UInt16;
    right_coeff: array [0 .. 2] of sInt16;
    left_coeff: array [0 .. 2] of sInt16;
    deadband: array [0 .. 2] of UInt16;
    center: array [0 .. 2] of sInt16;
  end;

  TSDL_HapticRamp = record
    _type: UInt16;
    direction: TSDL_HapticDirection;
    Length: UInt32;
    delay: UInt16;
    button: UInt16;
    interval: UInt16;
    start: sInt16;
    _end: sInt16;
    attack_length: UInt16;
    attack_level: UInt16;
    fade_length: UInt16;
    fade_level: UInt16;
  end;

  TSDL_HapticCustom = record
    _type: UInt16;
    direction: TSDL_HapticDirection;
    Length: UInt32;
    delay: UInt16;
    button: UInt16;
    interval: UInt16;
    channels: UInt8;
    period: UInt16;
    samples: UInt16;
    data: PUInt16;
    attack_length: UInt16;
    attack_level: UInt16;
    fade_length: UInt16;
    fade_level: UInt16;
  end;

  PSDL_HapticEffect = ^TSDL_HapticEffect;

  TSDL_HapticEffect = record
    _type: UInt16;
    case UInt16 of
      0:
        (constant: TSDL_HapticConstant;);
      1:
        (periodic: TSDL_HapticPeriodic;);
      2:
        (condition: TSDL_HapticCondition;);
      3:
        (ramp: TSDL_HapticRamp;);
      4:
        (custom: TSDL_HapticCustom;);
  end;

  SDL_HintPriority = (SDL_HINT_DEFAULT, SDL_HINT_NORMAL, SDL_HINT_OVERRIDE);

  TSDL_HintCallback = procedure(userdata: Pointer; const name: PChar; const oldValue: PChar; const newValue: PChar);

  PSDL_Joystick = Pointer;

  TSDL_JoystickGUID = record
    data: array [0 .. 15] of UInt8;
  end;

  TSDL_JoystickID         = SInt32;
  TSDL_JoystickPowerLevel = (SDL_JOYSTICK_POWER_UNKNOWN = -1, SDL_JOYSTICK_POWER_EMPTY, SDL_JOYSTICK_POWER_LOW, SDL_JOYSTICK_POWER_MEDIUM, SDL_JOYSTICK_POWER_FULL, SDL_JOYSTICK_POWER_WIRED, SDL_JOYSTICK_POWER_MAX);

  PKeyStateArr = ^TKeyStateArr;
  TKeyStateArr = array [0 .. 65000] of UInt8;
  PSDL_Keysym  = ^TSDL_KeySym;

  TSDL_KeySym = record
    scancode: TSDL_ScanCode;
    sym: TSDL_KeyCode;
    _mod: UInt16;
    unicode: UInt32;
  end;

  TSDL_LogCategory = (SDL_LOG_CATEGORY_APPLICATION, SDL_LOG_CATEGORY_ERROR, SDL_LOG_CATEGORY_ASSERT, SDL_LOG_CATEGORY_SYSTEM, SDL_LOG_CATEGORY_AUDIO, SDL_LOG_CATEGORY_VIDEO, SDL_LOG_CATEGORY_RENDER, SDL_LOG_CATEGORY_INPUT, SDL_LOG_CATEGORY_TEST, SDL_LOG_CATEGORY_RESERVED1, SDL_LOG_CATEGORY_RESERVED2, SDL_LOG_CATEGORY_RESERVED3, SDL_LOG_CATEGORY_RESERVED4, SDL_LOG_CATEGORY_RESERVED5,
    SDL_LOG_CATEGORY_RESERVED6, SDL_LOG_CATEGORY_RESERVED7, SDL_LOG_CATEGORY_RESERVED8, SDL_LOG_CATEGORY_RESERVED9, SDL_LOG_CATEGORY_RESERVED10, SDL_LOG_CATEGORY_CUSTOM);

  TSDL_LogPriority = Integer;

  TSDL_LogOutputFunction = procedure(userdata: Pointer; category: Integer; priority: TSDL_LogPriority; const msg: PAnsiChar);
  PSDL_LogOutputFunction = ^TSDL_LogOutputFunction;

  TSDL_MessageBoxFlags = Byte;

  TSDL_MessageBoxButtonFlags = Byte;

  PSDL_MessageBoxButtonData = ^TSDL_MessageBoxButtonData;

  TSDL_MessageBoxButtonData = record
    flags: UInt32;
    buttonid: Integer;
    text: PAnsiChar;
  end;

  PSDL_MessageBoxColor = ^TSDL_MessageBoxColor;

  TSDL_MessageBoxColor = record
    r, g, b: UInt8;
  end;

  PSDL_MessageBoxColorType = ^TSDL_MessageBoxColorType;
  TSDL_MessageBoxColorType = (SDL_MESSAGEBOX_COLOR_BACKGROUND, SDL_MESSAGEBOX_COLOR_TEXT, SDL_MESSAGEBOX_COLOR_BUTTON_BORDER, SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND, SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED, SDL_MESSAGEBOX_COLOR_MAX);

  PSDL_MessageBoxColorScheme = ^TSDL_MessageBoxColorScheme;

  TSDL_MessageBoxColorScheme = record
    colors: array [0 .. 4] of TSDL_MessageBoxColor;
  end;

  PSDL_MessageBoxData = ^TSDL_MessageBoxData;

  TSDL_MessageBoxData = record
    flags: UInt32;
    window: PSDL_Window;
    title: PAnsiChar;
    _message: PAnsiChar;
    numbuttons: Integer;
    buttons: PSDL_MessageBoxButtonData;
    colorScheme: PSDL_MessageBoxColorScheme;
  end;

  PSDL_Cursor = Pointer;

  PSDL_SystemCursor = ^TSDL_SystemCursor;
  TSDL_SystemCursor = Word;

  PSDL_Mutex = Pointer;

  PSDL_Sem  = Pointer;
  PSDL_Cond = Pointer;

  PSDL_Color = ^TSDL_Color;

  TSDL_Color = record
    r: UInt8;
    g: UInt8;
    b: UInt8;
    a: UInt8;
  end;

  TSDL_Colour  = TSDL_Color;
  PSDL_Colour  = ^TSDL_Colour;
  PSDL_Palette = ^TSDL_Palette;

  TSDL_Palette = record
    ncolors: SInt32;
    colors: PSDL_Color;
    version: UInt32;
    refcount: SInt32;
  end;

  PSDL_PixelFormat = ^TSDL_PixelFormat;

  TSDL_PixelFormat = record
    format: UInt32;
    palette: PSDL_Palette;
    BitsPerPixel: UInt8;
    BytesPerPixel: UInt8;
    padding: array [0 .. 1] of UInt8;
    Rmask: UInt32;
    Gmask: UInt32;
    Bmask: UInt32;
    Amask: UInt32;
    Rloss: UInt8;
    Gloss: UInt8;
    Bloss: UInt8;
    Aloss: UInt8;
    Rshift: UInt8;
    Gshift: UInt8;
    Bshift: UInt8;
    Ashift: UInt8;
    refcount: SInt32;
    next: PSDL_PixelFormat;
  end;

  PSDL_Point = ^TSDL_Point;

  TSDL_Point = record
    x: SInt32;
    Y: SInt32;
  end;

  PSDL_Rect = ^TSDL_Rect;

  TSDL_Rect = record
    x, Y: SInt32;
    w, h: SInt32;
  end;

  PSDL_RendererFlags = ^TSDL_RendererFlags;
  TSDL_RendererFlags = Word;
  PSDL_RendererInfo  = ^TSDL_RendererInfo;

  TSDL_RendererInfo = record
    name: PAnsiChar;
    flags: UInt32;
    num_texture_formats: UInt32;
    texture_formats: array [0 .. 15] of UInt32;
    max_texture_width: SInt32;
    max_texture_height: SInt32;
  end;

  PSDL_TextureAccess = ^TSDL_TextureAccess;
  TSDL_TextureAccess = SInt32;

  PSDL_TextureModulate = ^TSDL_TextureModulate;
  TSDL_TextureModulate = (SDL_TEXTUREMODULATE_NONE, SDL_TEXTUREMODULATE_COLOR, SDL_TEXTUREMODULATE_ALPHA);

  PPSDL_Renderer = ^PSDL_Renderer;
  PSDL_Renderer  = ^TSDL_Renderer;

  TSDL_Renderer = record
  end;

  PSDL_Texture = ^TSDL_Texture;

  TSDL_Texture = record
  end;

  PSDL_RWops = ^TSDL_RWops;
  TSize      = function(context: PSDL_RWops)                                : SInt64; {$IFNDEF GPC} cdecl; {$ENDIF}
  TSeek      = function(context: PSDL_RWops; offset: SInt64; whence: SInt32): SInt64;
{$IFNDEF GPC} cdecl; {$ENDIF}
  TRead = function(context: PSDL_RWops; ptr: Pointer; size: size_t; maxnum: size_t): size_t;
{$IFNDEF GPC} cdecl; {$ENDIF}
  TWrite = function(context: PSDL_RWops; const ptr: Pointer; size: size_t; num: size_t): size_t;
{$IFNDEF GPC} cdecl; {$ENDIF}
  TClose = function(context: PSDL_RWops): SInt32; {$IFNDEF GPC} cdecl; {$ENDIF}

  TStdio = record
    autoclose: TSDL_Bool;
    fp: file;
  end;

  TMem = record
    base: PuInt8;
    here: PuInt8;
    stop: PuInt8;
  end;

  TUnknown = record
    data1: Pointer;
  end;

  TAndroidIO = record
    fileNameRef: Pointer;
    inputStreamRef: Pointer;
    readableByteChannelRef: Pointer;
    readMethod: Pointer;
    assetFileDescriptorRef: Pointer;
    position: LongInt;
    size: LongInt;
    offset: LongInt;
    fd: SInt32;
  end;

  TWindowsIOBuffer = record
    data: Pointer;
    size: size_t;
    left: size_t;
  end;

  TWindowsIO = record
    append: TSDL_Bool;
    h: Pointer;
    buffer: TWindowsIOBuffer;
  end;

  TSDL_RWops = packed record
    size: TSize;
    seek: TSeek;
    read: TRead;
    write: TWrite;
    close: TClose;
    _type: UInt32;
    case Integer of
      0:
        (stdio: TStdio);
      1:
        (mem: TMem);
      2:
        (unknown: TUnknown);
{$IFDEF ANDROID}
      3:
        (androidio: TAndroidIO);
{$ENDIF}
{$IFDEF WINDOWS}
      3:
        (windowsio: TWindowsIO);
{$ENDIF}
  end;

  TSDL_PowerState = (SDL_POWERSTATE_UNKNOWN, SDL_POWERSTATE_ON_BATTERY, SDL_POWERSTATE_NO_BATTERY, SDL_POWERSTATE_CHARGING, SDL_POWERSTATE_CHARGED);

  PSDL_ScanCode = ^TSDL_ScanCode;
  TSDL_ScanCode = DWord;
  PSDL_KeyCode  = ^TSDL_KeyCode;
  TSDL_KeyCode  = SInt32;

  PSDL_KeyMod = ^TSDL_KeyMod;
  TSDL_KeyMod = Word;

  PPSDL_Window     = ^PSDL_Window;
  PSDL_Window      = ^TSDL_Window;
  TWindowShapeMode = (ShapeModeDefault, ShapeModeBinarizeAlpha, ShapeModeReverseBinarizeAlpha, ShapeModeColorKey);

  TSDL_WindowShapeParams = record
    case Integer of
      0:
        (binarizationCutoff: UInt8;);
      1:
        (colorKey: TSDL_Color;);
  end;

  PSDL_WindowShapeMode = ^TSDL_WindowShapeMode;

  TSDL_WindowShapeMode = record
    mode: TWindowShapeMode;
    parameters: TSDL_WindowShapeParams;
  end;

  PSDL_BlitMap = ^TSDL_BlitMap;

  TSDL_BlitMap = record
    map: Pointer;
  end;

  PSDL_Surface = ^TSDL_Surface;

  TSDL_Surface = record
    flags: UInt32;
    format: PSDL_PixelFormat;
    w, h: SInt32;
    pitch: SInt32;
    pixels: Pointer;
    userdata: Pointer;
    locked: SInt32;
    lock_data: Pointer;
    clip_rect: PSDL_Rect;
    map: Pointer;
    refcount: SInt32;
  end;

  TSDL_Blit               = function(Src: PSDL_Surface; srcrect: PSDL_Rect; dst: PSDL_Surface; dstrect: PSDL_Rect): SInt32;
  TSDL_WindowsMessageHook = Procedure(userdata, hWnd: Pointer; mesage: UInt32; wParam: UInt64; lParam: SInt64); cdecl;
  PIDirect3DDevice9       = Pointer;
  TSDL_WinRT_Path         = (SDL_WINRT_PATH_INSTALLED_LOCATION = 0, SDL_WINRT_PATH_LOCAL_FOLDER = 1, SDL_WINRT_PATH_ROAMING_FOLDER = 2, SDL_WINRT_PATH_TEMP_FOLDER = 3);
  TSDL_SYSWM_TYPE         = (SDL_SYSWM_UNKNOWN, SDL_SYSWM_WINDOWS, SDL_SYSWM_X11, SDL_SYSWM_DIRECTFB, SDL_SYSWM_COCOA, SDL_SYSWM_UIKIT, SDL_SYSWM_WAYLAND, SDL_SYSWM_MIR, SDL_SYSWM_WINRT, SDL_SYSWM_ANDROID, SDL_SYSWM_VIVANTE);
{$IFDEF SDL_VIDEO_DRIVER_WINDOWS}

  __SYSWM_WINDOWS = record
    hWnd: hWnd;
    msg: uInt;
    wParam: wParam;
    lParam: lParam;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_X11}

  __SYSWM_X11 = record
    event: {$IFDEF FPC} TXEvent
{$ELSE} XEvent {$ENDIF};
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_DIRECTFB}

  __SYSWM_DIRECTFB = record
    event: DFBEvent;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_COCOA}

  __SYSWM_COCOA = record
    dummy: Integer;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_UIKIT}

  __SYSWM_UIKIT = record
    dummy: Integer;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_VIVANTE}

  __SYSWM_VIVANTE = record
    dummy: Integer;
  end;
{$ENDIF}

  PSDL_SysWMmsg = ^TSDL_SysWMmsg;

  TSDL_SysWMmsg = record
    version: TSDL_Version;
    subsystem: TSDL_SYSWM_TYPE;
{$IFDEF SDL_VIDEO_DRIVER_WINDOWS}
    win: __SYSWM_WINDOWS;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_X11}
    x11: __SYSWM_X11;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_DIRECTFB}
    dfb: __SYSWM_DIRECTFB;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_COCOA}
    cocoa: __SYSWM_COCOA;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_UIKIT}
    uikit: __SYSWM_UIKIT;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_VIVANTE}
    vivante: __SYSWM_VIVANTE;
{$ELSE}
    dummy: Integer;
{$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF}
  end;
{$IFDEF SDL_VIDEO_DRIVER_WINDOWS}

  __WMINFO_WINDOWS = record
    window: hWnd;
    hdc: hdc;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_WINRT}

  __WMINFO_WINRT = record
    window: IInspectable;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_X11}

  __WMINFO_X11 = record
    display: PDisplay;
    window: TWindow;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_DIRECTFB}

  __WMINFO_DFB = record
    dfb: IDirectFB;
    window: IDirectFBWindow;
    surface: IDirectFBSurface;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_COCOA}

  __WMINFO_COCOA = record
    window: NSWindow;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_UIKIT}

  __WMINFO_UIKIT = record
    window: UIWindow;
    framebuffer: GLuint;
    colorbuffer: GLuint;
    resolveFramebuffer: GLuint;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_WAYLAND}

  __WMINFO_WAYLAND = record
    display: wl_display;
    surface: wl_surface;
    shell_surface: wl_shell_surface;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_MIR}

  __WMINFO_MIR = record
    connection: PMirConnection;
    surface: PMirSurface;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_ANDROID}

  __WMINFO_ANDROID = record
    window: Pointer;
    surface: Pointer;
  end;
{$ENDIF}
{$IFDEF SDL_VIDEO_DRIVER_VIVANTE}

  __WMINFO_VIVANTE = record
    display: EGLNativeDisplayType;
    window: EGLNativeWindowType;
  end;
{$ENDIF}

  PSDL_SysWMinfo = ^TSDL_SysWMinfo;

  TSDL_SysWMinfo = record
    version: TSDL_Version;
    subsystem: TSDL_SYSWM_TYPE;
{$IFDEF SDL_VIDEO_DRIVER_WINDOWS}
    win: __WMINFO_WINDOWS;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_WINRT}
    winrt: __WMINFO_WINRT;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_X11}
    x11: __WMINFO_X11;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_DIRECTFB}
    dfb: __WMINFO_DFB;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_COCOA}
    cocoa: __WMINFO_COCOA;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_UIKIT}
    uikit: __WMINFO_UIKIT;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_WAYLAND}
    wl: __WMINFO_WAYLAND;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_MIR}
    mir: __WMINFO_MIR;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_ANDROID}
    android: __WMINFO_ANDROID;
{$ELSE} {$IFDEF SDL_VIDEO_DRIVER_VIVANTE}
    vivante: __WMINFO_VIVANTE;
{$ELSE}
    dummy: Integer;
{$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF} {$ENDIF}
  end;

  TSDL_ThreadPriority = (SDL_THREAD_PRIORITY_LOW, SDL_THREAD_PRIORITY_NORMAL, SDL_THREAD_PRIORITY_HIGH);
  PSDL_ThreadFunction = ^TSDL_ThreadFunction;
  TSDL_ThreadFunction = function(data: Pointer): Integer; cdecl;
  TSDL_ThreadID       = LongWord;
  PSDL_Thread         = ^TSDL_Thread;

  TSDL_Thread = record
    threadid: TSDL_ThreadID;
    handle: THandle;
    status: SInt32;
    errbuf: TSDL_Error;
    name: PAnsiChar;
    data: Pointer;
  end;

  TSDL_TLSID = Cardinal;
{$IFDEF WINDOWS}
{$DEFINE SDL_PASSED_BEGINTHREAD_ENDTHREAD}
{$IFNDEF DELPHI16UP}
  TThreadID = Cardinal;
{$ENDIF}
  TpfnSDL_CurrentBeginThread = function(SecurityAttributes: Pointer; StackSize: LongWord; ThreadFunc: TThreadFunc; Parameter: Pointer; CreationFlags: LongWord; var threadid: TThreadID): Integer;
  TpfnSDL_CurrentEndThread   = procedure(ExitCode: Integer);

  TSDL_TimerCallback = function(interval: UInt32; param: Pointer): UInt32; cdecl;
  TSDL_TimerID       = SInt32;
  PSDL_TouchID       = ^TSDL_TouchID;
  TSDL_TouchID       = SInt64;
  PSDL_FingerID      = ^TSDL_FingerID;
  TSDL_FingerID      = SInt64;
  PSDL_Finger        = ^TSDL_Finger;

  TSDL_Finger = record
    id: TSDL_FingerID;
    x: Float;
    Y: Float;
    pressure: Float;
  end;

  TSDL_Bool   = (SDL_FALSE, SDL_TRUE);
  DWord       = LongWord;
  PUInt8Array = ^TUInt8Array;
  PuInt8      = ^UInt8;
  PPUInt8     = ^PuInt8;
  UInt8       = Byte;
{$EXTERNALSYM UInt8}
  TUInt8Array = array [0 .. MAXINT shr 1] of UInt8;
  PUInt16     = ^UInt16;
  UInt16      = Word;
{$EXTERNALSYM UInt16}
  PSInt8 = ^SInt8;
  SInt8  = Shortint;
{$EXTERNALSYM SInt8}
  PsInt16 = ^sInt16;
  sInt16  = smallint;
{$EXTERNALSYM SInt16}
  PUInt32 = ^UInt32;
  UInt32  = Cardinal;
{$EXTERNALSYM UInt32}
  PSInt32 = ^SInt32;
  SInt32  = LongInt;
{$EXTERNALSYM SInt32}
  PFloat    = ^Float;
  PInt      = ^LongInt;
  PShortInt = ^Shortint;
{$IFNDEF Has_Int64}
  PUInt64 = ^UInt64;

  UInt64 = record
    hi: UInt32;
    lo: UInt32;
  end;
{$EXTERNALSYM UInt64}

  PInt64 = ^Int64;

  Int64 = record
    hi: UInt32;
    lo: UInt32;
  end;
{$EXTERNALSYM Int64}

  PSInt64 = ^SInt64;
  SInt64  = Int64;
{$EXTERNALSYM SInt64}
{$ELSE}
  PSInt64 = ^SInt64;
  SInt64  = Int64;
{$ENDIF}
{$IFNDEF WIN64}
  size_t = UInt32;
{$ELSE}
  size_t = UInt64;
{$ENDIF}
{$EXTERNALSYM SIZE_T}
  Float = Single;
{$EXTERNALSYM Float}
  PSDL_Version = ^TSDL_Version;

  TSDL_Version = record
    major, minor, patch: UInt8;
  end;

  PSDL_DisplayMode = ^TSDL_DisplayMode;

  TSDL_DisplayMode = record
    format: UInt32;
    w: SInt32;
    h: SInt32;
    refresh_rate: SInt32;
    driverdata: Pointer;
  end;

  PSDL_WindowShaper = ^TSDL_WindowShaper;

  TSDL_WindowShaper = record
    window: PSDL_Window;
    userx, usery: UInt32;
    mode: TSDL_WindowShapeMode;
    hasshape: TSDL_Bool;
    driverdata: Pointer;
  end;

  PSDL_WindowUserData = ^TSDL_WindowUserData;

  TSDL_WindowUserData = record
    name: PAnsiChar;
    data: Pointer;
    next: PSDL_WindowUserData;
  end;

  TSDL_Window = record
    magic: Pointer;
    id: UInt32;
    title: PAnsiChar;
    icon: PSDL_Surface;
    x, Y: SInt32;
    w, h: SInt32;
    min_w, min_h: SInt32;
    max_w, max_h: SInt32;
    flags: UInt32;
    last_fullscreen_flags: UInt32;
    windowed: TSDL_Rect;
    fullscreen_mode: TSDL_DisplayMode;
    brightness: Float;
    gamma: PUInt16;
    saved_gamma: PUInt16;
    surface: PSDL_Surface;
    surface_valid: TSDL_Bool;
    shaper: PSDL_WindowShaper;
    data: PSDL_WindowUserData;
    driverdata: Pointer;
    prev: PSDL_Window;
    next: PSDL_Window;
  end;

  TSDL_WindowFlags = DWord;

  TSDL_WindowEventID = DWord;
  TSDL_GLContext     = Pointer;
  TSDL_GLattr        = DWord;

  TSDL_GLprofile = DWord;

  TSDL_GLcontextFlag = DWord;

  TSDL_GLcontextReleaseFlag = DWord;
  TSDL_HitTestResult        = (SDL_HITTEST_NORMAL, SDL_HITTEST_DRAGGABLE, SDL_HITTEST_RESIZE_TOPLEFT, SDL_HITTEST_RESIZE_TOP, SDL_HITTEST_RESIZE_TOPRIGHT, SDL_HITTEST_RESIZE_RIGHT, SDL_HITTEST_RESIZE_BOTTOMRIGHT, SDL_HITTEST_RESIZE_BOTTOM, SDL_HITTEST_RESIZE_BOTTOMLEFT, SDL_HITTEST_RESIZE_LEFT);
  TSDL_HitTest              = Function(win: PSDL_Window; const area: PSDL_Point; data: Pointer): TSDL_HitTestResult; cdecl;

function Mix_Linked_Version: PSDL_Version cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_Linked_Version' {$ENDIF} {$ENDIF};
{$EXTERNALSYM SDL_INIT_EVERYTHING}
function SDL_Init(flags: UInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_Init' {$ENDIF} {$ENDIF};
function SDL_InitSubSystem(flags: UInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_InitSubSystem' {$ENDIF} {$ENDIF};
procedure SDL_QuitSubSystem(flags: UInt32)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_QuitSubSystem' {$ENDIF} {$ENDIF};
function SDL_WasInit(flags: UInt32): UInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WasInit' {$ENDIF} {$ENDIF};
procedure SDL_Quit()cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_Quit' {$ENDIF} {$ENDIF};
Procedure SDL_initFramerate(manager: PFPSManager); external GFX_LibName
{$IFDEF DELMAC} name '_SDL_initFramerate' {$ENDIF};
Function SDL_setFramerate(manager: PFPSManager; rate: UInt32): SInt32; external GFX_LibName {$IFDEF DELMAC} name '_SDL_setFramerate' {$ENDIF};
Function SDL_getFramerate(manager: PFPSManager): SInt32; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_getFramerate' {$ENDIF};
Function SDL_getFramecount(manager: PFPSManager): SInt32; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_getFramecount' {$ENDIF};
Function SDL_framerateDelay(manager: PFPSManager): UInt32; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_framerateDelay' {$ENDIF};
Function pixelColor(renderer: PSDL_Renderer; x, Y: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_pixelColor'
{$ENDIF};
Function pixelRGBA(renderer: PSDL_Renderer; x, Y: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_pixelRGBA'
{$ENDIF};
Function hlineColor(renderer: PSDL_Renderer; x1, x2, Y: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_hlineColor'
{$ENDIF};
Function hlineRGBA(renderer: PSDL_Renderer; x1, x2, Y: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_hlineRGBA' {$ENDIF};
Function vlineColor(renderer: PSDL_Renderer; x, y1, y2: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_vlineColor'
{$ENDIF};
Function vlineRGBA(renderer: PSDL_Renderer; x, y1, y2: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_vlineRGBA' {$ENDIF};
Function rectangleColor(renderer: PSDL_Renderer; x1, y1, x2, y2: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_rectangleColor' {$ENDIF};
Function rectangleRGBA(renderer: PSDL_Renderer; x1, y1, x2, y2: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_rectangleRGBA' {$ENDIF};
Function roundedRectangleColor(renderer: PSDL_Renderer; x1, y1, x2, y2, rad: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_roundedRectangleColor' {$ENDIF};
Function roundedRectangleRGBA(renderer: PSDL_Renderer; x1, y1, x2, y2, rad: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_roundedRectangleRGBA' {$ENDIF};
Function boxColor(renderer: PSDL_Renderer; x1, y1, x2, y2: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_boxColor' {$ENDIF};
Function boxRGBA(renderer: PSDL_Renderer; x1, y1, x2, y2: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_boxRGBA' {$ENDIF};
Function roundedBoxColor(renderer: PSDL_Renderer; x1, y1, x2, y2, rad: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_roundedBoxColor' {$ENDIF};
Function roundedBoxRGBA(renderer: PSDL_Renderer; x1, y1, x2, y2, rad: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_roundedBoxRGBA' {$ENDIF};
Function lineColor(renderer: PSDL_Renderer; x1, y1, x2, y2: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_lineColor' {$ENDIF};
Function lineRGBA(renderer: PSDL_Renderer; x1, y1, x2, y2: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_lineRGBA' {$ENDIF};
Function aalineColor(renderer: PSDL_Renderer; x1, y1, x2, y2: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_aalineColor' {$ENDIF};
Function aalineRGBA(renderer: PSDL_Renderer; x1, y1, x2, y2: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_aalineRGBA' {$ENDIF};
Function thickLineColor(renderer: PSDL_Renderer; x1, y1, x2, y2: sInt16; width: UInt8; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_thickLineColor' {$ENDIF};
Function thickLineRGBA(renderer: PSDL_Renderer; x1, y1, x2, y2: sInt16; width, r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_thickLineRGBA' {$ENDIF};
Function circleColor(renderer: PSDL_Renderer; x, Y, rad: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_circleColor'
{$ENDIF};
Function circleRGBA(renderer: PSDL_Renderer; x, Y, rad: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_circleRGBA' {$ENDIF};
Function arcColor(renderer: PSDL_Renderer; x, Y, rad, start, finish: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_arcColor' {$ENDIF};
Function arcRGBA(renderer: PSDL_Renderer; x, Y, rad, start, finish: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_arcRGBA' {$ENDIF};
Function aacircleColor(renderer: PSDL_Renderer; x, Y, rad: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_aacircleColor' {$ENDIF};
Function aacircleRGBA(renderer: PSDL_Renderer; x, Y, rad: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_aacircleRGBA' {$ENDIF};
Function filledCircleColor(renderer: PSDL_Renderer; x, Y, rad: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_filledCircleColor' {$ENDIF};
Function filledCircleRGBA(renderer: PSDL_Renderer; x, Y, rad: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_filledCircleRGBA' {$ENDIF};
Function ellipseColor(renderer: PSDL_Renderer; x, Y, rx, ry: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_ellipseColor' {$ENDIF};
Function ellipseRGBA(renderer: PSDL_Renderer; x, Y, rx, ry: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_ellipseRGBA' {$ENDIF};
Function aaellipseColor(renderer: PSDL_Renderer; x, Y, rx, ry: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_aaellipseColor' {$ENDIF};
Function aaellipseRGBA(renderer: PSDL_Renderer; x, Y, rx, ry: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_aaellipseRGBA' {$ENDIF};
Function filledEllipseColor(renderer: PSDL_Renderer; x, Y, rx, ry: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_filledEllipseColor' {$ENDIF};
Function filledEllipseRGBA(renderer: PSDL_Renderer; x, Y, rx, ry: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_filledEllipseRGBA' {$ENDIF};
Function pieColor(renderer: PSDL_Renderer; x, Y, rad, start, finish: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_pieColor' {$ENDIF};
Function pieRGBA(renderer: PSDL_Renderer; x, Y, rad, start, finish: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_pieRGBA' {$ENDIF};
Function filledPieColor(renderer: PSDL_Renderer; x, Y, rad, start, finish: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_filledPieColor' {$ENDIF};
Function filledPieRGBA(renderer: PSDL_Renderer; x, Y, rad, start, finish: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_filledPieRGBA' {$ENDIF};
Function trigonColor(renderer: PSDL_Renderer; x1, y1, x2, y2, x3, y3: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_trigonColor' {$ENDIF};
Function trigonRGBA(renderer: PSDL_Renderer; x1, y1, x2, y2, x3, y3: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_trigonRGBA' {$ENDIF};
Function aatrigonColor(renderer: PSDL_Renderer; x1, y1, x2, y2, x3, y3: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_aatrigonColor' {$ENDIF};
Function aatrigonRGBA(renderer: PSDL_Renderer; x1, y1, x2, y2, x3, y3: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_aatrigonRGBA' {$ENDIF};
Function filledTrigonColor(renderer: PSDL_Renderer; x1, y1, x2, y2, x3, y3: sInt16; colour: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_filledTrigonColor' {$ENDIF};
Function filledTrigonRGBA(renderer: PSDL_Renderer; x1, y1, x2, y2, x3, y3: sInt16; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_filledTrigonRGBA' {$ENDIF};
Function polygonColor(renderer: PSDL_Renderer; Const vx, vy: PsInt16; n: SInt32; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_polygonColor' {$ENDIF};
Function polygonRGBA(renderer: PSDL_Renderer; Const vx, vy: PsInt16; n: SInt32; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_polugonRGBA' {$ENDIF};
Function aapolygonColor(renderer: PSDL_Renderer; Const vx, vy: PsInt16; n: SInt32; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_aapolygonColor' {$ENDIF};
Function aapolygonRGBA(renderer: PSDL_Renderer; Const vx, vy: PsInt16; n: SInt32; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_aapolygonRGBA' {$ENDIF};
Function filledPolygonColor(renderer: PSDL_Renderer; Const vx, vy: PsInt16; n: SInt32; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_filledPolygonColor' {$ENDIF};
Function filledPolygonRGBA(renderer: PSDL_Renderer; Const vx, vy: PsInt16; n: SInt32; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_filledPolygonRGBA' {$ENDIF};
Function texturedPolygon(renderer: PSDL_Renderer; Const vx, vy: PsInt16; n: SInt32; texture: PSDL_Surface; texture_dx, texture_dy: SInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_texturedPolygon' {$ENDIF};
Function bezierColor(renderer: PSDL_Renderer; Const vx, vy: PsInt16; n, S: SInt32; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_bezierColor' {$ENDIF};
Function bezierRGBA(renderer: PSDL_Renderer; Const vx, vy: PsInt16; n, S: SInt32; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_bezierRGBA' {$ENDIF};
Procedure gfxPrimitivesSetFont(Const fontdata: Pointer; cw, ch: UInt32); cdecl; external GFX_LibName {$IFDEF DELMAC} name '_gfxPrimitivesSetFont' {$ENDIF};
Procedure gfxPrimitivesSetFontRotation(rotation: UInt32); cdecl; external GFX_LibName {$IFDEF DELMAC} name '_gfxPrimitivesSetFontRotation'
{$ENDIF};
Function characterColor(renderer: PSDL_Renderer; x, Y: sInt16; c: Char; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_characterColor' {$ENDIF};
Function characterRGBA(renderer: PSDL_Renderer; x, Y: sInt16; c: Char; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_characterRGBA' {$ENDIF};
Function stringColor(renderer: PSDL_Renderer; x, Y: sInt16; Const str: PChar; colour: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_stringColor' {$ENDIF};
Function stringRGBA(renderer: PSDL_Renderer; x, Y: sInt16; Const syt: PChar; r, g, b, a: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_stringRGBA' {$ENDIF};
Function SDL_imageFilterMMXdetect(): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterMMXdetect' {$ENDIF};
Procedure SDL_imageFilterMMXoff(); cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterMMXoff' {$ENDIF};
Procedure SDL_imageFilterMMXon(); cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterMMXon' {$ENDIF};
Function SDL_imageFilterAdd(Src1, Src2, Dest: PuInt8; Length: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_SDL_imageFilterAdd'
{$ENDIF};
Function SDL_imageFilterMean(Src1, Src2, Dest: PuInt8; Length: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_SDL_imageFilterMean'
{$ENDIF};
Function SDL_imageFilterSub(Src1, Src2, Dest: PuInt8; Length: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_SDL_imageFilterSub'
{$ENDIF};
Function SDL_imageFilterAbsDiff(Src1, Src2, Dest: PuInt8; Length: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterAbsDiff' {$ENDIF};
Function SDL_imageFilterMult(Src1, Src2, Dest: PuInt8; Length: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_SDL_imageFilterMult'
{$ENDIF};
Function SDL_imageFilterMultNor(Src1, Src2, Dest: PuInt8; Length: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterMultNor' {$ENDIF};
Function SDL_imageFilterMultDivby2(Src1, Src2, Dest: PuInt8; Length: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterMultDivby2' {$ENDIF};
Function SDL_imageFilterMultDivby4(Src1, Src2, Dest: PuInt8; Length: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterMultDivby4' {$ENDIF};
Function SDL_imageFilterBitAnd(Src1, Src2, Dest: PuInt8; Length: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterBitAnd' {$ENDIF};
Function SDL_imageFilterBitOr(Src1, Src2, Dest: PuInt8; Length: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_SDL_imageFilterBitOr'
{$ENDIF};
Function SDL_imageFilterDiv(Src1, Src2, Dest: PuInt8; Length: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_SDL_imageFilterDiv'
{$ENDIF};
Function SDL_imageFilterBitNegation(Src1, Dest: PuInt8; Length: UInt32): SInt32; cdecl; external GFX_LibName {$IFDEF DELMAC} name '_SDL_imageFilterBitNegation'
{$ENDIF};
Function SDL_imageFilterAddByte(Src1, Dest: PuInt8; Length: UInt32; c: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterAddByte' {$ENDIF};
Function SDL_imageFilterAddUsInt32(Src1, Dest: PuInt8; Length: UInt32; c: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterAddUsInt32' {$ENDIF};
Function SDL_imageFilterAddByteToHalf(Src1, Dest: PuInt8; Length: UInt32; c: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterAddByteToHalf' {$ENDIF};
Function SDL_imageFilterSubByte(Src1, Dest: PuInt8; Length: UInt32; c: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterSubByte' {$ENDIF};
Function SDL_imageFilterSubUsInt32(Src1, Dest: PuInt8; Length: UInt32; c: UInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterSubUsInt32' {$ENDIF};
Function SDL_imageFilterShiftRight(Src1, Dest: PuInt8; Length: UInt32; n: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterShiftRight' {$ENDIF};
Function SDL_imageFilterShiftRightUsInt32(Src1, Dest: PuInt8; Length: UInt32; n: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterShiftRightUsInt32' {$ENDIF};
Function SDL_imageFilterMultByByte(Src1, Dest: PuInt8; Length: UInt32; c: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterMultByByte' {$ENDIF};
Function SDL_imageFilterShiftRightAndMultByByte(Src1, Dest: PuInt8; Length: UInt32; n, c: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterShiftRightAndMultByByte' {$ENDIF};
Function SDL_imageFilterShiftLeftByte(Src1, Dest: PuInt8; Length: UInt32; n: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterShiftLeftByte' {$ENDIF};
Function SDL_imageFilterShiftLeftUsInt32(Src1, Dest: PuInt8; Length: UInt32; n: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterShiftLeftUsInt32' {$ENDIF};
Function SDL_imageFilterShiftLeft(Src1, Dest: PuInt8; Length: UInt32; n: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterShiftLeft' {$ENDIF};
Function SDL_imageFilterBinarizeUsingThreshold(Src1, Dest: PuInt8; Length: UInt32; T: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterBinarizeUsingThreshold' {$ENDIF};
Function SDL_imageFilterClipToRange(Src1, Dest: PuInt8; Length: UInt32; Tmin, Tmax: UInt8): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterClipToRange' {$ENDIF};
Function SDL_imageFilterNormalizeLinear(Src, Dest: PuInt8; Length, Cmin, Cmax, Nmin, Nmax: SInt32): SInt32; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_SDL_imageFilterNormalizeLinear' {$ENDIF};
Function rotozoomSurface(Src: PSDL_Surface; angle, zoom: Double; smooth: SInt32): PSDL_Surface; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_rotozoomSurface' {$ENDIF};
Function rotozoomSurfaceXY(Src: PSDL_Surface; angle, zoomx, zoomy: Double; smooth: SInt32): PSDL_Surface; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_rotozoomSurfaceXY' {$ENDIF};
Procedure rotozoomSurfaceSize(width, height: SInt32; angle, zoom: Double; dstwidth, dstheight: PUInt32); cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_rotozoomSurfaceSize' {$ENDIF};
Procedure rotozoomSurfaceSizeXY(width, height: SInt32; angle, zoomx, zoomy: Double; dstwidth, dstheight: PUInt32); cdecl; external GFX_LibName {$IFDEF DELMAC} name '_rotozoomSurfaceSizeXY' {$ENDIF};
Function zoomSurface(Src: PSDL_Surface; zoomx, zoomy: Double; smooth: SInt32): PSDL_Surface; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_zoomSurface' {$ENDIF};
Procedure zoomSurfaceSize(width, height: SInt32; zoomx, zoomy: Double; dstwidth, dstheight: PUInt32); cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_zoomSurfaceSize' {$ENDIF};
Function shrinkSurface(Src: PSDL_Surface; factorx, factory: SInt32): PSDL_Surface; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_shrinkSurface' {$ENDIF};
Function rotateSurface90Degrees(Src: PSDL_Surface; numClockwiseTurns: SInt32): PSDL_Surface; cdecl; external GFX_LibName
{$IFDEF DELMAC} name '_rotateSurface90Degrees' {$ENDIF};
procedure SDL_IMAGE_VERSION(Out x: TSDL_Version);
function IMG_Linked_Version: PSDL_Version cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_Linked_Version' {$ENDIF} {$ENDIF};
function IMG_Init(flags: SInt32): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_Init' {$ENDIF} {$ENDIF};
procedure IMG_Quit()cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_Quit' {$ENDIF} {$ENDIF};
function IMG_LoadTyped_RW(Src: PSDL_RWops; freesrc: SInt32; _type: PAnsiChar): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadTyped_RW' {$ENDIF} {$ENDIF};
function IMG_Load(_file: PAnsiChar): PSDL_Surface cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_Load' {$ENDIF} {$ENDIF};
function IMG_Load_RW(Src: PSDL_RWops; freesrc: SInt32): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_Load_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadTexture(renderer: PSDL_Renderer; _file: PAnsiChar): PSDL_Texture cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadTexture' {$ENDIF} {$ENDIF};
function IMG_LoadTexture_RW(renderer: PSDL_Renderer; Src: PSDL_RWops; freesrc: SInt32): PSDL_Texture cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadTexture_RW' {$ENDIF} {$ENDIF};
function IMG_LoadTextureTyped_RW(renderer: PSDL_Renderer; Src: PSDL_RWops; freesrc: SInt32; _type: PAnsiChar): PSDL_Texture cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadTextureTyped_RW' {$ENDIF} {$ENDIF};
function IMG_isICO(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isICO' {$ENDIF} {$ENDIF};
function IMG_isCUR(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isCUR' {$ENDIF} {$ENDIF};
function IMG_isBMP(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isBMP' {$ENDIF} {$ENDIF};
function IMG_isGIF(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isGIF' {$ENDIF} {$ENDIF};
function IMG_isJPG(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isJPG' {$ENDIF} {$ENDIF};
function IMG_isLBM(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isLBM' {$ENDIF} {$ENDIF};
function IMG_isPCX(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isPCX' {$ENDIF} {$ENDIF};
function IMG_isPNG(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isPNG' {$ENDIF} {$ENDIF};
function IMG_isPNM(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isPNM' {$ENDIF} {$ENDIF};
function IMG_isTIF(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isTIF' {$ENDIF} {$ENDIF};
function IMG_isXCF(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '-IMG_isXCF' {$ENDIF} {$ENDIF};
function IMG_isXPM(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isXPM' {$ENDIF} {$ENDIF};
function IMG_isXV(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isXV' {$ENDIF} {$ENDIF};
function IMG_isWEBP(Src: PSDL_RWops): SInt32 cdecl; external IMG_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_isWEBP' {$ENDIF} {$ENDIF};
function IMG_LoadICO_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadICO_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadCUR_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadCUR_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadBMP_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadBMP_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadGIF_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadGIF_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadJPG_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadJPG_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadLBM_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadLBM_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadPCX_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadPCX_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadPNG_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadPNG_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadPNM_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadPNM_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadTGA_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadTGA_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadTIF_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadTIF_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadXCF_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadXCF_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadXPM_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadXMP_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadXV_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadXV_RW'
{$ENDIF} {$ENDIF};
function IMG_LoadWEBP_RW(Src: PSDL_RWops): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_LoadWEBP_RW'
{$ENDIF} {$ENDIF};
function IMG_ReadXPMFromArray(xpm: PPChar): PSDL_Surface cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_ReadXPMFromArray' {$ENDIF} {$ENDIF};
function IMG_SavePNG(surface: PSDL_Surface; const _file: PAnsiChar): SInt32 cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_SavePNG' {$ENDIF} {$ENDIF};
function IMG_SavePNG_RW(surface: PSDL_Surface; dst: PSDL_RWops; freedst: SInt32): SInt32 cdecl; external IMG_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_IMG_SavePNG_RW' {$ENDIF} {$ENDIF};
function Mix_Init(flags: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_Init' {$ENDIF} {$ENDIF};
procedure Mix_Quit()cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_Quit' {$ENDIF} {$ENDIF};
function Mix_OpenAudio(frequency: Integer; format: UInt16; channels: Integer; chunksize: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_OpenAudio' {$ENDIF} {$ENDIF};
function Mix_AllocateChannels(numchans: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_AllocateChannels' {$ENDIF} {$ENDIF};
function Mix_QuerySpec(frequency: PInt; format: PUInt16; channels: Pnt): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_QuerySpec' {$ENDIF} {$ENDIF};
function Mix_LoadWAV_RW(Src: PSDL_RWops; freesrc: Integer): PMix_Chunk cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_LoadWAV_RW'
{$ENDIF} {$ENDIF};
function Mix_LoadMUS(_file: PAnsiChar): PMix_Music cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_LoadMUS' {$ENDIF} {$ENDIF};
function Mix_LoadMUS_RW(Src: PSDL_RWops; freesrc: Integer): PMix_Music cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_LoadMUS_RW'
{$ENDIF} {$ENDIF};
function Mix_LoadMUSType_RW(Src: PSDL_RWops; _type: TMix_MusicType; freesrc: Integer): PMix_Music cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_LoadMUSType_RW' {$ENDIF} {$ENDIF};
function Mix_QuickLoad_WAV(mem: PuInt8): PMix_Chunk cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_QuickLoad_WAV' {$ENDIF} {$ENDIF};
function Mix_QuickLoad_RAW(mem: PuInt8; len: UInt32): PMix_Chunk cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_QuickLoad_RAW'
{$ENDIF} {$ENDIF};
procedure Mix_FreeChunk(chunk: PMix_Chunk)cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_FreeChunk' {$ENDIF} {$ENDIF};
procedure Mix_FreeMusic(music: PMix_Music)cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_FreeMusic' {$ENDIF} {$ENDIF};
function Mix_GetNumChunkDecoders: Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GetNumChunkDecoders' {$ENDIF} {$ENDIF};
function Mix_GetChunkDecoder(index: Integer): PAnsiChar cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GetChunkDecoder' {$ENDIF} {$ENDIF};
function Mix_GetNumMusicDecoders: Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GetNumMusicDecoders' {$ENDIF} {$ENDIF};
function Mix_GetMusicDecoder(index: Integer): PAnsiChar cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GetMusicDecoder' {$ENDIF} {$ENDIF};
function Mix_GetMusicType(music: TMix_Music): TMix_MusicType cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GetMusicType'
{$ENDIF} {$ENDIF};
procedure Mix_SetPostMix(func: TMix_Func; arg: Pointer)cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_SetPostMix'
{$ENDIF} {$ENDIF};
procedure Mix_HookMusic(func: TMix_Func; arg: Pointer)cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_HookMusic'
{$ENDIF} {$ENDIF};
procedure Mix_HookMusicFinished(music_finished: PMix_Music_Finished)cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_HookMusicFinished' {$ENDIF} {$ENDIF};
function Mix_GetMusicHookData: Pointer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GetMusicHookData' {$ENDIF} {$ENDIF};
procedure Mix_ChannelFinished(channel_finished: TMix_Channel_Finished)cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_ChannelFinished' {$ENDIF} {$ENDIF};
function Mix_RegisterEffect(chan: Integer; f: TMix_EffectFunc_t; d: TMix_EffectDone_t; arg: Pointer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_RegisterEffect' {$ENDIF} {$ENDIF};
function Mix_UnregisterEffect(channel: Integer; f: TMix_EffectFunc_t): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_UnregisterEffect' {$ENDIF} {$ENDIF};
function Mix_UnregisterAllEffects(channel: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_UnregisterEffects' {$ENDIF} {$ENDIF};
function Mix_SetPanning(channel: Integer; left: UInt8; right: UInt8): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_SetPanning' {$ENDIF} {$ENDIF};
function Mix_SetPosition(channel: Integer; angle: sInt16; distance: UInt8): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_SetPosition' {$ENDIF} {$ENDIF};
function Mix_SetDistance(channel: Integer; distance: UInt8): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_SetDistance'
{$ENDIF} {$ENDIF};
function Mix_SetReverseStereo(channel: Integer; flip: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_SetReverseStereo' {$ENDIF} {$ENDIF};
function Mix_ReserveChannels(num: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_ReverseChannels' {$ENDIF} {$ENDIF};
function Mix_GroupChannel(which: Integer; tag: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GroupChannel'
{$ENDIF} {$ENDIF};
function Mix_GroupChannels(from: Integer; _to: Integer; tag: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GroupChannels' {$ENDIF} {$ENDIF};
function Mix_GroupAvailable(tag: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GroupAvailable' {$ENDIF} {$ENDIF};
function Mix_GroupCount(tag: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GroupCount' {$ENDIF} {$ENDIF};
function Mix_GroupOldest(tag: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GroupOldest' {$ENDIF} {$ENDIF};
function Mix_GroupNewer(tag: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GroupNewer' {$ENDIF} {$ENDIF};
function Mix_PlayChannel(channel: Integer; chunk: PMix_Chunk; loops: Integer): Integer;
function Mix_PlayChannelTimed(channel: Integer; chunk: PMix_Chunk; loops: Integer; ticks: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_PlayChannelTimed' {$ENDIF} {$ENDIF};
function Mix_PlayMusic(music: PMix_Music; loops: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_PlayMusic'
{$ENDIF} {$ENDIF};
function Mix_FadeInMusic(music: PMix_Music; loops: Integer; ms: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_FadeInMusic' {$ENDIF} {$ENDIF};
function Mix_FadeInMusicPos(music: PMix_Music; loops: Integer; ms: Integer; position: Double): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_FadeInMusicPos' {$ENDIF} {$ENDIF};
function Mix_FadeInChannel(channel: Integer; chunk: PMix_Chunk; loops: Integer; ms: Integer): Integer;
function Mix_FadeInChannelTimed(channel: Integer; chunk: PMix_Chunk; loops: Integer; ms: Integer; ticks: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_FadeInChannelTimed' {$ENDIF} {$ENDIF};
function Mix_Volume(channel: Integer; volume: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_Volume'
{$ENDIF} {$ENDIF};
function Mix_VolumeChunk(chunk: PMix_Chunk; volume: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_VolumeChunk'
{$ENDIF} {$ENDIF};
function Mix_VolumeMusic(volume: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_VolumeMusic' {$ENDIF} {$ENDIF};
function Mix_HaltChannel(channel: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_HaltChannel' {$ENDIF} {$ENDIF};
function Mix_HaltGroup(tag: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_HaltGroup' {$ENDIF} {$ENDIF};
function Mix_HaltMusic: Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_HaltMusic' {$ENDIF} {$ENDIF};
function Mix_ExpireChannel(channel: Integer; ticks: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_ExpireChannel'
{$ENDIF} {$ENDIF};
function Mix_FadeOutChannel(which: Integer; ms: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_FadeOutChannel'
{$ENDIF} {$ENDIF};
function Mix_FadeOutGroup(tag: Integer; ms: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_FadeOutGroup'
{$ENDIF} {$ENDIF};
function Mix_FadeOutMusic(ms: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_FadeOutMusic' {$ENDIF} {$ENDIF};
function Mix_FadingMusic: TMix_Fading cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_FadingMusic' {$ENDIF} {$ENDIF};
function Mix_FadingChannel(which: Integer): TMix_Fading cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_FadingChannel'
{$ENDIF} {$ENDIF};
procedure Mix_Pause(channel: Integer)cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_Pause' {$ENDIF} {$ENDIF};
procedure Mix_Resume(channel: Integer)cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_Resume' {$ENDIF} {$ENDIF};
function Mix_Paused(channel: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_Paused' {$ENDIF} {$ENDIF};
procedure Mix_PauseMusic cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_PauseMusic' {$ENDIF} {$ENDIF};
procedure Mix_ResumeMusic cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_ResumeMusic' {$ENDIF} {$ENDIF};
procedure Mix_RewindMusic cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_RewindMusic' {$ENDIF} {$ENDIF};
function Mix_PausedMusic: Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_PausedMusic' {$ENDIF} {$ENDIF};
function Mix_SetMusicPosition(position: Double): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_SetMusicPosition' {$ENDIF} {$ENDIF};
function Mix_Playing(channel: Integer): Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_Playing' {$ENDIF} {$ENDIF};
function Mix_PlayingMusic: Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_PlayingMusic' {$ENDIF} {$ENDIF};
function Mix_SetMusicCMD(command: PAnsiChar): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_SetMusicCMD'
{$ENDIF} {$ENDIF};
function Mix_SetSynchroValue(value: Integer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_SetSynchroValue' {$ENDIF} {$ENDIF};
function Mix_GetSynchroValue: Integer cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GetSynchroValue' {$ENDIF} {$ENDIF};
function Mix_SetSoundFonts(paths: PAnsiChar): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_SetSoundFonts'
{$ENDIF} {$ENDIF};
function Mix_GetSoundFonts: PAnsiChar cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GetSoundFonts' {$ENDIF} {$ENDIF};
function Mix_EachSoundFont(func: TMix_SoundFunc; data: Pointer): Integer cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_EachSoundFont'
{$ENDIF} {$ENDIF};
function Mix_GetChunk(channel: Integer): PMix_Chunk cdecl; external MIX_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_GetChunk' {$ENDIF} {$ENDIF};
procedure Mix_CloseAudio cdecl; external MIX_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_MIX_CloseAudio' {$ENDIF} {$ENDIF};
procedure SDLNet_Linked_Version()cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_Linked_Version' {$ENDIF} {$ENDIF};
function SDLNet_Init(): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_Init' {$ENDIF} {$ENDIF};
procedure SDLNet_Quit()cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_Quit' {$ENDIF} {$ENDIF};
function SDLNet_ResolveHost(address: PIPaddress; const host: PAnsiChar; port: UInt16): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_ResolveHost' {$ENDIF} {$ENDIF};
function SDLNet_ResolveIP(const ip: PIPaddress): PAnsiChar cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_ResolveIP' {$ENDIF} {$ENDIF};
function SDLNet_GetLocalAddresses(addresses: PIPaddress; maxcount: Integer): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_GetLocalAddresses' {$ENDIF} {$ENDIF};
function SDLNet_TCP_Open(ip: PIPaddress): TTCPSocket cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_TCP_Open'
{$ENDIF} {$ENDIF};
function SDLNet_TCP_Accept(server: TTCPSocket): TTCPSocket cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_TCP_Accept' {$ENDIF} {$ENDIF};
function SDLNet_TCP_GetPeerAddress(sock: TTCPSocket): PIPaddress cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_TCP_GetPeerAddress' {$ENDIF} {$ENDIF};
function SDLNet_TCP_Send(sock: TTCPSocket; const data: Pointer; len: Integer): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_TCP_Send' {$ENDIF} {$ENDIF};
function SDLNet_TCP_Recv(sock: TTCPSocket; data: Pointer; maxlen: Integer): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_TCP_Recv' {$ENDIF} {$ENDIF};
procedure SDLNet_TCP_Close(sock: TTCPSocket)cdecl; external SDLNet_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_TCP_Close' {$ENDIF} {$ENDIF};
function SDLNet_AllocPacket(size: Integer): PUDPPacket cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_AllocPacket' {$ENDIF} {$ENDIF};
function SDLNet_ResizePacket(packet: PUDPPacket; newsize: Integer): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_ResizePacket' {$ENDIF} {$ENDIF};
procedure SDLNet_FreePacket(packet: PUDPPacket)cdecl; external SDLNet_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_FreePacket' {$ENDIF} {$ENDIF};
function SDLNet_AllocPacketV(howmany: Integer; size: Integer): PPUDPPacket cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_AllocPacketV' {$ENDIF} {$ENDIF};
procedure SDLNet_FreePacketV(packetV: PPUDPPacket)cdecl; external SDLNet_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_FreePacketV' {$ENDIF} {$ENDIF};
function SDLNet_UDP_Open(port: UInt16): TUDPSocket cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_UDP_Open'
{$ENDIF} {$ENDIF};
procedure SDLNet_UDP_SetPacketLoss(sock: TUDPSocket; percent: Integer)cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_UDP_SetPacketLoss' {$ENDIF} {$ENDIF};
function SDLNet_UDP_Bind(sock: TUDPSocket; channel: Integer; const address: PIPaddress): Integer cdecl; external SDLNet_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_UDP_Bind' {$ENDIF} {$ENDIF};
procedure SDLNet_UDP_Unbind(sock: TUDPSocket; channel: Integer)cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_UDP_Unbind' {$ENDIF} {$ENDIF};
function SDLNet_UDP_GetPeerAddress(sock: TUDPSocket; channel: Integer): PIPaddress cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_UDP_GetPeerAddress' {$ENDIF} {$ENDIF};
function SDLNet_UDP_SendV(sock: TUDPSocket; packets: PPUDPPacket; npackets: Integer): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_UDP_SendV' {$ENDIF} {$ENDIF};
function SDLNet_UDP_Send(sock: TUDPSocket; channel: Integer; packet: PUDPPacket): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_UDP_Send' {$ENDIF} {$ENDIF};
function SDLNet_UDP_RecvV(sock: TUDPSocket; packets: PPUDPPacket): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_UDP_RecvV' {$ENDIF} {$ENDIF};
function SDLNet_UDP_Recv(sock: TUDPSocket; packet: PUDPPacket): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_UDP_Recv'
{$ENDIF} {$ENDIF};
procedure SDLNet_UDP_Close(sock: TUDPSocket)cdecl; external SDLNet_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_UDP_Close' {$ENDIF} {$ENDIF};
function SDLNet_AllocSocketSet(maxsockets: Integer): TSDLNet_GenericSocket cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_AllocSocketSet' {$ENDIF} {$ENDIF};
function SDLNet_AddSocket(set_: TSDLNet_SocketSet; sock: TSDLNet_GenericSocket): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_AddSocket' {$ENDIF} {$ENDIF};
function SDLNet_DelSocket(set_: TSDLNet_SocketSet; sock: TSDLNet_GenericSocket): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_DelSocket' {$ENDIF} {$ENDIF};
function SDLNet_CheckSockets(set_: TSDLNet_SocketSet; timeout: UInt32): Integer cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_CheckSockets' {$ENDIF} {$ENDIF};
function SDLNet_SocketReady(sock: TSDLNet_GenericSocket): Integer;
{$IFNDEF DELPHI} inline; {$ELSE} {$IFDEF DELPHI10UP} inline; {$ENDIF} {$ENDIF}
procedure SDLNet_FreeSocketSet(set_: TSDLNet_SocketSet)cdecl; external SDLNet_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDLNet_FreeSocketSet' {$ENDIF} {$ENDIF};
function TTF_Linked_Version: TSDL_Version cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_Linked_Version' {$ENDIF} {$ENDIF};
procedure TTF_ByteSwappedUNICODE(swapped: Integer)cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_ByteSwappedUNICODE' {$ENDIF} {$ENDIF};
function TTF_Init(): Integer cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_Init' {$ENDIF} {$ENDIF};
function TTF_OpenFont(_file: PAnsiChar; ptsize: Integer): PTTF_Font cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_OpenFont'
{$ENDIF} {$ENDIF};
function TTF_OpenFontIndex(_file: PAnsiChar; ptsize: Integer; index: LongInt): PTTF_Font cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_OpenFontIndex' {$ENDIF} {$ENDIF};
function TTF_OpenFontRW(Src: PSDL_RWops; freesrc: Integer; ptsize: LongInt): PTTF_Font cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_OpenFontRW' {$ENDIF} {$ENDIF};
function TTF_OpenFontIndexRW(Src: PSDL_RWops; freesrc: Integer; ptsize: Integer; index: LongInt): PTTF_Font cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_OpenFontIndexRW' {$ENDIF} {$ENDIF};
function TTF_GetFontStyle(font: PTTF_Font): Integer cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_GetFontStyle' {$ENDIF} {$ENDIF};
procedure TTF_SetFontStyle(font: PTTF_Font; style: Integer)cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_SetFontStyle'
{$ENDIF} {$ENDIF};
function TTF_GetFontOutline(font: PTTF_Font): Integer cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_GetFontOutline'
{$ENDIF} {$ENDIF};
procedure TTF_SetFontOutline(font: PTTF_Font; outline: Integer)cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_SetFontOutline'
{$ENDIF} {$ENDIF};
function TTF_GetFontHinting(font: PTTF_Font): Integer cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_GetFontHinting'
{$ENDIF} {$ENDIF};
procedure TTF_SetFontHinting(font: PTTF_Font; hinting: Integer)cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_SetFontHinting'
{$ENDIF} {$ENDIF};
function TTF_FontHeight(font: PTTF_Font): Integer cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_FontHeight' {$ENDIF} {$ENDIF};
function TTF_FontAscent(font: PTTF_Font): Integer cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_FontAscent' {$ENDIF} {$ENDIF};
function TTF_FontDescent(font: PTTF_Font): Integer cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_FontDescent' {$ENDIF} {$ENDIF};
function TTF_FontLineSkip(font: PTTF_Font): Integer cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_FontLineSkip' {$ENDIF} {$ENDIF};
function TTF_GetFontKerning(font: PTTF_Font): Integer cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_GetFontKerning'
{$ENDIF} {$ENDIF};
procedure TTF_SetFontKerning(font: PTTF_Font; allowed: Integer)cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_SetFontKerning'
{$ENDIF} {$ENDIF};
function TTF_FontFaces(font: PTTF_Font): LongInt cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_FontFaces' {$ENDIF} {$ENDIF};
function TTF_FontFaceIsFixedWidth(font: PTTF_Font): Integer cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_FontFaceIsFixedWidth' {$ENDIF} {$ENDIF};
function TTF_FontFaceFamilyName(font: PTTF_Font): PAnsiChar cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_FontFaceFamilyName' {$ENDIF} {$ENDIF};
function TTF_FontFaceStyleName(font: PTTF_Font): PAnsiChar cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_FontFaceStyleName' {$ENDIF} {$ENDIF};
function TTF_GlyphIsProvided(font: PTTF_Font; ch: UInt16): Integer cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_GlyphIsProvided' {$ENDIF} {$ENDIF};
function TTF_GlyphMetrics(font: PTTF_Font; ch: UInt16; minx, maxx: PInt; miny, maxy: PInt; advance: PInt): Integer cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_GlyphMetrics' {$ENDIF} {$ENDIF};
function TTF_SizeText(font: PTTF_Font; text: PAnsiChar; w, h: PInt): Integer cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_SizeText' {$ENDIF} {$ENDIF};
function TTF_SizeUTF8(font: PTTF_Font; text: PAnsiChar; w, h: PInt): Integer cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_SizeUTF8' {$ENDIF} {$ENDIF};
function TTF_SizeUNICODE(font: PTTF_Font; text: PUInt16; w, h: PInt): Integer cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_SizeUNICODE' {$ENDIF} {$ENDIF};
function TTF_RenderText_Solid(font: PTTF_Font; text: PAnsiChar; fg: TSDL_Color): PSDL_Surface cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderText_Solid' {$ENDIF} {$ENDIF};
function TTF_RenderUTF8_Solid(font: PTTF_Font; text: PAnsiChar; fg: TSDL_Color): PSDL_Surface cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderUTF8_Solid' {$ENDIF} {$ENDIF};
function TTF_RenderUNICODE_Solid(font: PTTF_Font; text: PUInt16; fg: TSDL_Color): PSDL_Surface cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderUNICODE_Solid' {$ENDIF} {$ENDIF};
function TTF_RenderGlyph_Solid(font: PTTF_Font; ch: UInt16; fg: TSDL_Color): PSDL_Surface cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderGlyph_Solid' {$ENDIF} {$ENDIF};
function TTF_RenderText_Shaded(font: PTTF_Font; text: PAnsiChar; fg, bg: TSDL_Color): PSDL_Surface cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderText_Shaded' {$ENDIF} {$ENDIF};
function TTF_RenderUTF8_Shaded(font: PTTF_Font; text: PAnsiChar; fg, bg: TSDL_Color): PSDL_Surface cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderUTF8_Shaded' {$ENDIF} {$ENDIF};
function TTF_RenderUNICODE_Shaded(font: PTTF_Font; text: PUInt16; fg, bg: TSDL_Color): PSDL_Surface cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderUNICODE_Shaded' {$ENDIF} {$ENDIF};
function TTF_RenderGlyph_Shaded(font: PTTF_Font; ch: UInt16; fg, bg: TSDL_Color): PSDL_Surface cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderGlyph_Shaded' {$ENDIF} {$ENDIF};
function TTF_RenderText_Blended(font: PTTF_Font; text: PAnsiChar; fg: TSDL_Color): PSDL_Surface cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderText_Blended' {$ENDIF} {$ENDIF};
function TTF_RenderUTF8_Blended(font: PTTF_Font; text: PAnsiChar; fg: TSDL_Color): PSDL_Surface cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderUTF8_Blended' {$ENDIF} {$ENDIF};
function TTF_RenderUNICODE_Blended(font: PTTF_Font; text: UInt16; fg: TSDL_Color): PSDL_Surface cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderUNICODE_Blended' {$ENDIF} {$ENDIF};
function TTF_RenderText_Blended_Wrapped(font: PTTF_Font; text: PAnsiChar; fg: TSDL_Color; wrapLength: UInt32): PSDL_Surface cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderText_Blended_Wrapped' {$ENDIF} {$ENDIF};
function TTF_RenderUTF8_Blended_Wrapped(font: PTTF_Font; text: PAnsiChar; fg: TSDL_Color; wrapLength: UInt32): PSDL_Surface cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderUTF8_Blended_Wrapped' {$ENDIF} {$ENDIF};
function TTF_RenderUNICODE_Blended_Wrapped(font: PTTF_Font; text: PUInt16; fg: TSDL_Color; wrapLength: UInt32): PSDL_Surface cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderUNICODE_Blended_Wrapped'
{$ENDIF} {$ENDIF};
function TTF_RenderGlyph_Blended(font: PTTF_Font; ch: UInt16; fg: TSDL_Color): PSDL_Surface cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_RenderGlyph_Blended' {$ENDIF} {$ENDIF};
procedure TTF_CloseFont(font: PTTF_Font)cdecl; external TTF_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_CloseFont' {$ENDIF} {$ENDIF};
procedure TTF_Quit()cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_Quit' {$ENDIF} {$ENDIF};
function TTF_WasInit: Boolean cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_WasInit' {$ENDIF} {$ENDIF};
function TTF_GetFontKerningSize(font: PTTF_Font; prev_index, index: Integer): Integer cdecl; external TTF_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_TTF_GetFontKerningSize' {$ENDIF} {$ENDIF};
function SDL_GetNumAudioDrivers: Integer cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetNumAudioDrivers'
{$ENDIF} {$ENDIF};
function SDL_GetAudioDriver(index: Integer): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetAudioDriver' {$ENDIF} {$ENDIF};
function SDL_AudioInit(driver_name: PAnsiChar): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_AudioInit' {$ENDIF} {$ENDIF};
procedure SDL_AudioQuit cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_AudioQuit' {$ENDIF} {$ENDIF};
function SDL_GetCurrentAudioDriver: PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetCurrentAudioDriver' {$ENDIF} {$ENDIF};
function SDL_OpenAudio(desired: PSDL_AudioSpec; obtained: PSDL_AudioSpec): Integer cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_OpenAudio' {$ENDIF} {$ENDIF};
function SDL_GetNumAudioDevices(iscapture: Integer): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetNumAudioDevices' {$ENDIF} {$ENDIF};
function SDL_GetAudioDeviceName(index: Integer; iscapture: Integer): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetAudioDeviceName' {$ENDIF} {$ENDIF};
function SDL_OpenAudioDevice(device: PAnsiChar; iscapture: Integer; desired: PSDL_AudioSpec; obtained: PSDL_AudioSpec; allowed_changes: Integer): TSDL_AudioDeviceID cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_OpenAudioDevice' {$ENDIF} {$ENDIF};
function SDL_GetAudioStatus: TSDL_AudioStatus cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetAudioStatus' {$ENDIF} {$ENDIF};
function SDL_GetAudioDeviceStatus(dev: TSDL_AudioDeviceID): TSDL_AudioStatus cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetAudioDeviceStatus' {$ENDIF} {$ENDIF};
procedure SDL_PauseAudio(pause_on: Integer)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_PauseAudio' {$ENDIF} {$ENDIF};
procedure SDL_PauseAudioDevice(dev: TSDL_AudioDeviceID; pause_on: Integer)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_PauseAudioDevice' {$ENDIF} {$ENDIF};
function SDL_LoadWAV_RW(Src: PSDL_RWops; freesrc: Integer; spec: PSDL_AudioSpec; audio_buf: PPUInt8; audio_len: PUInt32): PSDL_AudioSpec cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LoadWAV_RW' {$ENDIF} {$ENDIF};
function SDL_LoadWAV(_file: PAnsiChar; spec: PSDL_AudioSpec; audio_buf: PPUInt8; audio_len: PUInt32): PSDL_AudioSpec;
procedure SDL_FreeWAV(audio_buf: PuInt8)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_FreeWAV' {$ENDIF} {$ENDIF};
function SDL_BuildAudioCVT(cvt: PSDL_AudioCVT; src_format: TSDL_AudioFormat; src_channels: UInt8; src_rate: Integer; dst_format: TSDL_AudioFormat; dst_channels: UInt8; dst_rate: Integer): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_BuildAudioCVT' {$ENDIF} {$ENDIF};
function SDL_ConvertAudio(cvt: PSDL_AudioCVT): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ConvertAudio' {$ENDIF} {$ENDIF};
procedure SDL_MixAudio(dst: PuInt8; Src: PuInt8; len: UInt32; volume: Integer)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_MixAudio' {$ENDIF} {$ENDIF};
procedure SDL_MixAudioFormat(dst: PuInt8; Src: PuInt8; format: TSDL_AudioFormat; len: UInt32; volume: Integer)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_MixAudioFormat' {$ENDIF} {$ENDIF};
function SDL_QueueAudio(dev: TSDL_AudioDeviceID; data: Pointer; len: UInt32): SInt32; cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_QueueAudio' {$ENDIF} {$ENDIF};
function SDL_DequeueAudio(dev: TSDL_AudioDeviceID; data: Pointer; len: UInt32): UInt32; cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_DequeueAudio' {$ENDIF} {$ENDIF};
function SDL_GetQueuedAudioSize(dev: TSDL_AudioDeviceID): UInt32; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetQueuedAudioSize' {$ENDIF} {$ENDIF};
procedure SDL_ClearQueuedAudio(dev: TSDL_AudioDeviceID); cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ClearQueuedAudio' {$ENDIF} {$ENDIF};
procedure SDL_LockAudio cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LockAudio' {$ENDIF} {$ENDIF};
procedure SDL_LockAudioDevice(dev: TSDL_AudioDeviceID)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LockAudioDevice' {$ENDIF} {$ENDIF};
procedure SDL_UnlockAudio cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_Unlock' {$ENDIF} {$ENDIF};
procedure SDL_UnlockAudioDevice(dev: TSDL_AudioDeviceID)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_UnlockAudioDevice' {$ENDIF} {$ENDIF};
procedure SDL_CloseAudio cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CloseAudio' {$ENDIF} {$ENDIF};
procedure SDL_CloseAudioDevice(dev: TSDL_AudioDeviceID)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CloseAudioDevice' {$ENDIF} {$ENDIF};
function SDL_AudioDeviceConnected(dev: TSDL_AudioDeviceID): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_AudioDeviceConnected' {$ENDIF} {$ENDIF};
function SDL_SetClipboardText(const text: PAnsiChar): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetClipboardText' {$ENDIF} {$ENDIF};
function SDL_GetClipboardText(): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetClipboardText' {$ENDIF} {$ENDIF};
function SDL_HasClipboardText(): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasClipboardText' {$ENDIF} {$ENDIF};
function SDL_GetCPUCacheLineSize(): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetCPUCacheLineSize' {$ENDIF} {$ENDIF};
function SDL_HasRDTSC(): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasRDTSC' {$ENDIF} {$ENDIF};
function SDL_HasAltiVec(): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasAltiVec' {$ENDIF} {$ENDIF};
function SDL_HasMMX(): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasMMX' {$ENDIF} {$ENDIF};
function SDL_Has3DNow(): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_Has3DNow' {$ENDIF} {$ENDIF};
function SDL_HasSSE(): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasSSE' {$ENDIF} {$ENDIF};
function SDL_HasSSE2(): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasSSE2' {$ENDIF} {$ENDIF};
function SDL_HasSSE3(): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasSSE3' {$ENDIF} {$ENDIF};
function SDL_HasSSE41(): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasSSE41' {$ENDIF} {$ENDIF};
function SDL_HasSSE42(): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasSSE42' {$ENDIF} {$ENDIF};
function SDL_HasAVX(): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasAVX' {$ENDIF} {$ENDIF};
function SDL_HasAVX2(): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasAVX2' {$ENDIF} {$ENDIF};
function SDL_GetSystemRAM(): Integer cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetSystemRAM' {$ENDIF} {$ENDIF};
function SDL_SetError(const fmt: PAnsiChar): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetError' {$ENDIF} {$ENDIF};
function SDL_GetError: PAnsiChar cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetError' {$ENDIF} {$ENDIF};
procedure SDL_ClearError cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ClearError' {$ENDIF} {$ENDIF};
function SDL_Error(code: TSDL_ErrorCode): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_Error' {$ENDIF} {$ENDIF};
procedure SDL_PumpEvents cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_PumpEvents' {$ENDIF} {$ENDIF};
function SDL_PeepEvents(events: PSDL_Event; numevents: SInt32; action: TSDL_EventAction; minType: UInt32; maxType: UInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_PeepEvents' {$ENDIF} {$ENDIF};
function SDL_HasEvent(type_: UInt32): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasEvent' {$ENDIF} {$ENDIF};
function SDL_HasEvents(minType: UInt32; maxType: UInt32): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasEvents' {$ENDIF} {$ENDIF};
procedure SDL_FlushEvent(type_: UInt32)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_FlushEvent' {$ENDIF} {$ENDIF};
procedure SDL_FlushEvents(minType: UInt32; maxType: UInt32)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_FlushEvents' {$ENDIF} {$ENDIF};
function SDL_PollEvent(event: PSDL_Event): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_PollEvent' {$ENDIF} {$ENDIF};
function SDL_WaitEvent(event: PSDL_Event): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WaitEvent' {$ENDIF} {$ENDIF};
function SDL_WaitEventTimeout(event: PSDL_Event; timeout: SInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WaitEventTimeout'
{$ENDIF} {$ENDIF};
function SDL_PushEvent(event: PSDL_Event): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_PumpEvents' {$ENDIF} {$ENDIF};
procedure SDL_SetEventFilter(filter: TSDL_EventFilter; userdata: Pointer)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetEventFilter' {$ENDIF} {$ENDIF};
function SDL_GetEventFilter(var filter: PSDL_EventFilter; var userdata: PPointer): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetEventFilter'
{$ENDIF} {$ENDIF};
procedure SDL_AddEventWatch(filter: TSDL_EventFilter; userdata: Pointer)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_AddEventWatch' {$ENDIF} {$ENDIF};
procedure SDL_DelEventWatch(filter: TSDL_EventFilter; userdata: Pointer)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_DelEventWatch' {$ENDIF} {$ENDIF};
procedure SDL_FilterEvents(filter: TSDL_EventFilter; userdata: Pointer)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_FilterEvents' {$ENDIF} {$ENDIF};
function SDL_EventState(type_: UInt32; state: SInt32): UInt8 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_EventState' {$ENDIF} {$ENDIF};
function SDL_GetEventState(type_: UInt32): UInt8;
function SDL_RegisterEvents(numevents: SInt32): UInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RegisterEvents' {$ENDIF} {$ENDIF};
function SDL_GetBasePath(): PChar cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetBasePath'
{$ENDIF} {$ENDIF};
function SDL_GetPrefPath(const org: PAnsiChar; const app: PAnsiChar): PChar cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetPrefPath'
{$ENDIF} {$ENDIF};
function SDL_GameControllerAddMapping(mappingString: PAnsiChar): Integer cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerAddMapping' {$ENDIF} {$ENDIF};
function SDL_GameControllerAddMappingsFromRW(rw: PSDL_RWops; freerw: SInt32): SInt32; cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerAddMappingsFromRW' {$ENDIF} {$ENDIF};
function SDL_GameControllerMappingForGUID(guid: TSDL_JoystickGUID): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerMappingForGUID' {$ENDIF} {$ENDIF};
function SDL_GameControllerMapping(gamecontroller: PSDL_GameController): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerMapping' {$ENDIF} {$ENDIF};
function SDL_IsGameController(joystick_index: Integer): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_IsGameController' {$ENDIF} {$ENDIF};
function SDL_GameControllerNameForIndex(joystick_index: Integer): PAnsiChar cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerNameForIndex' {$ENDIF} {$ENDIF};
function SDL_GameControllerOpen(joystick_index: Integer): PSDL_GameController cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerOpen'
{$ENDIF} {$ENDIF};
function SDL_GameControllerFromInstanceID(joyid: TSDL_JoystickID): PSDL_GameController; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerFromInstanceID' {$ENDIF} {$ENDIF};
function SDL_GameControllerName(gamecontroller: PSDL_GameController): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerName' {$ENDIF} {$ENDIF};
function SDL_GameControllerGetAttached(gamecontroller: PSDL_GameController): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerGetAttached' {$ENDIF} {$ENDIF};
function SDL_GameControllerGetJoystick(gamecontroller: PSDL_GameController): PSDL_Joystick cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerGetJoystick' {$ENDIF} {$ENDIF};
function SDL_GameControllerEventState(state: Integer): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerEventState' {$ENDIF} {$ENDIF};
procedure SDL_GameControllerUpdate()cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerUpdate' {$ENDIF} {$ENDIF};
function SDL_GameControllerGetAxisFromString(pchString: PAnsiChar): TSDL_GameControllerAxis cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerGetAxisFromString' {$ENDIF} {$ENDIF};
function SDL_GameControllerGetStringForAxis(axis: TSDL_GameControllerAxis): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerGetStringForAxis' {$ENDIF} {$ENDIF};
function SDL_GameControllerGetBindForAxis(gamecontroller: PSDL_GameController; axis: TSDL_GameControllerAxis): TSDL_GameControllerButtonBind cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerGetBindForAxis' {$ENDIF} {$ENDIF};
function SDL_GameControllerGetAxis(gamecontroller: PSDL_GameController; axis: TSDL_GameControllerAxis): sInt16 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerGetAxis' {$ENDIF} {$ENDIF};
function SDL_GameControllerGetButtonFromString(pchString: PAnsiChar): TSDL_GameControllerButton cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerGetButtonFromString' {$ENDIF} {$ENDIF};
function SDL_GameControllerGetStringForButton(button: TSDL_GameControllerButton): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerGetStringForButton' {$ENDIF} {$ENDIF};
function SDL_GameControllerGetBindForButton(gamecontroller: PSDL_GameController; button: TSDL_GameControllerButton): TSDL_GameControllerButtonBind cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerGetBindForButton' {$ENDIF} {$ENDIF};
function SDL_GameControllerGetButton(gamecontroller: PSDL_GameController; button: TSDL_GameControllerButton): UInt8 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerGetButton' {$ENDIF} {$ENDIF};
procedure SDL_GameControllerClose(gamecontroller: PSDL_GameController)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GameControllerClose'
{$ENDIF} {$ENDIF};
function SDL_GameControllerAddMappingsFromFile(Const FilePath: PAnsiChar): SInt32;
function SDL_RecordGesture(touchId: TSDL_TouchID): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RecordGesture' {$ENDIF} {$ENDIF};
function SDL_SaveAllDollarTemplates(Src: PSDL_RWops): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SaveAllDollarTemplates' {$ENDIF} {$ENDIF};
function SDL_SaveDollarTemplate(gestureId: TSDL_GestureID; Src: PSDL_RWops): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SaveDollarTemplate' {$ENDIF} {$ENDIF};
function SDL_LoadDollarTemplates(touchId: TSDL_TouchID; Src: PSDL_RWops): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LoadDollarTemplates' {$ENDIF} {$ENDIF};
function SDL_NumHaptics: Integer cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_NumHaptics'
{$ENDIF} {$ENDIF};
function SDL_HapticName(device_index: Integer): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticName' {$ENDIF} {$ENDIF};
function SDL_HapticOpen(device_index: Integer): PSDL_Haptic cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticOpen' {$ENDIF} {$ENDIF};
function SDL_HapticOpened(device_index: Integer): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticOpened' {$ENDIF} {$ENDIF};
function SDL_HapticIndex(haptic: PSDL_Haptic): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticIndex' {$ENDIF} {$ENDIF};
function SDL_MouseIsHaptic: Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_MouseInHaptic' {$ENDIF} {$ENDIF};
function SDL_HapticOpenFromMouse: PSDL_Haptic cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticOpenFromMouse' {$ENDIF} {$ENDIF};
function SDL_JoystickIsHaptic(joystick: PSDL_Joystick): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickIsHaptic' {$ENDIF} {$ENDIF};
function SDL_HapticOpenFromJoystick(joystick: PSDL_Joystick): PSDL_Haptic cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticOpenFromJoystick' {$ENDIF} {$ENDIF};
procedure SDL_HapticClose(haptic: PSDL_Haptic)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticClose' {$ENDIF} {$ENDIF};
function SDL_HapticNumEffects(haptic: PSDL_Haptic): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticNumEffects' {$ENDIF} {$ENDIF};
function SDL_HapticNumEffectsPlaying(haptic: PSDL_Haptic): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticNumEffectsPlaying' {$ENDIF} {$ENDIF};
function SDL_HapticQuery(haptic: PSDL_Haptic): UInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticQuery' {$ENDIF} {$ENDIF};
function SDL_HapticNumAxes(haptic: PSDL_Haptic): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticNumAxes' {$ENDIF} {$ENDIF};
function SDL_HapticEffectSupported(haptic: PSDL_Haptic; effect: PSDL_HapticEffect): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticEffectSupported' {$ENDIF} {$ENDIF};
function SDL_HapticNewEffect(haptic: PSDL_Haptic; effect: PSDL_HapticEffect): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticNewEffect' {$ENDIF} {$ENDIF};
function SDL_HapticUpdateEffect(haptic: PSDL_Haptic; effect: Integer; data: PSDL_HapticEffect): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticUpdateEffect' {$ENDIF} {$ENDIF};
function SDL_HapticRunEffect(haptic: PSDL_Haptic; effect: Integer; iterations: UInt32): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticRunEffect' {$ENDIF} {$ENDIF};
function SDL_HapticStopEffect(haptic: PSDL_Haptic; effect: Integer): Integer cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticStopEffect'
{$ENDIF} {$ENDIF};
procedure SDL_HapticDestroyEffect(haptic: PSDL_Haptic; effect: Integer)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticDestroyEffect' {$ENDIF} {$ENDIF};
function SDL_HapticGetEffectStatus(haptic: PSDL_Haptic; effect: Integer): Integer cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticGetEffectStatus' {$ENDIF} {$ENDIF};
function SDL_HapticSetGain(haptic: PSDL_Haptic; gain: Integer): Integer cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticSetGain'
{$ENDIF} {$ENDIF};
function SDL_HapticSetAutocenter(haptic: PSDL_Haptic; autocenter: Integer): Integer cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticSetAutocenter' {$ENDIF} {$ENDIF};
function SDL_HapticPause(haptic: PSDL_Haptic): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticPause' {$ENDIF} {$ENDIF};
function SDL_HapticUnpause(haptic: PSDL_Haptic): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticUnPause' {$ENDIF} {$ENDIF};
function SDL_HapticStopAll(haptic: PSDL_Haptic): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticStopAll' {$ENDIF} {$ENDIF};
function SDL_HapticRumbleSupported(haptic: PSDL_Haptic): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticRumbleSupported' {$ENDIF} {$ENDIF};
function SDL_HapticRumbleInit(haptic: PSDL_Haptic): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticRumbleInit' {$ENDIF} {$ENDIF};
function SDL_HapticRumblePlay(haptic: PSDL_Haptic; strength: Float; Length: UInt32): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticRumblePlay' {$ENDIF} {$ENDIF};
function SDL_HapticRumbleStop(haptic: PSDL_Haptic): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HapticRumbleStop' {$ENDIF} {$ENDIF};
function SDL_SetHintWithPriority(const name: PChar; const value: PChar; priority: SDL_HintPriority): Boolean; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetHintWithPriority' {$ENDIF} {$ENDIF};
function SDL_SetHint(const name: PChar; const value: PChar): Boolean; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetHint' {$ENDIF} {$ENDIF};
function SDL_GetHint(const name: PChar): PChar; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetHint' {$ENDIF} {$ENDIF};
function SDL_GetHintBoolean(const name: PChar; default_value: Boolean): Boolean; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetHintBoolean' {$ENDIF} {$ENDIF};
procedure SDL_AddHintCallback(const name: PChar; callback: TSDL_HintCallback; userdata: Pointer); cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_AddHintCallback' {$ENDIF} {$ENDIF};
procedure SDL_DelHintCallback(const name: PChar; callback: TSDL_HintCallback; userdata: Pointer); cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_DelHintCallback' {$ENDIF} {$ENDIF};
procedure SDL_ClearHints(); cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ClearHints'
{$ENDIF} {$ENDIF};
function SDL_NumJoysticks: SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_NumJoysticks' {$ENDIF} {$ENDIF};
function SDL_JoystickNameForIndex(device_index: SInt32): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickNameForIndex' {$ENDIF} {$ENDIF};
function SDL_JoystickOpen(device_index: SInt32): PSDL_Joystick cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickOpen'
{$ENDIF} {$ENDIF};
function SDL_JoystickFromInstanceID(joyid: TSDL_JoystickID): PSDL_Joystick; cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickFromInstanceID' {$ENDIF} {$ENDIF};
function SDL_JoystickName(joystick: PSDL_Joystick): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickName' {$ENDIF} {$ENDIF};
function SDL_JoystickGetDeviceGUID(device_index: SInt32): TSDL_JoystickGUID cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickGetDeviceGUID' {$ENDIF} {$ENDIF};
function SDL_JoystickGetGUID(joystick: PSDL_Joystick): TSDL_JoystickGUID cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickGetGUID'
{$ENDIF} {$ENDIF};
procedure SDL_JoystickGetGUIDString(guid: TSDL_JoystickGUID; pszGUID: PAnsiChar; cbGUID: SInt32)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickGetGUIDString' {$ENDIF} {$ENDIF};
function SDL_JoystickGetGUIDFromString(const pchGUID: PAnsiChar): TSDL_JoystickGUID cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickGetGUIDFromString' {$ENDIF} {$ENDIF};
function SDL_JoystickGetAttached(joystick: PSDL_Joystick): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickGetAttached' {$ENDIF} {$ENDIF};
function SDL_JoystickInstanceID(joystick: PSDL_Joystick): TSDL_JoystickID cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickInstanceID' {$ENDIF} {$ENDIF};
function SDL_JoystickNumAxes(joystick: PSDL_Joystick): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickNumAxes' {$ENDIF} {$ENDIF};
function SDL_JoystickNumBalls(joystick: PSDL_Joystick): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickNumBalls' {$ENDIF} {$ENDIF};
function SDL_JoystickNumHats(joystick: PSDL_Joystick): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickNumHats' {$ENDIF} {$ENDIF};
function SDL_JoystickNumButtons(joystick: PSDL_Joystick): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickNumButtons' {$ENDIF} {$ENDIF};
procedure SDL_JoystickUpdate cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickUpdate'
{$ENDIF} {$ENDIF};
function SDL_JoystickEventState(state: SInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickEventState' {$ENDIF} {$ENDIF};
function SDL_JoystickGetAxis(joystick: PSDL_Joystick; axis: SInt32): sInt16 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickGetAxis'
{$ENDIF} {$ENDIF};
function SDL_JoystickGetHat(joystick: PSDL_Joystick; hat: SInt32): UInt8 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickGetHat'
{$ENDIF} {$ENDIF};
function SDL_JoystickGetBall(joystick: PSDL_Joystick; ball: SInt32; dx: PInt; dy: PInt): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickGetBall' {$ENDIF} {$ENDIF};
function SDL_JoystickGetButton(joystick: PSDL_Joystick; button: SInt32): UInt8 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickGetButton'
{$ENDIF} {$ENDIF};
procedure SDL_JoystickClose(joystick: PSDL_Joystick)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickClose' {$ENDIF} {$ENDIF};
function SDL_JoystickCurrentPowerLevel(joystick: PSDL_Joystick): TSDL_JoystickPowerLevel; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_JoystickCurrentPowerLevel' {$ENDIF} {$ENDIF};
function SDL_GetKeyboardFocus: PSDL_Window cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetKeyboardFocus' {$ENDIF}{$ENDIF};
function SDL_GetKeyboardState(numkeys: PInt): PuInt8 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetKeyboardState' {$ENDIF}{$ENDIF};
function SDL_GetModState: TSDL_KeyMod cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetModState' {$ENDIF}{$ENDIF};
procedure SDL_SetModState(modstate: TSDL_KeyMod)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetModState' {$ENDIF}{$ENDIF};
function SDL_GetKeyFromScancode(scancode: TSDL_ScanCode): TSDL_KeyCode cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetKeyFromScancode' {$ENDIF}{$ENDIF};
function SDL_GetScancodeFromKey(key: TSDL_KeyCode): TSDL_ScanCode cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetScancodeFromKey' {$ENDIF}{$ENDIF};
function SDL_GetScancodeName(scancode: TSDL_ScanCode): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetScancodeName' {$ENDIF}{$ENDIF};
function SDL_GetScancodeFromName(const name: PAnsiChar): TSDL_ScanCode cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetScancodeFromName' {$ENDIF}{$ENDIF};
function SDL_GetKeyName(key: TSDL_KeyCode): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetKeyName' {$ENDIF}{$ENDIF};
function SDL_GetKeyFromName(const name: PAnsiChar): TSDL_KeyCode cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetKeyFromName' {$ENDIF}{$ENDIF};
procedure SDL_StartTextInput cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_StartTextInput'
{$ENDIF}{$ENDIF};
function SDL_IsTextInputActive: TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_IsTextInputActive' {$ENDIF}{$ENDIF};
procedure SDL_StopTextInput cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_StopTextInput'
{$ENDIF}{$ENDIF};
procedure SDL_SetTextInputRect(rect: PSDL_Rect)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetTextInputRect' {$ENDIF}{$ENDIF};
function SDL_HasScreenKeyboardSupport: TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasScreenKeyboardSupport' {$ENDIF}{$ENDIF};
function SDL_IsScreenKeyboardShown(window: PSDL_Window): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_IsScreenKeyboardShown' {$ENDIF}{$ENDIF};
function SDL_LoadObject(Const sofile: PAnsiChar): Pointer; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LoadObject' {$ENDIF}{$ENDIF};
function SDL_LoadFunction(handle: Pointer; Const name: PAnsiChar): Pointer; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LoadFunction' {$ENDIF}{$ENDIF};
procedure SDL_UnloadObject(handle: Pointer); cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_UnloadObject' {$ENDIF}{$ENDIF};
{$IFDEF FPC}
procedure SDL_LogSetAllPriority(priority: TSDL_LogPriority)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogSetAllPriority' {$ENDIF} {$ENDIF};
procedure SDL_LogSetPriority(category: Integer; priority: TSDL_LogPriority)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogSetPriority'
{$ENDIF} {$ENDIF};
function SDL_LogGetPriority(category: Integer): TSDL_LogPriority cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogGetPriority'
{$ENDIF} {$ENDIF};
procedure SDL_LogResetPriorities()cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogResetPriorities' {$ENDIF} {$ENDIF};
procedure SDL_Log(const fmt: PAnsiChar; pars: array of const)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_Log' {$ENDIF} {$ENDIF};
procedure SDL_LogVerbose(category: Integer; const fmt: PAnsiChar; pars: array of const)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogVerbose' {$ENDIF} {$ENDIF};
procedure SDL_LogDebug(category: Integer; const fmt: PAnsiChar; pars: array of const)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogDebug' {$ENDIF} {$ENDIF};
procedure SDL_LogInfo(category: Integer; const fmt: PAnsiChar; pars: array of const)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogInfo' {$ENDIF} {$ENDIF};
procedure SDL_LogWarn(category: Integer; const fmt: PAnsiChar; pars: array of const)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogWarn' {$ENDIF} {$ENDIF};
procedure SDL_LogError(category: Integer; const fmt: PAnsiChar; pars: array of const)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogError' {$ENDIF} {$ENDIF};
procedure SDL_LogCritical(category: Integer; const fmt: PAnsiChar; pars: array of const)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogCritical' {$ENDIF} {$ENDIF};
procedure SDL_LogMessage(category: Integer; priority: TSDL_LogPriority; const fmt: PAnsiChar; pars: array of const)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogMessage'
{$ENDIF} {$ENDIF};
procedure SDL_LogMessageV(category: Integer; priority: TSDL_LogPriority; const fmt: PAnsiChar; ap: array of const)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogMessageV'
{$ENDIF} {$ENDIF};
procedure SDL_LogGetOutputFunction(callback: PSDL_LogOutputFunction; userdata: PPointer)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogGetOutputFunction' {$ENDIF} {$ENDIF};
procedure SDL_LogSetOutputFunction(callback: TSDL_LogOutputFunction; userdata: Pointer)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LogSetOutputFunction' {$ENDIF} {$ENDIF};
{$ENDIF}
function SDL_ShowMessageBox(messageboxdata: PSDL_MessageBoxData; buttonid: PInt): Integer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ShowMessageBox' {$ENDIF} {$ENDIF};
function SDL_ShowSimpleMessageBox(flags: UInt32; title: PAnsiChar; _message: PAnsiChar; window: PSDL_Window): Integer cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ShowSimpleMessageBox' {$ENDIF} {$ENDIF};
function SDL_GetMouseFocus: PSDL_Window cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetMouseFocus' {$ENDIF}{$ENDIF};
function SDL_GetMouseState(x: PInt; Y: PInt): UInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetMouseState' {$ENDIF}{$ENDIF};
function SDL_GetGlobalMouseState(x, Y: PSInt32): UInt32; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetGlobalMouseState' {$ENDIF}{$ENDIF};
function SDL_GetRelativeMouseState(x: PInt; Y: PInt): UInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRelativeMouseState' {$ENDIF}{$ENDIF};
procedure SDL_WarpMouseInWindow(window: PSDL_Window; x: SInt32; Y: SInt32)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WarpMouseInWindow'
{$ENDIF}{$ENDIF};
Function SDL_WarpMouseGlobal(x, Y: SInt32): SInt32; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WarpMouseGlobal' {$ENDIF}{$ENDIF};
function SDL_SetRelativeMouseMode(enabled: TSDL_Bool): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetRelativeMouseMode' {$ENDIF}{$ENDIF};
function SDL_CaptureMouse(enabled: TSDL_Bool): SInt32; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CaptureMouse' {$ENDIF}{$ENDIF};
function SDL_GetRelativeMouseMode: TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRelativeMouseMode' {$ENDIF}{$ENDIF};
function SDL_CreateCursor(const data: PuInt8; const mask: PuInt8; w: SInt32; h: SInt32; hot_x: SInt32; hot_y: SInt32): PSDL_Cursor cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateCursor'
{$ENDIF}{$ENDIF};
function SDL_CreateColorCursor(surface: PSDL_Surface; hot_x: SInt32; hot_y: SInt32): PSDL_Cursor cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateColorCursor' {$ENDIF}{$ENDIF};
function SDL_CreateSystemCursor(id: TSDL_SystemCursor): PSDL_Cursor cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateSystemCursor' {$ENDIF}{$ENDIF};
procedure SDL_SetCursor(cursor: PSDL_Cursor)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetCursor' {$ENDIF}{$ENDIF};
function SDL_GetCursor: PSDL_Cursor cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetCursor' {$ENDIF}{$ENDIF};
function SDL_GetDefaultCursor: PSDL_Cursor cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetDefaultCursor' {$ENDIF}{$ENDIF};
procedure SDL_FreeCursor(cursor: PSDL_Cursor)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_FreeCursor' {$ENDIF}{$ENDIF};
function SDL_ShowCursor(toggle: SInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ShowCursor' {$ENDIF}{$ENDIF};
function SDL_Button(button: SInt32): SInt32;
{$IFNDEF DELPHI} inline; {$ELSE} {$IFDEF DELPHI10UP} inline; {$ENDIF} {$ENDIF}
function SDL_CreateMutex: PSDL_Mutex cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateMutex' {$ENDIF} {$ENDIF};
function SDL_LockMutex(mutex: PSDL_Mutex): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LockMutex' {$ENDIF} {$ENDIF};
function SDL_TryLockMutex(mutex: PSDL_Mutex): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_TryLockMutex' {$ENDIF} {$ENDIF};
function SDL_UnlockMutex(mutex: PSDL_Mutex): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_UnlockMutex' {$ENDIF} {$ENDIF};
procedure SDL_DestroyMutex(mutex: PSDL_Mutex)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_DestroyMutex' {$ENDIF} {$ENDIF};
function SDL_CreateSemaphore(initial_value: UInt32): PSDL_Sem cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateSemaphore' {$ENDIF} {$ENDIF};
procedure SDL_DestroySemaphore(sem: PSDL_Sem)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_DestroySemaphore' {$ENDIF} {$ENDIF};
function SDL_SemWait(sem: PSDL_Sem): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SemWait' {$ENDIF} {$ENDIF};
function SDL_SemTryWait(sem: PSDL_Sem): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SemTryWait' {$ENDIF} {$ENDIF};
function SDL_SemWaitTimeout(sem: PSDL_Sem; ms: UInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SemWaitTimeout' {$ENDIF} {$ENDIF};
function SDL_SemPost(sem: PSDL_Sem): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SemPost' {$ENDIF} {$ENDIF};
function SDL_SemValue(sem: PSDL_Sem): UInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SemValue' {$ENDIF} {$ENDIF};
function SDL_CreateCond: PSDL_Cond cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateCond' {$ENDIF} {$ENDIF};
procedure SDL_DestroyCond(cond: PSDL_Cond)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_DestroyCond' {$ENDIF} {$ENDIF};
function SDL_CondSignal(cond: PSDL_Cond): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CondSignal' {$ENDIF} {$ENDIF};
function SDL_CondBroadcast(cond: PSDL_Cond): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CondBroadcast' {$ENDIF} {$ENDIF};
function SDL_CondWait(cond: PSDL_Cond; mutex: PSDL_Mutex): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CondWait' {$ENDIF} {$ENDIF};
function SDL_CondWaitTimeout(cond: PSDL_Cond; mutex: PSDL_Mutex; ms: UInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CondWaitTimeout' {$ENDIF} {$ENDIF};
function SDL_GetPixelFormatName(format: UInt32): PAnsiChar cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetPixelFormatName' {$ENDIF} {$ENDIF};
function SDL_PixelFormatEnumToMasks(format: UInt32; bpp: PInt; Rmask: PUInt32; Gmask: PUInt32; Bmask: PUInt32; Amask: PUInt32): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_PixelFormatEnumToMasks' {$ENDIF} {$ENDIF};
function SDL_MasksToPixelFormatEnum(bpp: SInt32; Rmask: UInt32; Gmask: UInt32; Bmask: UInt32; Amask: UInt32): UInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_MasksToPixelFormatEnum' {$ENDIF} {$ENDIF};
function SDL_AllocFormat(pixel_format: UInt32): PSDL_PixelFormat cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_AllocFormat' {$ENDIF} {$ENDIF};
procedure SDL_FreeFormat(format: PSDL_PixelFormat)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_FreeFormat' {$ENDIF} {$ENDIF};
function SDL_AllocPalette(ncolors: SInt32): PSDL_Palette cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_AllocPalette' {$ENDIF} {$ENDIF};
function SDL_SetPixelFormatPalette(format: PSDL_PixelFormat; palette: PSDL_Palette): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetPixelFormatPalette' {$ENDIF} {$ENDIF};
function SDL_SetPaletteColors(palette: PSDL_Palette; const colors: PSDL_Color; firstcolor: SInt32; ncolors: SInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetPaletteColors' {$ENDIF} {$ENDIF};
procedure SDL_FreePalette(palette: PSDL_Palette)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_FreePalette' {$ENDIF} {$ENDIF};
function SDL_MapRGB(const format: PSDL_PixelFormat; r: UInt8; g: UInt8; b: UInt8): UInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_MapRGB' {$ENDIF} {$ENDIF};
function SDL_MapRGBA(const format: PSDL_PixelFormat; r: UInt8; g: UInt8; b: UInt8; a: UInt8): UInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_MapRGBA' {$ENDIF} {$ENDIF};
procedure SDL_GetRGB(pixel: UInt32; const format: PSDL_PixelFormat; r: PuInt8; g: PuInt8; b: PuInt8)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRGB' {$ENDIF} {$ENDIF};
procedure SDL_GetRGBA(pixel: UInt32; const format: PSDL_PixelFormat; r: PuInt8; g: PuInt8; b: PuInt8; a: PuInt8)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRGBA' {$ENDIF} {$ENDIF};
procedure SDL_CalculateGammaRamp(gamma: Float; ramp: PUInt16)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CalculateGammaRamp' {$ENDIF} {$ENDIF};
function SDL_GetPlatform: PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetPlatform' {$ENDIF} {$ENDIF};
function SDL_GetPowerInfo(secs: PInt; pct: PInt): TSDL_PowerState cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetPowerInfo' {$ENDIF} {$ENDIF};
function SDL_PointInRect(const p: PSDL_Point; const r: PSDL_Rect): Boolean; Inline;
function SDL_RectEmpty(const r: PSDL_Rect): Boolean; inline;
function SDL_RectEquals(const a, b: PSDL_Rect): Boolean; inline;
function SDL_HasIntersection(const a, b: PSDL_Rect): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HasIntersection' {$ENDIF} {$ENDIF};
function SDL_IntersectRect(const a, b: PSDL_Rect; Result: PSDL_Rect): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_IntersectRect' {$ENDIF} {$ENDIF};
procedure SDL_UnionRect(const a, b: PSDL_Rect; Result: PSDL_Rect)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_UnionRect' {$ENDIF} {$ENDIF};
function SDL_EnclosePoints(const points: PSDL_Point; count: SInt32; const clip: PSDL_Rect; Result: PSDL_Rect): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_EnclosePoints' {$ENDIF} {$ENDIF};
function SDL_IntersectRectAndLine(const rect: PSDL_Rect; x1, y1, x2, y2: PInt): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_IntersectRectAndLine' {$ENDIF} {$ENDIF};
function SDL_GetNumRenderDrivers: SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetNumRenderDrivers' {$ENDIF} {$ENDIF};
function SDL_GetRenderDriverInfo(index: SInt32; info: PSDL_RendererInfo): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRenderDriverInfo' {$ENDIF} {$ENDIF};
function SDL_CreateWindowAndRenderer(width: SInt32; height: SInt32; window_flags: UInt32; window: PPSDL_Window; renderer: PPSDL_Renderer): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateWindowAndRenderer' {$ENDIF} {$ENDIF};
function SDL_CreateRenderer(window: PSDL_Window; index: SInt32; flags: UInt32): PSDL_Renderer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateRenderer' {$ENDIF} {$ENDIF};
function SDL_CreateSoftwareRenderer(surface: PSDL_Surface): PSDL_Renderer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateSoftwareRenderer' {$ENDIF} {$ENDIF};
function SDL_GetRenderer(window: PSDL_Window): PSDL_Renderer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRenderer' {$ENDIF} {$ENDIF};
function SDL_GetRendererInfo(renderer: PSDL_Renderer; info: PSDL_RendererInfo): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRendererInfo' {$ENDIF} {$ENDIF};
function SDL_GetRendererOutputSize(renderer: PSDL_Renderer; w: PInt; h: PInt): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRendererOutputSize' {$ENDIF} {$ENDIF};
function SDL_CreateTexture(renderer: PSDL_Renderer; format: UInt32; access: SInt32; w: SInt32; h: SInt32): PSDL_Texture cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateTexture' {$ENDIF} {$ENDIF};
function SDL_CreateTextureFromSurface(renderer: PSDL_Renderer; surface: PSDL_Surface): PSDL_Texture cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateTextureFromSurface' {$ENDIF} {$ENDIF};
function SDL_QueryTexture(texture: PSDL_Texture; format: PUInt32; access: PInt; w: PInt; h: PInt): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_QueryTexture' {$ENDIF} {$ENDIF};
function SDL_SetTextureColorMod(texture: PSDL_Texture; r: UInt8; g: UInt8; b: UInt8): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetTextureColorMod' {$ENDIF} {$ENDIF};
function SDL_GetTextureColorMod(texture: PSDL_Texture; r: PuInt8; g: PuInt8; b: PuInt8): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetTextureColorMod' {$ENDIF} {$ENDIF};
function SDL_SetTextureAlphaMod(texture: PSDL_Texture; alpha: UInt8): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetTextureAlphaMod' {$ENDIF} {$ENDIF};
function SDL_GetTextureAlphaMod(texture: PSDL_Texture; alpha: PuInt8): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetTextureAlphaMod' {$ENDIF} {$ENDIF};
function SDL_SetTextureBlendMode(texture: PSDL_Texture; blendMode: TSDL_BlendMode): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetTextureBlendMode' {$ENDIF} {$ENDIF};
function SDL_GetTextureBlendMode(texture: PSDL_Texture; blendMode: PSDL_BlendMode): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetTextureBlendMode' {$ENDIF} {$ENDIF};
function SDL_UpdateTexture(texture: PSDL_Texture; rect: PSDL_Rect; pixels: Pointer; pitch: SInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_UpdateTexture' {$ENDIF} {$ENDIF};
function SDL_LockTexture(texture: PSDL_Texture; rect: PSDL_Rect; pixels: PPointer; pitch: PInt): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LockTexture' {$ENDIF} {$ENDIF};
procedure SDL_UnlockTexture(texture: PSDL_Texture)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LockTexture' {$ENDIF} {$ENDIF};
function SDL_RenderTargetSupported(renderer: PSDL_Renderer): Boolean cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderTargetSupported' {$ENDIF} {$ENDIF};
function SDL_SetRenderTarget(renderer: PSDL_Renderer; texture: PSDL_Texture): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetRenderTarget' {$ENDIF} {$ENDIF};
function SDL_GetRenderTarget(renderer: PSDL_Renderer): PSDL_Texture cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRenderTarget' {$ENDIF} {$ENDIF};
function SDL_RenderSetLogicalSize(renderer: PSDL_Renderer; w: SInt32; h: SInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderSetLogicalSize' {$ENDIF} {$ENDIF};
procedure SDL_RenderGetLogicalSize(renderer: PSDL_Renderer; w: PInt; h: PInt)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderGetLogicalSize' {$ENDIF} {$ENDIF};
function SDL_RenderSetIntegerScale(renderer: PSDL_Renderer; enable: TSDL_Bool): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderSetIntegerScale' {$ENDIF} {$ENDIF};
function SDL_RenderGetIntegerScale(renderer: PSDL_Renderer): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderGetIntegerScale' {$ENDIF} {$ENDIF};
function SDL_RenderSetViewport(renderer: PSDL_Renderer; const rect: PSDL_Rect): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderSetViewport' {$ENDIF} {$ENDIF};
procedure SDL_RenderGetViewport(renderer: PSDL_Renderer; rect: PSDL_Rect)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderGetViewport' {$ENDIF} {$ENDIF};
function SDL_RenderSetClipRect(renderer: PSDL_Renderer; rect: PSDL_Rect): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderSetClipRect' {$ENDIF} {$ENDIF};
procedure SDL_RenderGetClipRect(renderer: PSDL_Renderer; rect: PSDL_Rect)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderGetClipRect' {$ENDIF} {$ENDIF};
function SDL_RenderIsClipEnabled(renderer: PSDL_Renderer): TSDL_Bool; cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderIsClipEnabled' {$ENDIF} {$ENDIF};
function SDL_RenderSetScale(renderer: PSDL_Renderer; scaleX: Float; scaleY: Float): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderSetScale' {$ENDIF} {$ENDIF};
procedure SDL_RenderGetScale(renderer: PSDL_Renderer; scaleX: PFloat; scaleY: PFloat)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderGetScale' {$ENDIF} {$ENDIF};
function SDL_SetRenderDrawColor(renderer: PSDL_Renderer; r: UInt8; g: UInt8; b: UInt8; a: UInt8): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetRenderDrawColor' {$ENDIF} {$ENDIF};
function SDL_GetRenderDrawColor(renderer: PSDL_Renderer; r: PuInt8; g: PuInt8; b: PuInt8; a: PuInt8): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRenderDrawColor' {$ENDIF} {$ENDIF};
function SDL_SetRenderDrawBlendMode(renderer: PSDL_Renderer; blendMode: TSDL_BlendMode): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetRenderDrawBlendMode' {$ENDIF} {$ENDIF};
function SDL_GetRenderDrawBlendMode(renderer: PSDL_Renderer; blendMode: PSDL_BlendMode): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRenderDrawBlendMode' {$ENDIF} {$ENDIF};
function SDL_RenderClear(renderer: PSDL_Renderer): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderClear' {$ENDIF} {$ENDIF};
function SDL_RenderDrawPoint(renderer: PSDL_Renderer; x: SInt32; Y: SInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderDrawPoint' {$ENDIF} {$ENDIF};
function SDL_RenderDrawPoints(renderer: PSDL_Renderer; points: PSDL_Point; count: SInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderDrawPoints' {$ENDIF} {$ENDIF};
function SDL_RenderDrawLine(renderer: PSDL_Renderer; x1: SInt32; y1: SInt32; x2: SInt32; y2: SInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderDrawLine' {$ENDIF} {$ENDIF};
function SDL_RenderDrawLines(renderer: PSDL_Renderer; points: PSDL_Point; count: SInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderDrawLines' {$ENDIF} {$ENDIF};
function SDL_RenderDrawRect(renderer: PSDL_Renderer; rect: PSDL_Rect): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderDrawRect' {$ENDIF} {$ENDIF};
function SDL_RenderDrawRects(renderer: PSDL_Renderer; rects: PSDL_Rect; count: SInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderDrawRects' {$ENDIF} {$ENDIF};
function SDL_RenderFillRect(renderer: PSDL_Renderer; rect: PSDL_Rect): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderFillRect' {$ENDIF} {$ENDIF};
function SDL_RenderFillRects(renderer: PSDL_Renderer; rects: PSDL_Rect; count: SInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderFillRects' {$ENDIF} {$ENDIF};
function SDL_RenderCopy(renderer: PSDL_Renderer; texture: PSDL_Texture; srcrect: PSDL_Rect; dstrect: PSDL_Rect): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderCopy' {$ENDIF} {$ENDIF};
function SDL_RenderCopyEx(renderer: PSDL_Renderer; texture: PSDL_Texture; const srcrect: PSDL_Rect; dstrect: PSDL_Rect; angle: Double; center: PSDL_Point; flip: Integer): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderCopyEx' {$ENDIF} {$ENDIF};
function SDL_RenderReadPixels(renderer: PSDL_Renderer; rect: PSDL_Rect; format: UInt32; pixels: Pointer; pitch: SInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderReadPixels' {$ENDIF} {$ENDIF};
procedure SDL_RenderPresent(renderer: PSDL_Renderer)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RenderPresent' {$ENDIF} {$ENDIF};
procedure SDL_DestroyTexture(texture: PSDL_Texture)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_DestroyTexture' {$ENDIF} {$ENDIF};
procedure SDL_DestroyRenderer(renderer: PSDL_Renderer)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_DestroyRenderer' {$ENDIF} {$ENDIF};
function SDL_GL_BindTexture(texture: PSDL_Texture; texw: PFloat; texh: PFloat): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_BindTexture' {$ENDIF} {$ENDIF};
function SDL_GL_UnbindTexture(texture: PSDL_Texture): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_UnbindTexture' {$ENDIF} {$ENDIF};
function SDL_UpdateYUVTexture(texture: PSDL_Texture; rect: PSDL_Rect; Yplane: PuInt8; Ypitch: SInt32; Uplane: PuInt8; UPitch: SInt32; Vplane: UInt8; VPitch: SInt32): SInt32; cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_UpdateYUVTexture' {$ENDIF} {$ENDIF};
function SDL_RWFromFile(const _file: PAnsiChar; const mode: PAnsiChar): PSDL_RWops; cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RWFromFile' {$ENDIF} {$ENDIF};
function SDL_RWFromFP(fp: Pointer; autoclose: TSDL_Bool): PSDL_RWops; cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RWFromFP' {$ENDIF} {$ENDIF};
function SDL_RWFromMem(mem: Pointer; size: SInt32): PSDL_RWops; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RWFromMem' {$ENDIF} {$ENDIF};
function SDL_RWFromConstMem(const mem: Pointer; size: SInt32): PSDL_RWops; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RWFromConstMem' {$ENDIF} {$ENDIF};
function SDL_AllocRW: PSDL_RWops; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_AllocRW' {$ENDIF} {$ENDIF};
procedure SDL_FreeRW(area: PSDL_RWops); cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_FreeRW' {$ENDIF} {$ENDIF};
function SDL_ReadU8(Src: PSDL_RWops): UInt8 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ReadU8' {$ENDIF} {$ENDIF};
function SDL_ReadLE16(Src: PSDL_RWops): UInt16 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ReadLE16' {$ENDIF} {$ENDIF};
function SDL_ReadBE16(Src: PSDL_RWops): UInt16 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ReadBE16' {$ENDIF} {$ENDIF};
function SDL_ReadLE32(Src: PSDL_RWops): UInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ReadLE32' {$ENDIF} {$ENDIF};
function SDL_ReadBE32(Src: PSDL_RWops): UInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ReadBE32' {$ENDIF} {$ENDIF};
function SDL_ReadLE64(Src: PSDL_RWops): UInt64 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ReadLE64' {$ENDIF} {$ENDIF};
function SDL_ReadBE64(Src: PSDL_RWops): UInt64 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ReadBE64' {$ENDIF} {$ENDIF};
function SDL_WriteU8(dst: PSDL_RWops; value: UInt8): size_t cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WriteU8' {$ENDIF} {$ENDIF};
function SDL_WriteLE16(dst: PSDL_RWops; value: UInt16): size_t cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WriteLE16' {$ENDIF} {$ENDIF};
function SDL_WriteBE16(dst: PSDL_RWops; value: UInt16): size_t cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WriteBE16' {$ENDIF} {$ENDIF};
function SDL_WriteLE32(dst: PSDL_RWops; value: UInt32): size_t cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WriteLE32' {$ENDIF} {$ENDIF};
function SDL_WriteBE32(dst: PSDL_RWops; value: UInt32): size_t cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WriteBE32' {$ENDIF} {$ENDIF};
function SDL_WriteLE64(dst: PSDL_RWops; value: UInt64): size_t cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WriteLE64' {$ENDIF} {$ENDIF};
function SDL_WriteBE64(dst: PSDL_RWops; value: UInt64): size_t cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WriteBE64' {$ENDIF} {$ENDIF};
function SDL_MUSTLOCK(Const S: PSDL_Surface): Boolean;
function SDL_CreateRGBSurface(flags: UInt32; width: SInt32; height: SInt32; depth: SInt32; Rmask: UInt32; Gmask: UInt32; Bmask: UInt32; Amask: UInt32): PSDL_Surface cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateRGBSurface' {$ENDIF} {$ENDIF};
function SDL_CreateRGBSurfaceWithFormat(flags: UInt32; width, height, depth: SInt32; format: UInt32): PSDL_Surface; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateRGBSurfaceWithFormat' {$ENDIF} {$ENDIF};
function SDL_CreateRGBSurfaceFrom(pixels: Pointer; width: SInt32; height: SInt32; depth: SInt32; pitch: SInt32; Rmask: UInt32; Gmask: UInt32; Bmask: UInt32; Amask: UInt32): PSDL_Surface cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateRGBSurfaceFrom' {$ENDIF} {$ENDIF};
function SDL_CreateRGBSurfaceWithFormatFrom(pixels: Pointer; width, height, depth, pitch: SInt32; format: UInt32): PSDL_Surface; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateRGBSurfaceWithFormatFrom' {$ENDIF} {$ENDIF};
procedure SDL_FreeSurface(surface: PSDL_Surface)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_FreeSurface' {$ENDIF} {$ENDIF};
function SDL_SetSurfacePalette(surface: PSDL_Surface; palette: PSDL_Palette): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetSurfacePalette' {$ENDIF} {$ENDIF};
function SDL_LockSurface(surface: PSDL_Surface): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LockSurface' {$ENDIF} {$ENDIF};
procedure SDL_UnlockSurface(surface: PSDL_Surface)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_UnlockSurface' {$ENDIF} {$ENDIF};
function SDL_LoadBMP_RW(Src: PSDL_RWops; freesrc: SInt32): PSDL_Surface cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LoadBMP_RW' {$ENDIF} {$ENDIF};
function SDL_LoadBMP(_file: PAnsiChar): PSDL_Surface;
function SDL_SaveBMP_RW(surface: PSDL_Surface; dst: PSDL_RWops; freedst: SInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LoadBMP_RW' {$ENDIF} {$ENDIF};
function SDL_SaveBMP(Const surface: PSDL_Surface; Const filename: AnsiString): SInt32;
function SDL_SetSurfaceRLE(surface: PSDL_Surface; flag: SInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetSurfaceRLE' {$ENDIF} {$ENDIF};
function SDL_SetColorKey(surface: PSDL_Surface; flag: SInt32; key: UInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetColorKey' {$ENDIF} {$ENDIF};
function SDL_GetColorKey(surface: PSDL_Surface; key: PUInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetColorKey' {$ENDIF} {$ENDIF};
function SDL_SetSurfaceColorMod(surface: PSDL_Surface; r: UInt8; g: UInt8; b: UInt8): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetSurfaceColorMod' {$ENDIF} {$ENDIF};
function SDL_GetSurfaceColorMod(surface: PSDL_Surface; r: PuInt8; g: PuInt8; b: PuInt8): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetSurfaceColorMod' {$ENDIF} {$ENDIF};
function SDL_SetSurfaceAlphaMod(surface: PSDL_Surface; alpha: UInt8): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetSurfaceAlphaMod' {$ENDIF} {$ENDIF};
function SDL_GetSurfaceAlphaMod(surface: PSDL_Surface; alpha: PuInt8): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetSurfaceAlphaMod' {$ENDIF} {$ENDIF};
function SDL_SetSurfaceBlendMode(surface: PSDL_Surface; blendMode: TSDL_BlendMode): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetSurfaceBlendMode' {$ENDIF} {$ENDIF};
function SDL_GetSurfaceBlendMode(surface: PSDL_Surface; blendMode: PSDL_BlendMode): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetSurfaceBlendMode' {$ENDIF} {$ENDIF};
function SDL_SetClipRect(surface: PSDL_Surface; const rect: PSDL_Rect): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetClipRect' {$ENDIF} {$ENDIF};
procedure SDL_GetClipRect(surface: PSDL_Surface; rect: PSDL_Rect)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetClipRect' {$ENDIF} {$ENDIF};
function SDL_ConvertSurface(Src: PSDL_Surface; fmt: PSDL_PixelFormat; flags: UInt32): PSDL_Surface cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ConvertSurface' {$ENDIF} {$ENDIF};
function SDL_ConvertSurfaceFormat(Src: PSDL_Surface; pixel_format: UInt32; flags: UInt32): PSDL_Surface cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ConvertSurfaceFormat' {$ENDIF} {$ENDIF};
function SDL_ConvertPixels(width: SInt32; height: SInt32; src_format: UInt32; const Src: Pointer; src_pitch: SInt32; dst_format: UInt32; dst: Pointer; dst_pitch: SInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ConvertPixels' {$ENDIF} {$ENDIF};
function SDL_FillRect(dst: PSDL_Surface; const rect: PSDL_Rect; color: UInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_FillRect' {$ENDIF} {$ENDIF};
function SDL_FillRects(dst: PSDL_Surface; const rects: PSDL_Rect; count: SInt32; color: UInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_FillRects' {$ENDIF} {$ENDIF};
function SDL_BlitSurface(Src: PSDL_Surface; const srcrect: PSDL_Rect; dst: PSDL_Surface; dstrect: PSDL_Rect): SInt32 cdecl; external SDL_LibName name
{$IF DEFINED(DELPHI) AND DEFINED(MACOS)} '_SDL_UpperBlit' {$ELSE} 'SDL_UpperBlit' {$IFEND};
function SDL_UpperBlit(Src: PSDL_Surface; const srcrect: PSDL_Rect; dst: PSDL_Surface; dstrect: PSDL_Rect): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_UpperBlit' {$ENDIF} {$ENDIF};
function SDL_LowerBlit(Src: PSDL_Surface; srcrect: PSDL_Rect; dst: PSDL_Surface; dstrect: PSDL_Rect): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LowerBlit' {$ENDIF} {$ENDIF};
function SDL_SoftStretch(Src: PSDL_Surface; const srcrect: PSDL_Rect; dst: PSDL_Surface; const dstrect: PSDL_Surface): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SoftStretch' {$ENDIF} {$ENDIF};
function SDL_BlitSurfaceScaled(Src: PSDL_Surface; const srcrect: PSDL_Rect; dst: PSDL_Surface; dstrect: PSDL_Rect): SInt32 cdecl; external SDL_LibName name
{$IF DEFINED(DELPHI) AND DEFINED(MACOS)} '_SDL_UpperBlitScaled' {$ELSE} 'SDL_UpperBlitScaled' {$IFEND};
function SDL_UpperBlitScaled(Src: PSDL_Surface; const srcrect: PSDL_Rect; dst: PSDL_Surface; dstrect: PSDL_Rect): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_UpperBlitScaled' {$ENDIF} {$ENDIF};
function SDL_LowerBlitScaled(Src: PSDL_Surface; srcrect: PSDL_Rect; dst: PSDL_Surface; dstrect: PSDL_Rect): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_LowerBlitScaled' {$ENDIF} {$ENDIF};
{$IF DEFINED(WIN32) OR DEFINED(WIN64)}
Procedure SDL_SetWindowsMessageHook(callback: TSDL_WindowsMessageHook; userdata: Pointer); cdecl; external SDL_LibName;
Function SDL_Direct3D9GetAdapterIndex(displayIndex: SInt32): SInt32; cdecl; external SDL_LibName;
Function SDL_RenderGetD3D9Device(renderer: PSDL_Renderer): PIDirect3DDevice9; cdecl; external SDL_LibName;
function SDL_DXGIGetOutputInfo(displayIndex: SInt32; adapterIndex, outputIndex: PSInt32): TSDL_Bool; cdecl; external SDL_LibName;
{$IFEND}
{$IFDEF __WINRT__}
Function SDL_WinRTGetFSPathUNICODE(pathType: TSDL_WinRT_Path): PWideChar; cdecl; external SDL_LibName;
Function SDL_WinRTGetFSPathUTF8(pathType: TSDL_WinRT_Path): PChar; cdecl; external SDL_LibName;
{$ENDIF}
{$IFDEF WINDOWS}
{$DEFINE SDL_VIDEO_DRIVER_WINDOWS}
{$ENDIF}
{$IF DEFINED (LINUX) OR DEFINED(UNIX) AND NOT DEFINED(ANDROID)}
{$IFNDEF DARWIN}
{$DEFINE SDL_VIDEO_DRIVER_X11}
{$ENDIF}
{$IFEND}
{$IFDEF DARWIN}
{$DEFINE SDL_VIDEO_DRIVER_COCOA}
{$ENDIF}
{$IFDEF ANDROID}
{$DEFINE SDL_VIDEO_DRIVER_ANDROID}
{$ENDIF}
{$IFDEF VIVANTE}
{$DEFINE SDL_VIDEO_DRIVER_VIVANTE}
{$ENDIF}
Function SDL_GetWindowWMInfo(window: PSDL_Window; info: PSDL_SysWMinfo): TSDL_Bool; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowWMInfo' {$ENDIF} {$ENDIF};
function SDL_CreateThread(fn: TSDL_ThreadFunction; name: PAnsiChar; data: Pointer; pfnBeginThread: TpfnSDL_CurrentBeginThread; pfnEndThread: TpfnSDL_CurrentEndThread): PSDL_Thread; cdecl; overload; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateThread' {$ENDIF} {$ENDIF};
function SDL_CreateThread(fn: TSDL_ThreadFunction; name: PAnsiChar; data: Pointer): PSDL_Thread; overload;
{$ELSE}
function SDL_CreateThread(fn: TSDL_ThreadFunction; name: PAnsiChar; data: Pointer): PSDL_Thread; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateThread' {$ENDIF} {$ENDIF};
{$ENDIF}
function SDL_GetThreadName(thread: PSDL_Thread): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetThreadName' {$ENDIF}{$ENDIF};
function SDL_ThreadID: TSDL_ThreadID cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ThreadID' {$ENDIF}{$ENDIF};
function SDL_GetThreadID(thread: PSDL_Thread): TSDL_ThreadID cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetThreadID' {$ENDIF}{$ENDIF};
function SDL_SetThreadPriority(priority: TSDL_ThreadPriority): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetThreadPriority' {$ENDIF}{$ENDIF};
procedure SDL_WaitThread(thread: PSDL_Thread; status: PInt)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_WaitThread' {$ENDIF}{$ENDIF};
procedure SDL_DetachThread(thread: TSDL_Thread); cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_DetachThread' {$ENDIF}{$ENDIF};
function SDL_TLSCreate: TSDL_TLSID cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_TLSCreate' {$ENDIF} {$ENDIF};
function SDL_TLSGet(id: TSDL_TLSID): Pointer cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_TLSGet' {$ENDIF} {$ENDIF};
function SDL_TLSSet(id: TSDL_TLSID; value: Pointer; destructor_: Pointer): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_TLSSet' {$ENDIF} {$ENDIF};
function SDL_GetTicks: UInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetTicks' {$ENDIF} {$ENDIF};
function SDL_GetPerformanceCounter: UInt64 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetPerformanceCounter' {$ENDIF} {$ENDIF};
function SDL_GetPerformanceFrequency: UInt64 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetPerformanceFrequency' {$ENDIF} {$ENDIF};
procedure SDL_Delay(ms: UInt32)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_Delay' {$ENDIF} {$ENDIF};
function SDL_AddTimer(interval: UInt32; callback: TSDL_TimerCallback; param: Pointer): TSDL_TimerID cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_AddTimer' {$ENDIF} {$ENDIF};
function SDL_RemoveTimer(id: TSDL_TimerID): Boolean cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RemoveTimer' {$ENDIF} {$ENDIF};
function SDL_TICKS_PASSED(Const a, b: UInt32): Boolean;
function SDL_GetNumTouchDevices: SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetNumTouchDevices' {$ENDIF} {$ENDIF};
function SDL_GetTouchDevice(index: SInt32): TSDL_TouchID cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetTouchDevice' {$ENDIF} {$ENDIF};
function SDL_GetNumTouchFingers(touchId: TSDL_TouchID): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetNumTouchFingers' {$ENDIF} {$ENDIF};
function SDL_GetTouchFinger(touchId: TSDL_TouchID; index: SInt32): PSDL_Finger cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetTouchFinger' {$ENDIF} {$ENDIF};
procedure SDL_VERSION(Out x: TSDL_Version);
function SDL_VERSIONNUM(x, Y, Z: UInt32): Cardinal;
function SDL_COMPILEDVERSION: Cardinal;
function SDL_VERSION_ATLEAST(x, Y, Z: Cardinal): Boolean;
procedure SDL_GetVersion(ver: PSDL_Version)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetVersion' {$ENDIF} {$ENDIF};
function SDL_GetRevision: PAnsiChar cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRevision' {$ENDIF} {$ENDIF};
function SDL_GetRevisionNumber: SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetRevisionNumber' {$ENDIF} {$ENDIF};
function SDL_GetShapedWindowMode(window: PSDL_Window; shape_mode: TSDL_WindowShapeMode): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetShapedWindowMode' {$ENDIF} {$ENDIF};
function SDL_SetWindowShape(window: PSDL_Window; shape: PSDL_Surface; shape_mode: PSDL_WindowShapeMode): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowShape' {$ENDIF} {$ENDIF};
function SDL_CreateShapedWindow(title: PAnsiChar; x: UInt32; Y: UInt32; w: UInt32; h: UInt32; flags: UInt32): PSDL_Window cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateShapedWindow' {$ENDIF} {$ENDIF};
function SDL_IsShapedWindow(window: PSDL_Window): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_IsShapedWindow' {$ENDIF} {$ENDIF};
function SDL_WindowPos_IsUndefined(x: Variant): Variant;
function SDL_WindowPos_IsCentered(x: Variant): Variant;
function SDL_GetNumVideoDrivers: SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetNumVideoDrivers' {$ENDIF} {$ENDIF};
function SDL_GetVideoDriver(index: SInt32): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetVideoDriver' {$ENDIF} {$ENDIF};
function SDL_VideoInit(const driver_name: PAnsiChar): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_VideoInit' {$ENDIF} {$ENDIF};
procedure SDL_VideoQuit cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_VideoQuit' {$ENDIF} {$ENDIF};
function SDL_GetCurrentVideoDriver: PAnsiChar cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetCurrentVideoDriver' {$ENDIF} {$ENDIF};
function SDL_GetNumVideoDisplays: SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetNumVideoDisplays' {$ENDIF} {$ENDIF};
function SDL_GetDisplayName(displayIndex: SInt32): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetDisplayName' {$ENDIF} {$ENDIF};
function SDL_GetDisplayBounds(displayIndex: SInt32; rect: PSDL_Rect): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetDisplayBounds' {$ENDIF} {$ENDIF};
function SDL_GetDisplayDPI(displayIndex: SInt32; ddpi, hdpi, vdpi: PSingle): SInt32; cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetDisplayDPI' {$ENDIF} {$ENDIF};
function SDL_GetDisplayUsableBounds(displayIndex: SInt32; rect: PSDL_Rect): SInt32; cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetDisplayUsableBounds' {$ENDIF} {$ENDIF};
function SDL_GetNumDisplayModes(displayIndex: SInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetNumDisplayModes' {$ENDIF} {$ENDIF};
function SDL_GetDisplayMode(displayIndex: SInt32; modeIndex: SInt32; mode: PSDL_DisplayMode): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetDisplayMode' {$ENDIF} {$ENDIF};
function SDL_GetDesktopDisplayMode(displayIndex: SInt32; mode: PSDL_DisplayMode): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetDesktopDisplayMode' {$ENDIF} {$ENDIF};
function SDL_GetCurrentDisplayMode(displayIndex: SInt32; mode: PSDL_DisplayMode): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetCurrentDisplayIndex' {$ENDIF} {$ENDIF};
function SDL_GetClosestDisplayMode(displayIndex: SInt32; const mode: PSDL_DisplayMode; closest: PSDL_DisplayMode): PSDL_DisplayMode cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetClosestDisplayMode' {$ENDIF} {$ENDIF};
function SDL_GetWindowDisplayIndex(window: PSDL_Window): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowDisplayIndex' {$ENDIF} {$ENDIF};
function SDL_SetWindowDisplayMode(window: PSDL_Window; const mode: PSDL_DisplayMode): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowDisplayMode' {$ENDIF} {$ENDIF};
function SDL_GetWindowDisplayMode(window: PSDL_Window; mode: PSDL_DisplayMode): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowDisplayMode' {$ENDIF} {$ENDIF};
function SDL_GetWindowPixelFormat(window: PSDL_Window): UInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowPixelFormat' {$ENDIF} {$ENDIF};
function SDL_CreateWindow(const title: PAnsiChar; x: SInt32; Y: SInt32; w: SInt32; h: SInt32; flags: UInt32): PSDL_Window cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateWindow' {$ENDIF} {$ENDIF};
function SDL_CreateWindowFrom(const data: Pointer): PSDL_Window cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_CreateWindowFrom' {$ENDIF} {$ENDIF};
function SDL_GetWindowID(window: PSDL_Window): UInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowID' {$ENDIF} {$ENDIF};
function SDL_GetWindowFromID(id: UInt32): PSDL_Window cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowFromID' {$ENDIF} {$ENDIF};
function SDL_GetWindowFlags(window: PSDL_Window): UInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowFlags' {$ENDIF} {$ENDIF};
procedure SDL_SetWindowTitle(window: PSDL_Window; const title: PAnsiChar)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowTitle' {$ENDIF} {$ENDIF};
function SDL_GetWindowTitle(window: PSDL_Window): PAnsiChar cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowTitle' {$ENDIF} {$ENDIF};
procedure SDL_SetWindowIcon(window: PSDL_Window; icon: PSDL_Surface)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowIcon' {$ENDIF} {$ENDIF};
function SDL_SetWindowData(window: PSDL_Window; const name: PAnsiChar; userdata: Pointer): Pointer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowData' {$ENDIF} {$ENDIF};
function SDL_GetWindowData(window: PSDL_Window; const name: PAnsiChar): Pointer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowData' {$ENDIF} {$ENDIF};
procedure SDL_SetWindowPosition(window: PSDL_Window; x: SInt32; Y: SInt32)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowPosition' {$ENDIF} {$ENDIF};
procedure SDL_GetWindowPosition(window: PSDL_Window; x: PInt; Y: PInt)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowPosition' {$ENDIF} {$ENDIF};
procedure SDL_SetWindowSize(window: PSDL_Window; w: SInt32; h: SInt32)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowSize' {$ENDIF} {$ENDIF};
procedure SDL_GetWindowSize(window: PSDL_Window; w: PInt; h: PInt)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowSize' {$ENDIF} {$ENDIF};
function SDL_GetWindowBordersSize(window: PSDL_Window; top, left, bottom, right: PSInt32): SInt32; cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowBordersSize' {$ENDIF} {$ENDIF};
procedure SDL_SetWindowMinimumSize(window: PSDL_Window; min_w: SInt32; min_h: SInt32)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowMinimumSize' {$ENDIF} {$ENDIF};
procedure SDL_GetWindowMinimumSize(window: PSDL_Window; w: PInt; h: PInt)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowMinimumSize' {$ENDIF} {$ENDIF};
procedure SDL_SetWindowMaximumSize(window: PSDL_Window; max_w: SInt32; max_h: SInt32)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowMaximumSize' {$ENDIF} {$ENDIF};
procedure SDL_GetWindowMaximumSize(window: PSDL_Window; w: PInt; h: PInt)cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowMaximumSize' {$ENDIF} {$ENDIF};
procedure SDL_SetWindowBordered(window: PSDL_Window; bordered: TSDL_Bool)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowBordered' {$ENDIF} {$ENDIF};
procedure SDL_SetWindowResizable(window: PSDL_Window; resizable: TSDL_Bool); cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowResizable' {$ENDIF} {$ENDIF};
procedure SDL_ShowWindow(window: PSDL_Window)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_ShowWindow' {$ENDIF} {$ENDIF};
procedure SDL_HideWindow(window: PSDL_Window)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_HideWindow' {$ENDIF} {$ENDIF};
procedure SDL_RaiseWindow(window: PSDL_Window)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RaiseWindow' {$ENDIF} {$ENDIF};
procedure SDL_MaximizeWindow(window: PSDL_Window)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_MaximizeWindow' {$ENDIF} {$ENDIF};
procedure SDL_MinimizeWindow(window: PSDL_Window)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_MinimizeWindow' {$ENDIF} {$ENDIF};
procedure SDL_RestoreWindow(window: PSDL_Window)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_RestoreWindow' {$ENDIF} {$ENDIF};
function SDL_SetWindowFullscreen(window: PSDL_Window; flags: UInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowFullscreen' {$ENDIF} {$ENDIF};
function SDL_GetWindowSurface(window: PSDL_Window): PSDL_Surface cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowSurface' {$ENDIF} {$ENDIF};
function SDL_UpdateWindowSurface(window: PSDL_Window): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_UpdateWindowSurface' {$ENDIF} {$ENDIF};
function SDL_UpdateWindowSurfaceRects(window: PSDL_Window; rects: PSDL_Rect; numrects: SInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_UpdateWindowSurfaceRects' {$ENDIF} {$ENDIF};
procedure SDL_SetWindowGrab(window: PSDL_Window; grabbed: TSDL_Bool)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowGrab' {$ENDIF} {$ENDIF};
function SDL_GetWindowGrab(window: PSDL_Window): TSDL_Bool cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowGrab' {$ENDIF} {$ENDIF};
function SDL_GetGrabbedWindow(): PSDL_Window; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetGrabbedWindow' {$ENDIF} {$ENDIF};
function SDL_SetWindowBrightness(window: PSDL_Window; brightness: Float): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowBrightness' {$ENDIF} {$ENDIF};
function SDL_GetWindowBrightness(window: PSDL_Window): Float cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowBrightness' {$ENDIF} {$ENDIF};
function SDL_SetWindowOpacity(window: PSDL_Window; opacity: Float): SInt32; cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowOpacity' {$ENDIF} {$ENDIF};
function SDL_GetWindowOpacity(window: PSDL_Window; out_opacity: PFloat): SInt32; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowOpacity' {$ENDIF} {$ENDIF};
function SDL_SetWindowModalFor(modal_window, parent_window: PSDL_Window): SInt32; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowModalFor' {$ENDIF} {$ENDIF};
function SDL_SetWindowInputFocus(window: PSDL_Window): SInt32; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowInputFocus' {$ENDIF} {$ENDIF};
function SDL_SetWindowGammaRamp(window: PSDL_Window; const red: PUInt16; const green: PUInt16; const blue: PUInt16): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowGammaRamp' {$ENDIF} {$ENDIF};
function SDL_GetWindowGammaRamp(window: PSDL_Window; red: PUInt16; green: PUInt16; blue: PUInt16): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetWindowGammaRamp' {$ENDIF} {$ENDIF};
Function SDL_SetWindowHitTest(window: PSDL_Window; callback: TSDL_HitTest; callback_data: Pointer): SInt32; cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_SetWindowHitTest' {$ENDIF} {$ENDIF};
procedure SDL_DestroyWindow(window: PSDL_Window)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_DestroyWindow' {$ENDIF} {$ENDIF};
function SDL_IsScreenSaverEnabled: TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_IsScreenSaverEnabled' {$ENDIF} {$ENDIF};
procedure SDL_EnableScreenSaver cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_EnableScreenSaver' {$ENDIF} {$ENDIF};
procedure SDL_DisableScreenSaver cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_DisableScreenSaver' {$ENDIF} {$ENDIF};
function SDL_GL_LoadLibrary(const path: PAnsiChar): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_LoadLibrary' {$ENDIF} {$ENDIF};
function SDL_GL_GetProcAddress(const proc: PAnsiChar): Pointer cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_GetProcAddress' {$ENDIF} {$ENDIF};
procedure SDL_GL_UnloadLibrary cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_UnloadLibrary' {$ENDIF} {$ENDIF};
function SDL_GL_ExtensionSupported(const extension: PAnsiChar): TSDL_Bool cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_ExtensionSupported' {$ENDIF} {$ENDIF};
procedure SDL_GL_ResetAttributes(); cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_ResetAttributes' {$ENDIF} {$ENDIF};
function SDL_GL_SetAttribute(attr: TSDL_GLattr; value: SInt32): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_SetAttribute' {$ENDIF} {$ENDIF};
function SDL_GL_GetAttribute(attr: TSDL_GLattr; value: PInt): SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_GetAttribute' {$ENDIF} {$ENDIF};
function SDL_GL_CreateContext(window: PSDL_Window): TSDL_GLContext cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_CreateContext' {$ENDIF} {$ENDIF};
function SDL_GL_MakeCurrent(window: PSDL_Window; context: TSDL_GLContext): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_MakeCurrent' {$ENDIF} {$ENDIF};
function SDL_GL_GetCurrentWindow: PSDL_Window cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_GetCurrentWindow' {$ENDIF} {$ENDIF};
function SDL_GL_GetCurrentContext: TSDL_GLContext cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_GetCurrentContext' {$ENDIF} {$ENDIF};
procedure SDL_GL_GetDrawableSize(window: PSDL_Window; w: PInt; h: PInt); cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_GetDrawableSize' {$ENDIF} {$ENDIF};
function SDL_GL_SetSwapInterval(interval: SInt32): SInt32 cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_SetSwapInterval' {$ENDIF} {$ENDIF};
function SDL_GL_GetSwapInterval: SInt32 cdecl; external SDL_LibName
{$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_GetSwapInterval' {$ENDIF} {$ENDIF};
procedure SDL_GL_SwapWindow(window: PSDL_Window)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_SwapWindow' {$ENDIF} {$ENDIF};
procedure SDL_GL_DeleteContext(context: TSDL_GLContext)cdecl; external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GL_DeleteContext' {$ENDIF} {$ENDIF};
function SDL_GetCPUCount(): Integer;
cdecl external SDL_LibName {$IFDEF DELPHI} {$IFDEF MACOS} name '_SDL_GetCPUCount' {$ENDIF} {$ENDIF};

function SDL_RWsize(ctx: PSDL_RWops): SInt64; {$IFNDEF DELPHI} inline;
{$ELSE} {$IFDEF DELPHI10UP} inline;
{$ENDIF} {$ENDIF}
function SDL_RWseek(ctx: PSDL_RWops; offset: SInt64; whence: SInt32): SInt64;
{$IFNDEF DELPHI} inline; {$ELSE} {$IFDEF DELPHI10UP} inline; {$ENDIF} {$ENDIF}
function SDL_RWtell(ctx: PSDL_RWops): SInt64; {$IFNDEF DELPHI} inline;
{$ELSE} {$IFDEF DELPHI10UP} inline;
{$ENDIF} {$ENDIF}
function SDL_RWread(ctx: PSDL_RWops; ptr: Pointer; size: size_t; n: size_t): size_t; {$IFNDEF DELPHI} inline;
{$ELSE} {$IFDEF DELPHI10UP} inline;
{$ENDIF} {$ENDIF}
function SDL_RWwrite(ctx: PSDL_RWops; ptr: Pointer; size: size_t; n: size_t): size_t; {$IFNDEF DELPHI} inline;
{$ELSE} {$IFDEF DELPHI10UP} inline;
{$ENDIF} {$ENDIF}
function SDL_RWclose(ctx: PSDL_RWops): SInt32; {$IFNDEF DELPHI} inline;
{$ELSE} {$IFDEF DELPHI10UP} inline;
{$ENDIF} {$ENDIF}
function SDL_PIXELFLAG(x: Cardinal): Cardinal;
function SDL_PIXELTYPE(x: Cardinal): Cardinal;
function SDL_PIXELORDER(x: Cardinal): Cardinal;
function SDL_PIXELLAYOUT(x: Cardinal): Cardinal;
function SDL_BITSPERPIXEL(x: Cardinal): Cardinal;
function TTF_RenderText(font: PTTF_Font; text: PAnsiChar; fg, bg: TSDL_Color): PSDL_Surface;
function TTF_RenderUTF8(font: PTTF_Font; text: PAnsiChar; fg, bg: TSDL_Color): PSDL_Surface;
function TTF_RenderUNICODE(font: PTTF_Font; text: PUInt16; fg, bg: TSDL_Color): PSDL_Surface;
function SDL_AUDIO_BITSIZE(x: Cardinal): Cardinal;
function SDL_AUDIO_ISFLOAT(x: Cardinal): Cardinal;
function SDL_AUDIO_ISBIGENDIAN(x: Cardinal): Cardinal;
function SDL_AUDIO_ISSIGNED(x: Cardinal): Cardinal;
function SDL_AUDIO_ISINT(x: Cardinal): Cardinal;
function SDL_AUDIO_ISLITTLEENDIAN(x: Cardinal): Cardinal;
function SDL_AUDIO_ISUNSIGNED(x: Cardinal): Cardinal;
function TTF_SetError(const fmt: PAnsiChar): SInt32; cdecl;
function TTF_GetError: PAnsiChar; cdecl;
procedure SDLNet_SetError(const fmt: PAnsiChar); cdecl;
function SDLNet_GetError(): PAnsiChar; cdecl;
Procedure SDL_TTF_VERSION(Out x: TSDL_Version);
function Mix_SetError(const fmt: PAnsiChar): SInt32; cdecl;
function Mix_GetError: PAnsiChar; cdecl;
procedure SDL_NET_VERSION(Out x: TSDL_Version);
function Mix_LoadWAV(_file: PAnsiChar): PMix_Chunk;
procedure SDL_MIXER_VERSION(Out x: TSDL_Version);
procedure SDL_GFX_VERSION(Out x: TSDL_Version);
function IMG_SetError(fmt: PAnsiChar): SInt32; cdecl;
function IMG_GetError: PAnsiChar; cdecl;
procedure MIX_VERSION(Out x: TSDL_Version);

implementation

procedure SDL_VERSION(Out x: TSDL_Version);
begin
  x.major := SDL_MAJOR_VERSION;
  x.minor := SDL_MINOR_VERSION;
  x.patch := SDL_PATCHLEVEL;
end;

function SDL_VERSIONNUM(x, Y, Z: UInt32): Cardinal;
begin
  Result := x * 1000 + Y * 100 + Z;
end;

function SDL_COMPILEDVERSION: Cardinal;
begin
  Result := SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL);
end;

function SDL_VERSION_ATLEAST(x, Y, Z: Cardinal): Boolean;
begin
  Result := SDL_COMPILEDVERSION >= SDL_VERSIONNUM(x, Y, Z);
end;

function SDL_Button(button: SInt32): SInt32;
begin
  Result := 1 shl (button - 1);
end;
{$IFDEF WINDOWS}

function SDL_CreateThread(fn: TSDL_ThreadFunction; name: PAnsiChar; data: Pointer): PSDL_Thread; overload;
begin
  Result := SDL_CreateThread(fn, name, data, nil, nil);
end;
{$ENDIF}

function SDL_RectEmpty(const r: PSDL_Rect): Boolean;
begin
  Result := (r^.w <= 0) or (r^.h <= 0);
end;

function SDL_RectEquals(const a, b: PSDL_Rect): Boolean;
begin
  Result := (a^.x = b^.x) and (a^.Y = b^.Y) and (a^.w = b^.w) and (a^.h = b^.h);
end;

function SDL_PointInRect(const p: PSDL_Point; const r: PSDL_Rect): Boolean;
begin
  Result := (p^.x >= r^.x) and (p^.x < (r^.x + r^.w)) and (p^.Y >= r^.Y) and (p^.Y < (r^.Y + r^.h))
end;

function SDL_RWsize(ctx: PSDL_RWops): SInt64;
begin
  Result := ctx^.size(ctx);
end;

function SDL_RWseek(ctx: PSDL_RWops; offset: SInt64; whence: SInt32): SInt64;
begin
  Result := ctx^.seek(ctx, offset, whence);
end;

function SDL_RWtell(ctx: PSDL_RWops): SInt64;
begin
  Result := ctx^.seek(ctx, 0, RW_SEEK_CUR);
end;

function SDL_RWread(ctx: PSDL_RWops; ptr: Pointer; size: size_t; n: size_t): size_t;
begin
  Result := ctx^.read(ctx, ptr, size, n);
end;

function SDL_RWwrite(ctx: PSDL_RWops; ptr: Pointer; size: size_t; n: size_t): size_t;
begin
  Result := ctx^.write(ctx, ptr, size, n);
end;

function SDL_RWclose(ctx: PSDL_RWops): SInt32;
begin
  Result := ctx^.close(ctx);
end;

function SDL_LoadWAV(_file: PAnsiChar; spec: PSDL_AudioSpec; audio_buf: PPUInt8; audio_len: PUInt32): PSDL_AudioSpec;
begin
  Result := SDL_LoadWAV_RW(SDL_RWFromFile(_file, 'rb'), 1, spec, audio_buf, audio_len);
end;

function SDL_AUDIO_BITSIZE(x: Cardinal): Cardinal;
begin
  Result := x and SDL_AUDIO_MASK_BITSIZE;
end;

function SDL_AUDIO_ISFLOAT(x: Cardinal): Cardinal;
begin
  Result := x and SDL_AUDIO_MASK_DATATYPE;
end;

function SDL_AUDIO_ISBIGENDIAN(x: Cardinal): Cardinal;
begin
  Result := x and SDL_AUDIO_MASK_ENDIAN;
end;

function SDL_AUDIO_ISSIGNED(x: Cardinal): Cardinal;
begin
  Result := x and SDL_AUDIO_MASK_SIGNED;
end;

function SDL_AUDIO_ISINT(x: Cardinal): Cardinal;
begin
  Result := not SDL_AUDIO_ISFLOAT(x);
end;

function SDL_AUDIO_ISLITTLEENDIAN(x: Cardinal): Cardinal;
begin
  Result := not SDL_AUDIO_ISLITTLEENDIAN(x);
end;

function SDL_AUDIO_ISUNSIGNED(x: Cardinal): Cardinal;
begin
  Result := not SDL_AUDIO_ISSIGNED(x);
end;

function SDL_PIXELFLAG(x: Cardinal): Cardinal;
begin
  Result := (x shr 28) and $0F;
end;

function SDL_PIXELTYPE(x: Cardinal): Cardinal;
begin
  Result := (x shr 24) and $0F;
end;

function SDL_PIXELORDER(x: Cardinal): Cardinal;
begin
  Result := (x shr 20) and $0F;
end;

function SDL_PIXELLAYOUT(x: Cardinal): Cardinal;
begin
  Result := (x shr 16) and $0F;
end;

function SDL_BITSPERPIXEL(x: Cardinal): Cardinal;
begin
  Result := (x shr 8) and $FF;
end;

function SDL_IsPixelFormat_FOURCC(format: Variant): Boolean;
begin
  Result := format and SDL_PIXELFLAG(format) <> 1;
end;

function SDL_LoadBMP(_file: PAnsiChar): PSDL_Surface;
begin
  Result := SDL_LoadBMP_RW(SDL_RWFromFile(_file, 'rb'), 1);
end;

function SDL_SaveBMP(Const surface: PSDL_Surface; Const filename: AnsiString): SInt32;
begin
  Result := SDL_SaveBMP_RW(surface, SDL_RWFromFile(PAnsiChar(filename), 'wb'), 1)
end;

function SDL_MUSTLOCK(Const S: PSDL_Surface): Boolean;
begin
  Result := ((S^.flags and SDL_RLEACCEL) <> 0)
end;

function SDL_WindowPos_IsUndefined(x: Variant): Variant;
begin
  Result := (x and $FFFF0000) = SDL_WINDOWPOS_UNDEFINED_MASK;
end;

function SDL_WindowPos_IsCentered(x: Variant): Variant;
begin
  Result := (x and $FFFF0000) = SDL_WINDOWPOS_CENTERED_MASK;
end;

function SDL_GetEventState(type_: UInt32): UInt8;
begin
  Result := SDL_EventState(type_, SDL_QUERY);
end;

function SDL_TICKS_PASSED(Const a, b: UInt32): Boolean;
begin
  Result := ((Int64(b) - Int64(a)) <= 0)
end;

function SDL_GameControllerAddMappingsFromFile(Const FilePath: PAnsiChar): SInt32;
begin
  Result := SDL_GameControllerAddMappingsFromRW(SDL_RWFromFile(FilePath, 'rb'), 1)
end;

Procedure SDL_GFX_VERSION(Out x: TSDL_Version);
begin
  x.major := SDL2_GFXPRIMITIVES_MAJOR;
  x.minor := SDL2_GFXPRIMITIVES_MINOR;
  x.patch := SDL2_GFXPRIMITIVES_MICRO
end;

procedure SDL_IMAGE_VERSION(Out x: TSDL_Version);
begin
  x.major := SDL_IMAGE_MAJOR_VERSION;
  x.minor := SDL_IMAGE_MINOR_VERSION;
  x.patch := SDL_IMAGE_PATCHLEVEL;
end;

function IMG_SetError(fmt: PAnsiChar): SInt32; cdecl;
begin
  Result := SDL_SetError(fmt);
end;

function IMG_GetError: PAnsiChar; cdecl;
begin
  Result := SDL_GetError();
end;

procedure SDL_MIXER_VERSION(Out x: TSDL_Version);
begin
  x.major := SDL_MIXER_MAJOR_VERSION;
  x.minor := SDL_MIXER_MINOR_VERSION;
  x.patch := SDL_MIXER_PATCHLEVEL;
end;

procedure MIX_VERSION(Out x: TSDL_Version);
begin
  SDL_MIXER_VERSION(x);
end;

function Mix_FadeInChannel(channel: Integer; chunk: PMix_Chunk; loops: Integer; ms: Integer): Integer;
begin
  Result := Mix_FadeInChannelTimed(channel, chunk, loops, ms, -1);
end;

function Mix_PlayChannel(channel: Integer; chunk: PMix_Chunk; loops: Integer): Integer;
begin
  Result := Mix_PlayChannelTimed(channel, chunk, loops, -1);
end;

function Mix_LoadWAV(_file: PAnsiChar): PMix_Chunk;
begin
  Result := Mix_LoadWAV_RW(SDL_RWFromFile(_file, 'rb'), 1);
end;

function Mix_SetError(const fmt: PAnsiChar): SInt32; cdecl;
begin
  Result := SDL_SetError(fmt);
end;

function Mix_GetError: PAnsiChar; cdecl;
begin
  Result := SDL_GetError();
end;

procedure SDL_NET_VERSION(Out x: TSDL_Version);
begin
  x.major := SDL_NET_MAJOR_VERSION;
  x.minor := SDL_NET_MINOR_VERSION;
  x.patch := SDL_NET_PATCHLEVEL;
end;

function SDLNet_SocketReady(sock: TSDLNet_GenericSocket): Integer;
begin
  Result := sock.ready;
end;

procedure SDLNet_SetError(const fmt: PAnsiChar); cdecl;
begin
  SDL_SetError(fmt);
end;

function SDLNet_GetError(): PAnsiChar; cdecl;
begin
  Result := SDL_GetError();
end;

Procedure SDL_TTF_VERSION(Out x: TSDL_Version);
begin
  x.major := SDL_TTF_MAJOR_VERSION;
  x.minor := SDL_TTF_MINOR_VERSION;
  x.patch := SDL_TTF_PATCHLEVEL;
end;

function TTF_SetError(const fmt: PAnsiChar): SInt32; cdecl;
begin
  Result := SDL_SetError(fmt);
end;

function TTF_GetError: PAnsiChar; cdecl;
begin
  Result := SDL_GetError();
end;

function TTF_RenderText(font: PTTF_Font; text: PAnsiChar; fg, bg: TSDL_Color): PSDL_Surface;
begin
  Result := TTF_RenderText_Shaded(font, text, fg, bg);
end;

function TTF_RenderUTF8(font: PTTF_Font; text: PAnsiChar; fg, bg: TSDL_Color): PSDL_Surface;
begin
  Result := TTF_RenderUTF8_Shaded(font, text, fg, bg);
end;

function TTF_RenderUNICODE(font: PTTF_Font; text: PUInt16; fg, bg: TSDL_Color): PSDL_Surface;
begin
  Result := TTF_RenderUNICODE_Shaded(font, text, fg, bg);
end;
end;

unit ffmpeg.Common;

interface

const
  c_strFFmpegDllX64Name = 'ffx64.dll';

type
  UINT         = Cardinal;
  size_t       = Cardinal;
  unsigned     = Cardinal;
  uint32_t     = Cardinal;
  uint16_t     = ShortInt;
  Psize_t      = ^size_t;
  Int          = Integer;
  puint8_t     = PShortInt;
  pint8_t      = PByte;
  qword        = Int64;
  cint8        = ShortInt;
  pcint8       = ^cint8;
  cuint8       = Byte;
  pcuint8      = ^cuint8;
  cchar        = cint8;
  pcchar       = ^cchar;
  cschar       = cint8;
  pcschar      = ^cschar;
  cuchar       = cuint8;
  pcuchar      = ^cuchar;
  cint16       = SmallInt;
  pcint16      = ^cint16;
  ppcint16     = ^pcint16;
  cuint16      = word;
  pcuint16     = ^cuint16;
  cshort       = cint16;
  pcshort      = ^cshort;
  csshort      = cint16;
  pcsshort     = ^csshort;
  cushort      = cuint16;
  pcushort     = ^cushort;
  cint32       = LongInt;
  pcint32      = ^cint32;
  cuint32      = longword;
  pcuint32     = ^cuint32;
  cint         = cint32;
  pcint        = ^cint;
  csint        = cint32;
  pcsint       = ^csint;
  cuint        = cuint32;
  pcuint       = ^cuint;
  csigned      = cint;
  pcsigned     = ^csigned;
  cunsigned    = cuint;
  pcunsigned   = ^cunsigned;
  cint64       = Int64;
  pcint64      = ^cint64;
  cuint64      = qword;
  pcuint64     = ^cuint64;
  clonglong    = cint64;
  pclonglong   = ^clonglong;
  cslonglong   = cint64;
  pcslonglong  = ^cslonglong;
  culonglong   = cuint64;
  pculonglong  = ^culonglong;
  cbool        = LongBool;
  pcbool       = ^cbool;
  int64_t      = Int64;
  uint64_t     = UInt64;
  float        = Double;
  int32_t      = Integer;
  uint8_t      = Byte;
  ppuint8_t    = ^puint8_t;
  mfxU32       = Cardinal;
  unsigned_int = Cardinal;

{$IF defined(cpu64) and not(defined(win64) and defined(cpux86_64))}
  clong   = Int64;
  pclong  = ^clong;
  cslong  = Int64;
  pcslong = ^cslong;
  culong  = qword;
  pculong = ^culong;
{$ELSE}
  clong   = LongInt;
  pclong  = ^clong;
  cslong  = LongInt;
  pcslong = ^cslong;
  culong  = Cardinal;
  pculong = ^culong;
{$IFEND}
  cfloat       = single;
  pcfloat      = ^cfloat;
  cDouble      = Double;
  pcDouble     = ^cDouble;
  clongDouble  = extended;
  pclongDouble = ^clongDouble;

implementation

end.

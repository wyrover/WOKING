#include "config.h"
#include "stdint.h"


#pragma comment(lib,"Psapi.lib")
#pragma comment(lib,"E:\\Source\\ffmpeg\\20180425\\lib\\x64\\libavdevice.lib")
#pragma comment(lib,"E:\\Source\\ffmpeg\\20180425\\lib\\x64\\libavfilter.lib")
#pragma comment(lib,"E:\\Source\\ffmpeg\\20180425\\lib\\x64\\libavformat.lib")
#pragma comment(lib,"E:\\Source\\ffmpeg\\20180425\\lib\\x64\\libavcodec.lib")
#pragma comment(lib,"E:\\Source\\ffmpeg\\20180425\\lib\\x64\\libpostproc.lib")
#pragma comment(lib,"E:\\Source\\ffmpeg\\20180425\\lib\\x64\\libswresample.lib")
#pragma comment(lib,"E:\\Source\\ffmpeg\\20180425\\lib\\x64\\libswscale.lib")
#pragma comment(lib,"E:\\Source\\ffmpeg\\20180425\\lib\\x64\\libavutil.lib")
#pragma comment(lib,"E:\\Source\\ffmpeg\\20180425\\lib\\x64\\libmfx.lib")

char *avresample_configuration(void) 
{ 
  return *(char*)(0); 
}
 
unsigned avresample_version(void) 
{ 
  return 0; 
}

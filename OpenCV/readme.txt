01 无扩展模块动态库（MT、CUDA）版；
02 无扩展模块静态库（MT、CUDA）版；
   强制包含这些库：Winmm.lib Netapi32.lib Userenv.lib Mincore.lib F:\Green\Language\VS2015\lib\libzlib.lib F:\Green\Language\VS2015\lib\pcre2-16.lib F:\Green\Language\VS2015\lib\libharfbuzz.lib

03 有扩展模块动态库（MT、CUDA）版；


我的编译：

CPU
  1、无扩展模块：
	a)、动态库、单一DLL文件 MT		①
		1
	b)、静态库 		   	②
  2、有扩展模块：
	a)、动态库			③
	b)、静态库			④


GPU
  1、无扩展模块：
	a)、动态库			⑤
	b)、静态库			⑥
  2、有扩展模块：
	a)、动态库			⑦
	b)、静态库			⑧

1 VS2015 动态库 MT 无扩展模块 无GPU 单一DLL (单一DLL，无法编译 JAVA、MATLAB)
2 VS2015 动态库 MT       全模块 无GPU 多个DLL  (无 JAVA、MATLAB)
3 VS2015 动态库 MT       全模块 有GPU 多个DLL  (注：CUDA9.1 不支持 VS2015)

 全模块时，必须强制包含这些库：
 msvcrt.lib Winmm.lib Netapi32.lib Userenv.lib Mincore.lib F:\Green\Language\VS2015\lib\libzlib.lib F:\Green\Language\VS2015\lib\libpng.lib F:\Green\Language\VS2015\lib\pcre2-16.lib F:\Green\Language\VS2015\lib\libharfbuzz.lib

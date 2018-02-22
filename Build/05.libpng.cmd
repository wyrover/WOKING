@echo off

:: 当前目录
set CurrentCD=%~dp0

:: MSYS 的程序目录 
set "MSYS=F:\Green\Language\MSYS"
set "MSYSBIN=%MSYS%\bin"
set "IncPath=%MSYS%\local\include"
set "LibPath=%MSYS%\local\lib"
set "MINGWBIN=%MSYS%\mingw\bin"

:: 系统搜索路径
set "Path=%MSYSBIN%;%MINGWBIN%;%IncPath%;%LibPath%;%Path%"

:: libpng 源码路径
set "libpngsrc=E:\Source\05.libpng"

:: 进入源代码目录 
set "libpngDisk=%libpngsrc:~0,2%"
set "libpngPath=%libpngsrc:~3%"
cd\
%libpngDisk%
cd\
cd "%libpngPath%"

:: 编译 x64 静态库
copy /Y "%libpngsrc%\scripts\makefile.gcc" "%libpngsrc%\Makefile.gcc"
copy /Y "%CurrentCD%patch\libpng.gcc" "%libpngsrc%\Makefile.gcc"
bash -c "make -f Makefile.gcc"

:: 安装
md "%IncPath%\libpng"
copy /Y "%libpngsrc%\png.h" "%IncPath%\libpng\png.h"
copy /Y "%libpngsrc%\pngconf.h" "%IncPath%\libpng\pngconf.h"
copy /Y "%libpngsrc%\pnglibconf.h" "%IncPath%\libpng\pnglibconf.h"
copy /Y "%libpngsrc%\libpng.a" "%LibPath%\libpng.a"
copy /Y "%CurrentCD%patch\libpng.pc" "%LibPath%\pkgconfig\libpng.pc"

pause

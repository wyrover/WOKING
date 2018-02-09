::@echo off

:: 当前目录 
set "CurrentCD=%~dp0"

:: MSYS 程序路径
set "MSYSBIN=F:\Green\Language\MSYS\bin"
set "MINGWBIN=F:\Green\Language\MSYS\mingw\bin"

:: 系统搜索路径
set "Path=%MSYSBIN%;%MINGWBIN%;%Path%"

:: zlib 1.2.11 源代码路径
set "zlibsrc=E:\Source\01.zlib\1.2.11"

:: 进入源代码目录
set "zlibdisk=%zlibsrc:~0,2%"
set "zlibpath=%zlibsrc:~3%"
cd\
%zlibdisk%
cd\
cd "%zlibpath%"

:: 编译
copy /Y "%CurrentCD%patch\zlib.gcc" "%zlibsrc%\makefile.gcc"
copy /Y "%CurrentCD%patch\zlib.pc.in" "%zlibsrc%\zlib.pc.in"
bash -c "make -f Makefile.in distclean"
bash -c "make -f Makefile.gcc"

:: 安装
set INCLUDE_PATH=/usr/local/include
set LIBRARY_PATH=/usr/local/lib
set BINARY_PATH=/usr/local/bin
bash -c "make install -f Makefile.gcc"

pause

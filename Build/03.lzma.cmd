@echo off

:: 当前目录 
set "CurrentCD=%~dp0"

:: git 程序路径
set "GITBIN=D:\Tools\Git\bin"

:: MSYS 程序路径
set "MSYSBIN=F:\Green\Language\MSYS\bin"
set "MINGWBIN=F:\Green\Language\MSYS\mingw\bin"

:: MSYS2 程序路径
set "MSYS2BIN=F:\Green\Language\MSYS2\usr\bin"

:: 系统搜索路径
set "Path=%MSYS2BIN%;%Path%"

:: lzma 源代码路径
set "lzmasrc=E:\Source\03.lzma"

:: 进入源代码目录
set "lzmadisk=%lzmasrc:~0,2%"
set "lzmapath=%lzmasrc:~3%"
cd\
%lzmadisk%
cd\
cd "%lzmapath%"

:: 编译
%GITBIN%\git clean -xfd
%MSYS2BIN%\bash -c "./autogen.sh"

set "Path=%MSYSBIN%;%MINGWBIN%;%Path%"
%MSYSBIN%\bash -c "./configure --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-static --disable-shared"
%MSYSBIN%\bash -c "make -j8"
%MSYSBIN%\bash -c "make install"

pause

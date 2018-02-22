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

:: jpeg9b 源码路径
set "jpeg9bsrc=E:\Source\04.jpeg\9b"

:: 进入源代码目录 
set "jpeg9bDisk=%jpeg9bsrc:~0,2%"
set "jpeg9bPath=%jpeg9bsrc:~3%"
cd\
%jpeg9bDisk%
cd\
cd "%jpeg9bPath%"

:: 编译 x64 静态库
bash -c "make clean"
bash -c "./configure --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-static --disable-shared"
copy /Y "%CurrentCD%patch\jconfig.h" "%jpeg9bsrc%\jconfig.h"
bash -c "make -j8"
bash -c "make install"

pause

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

:: libgif 源码路径
set "libgifsrc=G:\Source\06.libgif"

:: 进入源代码目录 
set "libgifDisk=%libgifsrc:~0,2%"
set "libgifPath=%libgifsrc:~3%"
cd\
%libgifDisk%
cd\
cd "%libgifPath%"

:: 编译 x64 静态库
bash -c "make clean"
bash -c "./configure --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-static --disable-shared"
bash -c "make -j16"
bash -c "make install"

pause

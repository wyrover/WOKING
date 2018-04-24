@echo off

:: 当前目录
set CurrentCD=%~dp0

:: MSYS 的程序目录 
set "MSYS=F:\Green\Language\MSYS"
set "MSYSBIN=%MSYS%\bin"
set "IncPath=%MSYS%\local\include"
set "LibPath=%MSYS%\local\lib"
set "MINGWBIN=%MSYS%\mingw\bin"

:: libgif 源码路径
set "libgifsrc=E:\Source\06.libgif"

:: 进入源代码目录 
set "libgifDisk=%libgifsrc:~0,2%"
set "libgifPath=%libgifsrc:~3%"
cd\
%libgifDisk%
cd\
cd "%libgifPath%"

:: MSYS2 程序路径
set "MSYS2BIN=F:\Green\Language\MSYS2\usr\bin"

:: 系统搜索路径
set "Path=%MSYS2BIN%;%Path%"

:: 编译 x64 静态库
bash -c "./autogen.sh"

:: 系统搜索路径
set "Path=%MSYSBIN%;%MINGWBIN%;%IncPath%;%LibPath%;%Path%"

bash -c "make clean"
bash -c "./configure --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-static --disable-shared"
bash -c "make -j8"
bash -c "make install"

pause

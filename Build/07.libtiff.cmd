@echo off

:: 当前目录
set CurrentCD=%~dp0

:: MSYS 的程序目录 
set "MSYS=F:\Green\Language\MSYS"
set "MSYSBIN=%MSYS%\bin"

set "IncPath=%MSYS%\local\include"
set "IncPath=%IncPath:\=/%"

set "LibPath=%MSYS%\local\lib"
set "LibPath=%LibPath:\=/%"

set "MINGWBIN=%MSYS%\mingw\bin"

:: 系统搜索路径
set "Path=%MSYSBIN%;%MINGWBIN%;%Path%"

:: libtiff 源码路径
set "libtiffsrc=E:\Source\07.libtiff"

:: 进入源代码目录 
set "libtiffDisk=%libtiffsrc:~0,2%"
set "libtiffPath=%libtiffsrc:~3%"
cd\
%libtiffDisk%
cd\
cd "%libtiffPath%"

:: 编译 x64 静态库
bash -c "make clean"
bash -c "./configure --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-static --disable-shared --with-zlib-include-dir=%IncPath% --with-zlib-lib-dir=%LibPath% --with-jpeg-include-dir=%IncPath% --with-jpeg-lib-dir=%LibPath% --with-lzma-include-dir=%IncPath% --with-lzma-lib-dir=%LibPath%"
bash -c "make -j8"
bash -c "make install"

pause

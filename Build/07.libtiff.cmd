@echo off

:: ��ǰĿ¼
set CurrentCD=%~dp0

:: MSYS �ĳ���Ŀ¼ 
set "MSYS=F:\Green\Language\MSYS"
set "MSYSBIN=%MSYS%\bin"

set "IncPath=%MSYS%\local\include"
set "IncPath=%IncPath:\=/%"

set "LibPath=%MSYS%\local\lib"
set "LibPath=%LibPath:\=/%"

set "MINGWBIN=%MSYS%\mingw\bin"

:: ϵͳ����·��
set "Path=%MSYSBIN%;%MINGWBIN%;%Path%"

:: libtiff Դ��·��
set "libtiffsrc=G:\Source\07.tiff-4.0.9"

:: ����Դ����Ŀ¼ 
set "libtiffDisk=%libtiffsrc:~0,2%"
set "libtiffPath=%libtiffsrc:~3%"
cd\
%libtiffDisk%
cd\
cd "%libtiffPath%"

:: ���� x64 ��̬��
bash -c "make clean"
bash -c "./configure --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-static --disable-shared --with-zlib-include-dir=%IncPath% --with-zlib-lib-dir=%LibPath% --with-jpeg-include-dir=%IncPath% --with-jpeg-lib-dir=%LibPath% --with-lzma-include-dir=%IncPath% --with-lzma-lib-dir=%LibPath%"
bash -c "make -j16"
bash -c "make install"

pause

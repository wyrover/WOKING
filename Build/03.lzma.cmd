@echo off

:: ��ǰĿ¼ 
set "CurrentCD=%~dp0"

:: git ����·��
set "GITBIN=D:\Tools\Git\bin"

:: MSYS ����·��
set "MSYSBIN=F:\Green\Language\MSYS\bin"
set "MINGWBIN=F:\Green\Language\MSYS\mingw\bin"

:: MSYS2 ����·��
set "MSYS2BIN=F:\Green\Language\MSYS2\usr\bin"

:: ϵͳ����·��
set "Path=%MSYS2BIN%;%Path%"

:: lzma Դ����·��
set "lzmasrc=E:\Source\03.lzma"

:: ����Դ����Ŀ¼
set "lzmadisk=%lzmasrc:~0,2%"
set "lzmapath=%lzmasrc:~3%"
cd\
%lzmadisk%
cd\
cd "%lzmapath%"

:: ����
%GITBIN%\git clean -xfd
%MSYS2BIN%\bash -c "./autogen.sh"

set "Path=%MSYSBIN%;%MINGWBIN%;%Path%"
%MSYSBIN%\bash -c "./configure --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-static --disable-shared"
%MSYSBIN%\bash -c "make -j8"
%MSYSBIN%\bash -c "make install"

pause

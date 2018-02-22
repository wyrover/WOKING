@echo off

:: ��ǰĿ¼
set CurrentCD=%~dp0

:: MSYS �ĳ���Ŀ¼ 
set "MSYS=F:\Green\Language\MSYS"
set "MSYSBIN=%MSYS%\bin"
set "IncPath=%MSYS%\local\include"
set "LibPath=%MSYS%\local\lib"
set "MINGWBIN=%MSYS%\mingw\bin"

:: ϵͳ����·��
set "Path=%MSYSBIN%;%MINGWBIN%;%IncPath%;%LibPath%;%Path%"

:: jpeg9b Դ��·��
set "jpeg9bsrc=E:\Source\04.jpeg\9b"

:: ����Դ����Ŀ¼ 
set "jpeg9bDisk=%jpeg9bsrc:~0,2%"
set "jpeg9bPath=%jpeg9bsrc:~3%"
cd\
%jpeg9bDisk%
cd\
cd "%jpeg9bPath%"

:: ���� x64 ��̬��
bash -c "make clean"
bash -c "./configure --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-static --disable-shared"
copy /Y "%CurrentCD%patch\jconfig.h" "%jpeg9bsrc%\jconfig.h"
bash -c "make -j8"
bash -c "make install"

pause

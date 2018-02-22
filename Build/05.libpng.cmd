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

:: libpng Դ��·��
set "libpngsrc=E:\Source\05.libpng"

:: ����Դ����Ŀ¼ 
set "libpngDisk=%libpngsrc:~0,2%"
set "libpngPath=%libpngsrc:~3%"
cd\
%libpngDisk%
cd\
cd "%libpngPath%"

:: ���� x64 ��̬��
copy /Y "%libpngsrc%\scripts\makefile.gcc" "%libpngsrc%\Makefile.gcc"
copy /Y "%CurrentCD%patch\libpng.gcc" "%libpngsrc%\Makefile.gcc"
bash -c "make -f Makefile.gcc"

:: ��װ
md "%IncPath%\libpng"
copy /Y "%libpngsrc%\png.h" "%IncPath%\libpng\png.h"
copy /Y "%libpngsrc%\pngconf.h" "%IncPath%\libpng\pngconf.h"
copy /Y "%libpngsrc%\pnglibconf.h" "%IncPath%\libpng\pnglibconf.h"
copy /Y "%libpngsrc%\libpng.a" "%LibPath%\libpng.a"
copy /Y "%CurrentCD%patch\libpng.pc" "%LibPath%\pkgconfig\libpng.pc"

pause

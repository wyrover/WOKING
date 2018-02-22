::@echo off

:: ��ǰĿ¼ 
set "CurrentCD=%~dp0"

:: MSYS ����·��
set "MSYSBIN=F:\Green\Language\MSYS\bin"
set "MINGWBIN=F:\Green\Language\MSYS\mingw\bin"

:: ϵͳ����·��
set "Path=%MSYSBIN%;%MINGWBIN%;%Path%"

:: zlib 1.2.11 Դ����·��
set "zlibsrc=E:\Source\01.zlib\1.2.11"

:: ����Դ����Ŀ¼
set "zlibdisk=%zlibsrc:~0,2%"
set "zlibpath=%zlibsrc:~3%"
cd\
%zlibdisk%
cd\
cd "%zlibpath%"

:: ����
copy /Y "%CurrentCD%patch\zlib.gcc" "%zlibsrc%\makefile.gcc"
copy /Y "%CurrentCD%patch\zlib.pc.in" "%zlibsrc%\zlib.pc.in"
bash -c "make -f Makefile.in distclean"
bash -c "make -f Makefile.gcc"

:: ��װ
set INCLUDE_PATH=/usr/local/include
set LIBRARY_PATH=/usr/local/lib
set BINARY_PATH=/usr/local/bin
bash -c "make install -f Makefile.gcc"

pause

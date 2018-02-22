@echo off

:: ��ǰĿ¼
set CurrentCD=%~dp0

:: MSYS �ĳ���Ŀ¼ 
set "MSYS=F:\Green\Language\MSYS"
set "MSYSBIN=%MSYS%\bin"
set "IncPath=%MSYS%\local\include"
set "LibPath=%MSYS%\local\lib"
set "MINGWBIN=%MSYS%\mingw\bin"

:: libgif Դ��·��
set "libgifsrc=E:\Source\06.libgif"

:: ����Դ����Ŀ¼ 
set "libgifDisk=%libgifsrc:~0,2%"
set "libgifPath=%libgifsrc:~3%"
cd\
%libgifDisk%
cd\
cd "%libgifPath%"

:: MSYS2 ����·��
set "MSYS2BIN=F:\Green\Language\MSYS2\usr\bin"

:: ϵͳ����·��
set "Path=%MSYS2BIN%;%Path%"

:: ���� x64 ��̬��
bash -c "./autogen.sh"

:: ϵͳ����·��
set "Path=%MSYSBIN%;%MINGWBIN%;%IncPath%;%LibPath%;%Path%"

bash -c "make clean"
bash -c "./configure --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-static --disable-shared"
bash -c "make -j8"
bash -c "make install"

pause

@echo off

:: ��ǰĿ¼ 
set "CurrentCD=%~dp0"

:: MSYS ����·��
set "MSYSBIN=F:\Green\Language\MSYS\bin"
set "MINGWBIN=F:\Green\Language\MSYS\mingw\bin"

:: ϵͳ����·��
set "Path=%MSYSBIN%;%MINGWBIN%;%Path%"

:: bzip2 Դ����·��
set "bzip2src=E:\Source\02.bzip2"

:: ����Դ����Ŀ¼
set "bzip2disk=%bzip2src:~0,2%"
set "bzip2path=%bzip2src:~3%"
cd\
%bzip2disk%
cd\
cd "%bzip2path%"

:: ����
copy /Y "%CurrentCD%patch\bzip2.mk" "%bzip2src%\makefile"
bash -c "make"
bash -c "make install"

pause

@echo off

:: 当前目录 
set "CurrentCD=%~dp0"

:: MSYS 程序路径
set "MSYSBIN=F:\Green\Language\MSYS\bin"
set "MINGWBIN=F:\Green\Language\MSYS\mingw\bin"

:: 系统搜索路径
set "Path=%MSYSBIN%;%MINGWBIN%;%Path%"

:: bzip2 源代码路径
set "bzip2src=E:\Source\02.bzip2"

:: 进入源代码目录
set "bzip2disk=%bzip2src:~0,2%"
set "bzip2path=%bzip2src:~3%"
cd\
%bzip2disk%
cd\
cd "%bzip2path%"

:: 编译
copy /Y "%CurrentCD%patch\bzip2.mk" "%bzip2src%\makefile"
bash -c "make"
bash -c "make install"

pause

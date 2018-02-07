:: MSYS 程序路径
set "MSYSBIN=F:\Green\Language\MSYS\bin"
set "MINGWBIN=F:\Green\Language\MSYS\mingw\bin"
set "Path=%MSYSBIN%;%MINGWBIN%;%Path%"

:: libiconv 源代码路径
set "libiconvsrc=G:\Source\libiconv-1.15"
set "libiconvsrcDisk=%libiconvsrc:~0,2%
set "libiconvsrcPath=%libiconvsrc:~3%

:: 进入源代码目录
cd\
%libiconvsrcDisk%
cd\
cd "%libiconvsrcPath%"

bash -c "make clean"
bash -c "./configure --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-static --disable-shared"
bash -c "make -j16"
bash -c "make install"

pause

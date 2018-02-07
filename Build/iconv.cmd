:: MSYS ����·��
set "MSYSBIN=F:\Green\Language\MSYS\bin"
set "MINGWBIN=F:\Green\Language\MSYS\mingw\bin"
set "Path=%MSYSBIN%;%MINGWBIN%;%Path%"

:: libiconv Դ����·��
set "libiconvsrc=G:\Source\libiconv-1.15"
set "libiconvsrcDisk=%libiconvsrc:~0,2%
set "libiconvsrcPath=%libiconvsrc:~3%

:: ����Դ����Ŀ¼
cd\
%libiconvsrcDisk%
cd\
cd "%libiconvsrcPath%"

bash -c "make clean"
bash -c "./configure --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --enable-static --disable-shared"
bash -c "make -j16"
bash -c "make install"

pause

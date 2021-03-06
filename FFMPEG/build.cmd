@ECHO OFF
color 2F
Cls
Title VS2015 编译 X64位静态MT FFMPEG 

:: 设置 当前目录
set "CurrentCD=%~dp0"

:: 设置 ffmpeg 源代码目录
set "FFmpegSource=E:\Source\ffmpeg\GIT"

:: 设置 MSYS 的位置
set "MSYS=F:\Green\Language\MSYS\bin"

:: 设置 GIT 的位置
set "GIT=F:\Green\Language\GIT\Git\bin"

:: 设置 PKG_CONFIG.EXE 的位置
set "PKG_CONFIG=F:\Green\Language\CMake\3.11.1\bin"

:: 设置 PKG_CONFIG_PATH 位置 
set "PKG_CONFIG_PATH=F:\Green\Language\MSYS2\mingw64\lib\pkgconfig"

:: 设置 CUDA9.0 SDK 的位置
set "CudaInc=F:\Green\Language\NVIDIA\CUDA9.1\SDK\include"
set "CudaLib=F:\Green\Language\NVIDIA\CUDA9.1\SDK\lib\x64"
set "CudaBin=F:\Green\Language\NVIDIA\CUDA9.1\SDK\bin"

:: 设置 VS2015 环境变量，添加第三方的头文件、库文件搜索路径
call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64
set "include=%CurrentCD%Install\include;%CurrentCD%Install\include\libxml2;E:\Source\ffmpeg\20180702\include;E:\Source\ffmpeg\20180702\include\SDL;E:\Source\ffmpeg\20180702\include\openjpeg-2.3;%CudaInc%;%include%"
set "lib=%CurrentCD%Install\lib;%CudaLib%;E:\Source\ffmpeg\20180702\lib;E:\Source\gtk\zb\gtk01\gtk\x64\release\lib;%lib%"

:: 设置 系统搜索路径
set "Path=%MSYS%;%GIT%;%PKG_CONFIG%;%PKG_CONFIG_PATH%;%CudaBin%;%Path%"

:: 设置 安装目录 <注意系统日期应该修改为 - 格式(例如：2017-12-12)，不能是 \ 格式(2017\12\12),因为 \ 是目录路径，不是目录名称>
set "TempInstallPath=%CurrentCD%%date%\static"
set "InstallPath=%TempInstallPath:\=/%"

:: 切换到 ffmpeg 源代码目录。先切换到根目录，再进入子目录
set "TempFFmpegSourceDisk=%FFmpegSource%"
set "FFmpegSourceDisk=%TempFFmpegSourceDisk:~0,2%"
%FFmpegSourceDisk%
cd %FFmpegSource%

:: VS2015 静态编译 x64 版本
git clean -xdf
bash -c "make clean"
bash -c "./configure --enable-gpl --enable-version3 --enable-nonfree --enable-avisynth --enable-fontconfig --enable-gmp --enable-gnutls --enable-libass --enable-libbluray --enable-libcdio --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libilbc --enable-libmfx --enable-libmodplug --enable-libmp3lame --enable-libopenh264 --enable-libopenjpeg --enable-libopus --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --enable-libxml2 --enable-libxvid --enable-opengl --disable-schannel --toolchain=msvc --prefix=%InstallPath% --extra-cflags='-DMODPLUG_STATIC -DLIBSSH_STATIC -DOPJ_STATIC' --extra-libs='User32.lib Advapi32.lib shell32.lib dinput8.lib dxguid.lib gdi32.lib winmm.lib imm32.lib ole32.lib oleaut32.lib version.lib uuid.lib openjp2.lib'"

:: 暂停一下，查看是否有错误，如果有，打开 ffmpeg 源代码目录 ffbuild\config.log 查看错误
pause

:: 根据自己的机器的线程数修改 -j8。如果你的机器是8核16线程，修改为 "make -j16"。极大提高编译速度。
bash -c "make -j16"

:: 安装，本目录下，以今天的日期为目录
bash -c "make install"

pause

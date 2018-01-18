@ECHO OFF
color 2F
Cls
Title VS2015 编译 X64位静态MT FFMPEG 

:: 设置 当前目录
set "CurrentCD=%~dp0"

:: 设置 ffmpeg 源代码目录
set "FFmpegSource=E:\Source\ffmpeg\src"

:: 设置 MSYS 的位置
set "MSYS=F:\Green\Language\MSYS\bin"

:: 设置 GIT 的位置
set "GIT=D:\Tools\Git\bin"

:: 设置 PKG_CONFIG.EXE 的位置
set "PKG_CONFIG=%CurrentCD%PKG"

:: 设置 PKG_CONFIG_PATH 位置 
set "PKG_CONFIG_PATH=%CurrentCD%Install\pkgpc"

:: 修改所有 PC 文件第一行的路径
set "InstallPC=%CurrentCD%Install"
set "PCFirstTe=%InstallPC:\=/%"
set "StrValue=prefix=%PCFirstTe%"
for /r %PKG_CONFIG_PATH% %%i in (*.pc) do (
  for /f "tokens=1* delims=:" %%j in ('Type %%i^|Findstr /n ".*"') do (
    If "%%j"=="1" (
    echo %StrValue%>tmp.txt
    ) else (
    echo %%k>>tmp.txt
    )
  )
  move /y tmp.txt %%i
)

:: 设置 CUDA9.0 SDK 的位置
set "CudaInc=D:\Language\NVIDIA\CUDA9.0\SDK\include"
set "CudaLib=D:\Language\NVIDIA\CUDA9.0\SDK\lib\x64"
set "CudaBin=D:\Language\NVIDIA\CUDA9.0\SDK\bin"

:: 设置 VS2015 环境变量，添加第三方的头文件、库文件搜索路径
call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64
set "include=%CurrentCD%Install\include;%CurrentCD%Install\include\libxml2;%CudaInc%;%include%"
set "lib=%CurrentCD%Install\lib;%CudaLib%;%lib%"

:: 设置 系统搜索路径
set "Path=%MSYS%;%GIT%;%PKG_CONFIG%;%PKG_CONFIG_PATH%;%CudaBin%;%Path%"

:: 设置 安装目录 <注意系统日期应该修改为 - 格式(例如：2017-12-12)，不能是 \ 格式(2017\12\12),因为 \ 是目录路径，不是目录名称>
set "TempInstallPath=%CurrentCD%ffmpeg\%date%"
set "InstallPath=%TempInstallPath:\=/%"

:: 切换到 ffmpeg 源代码目录。先切换到根目录，再进入子目录
set "TempFFmpegSourceDisk=%FFmpegSource%"
set "FFmpegSourceDisk=%TempFFmpegSourceDisk:~0,2%"
%FFmpegSourceDisk%
cd %FFmpegSource%

:: VS2015 静态编译 x64 版本
git clean -xdf
bash -c "make clean"
bash -c "./configure --arch=x86_64 --enable-gpl --enable-version3 --enable-static --enable-nonfree --enable-avisynth --enable-libmp3lame --enable-libvorbis --enable-libspeex --enable-libopus --enable-libilbc --enable-libtheora --enable-libx264 --enable-libx265 --enable-libxvid --enable-libvpx --enable-libgme --enable-libfdk-aac --enable-libfribidi --enable-libfreetype --enable-libxml2 --enable-libfontconfig --enable-libass --enable-libopenh264 --enable-libwebp --enable-opengl --enable-libmfx --enable-cuda-sdk --toolchain=msvc --prefix=%InstallPath%"
::                                  --enable-gpl --enable-version3                                  --enable-avisynth --enable-libmp3lame --enable-libvorbis --enable-libspeex --enable-libopus --enable-libilbc --enable-libtheora --enable-libx264 --enable-libx265 --enable-libxvid --enable-libvpx --enable-libgme --enable-libmodplug --enable-libsoxr --enable-libfreetype --enable-fontconfig --enable-libfribidi --enable-libass --enable-libxml2 --enable-gnutls --disable-schannel --enable-gmp --enable-libssh --enable-libcdio --enable-libbluray --enable-opengl --enable-libmfx --toolchain=msvc"

:: 暂停一下，查看是否有错误，如果有，打开 ffmpeg 源代码目录 ffbuild\config.log 查看错误
pause

:: 根据自己的机器的线程数修改 -j8。如果你的机器是8核16线程，修改为 "make -j16"。极大提高编译速度。
bash -c "make -j8"

:: 安装，本目录下，以今天的日期为目录
bash -c "make install"

pause

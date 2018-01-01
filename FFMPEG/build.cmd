@ECHO OFF
color 2F
Cls
Title VS2015 ���� X64λ��̬MT FFMPEG 

:: ���� ��ǰĿ¼
set "CurrentCD=%~dp0"

:: ���� ffmpeg Դ����Ŀ¼
set "FFmpegSource=E:\source\ffmpeg\src"

:: ���� MSYS ��λ��
set "MSYS=F:\Green\Language\MSYS\bin"

:: ���� GIT ��λ��
set "GIT=D:\Tools\Git\bin"

:: ���� PKG_CONFIG.EXE ��λ��
set "PKG_CONFIG=E:\Working\PKG\pkgconfig"

:: ���� PKG_CONFIG_PATH λ�� 
set "PKG_CONFIG_PATH=E:\Working\PKG"

:: ���� CUDA9.0 SDK ��λ��
set "CudaInc=D:\Language\NVIDIA\CUDA9.0\SDK\include"
set "CudaLib=D:\Language\NVIDIA\CUDA9.0\SDK\lib\x64"
set "CudaBin=D:\Language\NVIDIA\CUDA9.0\SDK\bin"

:: ���� ��װĿ¼ <ע��ϵͳ����Ӧ���޸�Ϊ - ��ʽ(���磺2017-12-12)�������� \ ��ʽ(2017\12\12),��Ϊ \ ��Ŀ¼·��������Ŀ¼����>
set "TempInstallPath=%CurrentCD%%date%"
set "InstallPath=%TempInstallPath:\=/%"

:: ���� VS2015 ��������
call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64

:: ��ӵ�������ͷ�ļ������ļ�����·��
set "include=%PKG_CONFIG_PATH%\include;%PKG_CONFIG_PATH%\include\libxml2;%CudaInc%;%include%"
set "lib=%PKG_CONFIG_PATH%\lib;%CudaLib%;%lib%"

:: ���� ϵͳ����·��
set "Path=%MSYS%;%GIT%;%PKG_CONFIG%;%PKG_CONFIG_PATH%;%CudaBin%;%Path%"

:: �л��� ffmpeg Դ����Ŀ¼�����л�����Ŀ¼���ٽ�����Ŀ¼
set "TempFFmpegSourceDisk=%FFmpegSource%"
set "FFmpegSourceDisk=%TempFFmpegSourceDisk:~0,2%"
%FFmpegSourceDisk%
cd %FFmpegSource%

:: VS2015 ��̬���� x64 �汾
git clean -xdf
bash -c "make clean"
bash -c "./configure --arch=x86_64 --enable-static --enable-gpl --enable-version3 --enable-nonfree --enable-avisynth --enable-libgme --enable-libfdk-aac --enable-libilbc --enable-libmp3lame --enable-libfribidi --enable-libfreetype --enable-libxml2 --enable-libfontconfig --enable-libass --enable-libvorbis --enable-libtheora --enable-libopenh264 --enable-libx264 --enable-libx265 --enable-libxvid --enable-libwebp --enable-libmfx --enable-cuda-sdk --toolchain=msvc --prefix=%InstallPath%"

:: ��ͣһ�£��鿴�Ƿ��д�������У��� ffmpeg Դ����Ŀ¼ ffbuild\config.log �鿴����
pause

:: �����Լ��Ļ������߳����޸� -j8�������Ļ�����8��16�̣߳��޸�Ϊ "make -j16"��������߱����ٶȡ�
bash -c "make -j8"

:: ��װ����Ŀ¼�£��Խ��������ΪĿ¼
bash -c "make install"

pause

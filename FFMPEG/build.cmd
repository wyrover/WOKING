@ECHO OFF
color 2F
Cls
Title �� VS2015 ��̬����X64λ ffmpeg 

:: ���� ��ǰĿ¼
set "CurrentCD=%~dp0"

:: ���� ffmpeg Դ����Ŀ¼
set "FFmpegSource=E:\source\ffmpeg\src"

:: ���� MSYS ��λ��
set "MSYS=F:\Green\Language\MSYS\bin"

:: ���� PKG_CONFIG.EXE ��λ�ã��Լ� PKG_CONFIG_PATH λ�� 
set "PKG_CONFIG_PROC=%CurrentCD%PKG\PKGCONFIG"
set "PKG_CONFIG_PATH=%CurrentCD%PKG"

:: ���� ϵͳ����·��
set "Path=%MSYS%;%PKG_CONFIG_PROC%;%Path%"

:: ���� ��װĿ¼ <ע��ϵͳ����Ӧ���޸�Ϊ - ��ʽ(���磺2017-12-12)�������� \ ��ʽ(2017\12\12),��Ϊ \ ��Ŀ¼·��������Ŀ¼����>
set "TempInstallPath=%CurrentCD%%date%"
set "InstallPath=%TempInstallPath:\=/%"

:: ���� VS2015 ��������
call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64

:: ��ӵ�������ͷ�ļ������ļ�����·��
set "CudaInc=D:\Language\NVIDIA\CUDA9.0\SDK\include"
set "CudaLib=D:\Language\NVIDIA\CUDA9.0\SDK\lib\x64"

set "include=%CurrentCD%pkg\include;%CudaInc%;%CurrentCD%pkg\include\libxml2;%include%"
set "lib=%CurrentCD%pkg\lib;%CudaLib%;%lib%"

:: �л��� ffmpeg Դ����Ŀ¼�����л�����Ŀ¼���ٽ�����Ŀ¼
set "TempFFmpegSourceDisk=%FFmpegSource%"
set "FFmpegSourceDisk=%TempFFmpegSourceDisk:~0,2%"
%FFmpegSourceDisk%
cd %FFmpegSource%

:: VS2015 ��̬���� x64 �汾
git clean -xdf
bash -c "make clean"
bash -c "./configure --arch=x86_64 --enable-static --enable-gpl --enable-version3 --enable-nonfree --enable-libgme --enable-libfdk-aac --enable-libilbc --enable-libmp3lame --enable-libfribidi --enable-libfreetype --enable-libxml2 --enable-libfontconfig --enable-libass --enable-libvorbis --enable-libtheora --enable-libopenh264 --enable-libx264 --enable-libx265 --enable-libxvid --enable-libwebp --enable-libmfx --enable-cuda-sdk --toolchain=msvc --prefix=%InstallPath%"

:: ��ͣһ�£��鿴�Ƿ��д�������У��� ffmpeg Դ����Ŀ¼ ffbuild\config.log �鿴����
pause

:: �����Լ��Ļ������߳����޸� -j8�������Ļ�����8��16�̣߳��޸�Ϊ "make -j16"��������߱����ٶȡ�
bash -c "make -j8"

:: ��װ����Ŀ¼�£��Խ��������ΪĿ¼
bash -c "make install"

pause

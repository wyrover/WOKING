@ECHO OFF
color 2F
Cls
Title �� VS2015 ��̬����X64λ ffmpeg 

:: ���� ��ǰĿ¼
set "CurrentCD=%~dp0"

:: ���� ffmpeg Դ����Ŀ¼
set "FFmpegSource=E:\source\05.ffmpeg\src"

:: ���� MSYS ��λ��
set "MSYS=F:\Green\Language\MSYS\bin"

:: ���� PKG_CONFIG.EXE ��λ�ã��Լ� PKG_CONFIG_PATH λ�� 
set "PKG_CONFIG_PATH=%CurrentCD%PKG"
set "PKG_CONFIG_PROC=%PKG_CONFIG_PATH%\PKGCONFIG"

:: ���� CUDASDK ��λ��
set "CudaInc=%Cuda_Path%\include"
set "CudaLib=%Cuda_Path%\lib\x64"
set "CudaBin=%Cuda_Path%\bin"

:: ���� ϵͳ����·��
set "Path=%MSYS%;%PKG_CONFIG_PROC%;%CudaBin%;%Path%"

:: ���� ��װĿ¼ <ע��ϵͳ����Ӧ���޸�Ϊ - ��ʽ(���磺2017-12-12)�������� \ ��ʽ(2017\12\12),��Ϊ \ ��Ŀ¼·��������Ŀ¼����>
set "TempInstallPath=%CurrentCD%%date%"
set "InstallPath=%TempInstallPath:\=/%"

:: ���� VS2015 ��������
call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64

:: ��ӵ�������ͷ�ļ������ļ�����·��
set "include=%CurrentCD%PKG\include;%CurrentCD%PKG\include\libxml2;%CudaInc%;%include%"
set "lib=%CurrentCD%pkg\lib;%CudaLib%;%lib%"

:: �л��� ffmpeg Դ����Ŀ¼�����л�����Ŀ¼���ٽ�����Ŀ¼
set "TempFFmpegSourceDisk=%FFmpegSource%"
set "FFmpegSourceDisk=%TempFFmpegSourceDisk:~0,2%"
%FFmpegSourceDisk%
cd %FFmpegSource%

:: VS2015 ��̬���� x64 �汾
git clean -xdf
bash -c "make clean"
bash -c "./configure --arch=x86_64 --enable-static --enable-gpl --enable-version3 --enable-nonfree --enable-gnutls --enable-gmp --enable-libgme --enable-libfdk-aac --enable-libilbc --enable-libmp3lame --enable-libfribidi --enable-libfreetype --enable-libxml2 --enable-libfontconfig --enable-libass --enable-libvorbis --enable-libtheora --enable-libopenh264 --enable-libx264 --enable-libx265 --enable-libxvid --enable-libwebp --enable-libmfx --enable-cuda-sdk --toolchain=msvc --prefix=%InstallPath%"

:: ��ͣһ�£��鿴�Ƿ��д�������У��� ffmpeg Դ����Ŀ¼ ffbuild\config.log �鿴����
pause

:: �����Լ��Ļ������߳����޸� -j8�������Ļ�����8��16�̣߳��޸�Ϊ "make -j16"��������߱����ٶȡ�
bash -c "make -j16"

:: ��װ����Ŀ¼�£��Խ��������ΪĿ¼
bash -c "make install"

pause

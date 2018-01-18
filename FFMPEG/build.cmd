@ECHO OFF
color 2F
Cls
Title VS2015 ���� X64λ��̬MT FFMPEG 

:: ���� ��ǰĿ¼
set "CurrentCD=%~dp0"

:: ���� ffmpeg Դ����Ŀ¼
set "FFmpegSource=E:\Source\ffmpeg\src"

:: ���� MSYS ��λ��
set "MSYS=F:\Green\Language\MSYS\bin"

:: ���� GIT ��λ��
set "GIT=D:\Tools\Git\bin"

:: ���� PKG_CONFIG.EXE ��λ��
set "PKG_CONFIG=%CurrentCD%PKG"

:: ���� PKG_CONFIG_PATH λ�� 
set "PKG_CONFIG_PATH=%CurrentCD%Install\pkgpc"

:: �޸����� PC �ļ���һ�е�·��
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

:: ���� CUDA9.0 SDK ��λ��
set "CudaInc=D:\Language\NVIDIA\CUDA9.0\SDK\include"
set "CudaLib=D:\Language\NVIDIA\CUDA9.0\SDK\lib\x64"
set "CudaBin=D:\Language\NVIDIA\CUDA9.0\SDK\bin"

:: ���� VS2015 ������������ӵ�������ͷ�ļ������ļ�����·��
call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64
set "include=%CurrentCD%Install\include;%CurrentCD%Install\include\libxml2;%CudaInc%;%include%"
set "lib=%CurrentCD%Install\lib;%CudaLib%;%lib%"

:: ���� ϵͳ����·��
set "Path=%MSYS%;%GIT%;%PKG_CONFIG%;%PKG_CONFIG_PATH%;%CudaBin%;%Path%"

:: ���� ��װĿ¼ <ע��ϵͳ����Ӧ���޸�Ϊ - ��ʽ(���磺2017-12-12)�������� \ ��ʽ(2017\12\12),��Ϊ \ ��Ŀ¼·��������Ŀ¼����>
set "TempInstallPath=%CurrentCD%ffmpeg\%date%"
set "InstallPath=%TempInstallPath:\=/%"

:: �л��� ffmpeg Դ����Ŀ¼�����л�����Ŀ¼���ٽ�����Ŀ¼
set "TempFFmpegSourceDisk=%FFmpegSource%"
set "FFmpegSourceDisk=%TempFFmpegSourceDisk:~0,2%"
%FFmpegSourceDisk%
cd %FFmpegSource%

:: VS2015 ��̬���� x64 �汾
git clean -xdf
bash -c "make clean"
bash -c "./configure --arch=x86_64 --enable-gpl --enable-version3 --enable-static --enable-nonfree --enable-avisynth --enable-libmp3lame --enable-libvorbis --enable-libspeex --enable-libopus --enable-libilbc --enable-libtheora --enable-libx264 --enable-libx265 --enable-libxvid --enable-libvpx --enable-libgme --enable-libfdk-aac --enable-libfribidi --enable-libfreetype --enable-libxml2 --enable-libfontconfig --enable-libass --enable-libopenh264 --enable-libwebp --enable-opengl --enable-libmfx --enable-cuda-sdk --toolchain=msvc --prefix=%InstallPath%"
::                                  --enable-gpl --enable-version3                                  --enable-avisynth --enable-libmp3lame --enable-libvorbis --enable-libspeex --enable-libopus --enable-libilbc --enable-libtheora --enable-libx264 --enable-libx265 --enable-libxvid --enable-libvpx --enable-libgme --enable-libmodplug --enable-libsoxr --enable-libfreetype --enable-fontconfig --enable-libfribidi --enable-libass --enable-libxml2 --enable-gnutls --disable-schannel --enable-gmp --enable-libssh --enable-libcdio --enable-libbluray --enable-opengl --enable-libmfx --toolchain=msvc"

:: ��ͣһ�£��鿴�Ƿ��д�������У��� ffmpeg Դ����Ŀ¼ ffbuild\config.log �鿴����
pause

:: �����Լ��Ļ������߳����޸� -j8�������Ļ�����8��16�̣߳��޸�Ϊ "make -j16"��������߱����ٶȡ�
bash -c "make -j8"

:: ��װ����Ŀ¼�£��Խ��������ΪĿ¼
bash -c "make install"

pause

:: ----------------------------------------------
:: QT Source ver 5.11.1 Դ������� VS2015 X64 Static MT
:: ----------------------------------------------

:: QT Դ����Ŀ¼
set "QTSource_Path=E:\Source\QT\5.11.1"

:: QT ͷ�ļ������ļ��ȣ���װĿ¼ 
set "QTInstallPath=F:\Green\Language\VS2015\WIN7X64\QT"

:: ����Դ����Ŀ¼ 
set "QTSRCDisk=%QTSource_Path:~0,2%
set "QTSRCPath=%QTSource_Path:~3%
cd\
%QTSRCDisk%
cd\
cd "%QTSRCPath%"

:: ���� VS2015 �������� (X64 ����)
call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64

:: ���ñ���ѡ��
configure -confirm-license -opensource -platform win32-msvc -mp -debug-and-release -static -prefix "%QTInstallPath%" -nomake examples  -nomake tests

:: ����(ע������Ҳ������ nmake���������ٶȽ���)
jom

:: ��װ(ע������Ҳ������ nmake install���������Ӧ)
jom install

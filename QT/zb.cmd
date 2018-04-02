:: ----------------------------------------------
:: QT Source ver 5.10.1 源代码编译 VS2015 X64 Static MT
:: ----------------------------------------------

:: QT 源代码目录
set "QTSource_Path=G:\Source\QT\5.10.1"

:: QT 头文件、库文件等，安装目录 
set "QTInstallPath=F:\Green\Language\QT"

:: 进入源代码目录 
set "QTSRCDisk=%QTSource_Path:~0,2%
set "QTSRCPath=%QTSource_Path:~3%
cd\
%QTSRCDisk%
cd\
cd "%QTSRCPath%"

:: 设置 VS2015 环境变量 (X64)
call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64

:: 配置编译选项
configure -confirm-license -opensource -platform win32-msvc -mp -debug-and-release -static -prefix "%QTInstallPath%" -nomake examples  -nomake tests

:: 编译(注：这里也可以用 nmake，但编译速度较慢)
jom

:: 安装(注：这里也可以用 nmake install，和上面对应)
jom install

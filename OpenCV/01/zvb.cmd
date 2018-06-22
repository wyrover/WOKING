@echo off
@setlocal enableextensions enabledelayedexpansion

:: 设置系统搜索路径
@set "CurrentCD=%~dp0"
@set sPath=
@for /f "tokens=*" %%I in (%CurrentCD%zvs.txt) do (set "sPath=!sPath!;%%I")
set Path=%sPath%;%Path%

:: 设置系统环境变量
set "INTELMEDIASDKROOT=E:\Green\Language\Intel\MSDK2017"
set "Python27=E:\Green\Language\Python\2.7"


cmake ^
  -DBUILD_DOCS=False ^
  -DBUILD_EXAMPLES=TRUE ^
  -DBUILD_opencv_matlab=TRUE ^
  -DBUILD_opencv_python2=TRUE ^
  -DBUILD_opencv_python3=TRUE ^
  -DBUILD_shared_libs=TRUE ^
  -DBUILD_opencv_world=TRUE ^
  -DCMAKE_CONFIGURATION_TYPES=Debug;Release ^
  -DCMAKE_CXX_FLAGS="/DWIN32 /D_WINDOWS /W3 /GR /EHsc /wd4819" ^
  -DCMAKE_CXX_FLAGS_DEBUG="/MTd /Zi /Ob0 /Od /RTC1" ^
  -DCMAKE_CXX_FLAGS_RELEASE="/MT /O2 /Ob2 /DNDEBUG" ^
  -DCMAKE_C_FLAGS="/DWIN32 /D_WINDOWS /W3 /wd4819" ^
  -DCMAKE_C_FLAGS_DEBUG="/MTd /Zi /Ob0 /Od /RTC1" ^
  -DCMAKE_C_FLAGS_RELEASE="/MT /O2 /Ob2 /DNDEBUG" ^
  -DCMAKE_VERBOSE_MAKEFILE=TRUE ^
  -DINSTALL_CREATE_DISTRIB=TRUE ^
  -DINSTALL_C_EXAMPLES=TRUE ^
  -DINSTALL_PYTHON_EXAMPLES=TRUE ^
  -DINSTALL_TESTS=TRUE ^
  -DMKL_WITH_OPENMP=TRUE ^
  -DMKL_WITH_TBB=TRUE ^
  -DTINYDNN_USE_OMP=TRUE ^
  -DTINYDNN_USE_TBB=TRUE ^
  -DCUDA_FAST_MATH=TRUE ^
  -DCUDA_VERBOSE_BUILD=TRUE ^
  -DENABLE_CCACHE=TRUE ^
  -DENABLE_CXX11=TRUE ^
  -DOPENCV_ENABLE_NONFREE=TRUE ^
  -DPYTHON2_EXECUTABLE=%Python27%\python.exe ^
  -DPYTHON2_INCLUDE_DIR=%Python27%\include ^
  -DPYTHON2_LIBRARY_DEBUG=%Python27%\libs\python27_d.lib ^
  -DPYTHON2_NUMPY_INCLUDE_DIRS=%Python27%\lib\site-packages\numpy\core\include ^
  -DPYTHON2_PACKAGES_PATH=%Python27%\Lib\site-packages ^
  -DWITH_CUDA=False ^
  -DWITH_TBB=TRUE ^
  -DWITH_QT=TRUE ^
  -DWITH_OPENNI2=False ^
  -DWITH_OPENGL=TRUE ^
  -DWITH_OPENMP=TRUE ^
  -DWITH_MFX=TRUE ^
  -DWITH_MSMF=TRUE ^
  -DWITH_GSTREAMER_0_10=False ^
  -DWITH_GSTREAMER=False ^
  -DWITH_OPENCL_SVM=TRUE ^
  -DWITH_VTK=False ^
  -G "Visual Studio 14 2015 Win64" D:\Source\OpenCV\src
CMake .
CMake --build . --config Release --target install
pause

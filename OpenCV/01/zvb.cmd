@echo off
@setlocal enableextensions enabledelayedexpansion

:: 设置系统搜索路径
set "CurrentCD=%~dp0"
@set sPath=
@for /f "tokens=*" %%I in (%CurrentCD%zvs.txt) do (set "sPath=!sPath!;%%I")
set Path=%sPath%;%Path%

:: 设置系统环境变量
set PKG_CONFIG_PATH=E:\Green\Language\VS2015\lib\pkgconfig
set INTELMEDIASDKROOT=F:\Green\Language\Intel\MSDK2018\Intel(R) Media SDK 2018 R1\Software Development Kit
set BOOST_ROOT=F:\Green\Language\boost\1_65
set BOOST_LIBRARYDIR=F:\Green\Language\boost\1_65\lib64-msvc-14.0

cmake ^
  -DBUILD_DOCS=TRUE ^
  -DBUILD_EXAMPLES=TRUE ^
  -DBUILD_opencv_matlab=TRUE ^
  -DBUILD_opencv_python2=TRUE ^
  -DBUILD_opencv_python3=TRUE ^
  -DBUILD_shared_libs=TRUE ^
  -DBUILD_opencv_world=TRUE ^
  -DCMAKE_CXX_FLAGS_DEBUG="/MTd /Zi /Ob0 /Od /RTC1" ^
  -DCMAKE_CXX_FLAGS_RELEASE="/MT /O2 /Ob2 /DNDEBUG" ^
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
  -DCaffe_DIR=F:/Green/Language/Caffe/01/share/Caffe ^
  -DCaffe_INCLUDE_DIR=F:/Green/Language/Caffe/01/include ^
  -DCaffe_LIBS=F:/Green/Language/Caffe/01/lib/caffe.lib ^
  -Dgflags_DIR=F:/Green/Language/VS2015/lib/cmake/gflags ^
  -DHDF5_C_LIBRARY=F:/Green/Language/VS2015/lib/libhdf5.lib ^
  -DHDF5_INCLUDE_DIRS=F:/Green/Language/VS2015/include/hdf5 ^
  -DOGRE_DIR=F:/Green/Language/OGRE3D/CMake ^
  -DLept_LIBRARY=F:/Green/Language/VS2015/lib/leptonica-1.76.0.lib ^
  -DTesseract_INCLUDE_DIR=F:/Green/Language/VS2015/include ^
  -DTesseract_LIBRARY=F:/Green/Language/VS2015/lib/tesseract40.lib ^
  -Dopencv_dnn_PERF_CAFFE=TRUE ^
  -Dopencv_dnn_PERF_CLCAFFE=TRUE ^
  -DOPENCV_EXTRA_MODULES_PATH=E:/Source/OpenCV/opencv_contrib/modules ^
  -G "Visual Studio 14 2015 Win64" E:\Source\OpenCV\src
CMake .
pause

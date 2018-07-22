:: Usage
:: >..\caffe-win-dependency\build_caffe.cmd <Root directory in full path>/caffe-win-dependency/_install

@echo off

:: Setting
set "CMAKE_GENERATOR=Visual Studio 14 2015 Win64"
set "DEPEND_DIR=D:/Source/AI/caffe-win-dependency/_vs2015"
set "HDF5_ROOT=%DEPEND_DIR%"


:: Configuration
cmake ../../caffe ^
    -G"%CMAKE_GENERATOR%" ^
    -DCMAKE_INSTALL_PREFIX=_install ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_SHARED_LIBS=OFF ^
    -DBUILD_STATIC_CRT_LIBS=ON ^
    -DCPU_ONLY=ON ^
    -DCUDA_ARCH_NAME=Pascal ^
    -DBLAS=Open ^
    -DBUILD_python=ON ^
    -DBUILD_python_layer=ON ^
    -Dpython_version=3 ^
    -DBUILD_matlab=ON ^
    -DCOPY_PREREQUISITES=OFF ^
    -DINSTALL_PREREQUISITES=OFF ^
    -DUSE_NCCL=OFF ^
    -DUSE_LMDB=ON ^
    -DUSE_LEVELDB=ON ^
    -DUSE_OPENCV=OFF ^
    -DUSE_OPENMP=OFF ^
    -DGLOG_LIBRARY=%DEPEND_DIR%/lib/glog.lib ^
    -DGLOG_INCLUDE_DIR=%DEPEND_DIR%/include/glog ^
    -DGLOG_ROOT_DIR=%DEPEND_DIR% ^
    -Dglog_DIR=%DEPEND_DIR%/lib/cmake/glog ^
    -Dgflags_DIR=%DEPEND_DIR%/lib/cmake/gflags ^
    -DGFLAGS_INCLUDE_DIR=%DEPEND_DIR%/include/gflags ^
    -DGFLAGS_ROOT_DIR=%DEPEND_DIR% ^
    -DProtobuf_DIR=%DEPEND_DIR%/cmake ^
    -DLMDB_DIR=%DEPEND_DIR% ^
    -DOpenBLAS_INCLUDE_DIR=%DEPEND_DIR%/include ^
    -DOpenBLAS_LIB=%DEPEND_DIR%/lib/libopenblas.lib ^
    -DHDF5_DIR=%DEPEND_DIR%/cmake ^
    -DHDF5_USE_STATIC_LIBRARIES=ON ^
    -DLEVELDB_ROOT=%DEPEND_DIR% ^
    -DSNAPPY_ROOT_DIR=%DEPEND_DIR% ^
    -DBOOST_ROOT=%DEPEND_DIR% ^
    -DBoost_USE_STATIC_LIBS=ON ^
    -DBoost_USE_STATIC_RUNTIME=ON

:: Build
cmake --build . --config Release --target install
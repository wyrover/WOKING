@echo off
set "CurrentCD=%~dp0"

set "CMake_Path=F:\Green\Language\CMake\3.10.2\x64\bin"
set "Nasm__Path=F:\Green\Language\CMake\3.10.2\x64\bin"
set "Yasm__Path=F:\Green\Language\CMake\3.10.2\x64\bin"
set "ninja_Path=F:\Green\Language\CMake\3.10.2\x64\bin"
set "nuget_Path=F:\Green\Language\CMake\3.10.2\x64\bin"
set "pkgcofPath=F:\Green\Language\CMake\3.10.2\x64\bin"
set "meson_Path=F:\Green\Language\Meson"
set "Perl__Path=F:\Green\Language\Perl\bin"
set "PythonPath=F:\Green\Language\Python\3.6.3"
set "msys2_Path=F:\Green\Language\MSYS2\usr\bin"

set "Path=%CMake_Path%;%Nasm__Path%;%Yasm__Path%;%ninja_Path%;%nuget_Path%;%pkgcofPath%;%meson_Path%;%Perl__Path%;%PythonPath%;%msys2_Path%;%Path%

python %CurrentCD%build.py build -p x64 -c release --build-dir "G:\Source\gtk\gvsbuild\gtk"  --msys-dir "F:\Green\Language\MSYS2" --vs-ver 14 --vs-install-path "D:\Language\VS2015" --python-dir "F:\Green\Language\Python\3.6.3" gtk3

pause

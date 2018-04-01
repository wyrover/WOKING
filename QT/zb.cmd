call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64
configure -confirm-license -opensource -platform win32-msvc2015 -mp -debug-and-release -static -prefix ".\build" -nomake examples  -nomake tests
pause

jom
nmake install

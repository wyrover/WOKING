@echo off

:: 01 设置工具、源代码放置目录；由于源代码体积较大，编译也会占用很大空间，所以应找一个空余空间较多的磁盘来放置源代码。磁盘剩余空间最好不少于100G
set "CurrentCD=%~dp0"
set "CurrentCDDisk=%CurrentCD:~0,2%"
set "CurrentCDPath=%CurrentCD:~3%"
cd\
%CurrentCDDisk%
cd\
cd "%CurrentCDPath%"
set "dept_tools_path=%CurrentCD%dept_tools"
set "chromiumsrcpath=%CurrentCD%chromium"
set "git_cmdexe_path=F:\Green\Language\GIT\Git\cmd"

:: 02 设置系统代理
set httpProxyIP=127.0.0.1
set httpProxyPort=1080
netsh winhttp set proxy http://%httpProxyIP%:%httpProxyPort%
@echo [Boto]>%CurrentCD%boto.cfg
@echo proxy=http://%httpProxyIP%>>%CurrentCD%boto.cfg
@echo proxy_port=%httpProxyPort%>>%CurrentCD%boto.cfg
set NO_AUTH_BOTO_CONFIG=%CurrentCD%boto.cfg
set http_proxy=%httpProxyIP%:%httpProxyPort%
set https_proxy=%httpProxyIP%:%httpProxyPort%

:: 03 设置系统环境变量
set DEPOT_TOOLS_WIN_TOOLCHAIN = 0
set GYP_MSVS_VERSION = 2017
set GYP_MSVS_OVERRIDE_PATH = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise"
set Path=C:\Windows\System32\WindowsPowerShell\v1.0\;%git_cmdexe_path%;%dept_tools_path%

:: 04 下载 depot_tools
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git %dept_tools_path%
gclient

:: 05 下载 chromium 源代码
md %chromiumsrcpath%
cd %chromiumsrcpath%
fetch chromium
gclient sync 

:: 06 用 ninja  编译 chromium < 较快 >
gn gen out/Default --args="is_component_build = false is_debug = false"

:: 06 用 VS2017 编译 chromium < 较慢 >
gn gen out/VS2017 --args="is_component_build = false is_debug = false" --ide=vs

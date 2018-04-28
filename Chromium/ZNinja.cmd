set http_proxy=http://127.0.0.1:1080
set https_proxy=http://127.0.0.1:1080
set NO_AUTH_BOTO_CONFIG=E:\Source\chromium\boto.cfg

set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set GYP_MSVS_VERSION=2017
set GYP_MSVS_OVERRIDE_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise

:: 06 用 ninja  编译 chromium < 较快 >  
gn gen zout/Default --args="is_component_build = false is_debug = false"
ninja -C zout/Default chrome

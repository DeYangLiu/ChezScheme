# 准备

## vc
离线版本：
vs2015 http://download.microsoft.com/download/B/8/F/B8F1470D-2396-4E7A-83F5-AC09154EB925/vs2015.ent_chs.iso
在线安装：
https://www.visualstudio.com


## msys && mingw
离线旧版本：git for windows 自带了msys；make 可以选TDM GCC的。
在线安装： https://nchc.dl.sourceforge.net/project/mingw-w64/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/installer/mingw-w64-install.exe



# 下载和配置windows amd 64 多线程版本
git clone --depth 1 https://github.com/cisco/ChezScheme ChezScheme-git

msys>
./configure --threads -m=ta6nt
会自动下载依赖包，生成Makefile

# 编译
vs2015 x64 本机工具命令提示符>
cd ta6nt\c
make

# 运行
..\bin\ta6nt\scheme.exe

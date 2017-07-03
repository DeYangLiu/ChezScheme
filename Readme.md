# 准备
vs2015 http://download.microsoft.com/download/B/8/F/B8F1470D-2396-4E7A-83F5-AC09154EB925/vs2015.ent_chs.iso

git for windows 自带了msys。

make 可以选TDM GCC的


# 下载和配置windows amd 64 多线程版本
git clone https://github.com/cisco/ChezScheme ChezScheme-git

msys>
./configure --threads -m=ta6nt
会自动下载依赖包，生成Makefile

# 编译
vs2015 x64 本机工具命令提示符>
cd ta6nt\c
make

# 运行
..\bin\ta6nt\scheme.exe

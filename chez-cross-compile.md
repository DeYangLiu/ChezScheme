# download upstream source
git clone --depth 1 https://github.com/cisco/ChezScheme

# build mingw target on win7 host


## build host
msys>
 ./configure -m=ti3nt #first config will clone dependencies from github.com.

to support windows xp,
append /SUBSYSTEM:CONSOLE,5.01 to EXELDFLAGS in ti3nt/c/Makefile.ti3nt.

cmd>
 cd ti3nt\c
 .\make.bat

## patch
merge the contents of  patch-for-mingw directory.

## update host boot to include modification from patch.
msys>
 (cd ti3nt; make -f Mf-boot ti3nt.boot)


## build target boot
 mkdir boot/ti3mw
 (cd ti3nt; make -f Mf-boot ti3mw.boot) #create new boot files
 

## build target with the target c compiler
./configure -m=ti3mw
make

# build arm target on linux host

## build host
./configure
make


## build target boot
mkdir boot/arm32le
(cd a6le; make -f Mf-boot arm32le.boot)

## build target
./configure -m=arm32le CFLAGS="-O2 -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard"
make

# ref
https://programmingpraxis.com/2017/09/15/compile-chez-scheme-on-android-arm/

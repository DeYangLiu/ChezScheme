# download upstream source
git clone --depth 1 https://github.com/cisco/ChezScheme

# build mingw target on win7 host


## patch
merge the contents of  patch-for-mingw directory.

## build host
msys>
 ./configure -m=ti3nt

to support windows xp,
append /SUBSYSTEM:CONSOLE,5.01 to EXELDFLAGS in ti3nt/c/Makefile.i3nt.

cmd>
 cd ta6nt\c
 .\make.bat


## update host boot to include modification from patch.
msys>
 (cd ta6nt; make -f Mf-boot ta6nt.boot)


## build target boot
 mkdir boot/ti3mw
 (cd ta6nt; make -f Mf-boot ti3mw.boot) #create new boot files
 

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

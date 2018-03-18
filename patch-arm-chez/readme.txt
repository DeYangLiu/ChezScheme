## features
the **Chez Scheme for Android** is full blown. features includes: hard floating-points, REPL, load scripts, ...


## build sumary
```
git clone --depth 1 https://github.com/cisco/ChezScheme ChezScheme-upstream
git submodule init && git submodule update

cp -raf ChezScheme-upstream Chez

cd Chez

./configure -m=ta6le
make


mkdir boot/tarm32le
(cd ta6le; make -f Mf-boot tarm32le.boot)


./configure -m=tarm32le
cp -rf ../patch-arm-chez/* .

(cd tarm32le/c; for i in $(cd ../../c; echo *); do ln -s ../../c/$i $i; done)

cd tarm32le
ndk-build NDK_PROJECT_PATH=. NDK_APPLICATION_MK=./Application.mk
cp libs/armeabi-v7a/scheme bin/tarm32le/
ndk-build NDK_PROJECT_PATH=. NDK_APPLICATION_MK=./Application.mk clean
```
now we have bin/tarm32le/scheme and boot/tarm32le/*.boot
put them into the target machine, they will run:

```
 ./scheme -b ./petite.boot -b ./scheme.boot  

```

## update the boot files  (optional)
need do this if s/*.ss files are changed or 
will using native scheme be better?
on the target machine, you need make-for-android.

```
cd ..
edit s/Mf-base to change "cmp -s" to "cmp"
tar -cf ../chez-arm.tar boot examples  mats nanopass  s tarm32le unicode

adb push chez-arm.tar /data/
adb shell
 mkdir chez-arm && cd chez-arm
 busybox tar -xf ../chez-arm.tar

 (cd tarm32le/s;  make bootstrap)
 
```


## troublesomes
more troublesoumes and porting problems,
please ref the porting note [notes.txt].




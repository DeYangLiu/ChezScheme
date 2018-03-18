LOCAL_PATH:= $(call my-dir)

arm_config := -O2 -march=armv7-a -mfloat-abi=hard -mfpu=vfpv3-d16 -mhard-float -D_NDK_MATH_NO_SOFTFP=1 -DARMV6  -DUSE_MMAP

include $(CLEAR_VARS)


# measurements show that the ARM version of ZLib is about x1.17 faster than the thumb one...
LOCAL_ARM_MODE := arm

zlib_files := adler32.c compress.c  crc32.c deflate.c gzclose.c gzlib.c \
 gzread.c gzwrite.c infback.c inflate.c inftrees.c inffast.c trees.c \
 uncompr.c zutil.c


LOCAL_MODULE := libchez-z
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += $(arm_config)
LOCAL_CFLAGS += -pie -fPIE


LOCAL_SRC_FILES := $(zlib_files)



include $(BUILD_STATIC_LIBRARY)


include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_MODULE := libchez-z-shared
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += $(arm_config)
LOCAL_CFLAGS += -pie -fPIE
LOCAL_LDFLAGS += -pie -fPIE

LOCAL_SRC_FILES := $(zlib_files)

# include $(BUILD_SHARED_LIBRARY)

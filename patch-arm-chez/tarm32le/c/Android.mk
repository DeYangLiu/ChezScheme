LOCAL_PATH := $(call my-dir)

chez_config := -DANDROID -DSIGQUIT
arm_config := -O2 -march=armv7-a -mfloat-abi=hard -mfpu=vfpv3-d16 -mhard-float -D_NDK_MATH_NO_SOFTFP=1 -DARMV6

chez_cflags := $(chez_config) $(arm_config) -Wpointer-arith -Wextra  -Wno-implicit-fallthrough
chez_c_src := statics.c segment.c alloc.c symbol.c intern.c gcwrapper.c gc-ocd.c gc-oce.c \
 number.c schsig.c io.c new-io.c print.c fasl.c stats.c foreign.c prim.c prim5.c flushcache.c \
 schlib.c thread.c expeditor.c scheme.c \
 arm32le.c

################################## libchez.a
include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm

LOCAL_MODULE := libchez

LOCAL_SRC_FILES := $(chez_c_src)


$(info ===local-path: $(LOCAL_PATH)==)

chez_src_dir := $(LOCAL_PATH)/../../c
chez_src_dst := $(LOCAL_PATH)

# not working by some ndk, pls link rootsrc by hand
#rootsrc := $(shell cd $(chez_src_dir); echo *)

#$(info ==rootsrc: $(rootsrc)==)


${rootsrc}:
	@ [ -e $(chez_src_dst)/$@ ] || ln -s $(chez_src_dir)/$@ $(chez_src_dst)/$@ 

$(LOCAL_MODULE) : ${rootsrc}

LOCAL_CFLAGS := $(chez_cflags)
LOCAL_CFLAGS += -pie -fPIE

LOCAL_C_INCLUDES += $(LOCAL_PATH)/../boot/tarm32le $(LOCAL_PATH)/../zlib

include $(BUILD_STATIC_LIBRARY)



#################################### scheme executable
include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm
LOCAL_MODULE := scheme
LOCAL_SRC_FILES := main.c

LOCAL_CFLAGS := $(chez_cflags)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../boot/tarm32le 

LOCAL_CFLAGS += -pie -fPIE
LOCAL_LDFLAGS += -pie -fPIE
LOCAL_LDFLAGS += -lm_hard

LOCAL_STATIC_LIBRARIES := libchez libchez-z

TARGET_GLOBAL_LDFLAGS := -ldl #-lm #-lrt #-lncurses

include $(BUILD_EXECUTABLE)  


#################################### libchez-shared.so
include $(CLEAR_VARS)
LOCAL_ARM_MODE := arm

LOCAL_MODULE := libchez-shared

LOCAL_SRC_FILES := $(chez_c_src)


chez_src_dir := $(LOCAL_PATH)/../../c
chez_src_dst := $(LOCAL_PATH)

rootsrc := $(shell cd $(chez_src_dir); echo *)


#${rootsrc}:
#	@ [ -e $(chez_src_dst)/$@ ] || ln -s $(chez_src_dir)/$@ $(chez_src_dst)/$@ 

$(LOCAL_MODULE) : ${rootsrc}

LOCAL_CFLAGS := $(chez_cflags)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../boot/tarm32le $(LOCAL_PATH)/../zlib
LOCAL_CFLAGS += -pie -fPIE
LOCAL_LDFLAGS += -pie -fPIE


# LOCAL_LDLIBS += -lm -ldl  -lrt #-lncurses

LOCAL_SHARED_LIBRARIES := libchez-z-shared libdl

# include $(BUILD_SHARED_LIBRARY)

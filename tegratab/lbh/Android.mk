#
# Copyright (c) 2013 NVIDIA Corporation.  All rights reserved.
#

LOCAL_PATH:= $(call my-dir)

include $(LOCAL_PATH)/lbh_np.mk
include $(LOCAL_PATH)/lbh_nb.mk
ifeq ($(TARGET_PRODUCT),kalamata)
include $(LOCAL_PATH)/lbh_gp_kalamata.mk
else
include $(LOCAL_PATH)/lbh_gp.mk
endif
include $(LOCAL_PATH)/lbh_gb.mk
include $(LOCAL_PATH)/lbh_gen_tool.mk

nv_lbh_modules := \
    lbh_np_image \
    lbh_nb_image \
    lbh_gp_image \
    lbh_gb_image \
    lbh_gen_tool

include $(CLEAR_VARS)
LOCAL_MODULE := lbh_images
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := $(nv_lbh_modules)
include $(BUILD_PHONY_PACKAGE)

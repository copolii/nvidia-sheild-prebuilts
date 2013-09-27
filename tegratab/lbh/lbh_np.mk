#
# Copyright (c) 2013 NVIDIA Corporation.  All rights reserved.
#

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
include $(NVIDIA_DEFAULTS)

#------------------------------------------------
# Check LBH partition size in your flash.cfg
# sample size: 256MB
#------------------------------------------------
NP_LBHIMAGE_PARTITION_SIZE := 268435456

#------------------------------------------------
# Define CM/LBH ID (hexadecimal 4 characters)
# CM_ID for TegraTab is 0x0000
# LBH_ID for TegraTab is
# 0x0001 : Non-GMS/Premium
#------------------------------------------------
NP_CM_ID := 0000
NP_LBH_ID := 0001
NP_LBH_CLASS := 0001

#------------------------------------------------
# Set locale (Non-GMS/Premium)
#------------------------------------------------
NP_LBH_DEFAULT_LANGUAGE := zh
NP_LBH_DEFAULT_REGION := CN

#------------------------------------------------
# Environment setting (Non-GMS/Premium)
#------------------------------------------------
NP_PRODUCT_MODEL := TegraNote-Premium
NP_LBH_TAG := lbh_np
NP_LBHIMAGE_FILENAME := $(PRODUCT_OUT)/$(NP_LBH_TAG).img
NP_TARGET_OUT_LBH := $(PRODUCT_OUT)/$(NP_LBH_TAG)
NP_TARGET_OUT_LBH_ETC := $(NP_TARGET_OUT_LBH)/etc
NP_TARGET_OUT_LBH_PERM := $(NP_TARGET_OUT_LBH_ETC)/permissions
NP_LBHIMAGE_MOUNT_POINT := lbh
NP_LBHIMAGE_EXT_VARIANT := ext4

#------------------------------------------------
# Camera information (Non-GMS/Premium)
# if there is no sensor, set GUID to ""
#------------------------------------------------
NP_CAMERA_REAR_SENSOR_GUID := s_OV5693
NP_CAMERA_FRONT_SENSOR_GUID := s_OV7695
NP_CAMERA_FOCUSER_GUID := f_AD5823
NP_CAMERA_FLASHLIGHT_GUID :=
# Camera config file
NP_CAMERA_CONFIG_VERSION := 1
# Facing, Angle, Stereo/Mono
NP_CAMERA_REAR_CONFIG := camera0=/dev/ov5693,back,0,mono
NP_CAMERA_FRONT_CONFIG := camera1=/dev/ov7695,front,0,mono
NP_CAMERA_FRONT_ONLY_CONFIG := camera0=/dev/ov7695,front,0,mono

#------------------------------------------------
# Create default properties for LBH (Non-GMS/Premium)
#------------------------------------------------
NP_LBH_BUILD_PROP_TARGET := $(NP_TARGET_OUT_LBH)/default.prop
$(NP_LBH_BUILD_PROP_TARGET): $(LOCAL_PATH)/lbh.prop
	$(hide) mkdir -p $(NP_TARGET_OUT_LBH)
	$(hide) echo "ro.nvidia.cm_id=$(NP_CM_ID)" > $@
	$(hide) echo "ro.nvidia.lbh_id=$(NP_LBH_ID)" >> $@
	$(hide) echo "ro.nvidia.lbh_class=$(NP_LBH_CLASS)" >> $@
	$(hide) echo "ro.product.locale.language=$(NP_LBH_DEFAULT_LANGUAGE)" >> $@
	$(hide) echo "ro.product.locale.region=$(NP_LBH_DEFAULT_REGION)" >> $@
	$(hide) echo "ro.nvidia.hw.fcam=$(NP_CAMERA_FRONT_SENSOR_GUID)" >> $@
	$(hide) echo "ro.nvidia.hw.rcam=$(NP_CAMERA_REAR_SENSOR_GUID)" >> $@
	$(hide) echo "ro.nvidia.hw.flash=$(NP_CAMERA_FLASHLIGHT_GUID)" >> $@
	$(hide) echo "ro.nvidia.hw.focuser=$(NP_CAMERA_FOCUSER_GUID)" >> $@
	$(hide) if [ -f $(LOCAL_PATH)/lbh.prop ]; then \
	            cat $(LOCAL_PATH)/lbh.prop >> $@; \
	        fi

#------------------------------------------------
# Create camera config (Non-GMS/Premium)
#------------------------------------------------
NP_LBH_CAM_CONF_TARGET := $(NP_TARGET_OUT_LBH_ETC)/nvcamera.conf
$(NP_LBH_CAM_CONF_TARGET):
	$(hide) mkdir -p $(NP_TARGET_OUT_LBH_ETC)
	$(hide) echo "version=$(NP_CAMERA_CONFIG_VERSION)" > $@
ifneq ($(NP_CAMERA_REAR_SENSOR_GUID),)
	$(hide) echo $(NP_CAMERA_REAR_CONFIG) >> $@
ifneq ($(NP_CAMERA_FRONT_SENSOR_GUID),)
	$(hide) echo $(NP_CAMERA_FRONT_CONFIG) >> $@
endif
else
ifneq ($(NP_CAMERA_FRONT_SENSOR_GUID),)
	$(hide) echo $(NP_CAMERA_FRONT_ONLY_CONFIG) >> $@
endif
endif

#------------------------------------------------
# Define files to be copyied to LBH (Non-GMS/Premium)
# FIXME: we should define files to be copied
#------------------------------------------------
NP_LBH_COPY_FILES := \
    vendor/nvidia/tegra/tegratab/partition-data/media/bootanimation-800x450x15.zip:$(NP_LBH_TAG)/media/bootanimation.zip \
    vendor/nvidia/tegra/tegratab/partition-data/media/images/.nomedia:$(NP_LBH_TAG)/media/images/.nomedia \
    vendor/nvidia/tegra/tegratab/partition-data/media/images/tegratab_7in_1454x1280_12.jpg:$(NP_LBH_TAG)/media/images/default_wallpaper.jpg \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.usb.accessory.xml

ifneq ($(NP_CAMERA_FRONT_SENSOR_GUID),)
NP_LBH_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.camera.front.xml
endif
ifneq ($(NP_CAMERA_REAR_SENSOR_GUID),)
    ifneq ($(NP_CAMERA_FOCUSER_GUID),)
        ifneq ($(NP_CAMERA_FLASHLIGHT_GUID),)
            NP_LBH_COPY_FILES += \
                frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.camera.flash-autofocus.xml
        else
            NP_LBH_COPY_FILES += \
                frameworks/native/data/etc/android.hardware.camera.autofocus.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.camera.autofocus.xml
        endif
    else
        NP_LBH_COPY_FILES += \
            frameworks/native/data/etc/android.hardware.camera.xml:$(NP_LBH_TAG)/etc/permissions/android.hardware.camera.xml
    endif
endif

define check-np-lbh-copy-files
$(if $(filter %.apk, $(1)),$(error \
    Prebuilt apk found in NP_LBH_COPY_FILES: $(1), use BUILD_PREBUILT instead!))
endef
define copy-np-lbh-files
$(foreach cf,$(NP_LBH_COPY_FILES), \
    $(eval _src := $(call word-colon,1,$(cf))) \
    $(eval _dest := $(call word-colon,2,$(cf))) \
    $(call check-np-lbh-copy-files,$(cf)) \
    $(eval _fulldest := $(call append-path,$(PRODUCT_OUT),$(_dest))) \
    mkdir -p $(dir $(_fulldest)); \
    echo "Copy: $(_fulldest)"; \
    $(ACP) -fp $(_src) $(_fulldest);)
endef

MAKE_NP_LBH_DIR := $(NP_TARGET_OUT_LBH)
$(MAKE_NP_LBH_DIR):
	mkdir -p $@/app; \
	mkdir -p $@/etc/permissions; \
	mkdir -p $@/media/audio/alarms; \
	mkdir -p $@/media/audio/notifications; \
	mkdir -p $@/media/audio/ringtones; \
	mkdir -p $@/media/audio/ui; \
	mkdir -p $@/media/images;

.PHONY: $(NP_LBHIMAGE_FILENAME)
$(NP_LBHIMAGE_FILENAME): $(MAKE_EXT4FS) $(MKEXTUSERIMG) $(MAKE_NP_LBH_DIR) \
$(NP_LBH_BUILD_PROP_TARGET) $(NP_LBH_CAM_CONF_TARGET) | $(ACP)
	@echo "CM_ID: $(NP_CM_ID) / LBH_ID: $(NP_LBH_ID)"
	@echo $(NP_CM_ID) > $(NP_TARGET_OUT_LBH)/.cm_id
	@echo $(NP_LBH_ID) > $(NP_TARGET_OUT_LBH)/.lbh_id
	@echo $(NP_LBH_CLASS) > $(NP_TARGET_OUT_LBH)/.lbh_class
	$(call copy-np-lbh-files)
	$(MKEXTUSERIMG) -s $(NP_TARGET_OUT_LBH) $(NP_LBHIMAGE_FILENAME) $(NP_LBHIMAGE_EXT_VARIANT) \
		$(NP_LBHIMAGE_MOUNT_POINT) $(NP_LBHIMAGE_PARTITION_SIZE)

LOCAL_MODULE := $(NP_LBH_TAG)_image
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_SUFFIX := -timestamp

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(NP_LBHIMAGE_FILENAME)
	@echo "Generated LBH partition image ($(NP_LBHIMAGE_FILENAME))"; \
	mkdir -p $(dir $@); \
	rm -rf $@; \
	touch $@


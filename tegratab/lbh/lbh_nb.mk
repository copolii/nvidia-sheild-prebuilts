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
NB_LBHIMAGE_PARTITION_SIZE := 268435456

#------------------------------------------------
# Define CM/LBH ID (hexadecimal 4 characters)
# CM_ID for TegraTab is 0x0000
# LBH_ID for TegraTab is
# 0x0002 : Non-GMS/Basic
#------------------------------------------------
NB_CM_ID := 0000
NB_LBH_ID := 0002
NB_LBH_CLASS := 0002

#------------------------------------------------
# Set locale (Non-GMS/Basic)
#------------------------------------------------
NB_LBH_DEFAULT_LANGUAGE := zh
NB_LBH_DEFAULT_REGION := CN

#------------------------------------------------
# Environment setting (Non-GMS/Basic)
#------------------------------------------------
NB_PRODUCT_MODEL := TegraNote-Basic
NB_LBH_TAG := lbh_nb
NB_LBHIMAGE_FILENAME := $(PRODUCT_OUT)/$(NB_LBH_TAG).img
NB_TARGET_OUT_LBH := $(PRODUCT_OUT)/$(NB_LBH_TAG)
NB_TARGET_OUT_LBH_ETC := $(NB_TARGET_OUT_LBH)/etc
NB_TARGET_OUT_LBH_PERM := $(NB_TARGET_OUT_LBH_ETC)/permissions
NB_LBHIMAGE_MOUNT_POINT := lbh
NB_LBHIMAGE_EXT_VARIANT := ext4

#------------------------------------------------
# Camera information (Non-GMS/Basic)
# if there is no sensor, set GUID to ""
#------------------------------------------------
NB_CAMERA_REAR_SENSOR_GUID :=
NB_CAMERA_FRONT_SENSOR_GUID := s_OV7695
NB_CAMERA_FOCUSER_GUID :=
NB_CAMERA_FLASHLIGHT_GUID :=
# Camera config file
NB_CAMERA_CONFIG_VERSION := 1
# Facing, Angle, Stereo/Mono
NB_CAMERA_REAR_CONFIG := camera0=/dev/ov5693,back,0,mono
NB_CAMERA_FRONT_CONFIG := camera1=/dev/ov7695,front,0,mono
NB_CAMERA_FRONT_ONLY_CONFIG := camera0=/dev/ov7695,front,0,mono

#------------------------------------------------
# Create default properties for LBH (Non-GMS/Basic)
#------------------------------------------------
NB_LBH_BUILD_PROP_TARGET := $(NB_TARGET_OUT_LBH)/default.prop
$(NB_LBH_BUILD_PROP_TARGET): $(LOCAL_PATH)/lbh.prop
	$(hide) mkdir -p $(NB_TARGET_OUT_LBH)
	$(hide) echo "ro.nvidia.cm_id=$(NB_CM_ID)" > $@
	$(hide) echo "ro.nvidia.lbh_id=$(NB_LBH_ID)" >> $@
	$(hide) echo "ro.nvidia.lbh_class=$(NB_LBH_CLASS)" >> $@
	$(hide) echo "ro.product.locale.language=$(NB_LBH_DEFAULT_LANGUAGE)" >> $@
	$(hide) echo "ro.product.locale.region=$(NB_LBH_DEFAULT_REGION)" >> $@
	$(hide) echo "ro.nvidia.hw.fcam=$(NB_CAMERA_FRONT_SENSOR_GUID)" >> $@
	$(hide) echo "ro.nvidia.hw.rcam=$(NB_CAMERA_REAR_SENSOR_GUID)" >> $@
	$(hide) echo "ro.nvidia.hw.flash=$(NB_CAMERA_FLASHLIGHT_GUID)" >> $@
	$(hide) echo "ro.nvidia.hw.focuser=$(NB_CAMERA_FOCUSER_GUID)" >> $@
	$(hide) if [ -f $(LOCAL_PATH)/lbh.prop ]; then \
	            cat $(LOCAL_PATH)/lbh.prop >> $@; \
	        fi

#------------------------------------------------
# Create camera config (Non-GMS/Basic)
#------------------------------------------------
NB_LBH_CAM_CONF_TARGET := $(NB_TARGET_OUT_LBH_ETC)/nvcamera.conf
$(NB_LBH_CAM_CONF_TARGET):
	$(hide) mkdir -p $(NB_TARGET_OUT_LBH_ETC)
	$(hide) echo "version=$(NB_CAMERA_CONFIG_VERSION)" > $@
ifneq ($(NB_CAMERA_REAR_SENSOR_GUID),)
	$(hide) echo $(NB_CAMERA_REAR_CONFIG) >> $@
ifneq ($(NB_CAMERA_FRONT_SENSOR_GUID),)
	$(hide) echo $(NB_CAMERA_FRONT_CONFIG) >> $@
endif
else
ifneq ($(NB_CAMERA_FRONT_SENSOR_GUID),)
	$(hide) echo $(NB_CAMERA_FRONT_ONLY_CONFIG) >> $@
endif
endif

#------------------------------------------------
# Define files to be copyied to LBH (Non-GMS/Basic)
# FIXME: we should define files to be copied
#------------------------------------------------
NB_LBH_COPY_FILES := \
    vendor/nvidia/tegra/tegratab/partition-data/media/bootanimation-800x450x15.zip:$(NB_LBH_TAG)/media/bootanimation.zip \
    vendor/nvidia/tegra/tegratab/partition-data/media/images/.nomedia:$(NB_LBH_TAG)/media/images/.nomedia \
    vendor/nvidia/tegra/tegratab/partition-data/media/images/tegratab_7in_1454x1280_12.jpg:$(NB_LBH_TAG)/media/images/default_wallpaper.jpg \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(NB_LBH_TAG)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(NB_LBH_TAG)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(NB_LBH_TAG)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(NB_LBH_TAG)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(NB_LBH_TAG)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(NB_LBH_TAG)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(NB_LBH_TAG)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(NB_LBH_TAG)/etc/permissions/android.hardware.usb.accessory.xml

ifneq ($(NB_CAMERA_FRONT_SENSOR_GUID),)
NB_LBH_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(NB_LBH_TAG)/etc/permissions/android.hardware.camera.front.xml
endif
ifneq ($(NB_CAMERA_REAR_SENSOR_GUID),)
    ifneq ($(NB_CAMERA_FOCUSER_GUID),)
        ifneq ($(NB_CAMERA_FLASHLIGHT_GUID),)
            NB_LBH_COPY_FILES += \
                frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(NB_LBH_TAG)/etc/permissions/android.hardware.camera.flash-autofocus.xml
        else
            NB_LBH_COPY_FILES += \
                frameworks/native/data/etc/android.hardware.camera.autofocus.xml:$(NB_LBH_TAG)/etc/permissions/android.hardware.camera.autofocus.xml
        endif
    else
        NB_LBH_COPY_FILES += \
            frameworks/native/data/etc/android.hardware.camera.xml:$(NB_LBH_TAG)/etc/permissions/android.hardware.camera.xml
    endif
endif

define check-nb-lbh-copy-files
$(if $(filter %.apk, $(1)),$(error \
    Prebuilt apk found in NB_LBH_COPY_FILES: $(1), use BUILD_PREBUILT instead!))
endef
define copy-nb-lbh-files
$(foreach cf,$(NB_LBH_COPY_FILES), \
    $(eval _src := $(call word-colon,1,$(cf))) \
    $(eval _dest := $(call word-colon,2,$(cf))) \
    $(call check-nb-lbh-copy-files,$(cf)) \
    $(eval _fulldest := $(call append-path,$(PRODUCT_OUT),$(_dest))) \
    mkdir -p $(dir $(_fulldest)); \
    echo "Copy: $(_fulldest)"; \
    $(ACP) -fp $(_src) $(_fulldest);)
endef

MAKE_NB_LBH_DIR := $(NB_TARGET_OUT_LBH)
$(MAKE_NB_LBH_DIR):
	mkdir -p $@/app; \
	mkdir -p $@/etc/permissions; \
	mkdir -p $@/media/audio/alarms; \
	mkdir -p $@/media/audio/notifications; \
	mkdir -p $@/media/audio/ringtones; \
	mkdir -p $@/media/audio/ui; \
	mkdir -p $@/media/images;

.PHONY: $(NB_LBHIMAGE_FILENAME)
$(NB_LBHIMAGE_FILENAME): $(MAKE_EXT4FS) $(MKEXTUSERIMG) $(MAKE_NB_LBH_DIR) \
$(NB_LBH_BUILD_PROP_TARGET) $(NB_LBH_CAM_CONF_TARGET) | $(ACP)
	@echo "CM_ID: $(NB_CM_ID) / LBH_ID: $(NB_LBH_ID)"
	@echo $(NB_CM_ID) > $(NB_TARGET_OUT_LBH)/.cm_id
	@echo $(NB_LBH_ID) > $(NB_TARGET_OUT_LBH)/.lbh_id
	@echo $(NB_LBH_CLASS) > $(NB_TARGET_OUT_LBH)/.lbh_class
	$(call copy-nb-lbh-files)
	$(MKEXTUSERIMG) -s $(NB_TARGET_OUT_LBH) $(NB_LBHIMAGE_FILENAME) $(NB_LBHIMAGE_EXT_VARIANT) \
		$(NB_LBHIMAGE_MOUNT_POINT) $(NB_LBHIMAGE_PARTITION_SIZE)

LOCAL_MODULE := $(NB_LBH_TAG)_image
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_SUFFIX := -timestamp

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(NB_LBHIMAGE_FILENAME)
	@echo "Generated LBH partition image ($(NB_LBHIMAGE_FILENAME))"; \
	mkdir -p $(dir $@); \
	rm -rf $@; \
	touch $@


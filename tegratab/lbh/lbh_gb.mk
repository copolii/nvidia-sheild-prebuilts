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
GB_LBHIMAGE_PARTITION_SIZE := 268435456

#------------------------------------------------
# Define CM/LBH ID (hexadecimal 4 characters)
# CM_ID for TegraTab is 0x0000
# LBH_ID for TegraTab is
# 0x0008 : GMS/Basic
#------------------------------------------------
GB_CM_ID := 0000
GB_LBH_ID := 0008
GB_LBH_CLASS := 0008

#------------------------------------------------
# Set locale (GMS/Basic)
#------------------------------------------------
GB_LBH_DEFAULT_LANGUAGE := en
GB_LBH_DEFAULT_REGION := US

#------------------------------------------------
# Environment setting (GMS/Basic)
#------------------------------------------------
GB_PRODUCT_MODEL := TegraNote-Basic
GB_LBH_TAG := lbh_gb
GB_LBHIMAGE_FILENAME := $(PRODUCT_OUT)/$(GB_LBH_TAG).img
GB_TARGET_OUT_LBH := $(PRODUCT_OUT)/$(GB_LBH_TAG)
GB_TARGET_OUT_LBH_ETC := $(GB_TARGET_OUT_LBH)/etc
GB_TARGET_OUT_LBH_PERM := $(GB_TARGET_OUT_LBH_ETC)/permissions
GB_LBHIMAGE_MOUNT_POINT := lbh
GB_LBHIMAGE_EXT_VARIANT := ext4

#------------------------------------------------
# Camera information (GMS/Basic)
# if there is no sensor, set GUID to ""
#------------------------------------------------
GB_CAMERA_REAR_SENSOR_GUID :=
GB_CAMERA_FRONT_SENSOR_GUID := s_OV7695
GB_CAMERA_FOCUSER_GUID :=
GB_CAMERA_FLASHLIGHT_GUID :=
# Camera config file
GB_CAMERA_CONFIG_VERSION := 1
# Facing, Angle, Stereo/Mono
GB_CAMERA_REAR_CONFIG := camera0=/dev/ov5693,back,0,mono
GB_CAMERA_FRONT_CONFIG := camera1=/dev/ov7695,front,0,mono
GB_CAMERA_FRONT_ONLY_CONFIG := camera0=/dev/ov7695,front,0,mono

#------------------------------------------------
# Create default properties for LBH (GMS/Basic)
#------------------------------------------------
GB_LBH_BUILD_PROP_TARGET := $(GB_TARGET_OUT_LBH)/default.prop
$(GB_LBH_BUILD_PROP_TARGET): $(LOCAL_PATH)/lbh.prop
	$(hide) mkdir -p $(GB_TARGET_OUT_LBH)
	$(hide) echo "ro.nvidia.cm_id=$(GB_CM_ID)" > $@
	$(hide) echo "ro.nvidia.lbh_id=$(GB_LBH_ID)" >> $@
	$(hide) echo "ro.nvidia.lbh_class=$(GB_LBH_CLASS)" >> $@
	$(hide) echo "ro.product.locale.language=$(GB_LBH_DEFAULT_LANGUAGE)" >> $@
	$(hide) echo "ro.product.locale.region=$(GB_LBH_DEFAULT_REGION)" >> $@
	$(hide) echo "ro.nvidia.hw.fcam=$(GB_CAMERA_FRONT_SENSOR_GUID)" >> $@
	$(hide) echo "ro.nvidia.hw.rcam=$(GB_CAMERA_REAR_SENSOR_GUID)" >> $@
	$(hide) echo "ro.nvidia.hw.flash=$(GB_CAMERA_FLASHLIGHT_GUID)" >> $@
	$(hide) echo "ro.nvidia.hw.focuser=$(GB_CAMERA_FOCUSER_GUID)" >> $@
	$(hide) if [ -f $(LOCAL_PATH)/lbh.prop ]; then \
	            cat $(LOCAL_PATH)/lbh.prop >> $@; \
	        fi

#------------------------------------------------
# Create camera config (GMS/Basic)
#------------------------------------------------
GB_LBH_CAM_CONF_TARGET := $(GB_TARGET_OUT_LBH_ETC)/nvcamera.conf
$(GB_LBH_CAM_CONF_TARGET):
	$(hide) mkdir -p $(GB_TARGET_OUT_LBH_ETC)
	$(hide) echo "version=$(GB_CAMERA_CONFIG_VERSION)" > $@
ifneq ($(GB_CAMERA_REAR_SENSOR_GUID),)
	$(hide) echo $(GB_CAMERA_REAR_CONFIG) >> $@
ifneq ($(GB_CAMERA_FRONT_SENSOR_GUID),)
	$(hide) echo $(GB_CAMERA_FRONT_CONFIG) >> $@
endif
else
ifneq ($(GB_CAMERA_FRONT_SENSOR_GUID),)
	$(hide) echo $(GB_CAMERA_FRONT_ONLY_CONFIG) >> $@
endif
endif

#------------------------------------------------
# Define files to be copyied to LBH (GMS/Basic)
# FIXME: we should define files to be copied
#------------------------------------------------
GB_LBH_COPY_FILES := \
    vendor/nvidia/tegra/tegratab/partition-data/media/bootanimation-800x450x15.zip:$(GB_LBH_TAG)/media/bootanimation.zip \
    vendor/nvidia/tegra/tegratab/partition-data/media/images/.nomedia:$(GB_LBH_TAG)/media/images/.nomedia \
    vendor/nvidia/tegra/tegratab/partition-data/media/images/tegratab_7in_1454x1280_28.jpg:$(GB_LBH_TAG)/media/images/default_wallpaper.jpg \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(GB_LBH_TAG)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(GB_LBH_TAG)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(GB_LBH_TAG)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(GB_LBH_TAG)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(GB_LBH_TAG)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(GB_LBH_TAG)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(GB_LBH_TAG)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(GB_LBH_TAG)/etc/permissions/android.hardware.usb.accessory.xml

ifneq ($(GB_CAMERA_FRONT_SENSOR_GUID),)
GB_LBH_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(GB_LBH_TAG)/etc/permissions/android.hardware.camera.front.xml
endif
ifneq ($(GB_CAMERA_REAR_SENSOR_GUID),)
    ifneq ($(GB_CAMERA_FOCUSER_GUID),)
        ifneq ($(GB_CAMERA_FLASHLIGHT_GUID),)
            GB_LBH_COPY_FILES += \
                frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(GB_LBH_TAG)/etc/permissions/android.hardware.camera.flash-autofocus.xml
        else
            GB_LBH_COPY_FILES += \
                frameworks/native/data/etc/android.hardware.camera.autofocus.xml:$(GB_LBH_TAG)/etc/permissions/android.hardware.camera.autofocus.xml
        endif
    else
        GB_LBH_COPY_FILES += \
            frameworks/native/data/etc/android.hardware.camera.xml:$(GB_LBH_TAG)/etc/permissions/android.hardware.camera.xml
    endif
endif

define check-gb-lbh-copy-files
$(if $(filter %.apk, $(1)),$(error \
    Prebuilt apk found in GB_LBH_COPY_FILES: $(1), use BUILD_PREBUILT instead!))
endef
define copy-gb-lbh-files
$(foreach cf,$(GB_LBH_COPY_FILES), \
    $(eval _src := $(call word-colon,1,$(cf))) \
    $(eval _dest := $(call word-colon,2,$(cf))) \
    $(call check-gb-lbh-copy-files,$(cf)) \
    $(eval _fulldest := $(call append-path,$(PRODUCT_OUT),$(_dest))) \
    mkdir -p $(dir $(_fulldest)); \
    echo "Copy: $(_fulldest)"; \
    $(ACP) -fp $(_src) $(_fulldest);)
endef

MAKE_GB_LBH_DIR := $(GB_TARGET_OUT_LBH)
$(MAKE_GB_LBH_DIR):
	mkdir -p $@/app; \
	mkdir -p $@/etc/permissions; \
	mkdir -p $@/media/audio/alarms; \
	mkdir -p $@/media/audio/notifications; \
	mkdir -p $@/media/audio/ringtones; \
	mkdir -p $@/media/audio/ui; \
	mkdir -p $@/media/images;

.PHONY: $(GB_LBHIMAGE_FILENAME)
$(GB_LBHIMAGE_FILENAME): $(MAKE_EXT4FS) $(MKEXTUSERIMG) $(MAKE_GB_LBH_DIR) \
$(GB_LBH_BUILD_PROP_TARGET) $(GB_LBH_CAM_CONF_TARGET) | $(ACP)
	@echo "CM_ID: $(GB_CM_ID) / LBH_ID: $(GB_LBH_ID)"
	@echo $(GB_CM_ID) > $(GB_TARGET_OUT_LBH)/.cm_id
	@echo $(GB_LBH_ID) > $(GB_TARGET_OUT_LBH)/.lbh_id
	@echo $(GB_LBH_CLASS) > $(GB_TARGET_OUT_LBH)/.lbh_class
	$(call copy-gb-lbh-files)
	$(MKEXTUSERIMG) -s $(GB_TARGET_OUT_LBH) $(GB_LBHIMAGE_FILENAME) $(GB_LBHIMAGE_EXT_VARIANT) \
		$(GB_LBHIMAGE_MOUNT_POINT) $(GB_LBHIMAGE_PARTITION_SIZE)

LOCAL_MODULE := $(GB_LBH_TAG)_image
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_SUFFIX := -timestamp

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(GB_LBHIMAGE_FILENAME)
	@echo "Generated LBH partition image ($(GB_LBHIMAGE_FILENAME))"; \
	mkdir -p $(dir $@); \
	rm -rf $@; \
	touch $@


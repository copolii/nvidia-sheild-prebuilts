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
GP_LBHIMAGE_PARTITION_SIZE := 268435456

#------------------------------------------------
# Define CM/LBH ID (hexadecimal 4 characters)
# CM_ID for TegraTab is 0x0000
# LBH_ID for TegraTab is
# 0x0004 : GMS/Premium
#------------------------------------------------
GP_CM_ID := 0000
GP_LBH_ID := 0004
GP_LBH_CLASS := 0004

#------------------------------------------------
# Set locale (GMS/Premium)
#------------------------------------------------
GP_LBH_DEFAULT_LANGUAGE := en
GP_LBH_DEFAULT_REGION := US

#------------------------------------------------
# Environment setting (GMS/Premium)
#------------------------------------------------
GP_PRODUCT_MODEL := TegraNote-Premium
GP_LBH_TAG := lbh_gp
GP_LBHIMAGE_FILENAME := $(PRODUCT_OUT)/$(GP_LBH_TAG).img
GP_TARGET_OUT_LBH := $(PRODUCT_OUT)/$(GP_LBH_TAG)
GP_TARGET_OUT_LBH_ETC := $(GP_TARGET_OUT_LBH)/etc
GP_TARGET_OUT_LBH_PERM := $(GP_TARGET_OUT_LBH_ETC)/permissions
GP_LBHIMAGE_MOUNT_POINT := lbh
GP_LBHIMAGE_EXT_VARIANT := ext4

#------------------------------------------------
# Camera information (GMS/Premium)
# if there is no sensor, set GUID to ""
#------------------------------------------------
GP_CAMERA_REAR_SENSOR_GUID := s_OV5693
GP_CAMERA_FRONT_SENSOR_GUID := s_OV7695
GP_CAMERA_FOCUSER_GUID := f_AD5823
GP_CAMERA_FLASHLIGHT_GUID :=
# Camera config file
GP_CAMERA_CONFIG_VERSION := 1
# Facing, Angle, Stereo/Mono
GP_CAMERA_REAR_CONFIG := camera0=/dev/ov5693,back,0,mono
GP_CAMERA_FRONT_CONFIG := camera1=/dev/ov7695,front,0,mono
GP_CAMERA_FRONT_ONLY_CONFIG := camera0=/dev/ov7695,front,0,mono

#------------------------------------------------
# Create default properties for LBH (GMS/Premium)
#------------------------------------------------
GP_LBH_BUILD_PROP_TARGET := $(GP_TARGET_OUT_LBH)/default.prop
$(GP_LBH_BUILD_PROP_TARGET): $(LOCAL_PATH)/lbh.prop
	$(hide) mkdir -p $(GP_TARGET_OUT_LBH)
	$(hide) echo "ro.nvidia.cm_id=$(GP_CM_ID)" > $@
	$(hide) echo "ro.nvidia.lbh_id=$(GP_LBH_ID)" >> $@
	$(hide) echo "ro.nvidia.lbh_class=$(GP_LBH_CLASS)" >> $@
	$(hide) echo "ro.product.locale.language=$(GP_LBH_DEFAULT_LANGUAGE)" >> $@
	$(hide) echo "ro.product.locale.region=$(GP_LBH_DEFAULT_REGION)" >> $@
	$(hide) echo "ro.nvidia.hw.fcam=$(GP_CAMERA_FRONT_SENSOR_GUID)" >> $@
	$(hide) echo "ro.nvidia.hw.rcam=$(GP_CAMERA_REAR_SENSOR_GUID)" >> $@
	$(hide) echo "ro.nvidia.hw.flash=$(GP_CAMERA_FLASHLIGHT_GUID)" >> $@
	$(hide) echo "ro.nvidia.hw.focuser=$(GP_CAMERA_FOCUSER_GUID)" >> $@
	$(hide) if [ -f $(LOCAL_PATH)/lbh.prop ]; then \
	            cat $(LOCAL_PATH)/lbh.prop >> $@; \
	        fi

#------------------------------------------------
# Create camera config (GMS/Premium)
#------------------------------------------------
GP_LBH_CAM_CONF_TARGET := $(GP_TARGET_OUT_LBH_ETC)/nvcamera.conf
$(GP_LBH_CAM_CONF_TARGET):
	$(hide) mkdir -p $(GP_TARGET_OUT_LBH_ETC)
	$(hide) echo "version=$(GP_CAMERA_CONFIG_VERSION)" > $@
ifneq ($(GP_CAMERA_REAR_SENSOR_GUID),)
	$(hide) echo $(GP_CAMERA_REAR_CONFIG) >> $@
ifneq ($(GP_CAMERA_FRONT_SENSOR_GUID),)
	$(hide) echo $(GP_CAMERA_FRONT_CONFIG) >> $@
endif
else
ifneq ($(GP_CAMERA_FRONT_SENSOR_GUID),)
	$(hide) echo $(GP_CAMERA_FRONT_ONLY_CONFIG) >> $@
endif
endif

#------------------------------------------------
# Define files to be copyied to LBH (GMS/Premium)
# FIXME: we should define files to be copied
#------------------------------------------------
GP_LBH_COPY_FILES := \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.usb.accessory.xml


#LBH application and boot images
GP_LBH_COPY_FILES += \
   vendor/nvidia/tegra/tegratab/partition-data/media/bootanimation-800x450x15.zip:$(GP_LBH_TAG)/media/bootanimation.zip \
   vendor/nvidia/tegra/tegratab/partition-data/media/images/.nomedia:$(GP_LBH_TAG)/media/images/.nomedia \
   vendor/nvidia/tegra/tegratab/partition-data/media/images/tegratab_7in_1454x1280_28.jpg:$(GP_LBH_TAG)/media/images/default_wallpaper.jpg \
   3rdparty/applications/prebuilt/common/apps/XoloCare.apk:$(GP_LBH_TAG)/app/XoloCare.apk \
   3rdparty/applications/prebuilt/common/apps/TertiaryTracker.apk:$(GP_LBH_TAG)/app/TertiaryTracker.apk \
   3rdparty/applications/prebuilt/common/apps/ZenPinballHD.apk:$(GP_LBH_TAG)/app/ZenPinballHD.apk

ifneq ($(GP_CAMERA_FRONT_SENSOR_GUID),)
GP_LBH_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.camera.front.xml
endif
ifneq ($(GP_CAMERA_REAR_SENSOR_GUID),)
    ifneq ($(GP_CAMERA_FOCUSER_GUID),)
        ifneq ($(GP_CAMERA_FLASHLIGHT_GUID),)
            GP_LBH_COPY_FILES += \
                frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.camera.flash-autofocus.xml
        else
            GP_LBH_COPY_FILES += \
                frameworks/native/data/etc/android.hardware.camera.autofocus.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.camera.autofocus.xml
        endif
    else
        GP_LBH_COPY_FILES += \
            frameworks/native/data/etc/android.hardware.camera.xml:$(GP_LBH_TAG)/etc/permissions/android.hardware.camera.xml
    endif
endif

define copy-gp-lbh-files
$(foreach cf,$(GP_LBH_COPY_FILES), \
    $(eval _src := $(call word-colon,1,$(cf))) \
    $(eval _dest := $(call word-colon,2,$(cf))) \
    $(eval _fulldest := $(call append-path,$(PRODUCT_OUT),$(_dest))) \
    mkdir -p $(dir $(_fulldest)); \
    echo "Copy: $(_fulldest)"; \
    $(ACP) -fp $(_src) $(_fulldest);)
endef

MAKE_GP_LBH_DIR := $(GP_TARGET_OUT_LBH)
$(MAKE_GP_LBH_DIR):
	mkdir -p $@/app; \
	mkdir -p $@/etc/permissions; \
	mkdir -p $@/media/audio/alarms; \
	mkdir -p $@/media/audio/notifications; \
	mkdir -p $@/media/audio/ringtones; \
	mkdir -p $@/media/audio/ui; \
	mkdir -p $@/media/images;

.PHONY: $(GP_LBHIMAGE_FILENAME)
$(GP_LBHIMAGE_FILENAME): $(MAKE_EXT4FS) $(MKEXTUSERIMG) $(MAKE_GP_LBH_DIR) \
$(GP_LBH_BUILD_PROP_TARGET) $(GP_LBH_CAM_CONF_TARGET) | $(ACP)
	@echo "CM_ID: $(GP_CM_ID) / LBH_ID: $(GP_LBH_ID)"
	@echo $(GP_CM_ID) > $(GP_TARGET_OUT_LBH)/.cm_id
	@echo $(GP_LBH_ID) > $(GP_TARGET_OUT_LBH)/.lbh_id
	@echo $(GP_LBH_CLASS) > $(GP_TARGET_OUT_LBH)/.lbh_class
	$(call copy-gp-lbh-files)
	$(MKEXTUSERIMG) -s $(GP_TARGET_OUT_LBH) $(GP_LBHIMAGE_FILENAME) $(GP_LBHIMAGE_EXT_VARIANT) \
		$(GP_LBHIMAGE_MOUNT_POINT) $(GP_LBHIMAGE_PARTITION_SIZE)

LOCAL_MODULE := $(GP_LBH_TAG)_image
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_SUFFIX := -timestamp

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(GP_LBHIMAGE_FILENAME)
	@echo "Generated LBH partition image ($(GP_LBHIMAGE_FILENAME))"; \
	mkdir -p $(dir $@); \
	rm -rf $@; \
	touch $@


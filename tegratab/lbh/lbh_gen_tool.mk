#
# Copyright (c) 2013 NVIDIA Corporation.  All rights reserved.
#

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
include $(NVIDIA_DEFAULTS)

LBH_TOOL_TOP_DIR := lbh_gen_tool
LBH_TOOL_PERMISSION_DIR := $(LBH_TOOL_TOP_DIR)/permissions
LBH_TOOL_SOUND_DIR := $(LBH_TOOL_TOP_DIR)/sounds
LBH_TOOL_BIN_DIR := $(LBH_TOOL_TOP_DIR)/bin

# local files
LBH_TOOL_COPY_FILES := \
	$(LOCAL_PATH)/genLBH.sh:$(LBH_TOOL_TOP_DIR)/genLBH.sh \
	$(LOCAL_PATH)/lbh.prop:$(LBH_TOOL_TOP_DIR)/lbh.prop

# permission files
LBH_TOOL_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.audio.low_latency.xml \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.camera.autofocus.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.camera.autofocus.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.faketouch.multitouch.distinct.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.faketouch.multitouch.distinct.xml \
	frameworks/native/data/etc/android.hardware.faketouch.multitouch.jazzhand.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.faketouch.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.hardware.faketouch.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.faketouch.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.location.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.location.xml \
	frameworks/native/data/etc/android.hardware.nfc.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.sensor.barometer.xml \
	frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.sensor.compass.xml \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.telephony.cdma.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.touchscreen.multitouch.distinct.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.touchscreen.multitouch.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.touchscreen.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:$(LBH_TOOL_PERMISSION_DIR)/android.hardware.wifi.xml

# sample sound files
LBH_TOOL_COPY_FILES += \
	frameworks/base/data/sounds/effects/Effect_Tick.ogg:$(LBH_TOOL_SOUND_DIR)/ui/Effect_Tick.ogg \
	frameworks/base/data/sounds/effects/KeypressStandard.ogg:$(LBH_TOOL_SOUND_DIR)/ui/KeypressStandard.ogg \
	frameworks/base/data/sounds/effects/KeypressSpacebar.ogg:$(LBH_TOOL_SOUND_DIR)/ui/KeypressSpacebar.ogg \
	frameworks/base/data/sounds/effects/VideoRecord.ogg:$(LBH_TOOL_SOUND_DIR)/ui/VideoRecord.ogg \
	frameworks/base/data/sounds/effects/camera_click.ogg:$(LBH_TOOL_SOUND_DIR)/ui/camera_click.ogg \
	frameworks/base/data/sounds/effects/LowBattery.ogg:$(LBH_TOOL_SOUND_DIR)/ui/LowBattery.ogg \
	frameworks/base/data/sounds/effects/Dock.ogg:$(LBH_TOOL_SOUND_DIR)/ui/Dock.ogg \
	frameworks/base/data/sounds/effects/Undock.ogg:$(LBH_TOOL_SOUND_DIR)/ui/Undock.ogg \
	frameworks/base/data/sounds/effects/Lock.ogg:$(LBH_TOOL_SOUND_DIR)/ui/Lock.ogg \
	frameworks/base/data/sounds/effects/Unlock.ogg:$(LBH_TOOL_SOUND_DIR)/ui/Unlock.ogg \
	frameworks/base/data/sounds/effects/ogg/camera_focus.ogg:$(LBH_TOOL_SOUND_DIR)/ui/camera_focus.ogg

define copy-lbh-tool-files
$(foreach cf,$(LBH_TOOL_COPY_FILES), \
    $(eval _src := $(call word-colon,1,$(cf))) \
    $(eval _dest := $(call word-colon,2,$(cf))) \
    $(eval _fulldest := $(call append-path,$(PRODUCT_OUT),$(_dest))) \
    mkdir -p $(dir $(_fulldest)); \
    echo "Copy: $(_fulldest)"; \
    $(ACP) -fp $(_src) $(_fulldest);)
endef

MAKE_LBH_TOOL_DIR := $(PRODUCT_OUT)/$(LBH_TOOL_TOP_DIR)
$(MAKE_LBH_TOOL_DIR):
	mkdir -p $@/lbh/app; \
	mkdir -p $@/lbh/etc/permissions; \
	mkdir -p $@/lbh/media/audio/alarms; \
	mkdir -p $@/lbh/media/audio/notifications; \
	mkdir -p $@/lbh/media/audio/ringtones; \
	mkdir -p $@/lbh/media/audio/ui; \
	mkdir -p $@/lbh/media/images; \
	mkdir -p $@/bin; \
	mkdir -p $@/permissions; \
	mkdir -p $@/sounds;

LBH_GEN_TOOL_PATH := device/nvidia/tegratab/lbh
LBH_GEN_TOOL_FILENAME := tegratab-LBH-gen-tool.zip

COPY_LBH_TOOL_RESOURCES := genLBH.sh
$(COPY_LBH_TOOL_RESOURCES): $(MAKE_EXT4FS) $(MKEXTUSERIMG) $(MAKE_LBH_TOOL_DIR) | $(ACP)
	$(call copy-lbh-tool-files)
	$(ACP) -fp $(MAKE_EXT4FS) $(PRODUCT_OUT)/$(LBH_TOOL_BIN_DIR); \
	$(ACP) -fp $(MKEXTUSERIMG) $(PRODUCT_OUT)/$(LBH_TOOL_BIN_DIR)

.PHONY: $(LBH_GEN_TOOL_FILENAME)
$(LBH_GEN_TOOL_FILENAME): $(COPY_LBH_TOOL_RESOURCES)
	cd $(PRODUCT_OUT) && zip -rq $(LBH_GEN_TOOL_FILENAME) $(LBH_TOOL_TOP_DIR)

# Make LBH image generating tool
LOCAL_MODULE := lbh_gen_tool
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_SUFFIX := -timestamp

include $(BUILD_SYSTEM)/base_rules.mk

$(LOCAL_BUILT_MODULE): $(LBH_GEN_TOOL_FILENAME)
	@echo "Made LBH image generating tool ($(LBH_GEN_TOOL_FILENAME))"; \
	mkdir -p $(dir $@); \
	rm -rf $@; \
	touch $@

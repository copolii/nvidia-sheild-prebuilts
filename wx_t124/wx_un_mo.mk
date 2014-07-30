# NVIDIA Tegra5 "Ardbeg" development system
#
# Copyright (c) 2013, NVIDIA Corporation.  All rights reserved.
#
# AndroidProducts.mk is included before BoardConfig.mk, variable essential at
# start of build and used in here should always be intialized in this file

## All essential packages
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, device/nvidia/ardbeg/device.mk)
$(call inherit-product, device/nvidia/wx_t124/wx_common.mk)

## Thse are default settings, it gets changed as per sku manifest properties
PRODUCT_NAME := wx_un_mo
PRODUCT_DEVICE := ardbeg
PRODUCT_MODEL := wx_un_mo
PRODUCT_MANUFACTURER := NVIDIA
PRODUCT_BRAND := nvidia

## Fury LBH  feature
-include vendor/nvidia/fury/tools/lbh/fury.mk

## Values of PRODUCT_NAME and PRODUCT_DEVICE are mangeled before it can be
## used because of call to inherits, store their values to
## use later in this file below
_product_name := $(strip $(PRODUCT_NAME))
_product_device := $(strip $(PRODUCT_DEVICE))

## The base dtb file name used for this product
TARGET_KERNEL_DT_NAME := tegra124-tn8

## Icera modem integration
$(call inherit-product-if-exists, $(LOCAL_PATH)/../common/icera/icera-modules.mk)
SYSTEM_ICERA_FW_PATH=system/vendor/firmware/icera

LOCAL_ICERA_FW_PATH_ROOT=vendor/nvidia/tegra/icera/firmware/binaries/binaries_nvidia-e1729-tn8l
LOCAL_ICERA_NALA_FW_PATH_ROOT=vendor/nvidia/tegra/icera/firmware/binaries/binaries_nvidia-e1729-tn8l-nala

# Testing Firmware git structure
# Is there a dev folder?
ifneq ($(wildcard $(LOCAL_ICERA_FW_PATH_ROOT)/dev),)
LOCAL_ICERA_EU_FW_PATH_DEV=$(LOCAL_ICERA_FW_PATH_ROOT)/dev
else
LOCAL_ICERA_EU_FW_PATH_DEV=$(LOCAL_ICERA_FW_PATH_ROOT)
endif

# Is there a prod folder?
ifneq ($(wildcard $(LOCAL_ICERA_FW_PATH_ROOT)/prod),)
LOCAL_ICERA_EU_FW_PATH_PROD=$(LOCAL_ICERA_FW_PATH_ROOT)/prod
else
LOCAL_ICERA_EU_FW_PATH_PROD=$(LOCAL_ICERA_FW_PATH_ROOT)
endif

# Check if there is a separated NALA SKU (for certification purposes)
ifneq ($(wildcard $(LOCAL_ICERA_NALA_FW_PATH_ROOT)),)

# Is there a nala dev folder?
ifneq ($(wildcard $(LOCAL_ICERA_NALA_FW_PATH_ROOT)/dev),)
LOCAL_ICERA_NALA_FW_PATH_DEV=$(LOCAL_ICERA_NALA_FW_PATH_ROOT)/dev
else
LOCAL_ICERA_NALA_FW_PATH_DEV=$(LOCAL_ICERA_NALA_FW_PATH_ROOT)
endif

# Is there a nala prod folder?
ifneq ($(wildcard $(LOCAL_ICERA_NALA_FW_PATH_ROOT)/prod),)
LOCAL_ICERA_NALA_FW_PATH_PROD=$(LOCAL_ICERA_NALA_FW_PATH_ROOT)/prod
else
LOCAL_ICERA_NALA_FW_PATH_PROD=$(LOCAL_ICERA_NALA_FW_PATH_ROOT)
endif

else
# There is no specific NALA folder
LOCAL_ICERA_NALA_FW_PATH_DEV=$(LOCAL_ICERA_EU_FW_PATH_DEV)
LOCAL_ICERA_NALA_FW_PATH_PROD=$(LOCAL_ICERA_EU_FW_PATH_PROD)
endif

# Check if "product" build - point to prod folder if exists
ifeq ($(TARGET_BUILD_TYPE)-$(TARGET_BUILD_VARIANT),$(filter $(TARGET_BUILD_TYPE)-$(TARGET_BUILD_VARIANT),release-user release-userdebug))
LOCAL_ICERA_FW_PATH=$(LOCAL_ICERA_EU_FW_PATH_PROD)
LOCAL_ICERA_NALA_FW_PATH=$(LOCAL_ICERA_NALA_FW_PATH_PROD)
else
LOCAL_ICERA_FW_PATH=$(LOCAL_ICERA_EU_FW_PATH_DEV)
LOCAL_ICERA_NALA_FW_PATH=$(LOCAL_ICERA_NALA_FW_PATH_DEV)
endif

PRODUCT_COPY_FILES += \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_EU_FW_PATH_PROD)/secondary_boot.wrapped:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice/secondary_boot.wrapped) \
	$(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/loader.wrapped:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice/loader.wrapped) \
	$(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/modem.wrapped:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice/modem.wrapped) \
	$(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/audioConfig.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice/audioConfig.bin) \
	$(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/productConfigXml_icera_e1729_tn8l_voice.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice/productConfig.bin)

# Add NALA Voice SKU for testing purposes - comes from same build as EU Voice (not necessarily from NALA build)
ifeq (,$(filter $(TARGET_BUILD_TYPE)-$(TARGET_BUILD_VARIANT),release-user release-userdebug))
PRODUCT_COPY_FILES += \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_EU_FW_PATH_PROD)/secondary_boot.wrapped:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice-nala/secondary_boot.wrapped) \
	$(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/loader.wrapped:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice-nala/loader.wrapped) \
	$(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/modem.wrapped:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice-nala/modem.wrapped) \
	$(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/audioConfig.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice-nala/audioConfig.bin) \
	$(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/productConfigXml_icera_e1729_tn8l_voice_nala.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-voice-nala/productConfig.bin)
endif

PRODUCT_COPY_FILES += \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_PATH)/../t124/init.icera.rc:root/init.icera.rc) \
        $(call add-to-product-copy-files-if-exists, vendor/nvidia/tegra/icera/ril/icera-util/ril_atc.usb.config:system/etc/ril_atc.config)


## SKU specific overrides
include frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk

PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/../t124/overlay-phone

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.software.sip.xml:system/etc/permissions/android.software.sip.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

## common settings for all sku except for diag
include $(LOCAL_PATH)/wx_common_user.mk

## GPS configuration
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/gpsconfig-ardbeg.xml:system/etc/gps/gpsconfig.xml

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
    BCMBINARIES_PATH := vendor/nvidia/tegra/3rdparty/bcmbinaries
else
    BCMBINARIES_PATH := vendor/nvidia/tegra/prebuilt/ardbeg/3rdparty/bcmbinaries
endif

PRODUCT_COPY_FILES += \
    $(BCMBINARIES_PATH)/bcm43241/wlan/sdio-ag-pno-p2p-proptxstatus-dmatxrc-rxov-pktfilter-keepalive-aoe-vsdb-wapi-wl11d-sr-srvsdb-opt1.bin:system/vendor/firmware/bcm43241/fw_bcmdhd.bin

## enable cell broadcast receiver for mms
PRODUCT_PACKAGES += CellBroadcastReceiver

## common apps for all skus
$(call inherit-product-if-exists, vendor/nvidia/$(_product_device)/skus/wx_common_user.mk)

## nvidia apps for this sku
$(call inherit-product-if-exists, vendor/nvidia/$(_product_device)/skus/$(_product_name).mk)

## GMS apps
$(call inherit-product-if-exists, 3rdparty/google/gms-apps/products/gms.mk)

## Clean local variables
_product_name :=
_product_device :=

## Additional override APPs
ADDITIONAL_HANGOUT_OVERRIDE := Mms

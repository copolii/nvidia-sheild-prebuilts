# NVIDIA Tegra5 "Ardbeg" development system
#
# Copyright (c) 2013, NVIDIA Corporation.  All rights reserved.
#
# AndroidProducts.mk is included before BoardConfig.mk, variable essential at
# start of build and used in here should always be intialized in this file

## All essential packages
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, device/nvidia/ardbeg/device.mk)
$(call inherit-product, device/nvidia/wx_t124/wx_common.mk)

## Thse are default settings, it gets changed as per sku manifest properties
PRODUCT_NAME := wx_na_wf
PRODUCT_DEVICE := ardbeg
PRODUCT_MODEL := wx_na_wf
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

## SKU specific overrides
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../t124/init.none.rc:root/init.none.rc

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
    BCMBINARIES_PATH := vendor/nvidia/tegra/3rdparty/bcmbinaries
else
    BCMBINARIES_PATH := vendor/nvidia/tegra/prebuilt/ardbeg/3rdparty/bcmbinaries
endif

PRODUCT_COPY_FILES += \
    $(BCMBINARIES_PATH)/bcm43241/wlan/sdio-ag-pno-p2p-proptxstatus-dmatxrc-rxov-pktfilter-keepalive-aoe-vsdb-wapi-wl11d-sr-srvsdb-opt1.bin:system/vendor/firmware/bcm43241/fw_bcmdhd.bin

PRODUCT_PROPERTY_OVERRIDES += ro.radio.noril=true

PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/../t124/overlay-tablet

## GPS configuration
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/gpsconfig-wf-ardbeg.xml:system/etc/gps/gpsconfig.xml

## common settings for all sku except for diag
include $(LOCAL_PATH)/wx_common_user.mk

## common apps for all skus
$(call inherit-product-if-exists, vendor/nvidia/$(_product_device)/skus/wx_common_user.mk)

## nvidia apps for this sku
$(call inherit-product-if-exists, vendor/nvidia/$(_product_device)/skus/$(_product_name).mk)

## GMS apps
$(call inherit-product-if-exists, 3rdparty/google/gms-apps/products/gms.mk)

## Clean local variables
_product_name :=
_product_device :=

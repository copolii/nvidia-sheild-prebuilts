# NVIDIA Tegra4 "Roth" development system
#
# Copyright (c) 2012 NVIDIA Corporation.  All rights reserved.

$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)

ifeq ($(wildcard 3rdparty/google/gms-apps/products/gms.mk),3rdparty/google/gms-apps/products/gms.mk)
$(call inherit-product, 3rdparty/google/gms-apps/products/gms.mk)
endif

ifeq ($(wildcard 3rdparty/applications/prebuilt/common/products/roth.mk),3rdparty/applications/prebuilt/common/products/roth.mk)
$(call inherit-product, 3rdparty/applications/prebuilt/common/products/roth.mk)
endif

PRODUCT_NAME := roth
PRODUCT_DEVICE := roth
PRODUCT_MODEL := SHIELD
PRODUCT_MANUFACTURER := NVIDIA
PRODUCT_BRAND := nvidia

PRODUCT_LOCALES += en_US
PRODUCT_PROPERTY_OVERRIDES += \
ro.com.google.clientidbase=android-nvidia

# required for market filtering
NVSI_PRODUCT_CLASS := shield

$(call inherit-product-if-exists, vendor/nvidia/tegra/secureos/nvsi/nvsi.mk)

$(call inherit-product, device/nvidia/roth/device.mk)

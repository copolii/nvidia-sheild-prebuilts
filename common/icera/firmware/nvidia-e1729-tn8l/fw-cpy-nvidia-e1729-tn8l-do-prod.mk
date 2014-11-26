# Copyright (c) 2014 NVIDIA Corporation.  All rights reserved.

SYSTEM_ICERA_FW_PATH=system/vendor/firmware/icera
LOCAL_ICERA_FW_PATH_ROOT=vendor/nvidia/tegra/icera/firmware/binaries/binaries_nvidia-e1729-tn8l
LOCAL_ICERA_NALA_FW_PATH_ROOT=vendor/nvidia/tegra/icera/firmware/binaries/binaries_nvidia-e1729-tn8l-nala

# Is there a dev folder?
ifneq ($(wildcard $(LOCAL_ICERA_FW_PATH_ROOT)/dev),)
    LOCAL_ICERA_FW_PATH_DEV=$(LOCAL_ICERA_FW_PATH_ROOT)/dev
else
    LOCAL_ICERA_FW_PATH_DEV=$(LOCAL_ICERA_FW_PATH_ROOT)
endif

# Is there a prod folder?
ifneq ($(wildcard $(LOCAL_ICERA_FW_PATH_ROOT)/prod),)
    LOCAL_ICERA_FW_PATH_PROD=$(LOCAL_ICERA_FW_PATH_ROOT)/prod
else
    LOCAL_ICERA_FW_PATH_PROD=$(LOCAL_ICERA_FW_PATH_ROOT)
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
    LOCAL_ICERA_NALA_FW_PATH_DEV=$(LOCAL_ICERA_FW_PATH_DEV)
    LOCAL_ICERA_NALA_FW_PATH_PROD=$(LOCAL_ICERA_FW_PATH_PROD)
endif

# If "product" build - point to prod folder if exists
LOCAL_ICERA_FW_PATH=$(LOCAL_ICERA_FW_PATH_DEV)
LOCAL_ICERA_NALA_FW_PATH=$(LOCAL_ICERA_NALA_FW_PATH_DEV)
ifneq (,$(filter $(TARGET_BUILD_TYPE)-$(TARGET_BUILD_VARIANT),release-user release-userdebug))
    LOCAL_ICERA_FW_PATH=$(LOCAL_ICERA_FW_PATH_PROD)
    LOCAL_ICERA_NALA_FW_PATH=$(LOCAL_ICERA_NALA_FW_PATH_PROD)
endif

# Embed both eu and na firmware
PRODUCT_COPY_FILES += \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/secondary_boot.wrapped:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729/secondary_boot.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/loader.wrapped:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729/loader.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/modem.wrapped:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729/modem.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/audioConfig.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729/audioConfig.bin) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_FW_PATH)/productConfigXml_icera_e1729_tn8l.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729/productConfig.bin) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_NALA_FW_PATH)/secondary_boot.wrapped:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-nala/secondary_boot.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_NALA_FW_PATH)/loader.wrapped:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-nala/loader.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_NALA_FW_PATH)/modem.wrapped:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-nala/modem.wrapped) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_NALA_FW_PATH)/audioConfig.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-nala/audioConfig.bin) \
        $(call add-to-product-copy-files-if-exists, $(LOCAL_ICERA_NALA_FW_PATH)/productConfigXml_icera_e1729_tn8l_nala.bin:$(SYSTEM_ICERA_FW_PATH)/nvidia-e1729-nala/productConfig.bin)

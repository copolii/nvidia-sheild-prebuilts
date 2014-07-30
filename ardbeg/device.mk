

# NVIDIA Tegra5 "Ardbeg" development system
#
# Copyright (c) 2013 NVIDIA Corporation.  All rights reserved.

## Common property overrides
PRODUCT_PROPERTY_OVERRIDES += ro.com.google.clientidbase=android-nvidia

## Common packages
$(call inherit-product-if-exists, vendor/nvidia/tegra/secureos/nvsi/nvsi.mk)
$(call inherit-product-if-exists, frameworks/base/data/videos/VideoPackage2.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage3.mk)
$(call inherit-product-if-exists, vendor/nvidia/tegra/core/nvidia-tegra-vendor.mk)
$(call inherit-product-if-exists, vendor/nvidia/tegra/ardbeg/partition-data/factory-ramdisk/factory.mk)

include device/nvidia/common/dalvik/tablet-10in-hdpi-2048-dalvik-heap.mk
include $(LOCAL_PATH)/touchscreen/raydium/raydium.mk

PRODUCT_AAPT_CONFIG += mdpi hdpi xhdpi

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
    NVFLASH_FILES_PATH := vendor/nvidia/tegra/bootloader/nvbootloader/odm-partner/ardbeg
else
    NVFLASH_FILES_PATH := vendor/nvidia/tegra/odm/ardbeg
endif

PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/PM358_Hynix_2GB_H5TC4G63AFR_RDA_792MHz.cfg:flash_pm358_792.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/PM359_Hynix_2GB_H5TC4G63AFR_RDA_792MHz.cfg:flash_pm359_792.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1780_Hynix_2GB_H5TC4G63AFR_RDA_408Mhz.cfg:flash_e1780_408.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1780_Hynix_2GB_H5TC4G63AFR_RDA_792Mhz.cfg:flash_e1780_792.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1780_Hynix_4GB_H5TC8G63AMR_PBA_792Mhz.cfg:flash_e1780_4gb_792.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1780_Hynix_2GB_H5TC4G63AFR_RDA_924Mhz.cfg:flash_e1780_924.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1782_Hynix_4GB_H5TC8G63AMR_PBA_792Mhz.cfg:flash_e1782_4gb_792.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1782_Hynix_2GB_H5TC4G63AFR_RDA_924Mhz.cfg:flash_e1782_924.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1782_Hynix_4GB_H5TC8G63AMR_PBA_792Mhz_spi.cfg:flash_e1782_4gb_792_spi.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1782_Hynix_2GB_H5TC4G63AFR_RDA_924Mhz_spi.cfg:flash_e1782_924_spi.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1792_Elpida_2GB_EDFA164A2MA_JD_F_792MHz.cfg:flash_e1792_792.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1792_Elpida_2GB_EDFA164A2MA_JD_F_924MHz.cfg:flash_e1792_924.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1791_Elpida_4GB_edfa232a2ma_792MHz.cfg:flash_e1791_4gb_792.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1791_Elpida_4GB_edfa232a2ma_924MHz.cfg:flash_e1791_4gb_924.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1761_Hynix_4GB_H5TC4G63AFR_PBA_792Mhz.cfg:flash_e1761_4gb_792.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1761_Hynix_2GB_H5TC4G63AFR_PBA_792Mhz.cfg:flash_e1761_2gb_792.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1761_Hynix_2GB_H5TC4G63AFR_RDA_924MHz.cfg:flash_e1761_2gb_924.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1922_samsung_pop_3GB_K3QF6F60MM_924MHz.cfg:flash_e1922_3gb_924.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1923_samsung_pop_3GB_K3QF6F60MM_924MHz.cfg:flash_e1923_3gb_924.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/eks_nokey.dat:eks.dat \
    $(NVFLASH_FILES_PATH)/nvflash/NCT_ardbeg.txt:NCT_ardbeg.txt \
    $(NVFLASH_FILES_PATH)/nvflash/nct_tn8.txt:nct_tn8.txt \
    $(NVFLASH_FILES_PATH)/nvflash/nct_tn8-ffd.txt:nct_tn8-ffd.txt \
    $(NVFLASH_FILES_PATH)/partition_data/config/nvcamera.conf:system/etc/nvcamera.conf \
    $(NVFLASH_FILES_PATH)/nvflash/common_bct.cfg:bct.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/fuse_write.txt:fuse_write.txt \
    $(NVFLASH_FILES_PATH)/nvflash/tn8_bootsplash.bmp:tn8_bootsplash.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/tn8_bootsplash_land.bmp:tn8_bootsplash_land.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/lowbat.bmp:lowbat.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/charging.bmp:charging.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/charged.bmp:charged.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/fullycharged.bmp:fullycharged.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/charging.png:root/res/images/charger/charging.png \
    $(NVFLASH_FILES_PATH)/nvflash/charged.png:root/res/images/charger/charged.png \
    $(NVFLASH_FILES_PATH)/nvflash/fullycharged.png:root/res/images/charger/fullycharged.png \
    $(NVFLASH_FILES_PATH)/nvflash/nvbdktest_plan.txt:nvbdktest_plan.txt

ifeq ($(APPEND_DTB_TO_KERNEL), true)
PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_nvtboot_emmc_full.cfg:flash.cfg
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_nvtboot_spi_sata_full.cfg:flash_spi_sata.cfg
else
ifeq ($(BUILD_NV_CRASHCOUNTER),true)
PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/android_cc_fastboot_dtb_emmc_full.cfg:flash.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/android_cc_fastboot_nvtboot_dtb_spi_sata_full.cfg:flash_spi_sata.cfg
else
PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_nvtboot_nct_dtb_emmc_full.cfg:flash.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_nvtboot_dtb_spi_sata_full.cfg:flash_spi_sata.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_nvtboot_nct_dtb_emmc_full.cfg:flash_nct.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/laguna_android_fastboot_nvtboot_dtb_emmc_full.cfg:laguna_flash.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/tn8_android_fastboot_nvtboot_dtb_emmc_full.cfg:tn8_flash.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/tn8_android_fastboot_nvtboot_dtb_emmc_full_signed.cfg:tn8_flash_signed.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/tn8_android_fastboot_nvtboot_dtb_emmc_full_mfgtest.cfg:tn8diag_flash.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/tn8_android_fastboot_nvtboot_dtb_emmc_full_mfgtest_signed.cfg:tn8diag_flash_signed.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/norrin_android_fastboot_nvtboot_dtb_emmc_full.cfg:norrin_flash.cfg

NVFLASH_CFG_BASE_FILE := $(NVFLASH_FILES_PATH)/nvflash/tn8_android_fastboot_nvtboot_dtb_emmc_full.cfg
endif
endif

NVFLASH_FILES_PATH :=

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/ueventd.ardbeg.rc:root/ueventd.ardbeg.rc \
  $(LOCAL_PATH)/ueventd.ardbeg.rc:root/ueventd.laguna.rc \
  $(LOCAL_PATH)/ueventd.ardbeg.rc:root/ueventd.norrin.rc \
  $(LOCAL_PATH)/ueventd.ardbeg.rc:root/ueventd.tn8.rc \
  $(LOCAL_PATH)/ueventd.ardbeg.rc:root/ueventd.ardbeg_sata.rc \
  $(LOCAL_PATH)/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl \
  $(LOCAL_PATH)/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
  $(LOCAL_PATH)/Vendor_0955_Product_7210.kl:system/usr/keylayout/Vendor_0955_Product_7210.kl \
  $(LOCAL_PATH)/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
  $(LOCAL_PATH)/touch.idc:system/usr/idc/touch.idc \
  $(LOCAL_PATH)/sensor00fn11.idc:system/usr/idc/sensor00fn11.idc \
  $(LOCAL_PATH)/../common/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \
  $(LOCAL_PATH)/../common/wifi_loader.sh:system/bin/wifi_loader.sh \
  $(LOCAL_PATH)/../common/wpa_supplicant.sh:system/bin/wpa_supplicant.sh \
  $(LOCAL_PATH)/../common/gps_select.sh:system/bin/gps_select.sh \
  $(LOCAL_PATH)/../common/ussr_setup.sh:system/bin/ussr_setup.sh \
  $(LOCAL_PATH)/ussrd.conf:system/etc/ussrd.conf \
  $(LOCAL_PATH)/../common/input_cfboost_init.sh:system/bin/input_cfboost_init.sh \
  $(LOCAL_PATH)/../common/set_hwui_params.sh:system/bin/set_hwui_params.sh \
  $(LOCAL_PATH)/../common/set_light_sensor_perm.sh:system/bin/set_light_sensor_perm.sh \
  $(LOCAL_PATH)/../common/comms/marvel_wpa.conf:/system/etc/firmware/marvel_wpa.conf \
  $(LOCAL_PATH)/../common/comms/marvel_p2p.conf:/system/etc/firmware/marvel_p2p.conf

PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/../common/init_lbh.sh:system/bin/init_lbh.sh

ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml \
   $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml \
   $(LOCAL_PATH)/audio_policy.conf:system/etc/audio_policy.conf
else
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/media_profiles_noenhance.xml:system/etc/media_profiles.xml \
   $(LOCAL_PATH)/media_codecs_noenhance.xml:system/etc/media_codecs.xml \
   $(LOCAL_PATH)/audio_policy_noenhance.conf:system/etc/audio_policy.conf
endif

# t124 SOC rc files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../t124/init.tegra.rc:root/init.tegra.rc \
    $(LOCAL_PATH)/../t124/init.t124.rc:root/init.t124.rc \
    $(LOCAL_PATH)/../t124/init.tegra_sata.rc:root/init.tegra_sata.rc \
    $(LOCAL_PATH)/../t124/init.tegra_emmc.rc:root/init.tegra_emmc.rc

# ardbeg rc files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power.ardbeg.rc:system/etc/power.ardbeg.rc \
    $(LOCAL_PATH)/power.tn8.rc:system/etc/power.tn8.rc \
    $(LOCAL_PATH)/init.ardbeg.rc:root/init.ardbeg.rc \
    $(LOCAL_PATH)/init.laguna.rc:root/init.laguna.rc \
    $(LOCAL_PATH)/init.norrin.rc:root/init.norrin.rc \
    $(LOCAL_PATH)/init.tn8.rc:root/init.tn8.rc \
    $(LOCAL_PATH)/init.ardbeg_sata.rc:root/init.ardbeg_sata.rc \
    $(LOCAL_PATH)/fstab.ardbeg:root/fstab.ardbeg \
    $(LOCAL_PATH)/fstab.tn8:root/fstab.tn8 \
    $(LOCAL_PATH)/fstab.laguna:root/fstab.laguna \
    $(LOCAL_PATH)/fstab.norrin:root/fstab.norrin \
    $(LOCAL_PATH)/fstab.ardbeg_sata:root/fstab.ardbeg_sata \
    $(LOCAL_PATH)/init.tn8.usb.rc:root/init.tn8.usb.rc \
    $(LOCAL_PATH)/../common/init.nv_dev_board.usb.rc:root/init.nv_dev_board.usb.rc

ifeq ($(NO_ROOT_DEVICE),1)
  PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init_no_root_device.rc:root/init.rc
endif

# Face detection model
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/core/include/ft/model_frontalface.xml:system/etc/model_frontal.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../common/cluster:system/bin/cluster \
    $(LOCAL_PATH)/../common/cluster_get.sh:system/bin/cluster_get.sh \
    $(LOCAL_PATH)/../common/cluster_set.sh:system/bin/cluster_set.sh \
    $(LOCAL_PATH)/../common/dcc:system/bin/dcc \
    $(LOCAL_PATH)/../common/hotplug:system/bin/hotplug \
    $(LOCAL_PATH)/../common/mount_debugfs.sh:system/bin/mount_debugfs.sh

PRODUCT_COPY_FILES += \
    device/nvidia/ardbeg/nvcms/device.cfg:system/lib/nvcms/device.cfg

PRODUCT_COPY_FILES += \
    device/nvidia/common/bdaddr:system/etc/bluetooth/bdaddr \
    device/nvidia/ardbeg/audioConfig_qvoice_icera_pc400.xml:system/etc/audioConfig_qvoice_icera_pc400.xml \
    device/nvidia/ardbeg/nvaudio_conf.xml:system/etc/nvaudio_conf.xml \
    device/nvidia/ardbeg/nvaudio_fx.xml:system/etc/nvaudio_fx.xml \
    hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/fw_bcm4330_abg.bin:system/vendor/firmware/bcm4330/fw_bcmdhd.bin \
    hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/fw_bcm4330_apsta_bg.bin:system/vendor/firmware/bcm4330/fw_bcmdhd_apsta.bin \
    hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/fw_bcm4329_abg.bin:system/vendor/firmware/bcm4329/fw_bcmdhd.bin \
    hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/fw_bcm4329_apsta.bin:system/vendor/firmware/bcm4329/fw_bcmdhd_apsta.bin

PRODUCT_COPY_FILES += \
    device/nvidia/ardbeg/enctune.conf:system/etc/enctune.conf

PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/bcm4752/glgps_nvidiaTegra2android:system/bin/glgps_nvidiaTegra2android \
    vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/bcm4752/gpslogd_nvidiaTegra2android:system/bin/gpslogd \
    vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/bcm4752/gps.tegra.so:system/lib/hw/gps.brcm.so

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
    BCMBINARIES_PATH := vendor/nvidia/tegra/3rdparty/bcmbinaries
else
    BCMBINARIES_PATH := vendor/nvidia/tegra/prebuilt/ardbeg/3rdparty/bcmbinaries
endif

PRODUCT_COPY_FILES += \
    $(BCMBINARIES_PATH)/bcm4329/bluetooth/bcmpatchram.hcd:system/etc/firmware/bcm4329.hcd \
    $(BCMBINARIES_PATH)/bcm4330/bluetooth/BCM4330B1_002.001.003.0379.0390.hcd:system/etc/firmware/bcm4330.hcd \
    $(BCMBINARIES_PATH)/bcm43241/bluetooth/AB113_BCM43241B0_0012_Azurewave_AW-AH691_TEST.HCD:system/etc/firmware/bcm43241.hcd \
    $(BCMBINARIES_PATH)/bcm43241/wlan/bcm943241ipaagb_p100_hwoob.txt:system/etc/nvram_43241.txt \
    $(BCMBINARIES_PATH)/bcm43341/bluetooth/BCM43341A0_001.001.030.0015.0000_Generic_UART_37_4MHz_wlbga_iTR_Pluto_Evaluation_for_NVidia.hcd:system/etc/firmware/BCM43341A0_001.001.030.0015.0000.hcd \
    $(BCMBINARIES_PATH)/bcm43341/bluetooth/BCM43341B0_002.001.014.0008.0011.hcd:system/etc/firmware/BCM43341B0_002.001.014.0008.0011.hcd \
    $(BCMBINARIES_PATH)/bcm43341/wlan/sdio-ag-pno-pktfilter-keepalive-aoe-idsup-idauth-wme.bin:system/vendor/firmware/bcm43341/fw_bcmdhd.bin \
    $(BCMBINARIES_PATH)/bcm43341/wlan/sdio-ag-pno-p2p-proptxstatus-dmatxrc-rxov-pktfilter-keepalive-aoe-sr-wapi-wl11d.bin:system/vendor/firmware/bcm43341/fw_bcmdhd_a0.bin \
    $(BCMBINARIES_PATH)/bcm43341/wlan/bcm943341wbfgn_2_hwoob.txt:system/etc/nvram_rev2.txt \
    $(BCMBINARIES_PATH)/bcm43341/wlan/nvram_43341_rev3.txt:system/etc/nvram_rev3.txt \
    $(BCMBINARIES_PATH)/bcm43341/wlan/bcm943341wbfgn_4_hwoob.txt:system/etc/nvram_rev4.txt \
    $(BCMBINARIES_PATH)/bcm4335/bluetooth/BCM4335B0_002.001.006.0037.0046_ORC.hcd:system/etc/firmware/bcm4335.hcd \
    $(BCMBINARIES_PATH)/bcm4335/wlan/bcm94335wbfgn3_r04_hwoob.txt:system/etc/nvram_4335.txt \
    $(BCMBINARIES_PATH)/bcm4335/wlan/sdio-ag-pool-p2p-pno-pktfilter-keepalive-aoe-ccx-sr-vsdb-proptxstatus-lpc-wl11u-autoabn.bin:system/vendor/firmware/bcm4335/fw_bcmdhd.bin


# Nvidia Miracast
#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/../common/miracast/com.nvidia.miracast.xml:system/etc/permissions/com.nvidia.miracast.xml

# NvBlit JNI library
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/graphics-partner/android/frameworks/Graphics/com.nvidia.graphics.xml:system/etc/permissions/com.nvidia.graphics.xml


#enable Widevine drm
PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true
PRODUCT_PACKAGES += \
    com.google.widevine.software.drm.xml \
    com.google.widevine.software.drm \
    libdrmwvmplugin \
    libwvm \
    libWVStreamControlAPI_L1 \
    libwvdrm_L1

#needed by google GMS lib:libpatts_engine_jni_api.so
PRODUCT_PACKAGES += \
    libwebrtc_audio_coding

#Marvell firmware package
PRODUCT_PACKAGES += sd8897_uapsta.bin \
    sd8797_uapsta.bin

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    HoloSpiralWallpaper \
    MagicSmokeWallpapers \
    NoiseField \
    Galaxy4 \
    VisualizationWallpapers \
    PhaseBeam \
    librs_jni

PRODUCT_PACKAGES += \
    sensors.tegra \
    lights.tegra \
    audio.primary.tegra \
    audio.a2dp.default \
    audio.usb.default \
    audio_policy.tegra \
    power.tegra \
    setup_fs \
    drmserver \
    Gallery2 \
    libdrmframework_jni \
    overlaymon \
    e2fsck \
    charger \
    charger_res_images

# Homepage provider APK for Google Chrome browser
PRODUCT_PACKAGES += \
    ChromeCustomizations

# Bookmarks provider APK for Google Chrome browser
PRODUCT_PACKAGES += \
    PartnerBookmarksProvider

PRODUCT_PACKAGES += \
    tos.img

#MTK GPS
PRODUCT_PACKAGES += \
    libssladp \
    mtk_agpsd

#TegraOTA
PRODUCT_PACKAGES += \
    TegraOTA

#ControllerMapper
PRODUCT_PACKAGES += \
    ControllerMapper

#Stats
ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
    PRODUCT_PACKAGES += \
        Stats
endif

PRODUCT_PACKAGES += \
    lbh_images

# NFC packages
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_jni \
    Nfc
   #Tag

# HDCP SRM Support
PRODUCT_PACKAGES += \
    hdcp1x.srm \
    hdcp2x.srm \
    hdcp2xtest.srm

# Application for sending feedback to NVIDIA
PRODUCT_PACKAGES += \
    nvidiafeedback

# Android-OSC
PRODUCT_PACKAGES += \
    NvAndroidOSC

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_CHARACTERISTICS := tablet

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/../t124/overlay-common \
                           $(LOCAL_PATH)/../t124/overlay-tablet

# Enable secure USB debugging in user release build
ifeq ($(TARGET_BUILD_TYPE),release)
ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.adb.secure=1
endif
endif

ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
# Include RSMouse support - ShieldTech is included for the SKU
BOARD_USES_SHIELDTECH_RSMOUSE := true
TARGET_GLOBAL_CPPFLAGS += -DSHIELDTECH_RSMOUSE
TARGET_GLOBAL_CFLAGS += -DSHIELDTECH_RSMOUSE
endif

ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
# Add Blake services
PRODUCT_PACKAGES += \
    com.nvidia.blakemanager \
    com.nvidia.blakemanager.xml \
    NvBlakeManager \
    libblake_jni \
    blake.tegra \
    BlakePairing

endif

# Copy public/private tnspecs
ifeq ($(wildcard vendor/nvidia/ardbeg/tnspec.json),vendor/nvidia/ardbeg/tnspec.json)
PRODUCT_COPY_FILES += vendor/nvidia/ardbeg/tnspec.json:tnspec.json
else ifeq ($(wildcard $(LOCAL_PATH)/tnspec.json),$(LOCAL_PATH)/tnspec.json)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/tnspec.json:tnspec-public.json
endif

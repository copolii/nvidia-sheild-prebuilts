# NVIDIA Tegra4 "Roth" development system
#
# Copyright (c) 2012-2013 NVIDIA Corporation.  All rights reserved.

$(call inherit-product-if-exists, vendor/nvidia/tegra/core/nvidia-tegra-vendor.mk)
$(call inherit-product-if-exists, frameworks/base/data/videos/VideoPackage2.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage3.mk)
$(call inherit-product, build/target/product/languages_full.mk)

PRODUCT_LOCALES += mdpi hdpi xhdpi

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
    NVFLASH_FILES_PATH := vendor/nvidia/tegra/customers/nvidia-partner/roth
else
    NVFLASH_FILES_PATH := vendor/nvidia/tegra/odm/roth
endif

ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/P2454_Hynix_4gb_H5TC4G43AFR_204MHz.cfg:flash_204Mhz.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/P2454_Hynix_4gb_H5TC4G43AFR_204Mhz.bct:flash_204Mhz.bct \
    $(NVFLASH_FILES_PATH)/nvflash/P2454_Hynix_4gb_H5TC4G43AFR_450Mhz.cfg:bct.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/P2454_Hynix_4gb_H5TC4G43AFR_450Mhz.bct:flash.bct \
    $(NVFLASH_FILES_PATH)/nvflash/P2454_Hynix_4gb_H5TC4G43AFR_480Mhz.cfg:flash_480Mhz.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/P2454_Hynix_4gb_H5TC4G43AFR_480Mhz.bct:flash_480Mhz.bct \
    $(NVFLASH_FILES_PATH)/nvflash/P2454_Hynix_4gb_H5TC4G43AFR_528Mhz.cfg:flash_528Mhz.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/P2454_Hynix_4gb_H5TC4G43AFR_528Mhz.bct:flash_528Mhz.bct \
    $(NVFLASH_FILES_PATH)/nvflash/P2454_Hynix_4gb_H5TC4G43AFR_660Mhz.cfg:flash_660Mhz.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/P2454_Hynix_4gb_H5TC4G43AFR_660Mhz.bct:flash_660Mhz.bct \
    $(NVFLASH_FILES_PATH)/nvflash/P2454_Hynix_4gb_H5TC4G43AFR_792Mhz.cfg:flash_792Mhz.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/P2454_Hynix_4gb_H5TC4G43AFR_792Mhz.bct:flash_792Mhz.bct \
    $(NVFLASH_FILES_PATH)/nvflash/P2560_Hynix_2GB_H5TC4G63AFR-RDA_450Mhz_r415_v2.cfg:flash_p2560_450Mhz.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/P2560_Hynix_2GB_H5TC4G63AFR-RDA_450Mhz_r415_v2.bct:flash_p2560_450Mhz.bct \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_dtb_emmc_full.cfg:flash.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_dtb_emmc_full_mfg.cfg:flash_mfg.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_dtb_emmc_full_sif.cfg:flash_sif.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/eks_nokey.dat:eks.dat \
    $(NVFLASH_FILES_PATH)/nvflash/SIF.txt:SIF.txt \
    $(NVFLASH_FILES_PATH)/nvflash/nvidia.bmp:nvidia.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/lowbat.bmp:lowbat.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/charging.bmp:charging.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/charged.bmp:charged.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/fullycharged.bmp:fullycharged.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/fuse_write.txt:fuse_write.txt
else
PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/P2560_Hynix_2GB_H5TC4G63AFR-RDA_450Mhz_r415_v2.cfg:flash_p2560_450Mhz.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/P2560_Hynix_2GB_H5TC4G63AFR-RDA_450Mhz_r415_v2.bct:flash_p2560_450Mhz.bct \
    $(NVFLASH_FILES_PATH)/nvflash/eks_nokey.dat:eks.dat \
    $(NVFLASH_FILES_PATH)/nvflash/nvidia.bmp:nvidia.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/lowbat.bmp:lowbat.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/charging.bmp:charging.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/charged.bmp:charged.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/fullycharged.bmp:fullycharged.bmp
endif

NVFLASH_FILES_PATH :=

PRODUCT_COPY_FILES += \
    device/nvidia/roth/roth_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

ifneq (,$(filter $(BOARD_INCLUDES_TEGRA_JNI),display))
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/hal/frameworks/Display/com.nvidia.display.xml:system/etc/permissions/com.nvidia.display.xml
endif

ifneq (,$(filter $(BOARD_INCLUDES_TEGRA_JNI),cursor))
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/hal/frameworks/Graphics/com.nvidia.graphics.xml:system/etc/permissions/com.nvidia.graphics.xml
endif

PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/vold.fstab:system/etc/vold.fstab \
  $(LOCAL_PATH)/ueventd.roth.rc:root/ueventd.roth.rc \
  $(LOCAL_PATH)/Vendor_0955_Product_7202.kl:system/usr/keylayout/Vendor_0955_Product_7202.kl \
  $(LOCAL_PATH)/Vendor_0955_Product_7203.kl:system/usr/keylayout/Vendor_0955_Product_7203.kl \
  $(LOCAL_PATH)/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
  $(LOCAL_PATH)/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
  $(LOCAL_PATH)/raydium_ts.idc:system/usr/idc/raydium_ts.idc \
  $(LOCAL_PATH)/../common/input_cfboost_init.sh:system/bin/input_cfboost_init.sh

ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml \
  $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml \
  $(LOCAL_PATH)/audio_policy.conf:system/etc/audio_policy.conf \
  $(LOCAL_PATH)/overlay/packages/apps/Settings/res/raw/shield_legal.html:system/etc/shield_legal.html \
  $(LOCAL_PATH)/overlay/packages/apps/Settings/res/raw/tos.html:system/etc/tos.html \
  $(LOCAL_PATH)/overlay/packages/apps/Settings/res/raw/priv.html:system/etc/priv.html \
  $(LOCAL_PATH)/overlay/packages/apps/Settings/res/raw/shield_legal_zh_tw.html:system/etc/shield_legal_zh_tw.html \
  $(LOCAL_PATH)/overlay/packages/apps/Settings/res/raw/tos_zh_tw.html:system/etc/tos_zh_tw.html \
  $(LOCAL_PATH)/overlay/packages/apps/Settings/res/raw/priv_zh_tw.html:system/etc/priv_zh_tw.html \
  $(LOCAL_PATH)/overlay/packages/apps/Settings/res/raw/shield_legal_zh_cn.html:system/etc/shield_legal_zh_cn.html \
  $(LOCAL_PATH)/overlay/packages/apps/Settings/res/raw/tos_zh_cn.html:system/etc/tos_zh_cn.html \
  $(LOCAL_PATH)/overlay/packages/apps/Settings/res/raw/priv_zh_cn.html:system/etc/priv_zh_cn.html
else
PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/media_profiles_noenhance.xml:system/etc/media_profiles.xml \
  $(LOCAL_PATH)/media_codecs_noenhance.xml:system/etc/media_codecs.xml \
  $(LOCAL_PATH)/audio_policy_noenhance.conf:system/etc/audio_policy.conf
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power.roth.rc:system/etc/power.roth.rc \
    $(LOCAL_PATH)/init.roth.rc:root/init.roth.rc \
    $(LOCAL_PATH)/fstab.roth:root/fstab.roth \
    $(LOCAL_PATH)/init.roth.usb.rc:root/init.roth.usb.rc

ifeq ($(NO_ROOT_DEVICE),1)
  PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init_no_root_device.rc:root/init.rc
endif

# Face detection model
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/core/include/ft/model_frontalface.xml:system/etc/model_frontal.xml

# Test files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../common/cluster:system/bin/cluster \
    $(LOCAL_PATH)/../common/cluster_get.sh:system/bin/cluster_get.sh \
    $(LOCAL_PATH)/../common/cluster_set.sh:system/bin/cluster_set.sh \
    $(LOCAL_PATH)/../common/dcc:system/bin/dcc \
    $(LOCAL_PATH)/../common/hotplug:system/bin/hotplug \
    $(LOCAL_PATH)/../common/mount_debugfs.sh:system/bin/mount_debugfs.sh

PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/graphics-partner/android/build/egl.cfg:system/lib/egl/egl.cfg

PRODUCT_COPY_FILES += \
    device/nvidia/roth/nvcms/device.cfg:system/lib/nvcms/device.cfg

PRODUCT_COPY_FILES += \
	device/nvidia/common/bdaddr:system/etc/bluetooth/bdaddr \
	device/nvidia/roth/nvaudio_conf.xml:system/etc/nvaudio_conf.xml \
	device/nvidia/roth/audioConfig_qvoice_icera_pc400.xml:system/etc/audioConfig_qvoice_icera_pc400.xml

ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
# Configuration files for WiiMote support
PRODUCT_COPY_FILES += \
	vendor/nvidia/tegra/3rdparty/cwiid/wminput/configs/acc_ptr:system/etc/acc_ptr \
	vendor/nvidia/tegra/3rdparty/cwiid/wminput/configs/nunchuk_acc_ptr:system/etc/nunchuk_acc_ptr \
	vendor/nvidia/tegra/3rdparty/cwiid/wminput/configs/acc_led:system/etc/acc_led \
	vendor/nvidia/tegra/3rdparty/cwiid/wminput/configs/neverball:system/etc/neverball \
	vendor/nvidia/tegra/3rdparty/cwiid/wminput/configs/ir_ptr:system/etc/ir_ptr \
	vendor/nvidia/tegra/3rdparty/cwiid/wminput/configs/gamepad:system/etc/gamepad \
	vendor/nvidia/tegra/3rdparty/cwiid/wminput/configs/buttons:system/etc/buttons \
	vendor/nvidia/tegra/3rdparty/cwiid/wminput/configs/nunchuk_stick2btn:system/etc/nunchuk_stick2btn
endif

PRODUCT_COPY_FILES += \
	device/nvidia/roth/enctune.conf:system/etc/enctune.conf

ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
    PRODUCT_COPY_FILES += \
       vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/bcm4752/glgps_nvidiaTegra2android:system/bin/glgps_nvidiaTegra2android \
       vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/bcm4752/gpslogd_nvidiaTegra2android:system/bin/gpslogd \
       vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/gpsconfig-roth.xml:system/etc/gps/gpsconfig.xml \
       vendor/nvidia/tegra/3rdparty/broadcom/gps/bin/bcm4752/gps.tegra.so:system/lib/hw/gps.tegra.so 
endif

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
PRODUCT_COPY_FILES += \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm43241/wlan/sdio-ag-pno-p2p-proptxstatus-dmatxrc-rxov-pktfilter-keepalive-aoe-vsdb-wapi-wl11d-sr-srvsdb-opt1.bin:system/vendor/firmware/bcm43241/fw_bcmdhd.bin \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm43241/wlan/bcm943241ipaagb_p100_hwoob.txt:system/etc/nvram_43241.txt \
   vendor/nvidia/tegra/3rdparty/bcmbinaries/bcm43241/bluetooth/AB113_BCM43241B0_0012_Azurewave_AW-AH691_TEST.HCD:system/etc/firmware/bcm43241.hcd
else
ifeq ($(NV_ANDROID_FRAMEWORK_ENHANCEMENTS),TRUE)
    PRODUCT_COPY_FILES += \
       vendor/nvidia/tegra/prebuilt/roth/3rdparty/bcmbinaries/bcm43241/wlan/sdio-ag-pno-p2p-proptxstatus-dmatxrc-rxov-pktfilter-keepalive-aoe-vsdb-wapi-wl11d-sr-srvsdb-opt1.bin:system/vendor/firmware/bcm43241/fw_bcmdhd.bin \
       vendor/nvidia/tegra/prebuilt/roth/3rdparty/bcmbinaries/bcm43241/wlan/bcm943241ipaagb_p100_hwoob.txt:system/etc/nvram_43241.txt \
       vendor/nvidia/tegra/prebuilt/roth/3rdparty/bcmbinaries/bcm43241/bluetooth/AB113_BCM43241B0_0012_Azurewave_AW-AH691_TEST.HCD:system/etc/firmware/bcm43241.hcd
endif
endif


# Stereo API permissions file has different locations in private and customer builds
ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/stereo/api/com.nvidia.nvstereoutils.xml:system/etc/permissions/com.nvidia.nvstereoutils.xml
else
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/prebuilt/roth/stereo/api/com.nvidia.nvstereoutils.xml:system/etc/permissions/com.nvidia.nvstereoutils.xml
endif

# Power Features
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/overlay/frameworks/base/data/etc/com.nvidia.powerfeatures.xml:system/etc/permissions/com.nvidia.powerfeatures.xml

# Enable following APKs only for internal engineering build
ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
PRODUCT_PACKAGES += \
    WidevineSamplePlayer \
    NvwfdServiceTest \
    TegraOTA
endif

# Nvidia Miracast
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../common/miracast/com.nvidia.miracast.xml:system/etc/permissions/com.nvidia.miracast.xml

#enable Widevine drm
PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true
PRODUCT_PACKAGES += \
    com.google.widevine.software.drm.xml \
    com.google.widevine.software.drm \
    libdrmwvmplugin \
    libwvm \
    libWVStreamControlAPI_L1 \
    libwvdrm_L1

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
	sensors.roth \
	lights.roth \
	audio.primary.tegra \
	audio.a2dp.default \
	audio.usb.default \
	audio_policy.tegra \
	power.roth \
	setup_fs \
	drmserver \
	Gallery2 \
	libdrmframework_jni \
	InputViewer \
	nvidiafeedback

PRODUCT_PACKAGES += nvaudio_test

# Nvidia baseband integration
PRODUCT_PACKAGES += nvidia_tegra_icera_common_modules \
                    nvidia_tegra_icera_tablet_modules

# CPU volt cap daemon
PRODUCT_PACKAGES += \
	nvcpuvoltcapd

PRODUCT_PACKAGES += send_bug
PRODUCT_COPY_FILES += \
	system/extras/bugmailer/bugmailer.sh:system/bin/bugmailer.sh \
	system/extras/bugmailer/send_bug:system/bin/send_bug

# Support USB accessory
PRODUCT_PACKAGES += com.android.future.usb.accessory

include frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk
include $(LOCAL_PATH)/touchscreen/raydium/raydium.mk
# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_CHARACTERISTICS := shield

ifeq ($(wildcard vendor/nvidia/roth/rothui.mk),vendor/nvidia/roth/rothui.mk)
$(call inherit-product, vendor/nvidia/roth/rothui.mk)
else
DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay
endif

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

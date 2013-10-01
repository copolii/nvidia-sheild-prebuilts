# NVIDIA Tegra4 "Tegratab" development system
#
# Copyright (c) 2012-2013 NVIDIA Corporation.  All rights reserved.

$(call inherit-product-if-exists, vendor/nvidia/tegra/core/nvidia-tegra-vendor.mk)
$(call inherit-product-if-exists, frameworks/base/data/videos/VideoPackage2.mk)
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage3.mk)
$(call inherit-product, build/target/product/languages_full.mk)

PRODUCT_LOCALES += mdpi hdpi xhdpi

ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
    NVFLASH_FILES_PATH := vendor/nvidia/tegra/customers/nvidia-partner/tegratab
else
    NVFLASH_FILES_PATH := vendor/nvidia/tegra/odm/tegratab
endif

PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/P1640_Micron_1GB_MT41K128M16-125_408Mhz_v02_Hynix_1GB_H5TC2G63FFR-PBA_408Mhz_v01.cfg:bct.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/P1640_Micron_1GB_MT41K128M16-125_408Mhz_v02_Hynix_1GB_H5TC2G63FFR-PBA_408Mhz_v01.bct:flash.bct \
    $(NVFLASH_FILES_PATH)/nvflash/P1640_Micron_1GB_MT41K128M16-125_408Mhz_v02_Hynix_1GB_H5TC2G63FFR-PBA_408Mhz_v01.cfg:flash_tegratab_p1640.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/P1640_Micron_1GB_MT41K128M16-125_408Mhz_v02_Hynix_1GB_H5TC2G63FFR-PBA_408Mhz_v01.bct:flash_tegratab_p1640.bct \
    $(NVFLASH_FILES_PATH)/nvflash/E1569_Micron_1GB_MT41K128M16-125_408Mhz.cfg:flash_tegratab_e1569.cfg \
    $(NVFLASH_FILES_PATH)/nvflash/E1569_Micron_1GB_MT41K128M16-125_408Mhz.bct:flash_tegratab_e1569.bct \
    $(NVFLASH_FILES_PATH)/nvflash/eks_nokey.dat:eks.dat \
    $(NVFLASH_FILES_PATH)/partition_data/config/nvcamera.conf:system/etc/nvcamera.conf \
    $(NVFLASH_FILES_PATH)/nvflash/lowbat.bmp:lowbat.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/charging.bmp:charging.bmp \
    $(NVFLASH_FILES_PATH)/nvflash/fuse_write.txt:fuse_write.txt \
    $(NVFLASH_FILES_PATH)/nvflash/nct_gb.txt:nct_gb.txt \
    $(NVFLASH_FILES_PATH)/nvflash/nct_gp.txt:nct_gp.txt \
    $(NVFLASH_FILES_PATH)/nvflash/nct_nb.txt:nct_nb.txt \
    $(NVFLASH_FILES_PATH)/nvflash/nct_np.txt:nct_np.txt

ifeq ($(TARGET_PRODUCT),kalamata)
    ifneq ($(wildcard vendor/nvidia/kalamata/media/hpLogo.bmp),)
        PRODUCT_COPY_FILES += vendor/nvidia/kalamata/media/hpLogo.bmp:nvidia.bmp
    else
        PRODUCT_COPY_FILES += $(NVFLASH_FILES_PATH)/nvflash/nvidia.bmp:nvidia.bmp
    endif
else
    PRODUCT_COPY_FILES += $(NVFLASH_FILES_PATH)/nvflash/nvidia.bmp:nvidia.bmp
endif

ifeq ($(APPEND_DTB_TO_KERNEL), true)
PRODUCT_COPY_FILES += \
    $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_emmc_full.cfg:flash.cfg
else
NVFLASH_CFG_BASE_FILE := $(NVFLASH_FILES_PATH)/nvflash/android_fastboot_dtb_emmc_full_noxusb_nosif.cfg
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
  $(LOCAL_PATH)/ueventd.tegratab.rc:root/ueventd.tegratab.rc \
  $(LOCAL_PATH)/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl \
  $(LOCAL_PATH)/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
  $(LOCAL_PATH)/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
  $(LOCAL_PATH)/raydium_ts.idc:system/usr/idc/raydium_ts.idc \
  $(LOCAL_PATH)/sensor00fn11.idc:system/usr/idc/sensor00fn11.idc \
  $(LOCAL_PATH)/touch_fusion.idc:system/usr/idc/touch_fusion.idc \
  $(LOCAL_PATH)/../common/ussr_setup.sh:system/bin/ussr_setup.sh \
  $(LOCAL_PATH)/../common/input_cfboost_init.sh:system/bin/input_cfboost_init.sh \
  $(LOCAL_PATH)/../common/set_hwui_params.sh:system/bin/set_hwui_params.sh \
  $(LOCAL_PATH)/camera_lbh.sh:system/bin/camera_lbh.sh \
  $(LOCAL_PATH)/link_lbh.sh:system/bin/link_lbh.sh

PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/init_lbh.sh:system/bin/init_lbh.sh

PRODUCT_COPY_FILES += \
  $(LOCAL_PATH)/sensor_init.sh:system/bin/sensor_init.sh

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

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/power.tegratab.rc:system/etc/power.tegratab.rc \
    $(LOCAL_PATH)/init.tegratab.rc:root/init.tegratab.rc \
    $(LOCAL_PATH)/fstab.tegratab:root/fstab.tegratab \
    $(LOCAL_PATH)/init.tegratab.usb.rc:root/init.tegratab.usb.rc

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
    device/nvidia/tegratab/nvcms/device.cfg:system/lib/nvcms/device.cfg

PRODUCT_COPY_FILES += \
	external/alsa-lib/src/conf/alsa.conf:system/usr/share/alsa/alsa.conf \
	external/alsa-lib/src/conf/pcm/dsnoop.conf:system/usr/share/alsa/pcm/dsnoop.conf \
	external/alsa-lib/src/conf/pcm/modem.conf:system/usr/share/alsa/pcm/modem.conf \
	external/alsa-lib/src/conf/pcm/dpl.conf:system/usr/share/alsa/pcm/dpl.conf \
	external/alsa-lib/src/conf/pcm/default.conf:system/usr/share/alsa/pcm/default.conf \
	external/alsa-lib/src/conf/pcm/surround51.conf:system/usr/share/alsa/pcm/surround51.conf \
	external/alsa-lib/src/conf/pcm/surround41.conf:system/usr/share/alsa/pcm/surround41.conf \
	external/alsa-lib/src/conf/pcm/surround50.conf:system/usr/share/alsa/pcm/surround50.conf \
	external/alsa-lib/src/conf/pcm/dmix.conf:system/usr/share/alsa/pcm/dmix.conf \
	external/alsa-lib/src/conf/pcm/center_lfe.conf:system/usr/share/alsa/pcm/center_lfe.conf \
	external/alsa-lib/src/conf/pcm/surround40.conf:system/usr/share/alsa/pcm/surround40.conf \
	external/alsa-lib/src/conf/pcm/side.conf:system/usr/share/alsa/pcm/side.conf \
	external/alsa-lib/src/conf/pcm/iec958.conf:system/usr/share/alsa/pcm/iec958.conf \
	external/alsa-lib/src/conf/pcm/rear.conf:system/usr/share/alsa/pcm/rear.conf \
	external/alsa-lib/src/conf/pcm/surround71.conf:system/usr/share/alsa/pcm/surround71.conf \
	external/alsa-lib/src/conf/pcm/front.conf:system/usr/share/alsa/pcm/front.conf \
	external/alsa-lib/src/conf/cards/aliases.conf:system/usr/share/alsa/cards/aliases.conf \
	device/nvidia/tegratab/asound.conf:system/etc/asound.conf

# Configuration files for LBH 0000 which is used as default
PRODUCT_COPY_FILES += \
    device/nvidia/tegratab/lbh/0000_nvaudio_conf.xml:system/etc/lbh/0000_nvaudio_conf.xml \
	device/nvidia/tegratab/lbh/0000_nvaudio_tune.xml:system/etc/lbh/0000_nvaudio_tune.xml \
	device/nvidia/tegratab/lbh/0000_audioConfig_qvoice_icera_pc400.xml:system/etc/lbh/0000_audioConfig_qvoice_icera_pc400.xml \
    device/nvidia/tegratab/lbh/0000_nvaudio_fx.xml:system/etc/lbh/0000_nvaudio_fx.xml

# Configuration files for LBH 0001/0002/0004/0008
PRODUCT_COPY_FILES += \
    device/nvidia/tegratab/lbh/0001_nvaudio_conf.xml:system/etc/lbh/0001_nvaudio_conf.xml \
	device/nvidia/tegratab/lbh/0001_nvaudio_tune.xml:system/etc/lbh/0001_nvaudio_tune.xml \
	device/nvidia/tegratab/lbh/0001_audioConfig_qvoice_icera_pc400.xml:system/etc/lbh/0001_audioConfig_qvoice_icera_pc400.xml \
    device/nvidia/tegratab/lbh/0001_nvaudio_fx.xml:system/etc/lbh/0001_nvaudio_fx.xml \
    device/nvidia/tegratab/lbh/0002_nvaudio_conf.xml:system/etc/lbh/0002_nvaudio_conf.xml \
	device/nvidia/tegratab/lbh/0002_nvaudio_tune.xml:system/etc/lbh/0002_nvaudio_tune.xml \
	device/nvidia/tegratab/lbh/0002_audioConfig_qvoice_icera_pc400.xml:system/etc/lbh/0002_audioConfig_qvoice_icera_pc400.xml \
    device/nvidia/tegratab/lbh/0002_nvaudio_fx.xml:system/etc/lbh/0002_nvaudio_fx.xml \
    device/nvidia/tegratab/lbh/0004_nvaudio_conf.xml:system/etc/lbh/0004_nvaudio_conf.xml \
	device/nvidia/tegratab/lbh/0004_nvaudio_tune.xml:system/etc/lbh/0004_nvaudio_tune.xml \
	device/nvidia/tegratab/lbh/0004_audioConfig_qvoice_icera_pc400.xml:system/etc/lbh/0004_audioConfig_qvoice_icera_pc400.xml \
       device/nvidia/tegratab/lbh/0004_nvaudio_fx.xml:system/etc/lbh/0004_nvaudio_fx.xml \
    device/nvidia/tegratab/lbh/0008_nvaudio_conf.xml:system/etc/lbh/0008_nvaudio_conf.xml \
	device/nvidia/tegratab/lbh/0008_nvaudio_tune.xml:system/etc/lbh/0008_nvaudio_tune.xml \
    device/nvidia/tegratab/lbh/0008_audioConfig_qvoice_icera_pc400.xml:system/etc/lbh/0008_audioConfig_qvoice_icera_pc400.xml \
    device/nvidia/tegratab/lbh/0008_nvaudio_fx.xml:system/etc/lbh/0008_nvaudio_fx.xml

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
	device/nvidia/tegratab/enctune.conf:system/etc/enctune.conf

# nvcpud specific cpu frequencies config
PRODUCT_COPY_FILES += \
        device/nvidia/tegratab/nvcpud.conf:system/etc/nvcpud.conf

# Stereo API permissions file has different locations in private and customer builds
ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/stereo/api/com.nvidia.nvstereoutils.xml:system/etc/permissions/com.nvidia.nvstereoutils.xml
else
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/prebuilt/$(REFERENCE_DEVICE)/stereo/api/com.nvidia.nvstereoutils.xml:system/etc/permissions/com.nvidia.nvstereoutils.xml
endif

# Enable following APKs only for internal engineering build
ifeq ($(wildcard vendor/nvidia/tegra/core-private),vendor/nvidia/tegra/core-private)
PRODUCT_PACKAGES += \
    NvwfdServiceTest
endif

# Nvidia Miracast
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../common/miracast/com.nvidia.miracast.xml:system/etc/permissions/com.nvidia.miracast.xml

# NvBlit JNI library
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/graphics-partner/android/frameworks/Graphics/com.nvidia.graphics.xml:system/etc/permissions/com.nvidia.graphics.xml

# NCT ID help file
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/core/include/nvnct.h:README.nct_id

# EULA
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/eula.html:system/etc/eula.html

# Promotional content
ifneq ($(TARGET_PRODUCT),kalamata)
ifneq ($(wildcard vendor/nvidia/tegra/tegratab/partition-data/media_ad/Movies/TEGRA_NOTE_TapToTrack.mp4),)
PRODUCT_COPY_FILES += \
    vendor/nvidia/tegra/tegratab/partition-data/media_ad/Movies/TEGRA_NOTE_TapToTrack.mp4:data/media/Movies/TEGRA_NOTE_TapToTrack.mp4
endif
endif

#enable Widevine drm
PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true
PRODUCT_PACKAGES += \
    com.google.widevine.software.drm.xml \
    com.google.widevine.software.drm \
    libdrmwvmplugin \
    libwvm \
    libWVStreamControlAPI_L1 \
    libwvdrm_L1 \
    libdrmdecrypt

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    librs_jni

PRODUCT_PACKAGES += \
	sensors.tegratab \
	lights.tegratab \
	audio.primary.tegra \
	audio.a2dp.default \
	audio.usb.default \
	audio_policy.tegra \
	power.tegratab \
	setup_fs \
	drmserver \
	Gallery2 \
	libdrmframework_jni \
	e2fsck \
	nvidiafeedback

PRODUCT_PACKAGES += \
	charger\
	charger_res_images\

PRODUCT_PACKAGES += nvaudio_test

# WiiMote support
PRODUCT_PACKAGES += \
	libcwiid \
	wminput \
	acc \
	ir_ptr \
	led \
	nunchuk_acc \
	nunchuk_stick2btn

# Application to connect WiiMote with Tegra device
PRODUCT_PACKAGES += \
	WiiMote

#WiFi
PRODUCT_PACKAGES += \
		TQS_S_2.6.ini \
		iw \
		crda \
		regulatory.bin \
		wpa_supplicant.conf \
		p2p_supplicant.conf \
		hostapd.conf \
		ibss_supplicant.conf \
		dhcpd.conf \
		dhcpcd.conf

#Wifi firmwares
PRODUCT_PACKAGES += \
		wl1271-nvs_default.bin \
		wl128x-fw-4-sr.bin \
		wl128x-fw-4-mr.bin \
		wl128x-fw-4-plt.bin \
		wl18xx-fw-mc.bin \
		wl18xx-fw-mc_pg22.bin \
		wl18xx-fw.bin \
		wl18xx-fw-mc_v1168.bin \
		wl1271-nvs_wl8.bin

#BT & FM packages
PRODUCT_PACKAGES += \
		uim-sysfs \
		TIInit_10.6.15.bts \
		TIInit_11.8.32.bts \
		TIInit_12.8.32.bts

#GPS
PRODUCT_PACKAGES += \
		agnss_connect \
		client_app \
		client_hwd \
		Connect_Config.txt \
		devproxy \
		dproxy.conf \
		dproxy.patch \
		gps.tegra.so \
		hwd \
		libagnss.so \
		libassist.so \
		libclientlogger.so \
		libdevproxy.so \
		libgnssutils.so \
		Log_MD \
		log_MD.txt \
		logs.txt \
		nvs.txt \
		ser2soc \
		test_server
# CPU volt cap daemon
PRODUCT_PACKAGES += \
	nvcpuvoltcapd

# promotional contents
PRODUCT_PACKAGES += \
	media_ad

# Factory test packages
PRODUCT_PACKAGES += \
	nvbdktestbl \
        pcba_testcases.xml \
        postassembly_testcases.xml \
        preassembly_testcases.xml \
        audio_testcases.xml \
        usbhostumsread \
	tmc \
	tst \
	camera_existence \
	factory_adbd \
	oemcrypto_api_test

# Markers app (renamed to Tegra Draw)
PRODUCT_PACKAGES += \
        TegraDraw

# OV5693 bayer sensor calibration manager
PRODUCT_PACKAGES += otp-ov5693

#bugreport
PRODUCT_PACKAGES += send_bug
  PRODUCT_COPY_FILES += \
    system/extras/bugmailer/bugmailer.sh:system/bin/bugmailer.sh \
    system/extras/bugmailer/send_bug:system/bin/send_bug

ifeq ($(TARGET_PRODUCT),kalamata)
PRODUCT_PACKAGES += gen_tegranote_fuseblob
endif

include frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk
include $(LOCAL_PATH)/touchscreen/maxim/maxim.mk
# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_CHARACTERISTICS := tablet


ifeq ($(TARGET_PRODUCT),kalamata)
    PRODUCT_PACKAGE_OVERLAYS := $(LOCAL_PATH)/../../../vendor/nvidia/kalamata/overlay
else
    PRODUCT_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay
endif

# Include ShieldTech
ifeq ($(wildcard vendor/nvidia/tegra/shieldtech/common/shieldtech.mk),vendor/nvidia/tegra/shieldtech/common/shieldtech.mk)
$(call inherit-product, vendor/nvidia/tegra/shieldtech/common/shieldtech.mk)
endif

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

#enable Widevine drm
PRODUCT_PROPERTY_OVERRIDES += ro.sf.lcd_density=213
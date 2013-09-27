#!/bin/bash
# Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
#---------------------------------------------------------------
# Directory sturcture
#---------------------------------------------------------------
# lbh
#    - app
#      ; copy your prebuilt apps
#      ; game, wallpaper, launcher, lockscreen, home etc.
#    - media
#      ; copy your bootanimation.zip
#           - audio
#                  - ui
#                    ; copy UI effect sound files
#                  - ringtones
#                    ; copy ringtone sound files
#                  - alarms
#                    ; copy alarm sound files
#                  - notifications
#                    ; copy notification sound files
#           - images
#                    ; copy default_wallpaper.jpg
#	- etc
#	  ; nvcamera.conf
#			- permissions
#			  ; android HW permissions file to filter app
#---------------------------------------------------------------

#------------------------------------------------
# Check LBH partition size in your flash.cfg
# sample size: 256MB
#------------------------------------------------
## LBH partition size is predefined, you can’t change this.
LBHIMAGE_PARTITION_SIZE=268435456
LBHIMAGE_FILENAME=lbh.img

#------------------------------------------------
# Define your CM/LBH ID (hexadecimal 4 characters)
# 0000 means NVIDIA defaults
#------------------------------------------------
## You may be allocated CM/LBH ID from NVIDIA. You should change CM_ID and LBH_ID.
## both CM_ID and LBH_ID are 4 characters hexadecimal values.
## CM_ID 0000 is for NVIDIA, and others can be used for specific CM(Contract Manufacturer).
## LBH_ID 0000~0fff is reserved for NVIDIA use only.
## LBH_CLASS can be below value.
## - 1 : Non-GMS Premium
## - 2 : Non-GMS Basic
## - 4 : GMS Premium
## - 8 : GMS Basic
## [NOTE] 1000~ffff is for specific LBH(Local Build House).
CM_ID=0000
LBH_ID=0001
LBH_CLASS=0001
echo $CM_ID > ./lbh/.cm_id
echo $LBH_ID > ./lbh/.lbh_id
echo $LBH_CLASS > ./lbh/.lbh_class

#------------------------------------------------
# Set ro properties to override
# Model name, Locale setting
#------------------------------------------------
## If you want different model name in Setting menu, you should change PRODUCT_MODEL.
PRODUCT_MODEL="TegraNote-Premium"
## If you want different default locale setting, you should change LANGUAGE and REGION
## settings. The language is defined by a two-letter ISO 639-1 language code and
## region code is defined by two letter ISO 3166-1-alpha-2.
PRODUCT_DEFAULT_LANGUAGE="en"
PRODUCT_DEFAULT_REGION="US"

#------------------------------------------------
# Camera information
# if there is no sensor, set ""
#------------------------------------------------
LOCAL_CAMCONF_FILENAME=./lbh/etc/nvcamera.conf
#------------------------------------------------
## If you have front camera in your HW, you should set FRONT SENSOR GUID.
## You can get this GUID info from NVIDIA.
CAMERA_FRONT_SENSOR_GUID="s_OV7695"
## If you have rear camera in your HW, you should set REAR SENSOR GUID.
## You can get this GUID info from NVIDIA.
CAMERA_REAR_SENSOR_GUID="s_OV5693"
## If you have camera focuser in your HW, you should set FOCUSER GUID.
## You can get this GUID info from NVIDIA.
CAMERA_FOCUSER_GUID="f_AD5823"
## If you have camera flashlight in your HW, you should set FLASHLIGHT GUID.
## You can get this GUID info from NVIDIA.
CAMERA_FLASHLIGHT_GUID=""
# Camera config file
CAMERA_CONFIG_VERSION=1
# Facing, Angle, Stereo/Mono
## If you have camera sensor in your HW, you should define this camera config info.
## You can get this info from NVIDIA.
CAMERA_REAR_CONFIG="camera0=/dev/ov5693,back,0,mono"
CAMERA_FRONT_CONFIG="camera1=/dev/ov7695,front,0,mono"
CAMERA_FRONT_ONLY_CONFIG="camera0=/dev/ov7695,front,0,mono"

#---------------------------------------------------------------------------
# USB information
# If you want customize USB VID/PID, set below variables with proper values
#---------------------------------------------------------------------------
#USB_MODEL="Tegra NOTE"
#USB_VID="0955"
#USB_PID_CHARGER="CF02"
#USB_PID_MTP="CF02"
#USB_PID_MTP_ADB="CF00"
#USB_PID_PTP="CF02"
#USB_PID_PTP_ADB="CF00"
USB_MODEL=
USB_VID=
USB_PID_CHARGER=
USB_PID_MTP=
USB_PID_MTP_ADB=
USB_PID_PTP=
USB_PID_PTP_ADB=

# Create camera config file
echo "version=$CAMERA_CONFIG_VERSION" > $LOCAL_CAMCONF_FILENAME
if [ "$CAMERA_REAR_SENSOR_GUID" != "" ]; then
	echo $CAMERA_REAR_CONFIG >> $LOCAL_CAMCONF_FILENAME
	if [ "$CAMERA_FRONT_SENSOR_GUID" != "" ]; then
		echo $CAMERA_FRONT_CONFIG >> $LOCAL_CAMCONF_FILENAME
	fi
elif [ "$CAMERA_FRONT_SENSOR_GUID" != "" ]; then
	echo $CAMERA_FRONT_ONLY_CONFIG >> $LOCAL_CAMCONF_FILENAME
fi

#------------------------------------------------
# Create default properties for LBH
#------------------------------------------------
LOCAL_PROP_FILENAME=./lbh/default.prop
#------------------------------------------------
	echo "ro.nvidia.cm_id=$CM_ID" > $LOCAL_PROP_FILENAME
	echo "ro.nvidia.lbh_id=$LBH_ID" >> $LOCAL_PROP_FILENAME
	echo "ro.nvidia.lbh_class=$LBH_CLASS" >> $LOCAL_PROP_FILENAME
	echo "ro.product.locale.language=$PRODUCT_DEFAULT_LANGUAGE" >> $LOCAL_PROP_FILENAME
	echo "ro.product.locale.region=$PRODUCT_DEFAULT_REGION" >> $LOCAL_PROP_FILENAME
	echo "ro.nvidia.hw.fcam=$CAMERA_FRONT_SENSOR_GUID" >> $LOCAL_PROP_FILENAME
	echo "ro.nvidia.hw.rcam=$CAMERA_REAR_SENSOR_GUID" >> $LOCAL_PROP_FILENAME
	echo "ro.nvidia.hw.flash=$CAMERA_FLASHLIGHT_GUID" >> $LOCAL_PROP_FILENAME
	echo "ro.nvidia.hw.focuser=$CAMERA_FOCUSER_GUID" >> $LOCAL_PROP_FILENAME
if [ "$USB_MODEL" != "" ]; then
	echo "ro.usb.mode=$USB_MODEL" >> $LOCAL_PROP_FILENAME
fi
if [ "$USB_VID" != "" ]; then
	echo "ro.usb.vid=$USB_VID" >> $LOCAL_PROP_FILENAME
fi
if [ "$USB_PID_CHARGER" != "" ]; then
	echo "ro.usb.charger=$USB_CHARGER" >> $LOCAL_PROP_FILENAME
fi
if [ "$USB_PID_MTP" != "" ]; then
	echo "ro.usb.mtp=$USB_MTP" >> $LOCAL_PROP_FILENAME
fi
if [ "$USB_PID_MTP_ADB" != "" ]; then
	echo "ro.usb.mtp_adb=$USB_MTP_ADB" >> $LOCAL_PROP_FILENAME
fi
if [ "$USB_PID_PTP" != "" ]; then
	echo "ro.usb.ptp=$USB_PTP" >> $LOCAL_PROP_FILENAME
fi
if [ "$USB_PID_PTP_ADB" != "" ]; then
	echo "ro.usb.ptp_adb=$USB_PTP_ADB" >> $LOCAL_PROP_FILENAME
fi
if [ -f ./lbh.prop ]; then
	cat ./lbh.prop >> ./lbh/default.prop
fi

#------------------------------------------------
# Generate HW permission file
# Set HW configuration (1:enable, 0:disable)
#------------------------------------------------
LOCAL_HW_PERM_PATH=./lbh/etc/permissions/
#------------------------------------------------
## According to your HW configuration, supported apps should be filtered in
## Google App market. If you don’t set this config properly, although
## your HW can run specific apps, those apps won’t be listed in Google market or
## apps can be crashed in lauching time.
## If your touch panel support multi touch, set this to 1. Otherwise, should be 0
USE_MULTITOUCH_JAZZHAND=1
## If you have camera flash, set this to 1. Otherwize, should be 0.
USE_CAM_FLASH=0
## If your camera supports autofocus, set this to 1. Otherwize, should be 0.
USE_CAM_AUTOFOCUS=1
## If you have GPS chip, set this to 1. Otherwize, should be 0.
USE_GPS=1
## If you have accelerometer sensor, set this to 1. Otherwize, should be 0.
USE_SENSOR_ACCEL=1
## If you have barometer sensor, set this to 1. Otherwize, should be 0.
USE_SENSOR_BAROMETER=0
## If you have compass sensor, set this to 1. Otherwize, should be 0.
USE_SENSOR_COMPASS=1
## If you have gyroscope sensor, set this to 1. Otherwize, should be 0.
USE_SENSOR_GYRO=1
## If you have light sensor for LCD auto brightness, set this to 1. Otherwize, should be 0.
USE_SENSOR_LIGHT=1
## If you have proximity sensor, set this to 1. Otherwize, should be 0.
## This is only meaningful in smartphone.
USE_SENSOR_PROXIMITY=0
## If you have NFC chip, set this to 1. Otherwize, should be 0.
USE_NFC=0
## If you have WIFI chip, set this to 1. Otherwize, should be 0.
USE_WIFI=1
## If your WIFI chip supports WIFI direct (P2P), set this to 1. Otherwize, should be 0.
USE_WIFI_DIRECT=1
## If your HW supports USB host, set this to 1. Otherwize, should be 0.
USE_USB_HOST=1
## If your HW supports USB accessory, set this to 1. Otherwize, should be 0.
USE_USB_ACCESSORY=1
## If your HW has modem, set this to 1. Otherwize, should be 0.
USE_TELEPHONY=0
if [ "$USE_MULTITOUCH_JAZZHAND" == "1" ]; then
	cp ./permissions/android.hardware.touchscreen.multitouch.jazzhand.xml $LOCAL_HW_PERM_PATH
fi
if [ "$CAMERA_REAR_SENSOR_GUID" != "" ]; then
	if [ "$USE_CAM_FLASH" == "1" ] && [ "$USE_CAM_AUTOFUCOS" == "1" ]; then
		cp ./permissions/android.hardware.camera.flash-autofucus.xml $LOCAL_HW_PERM_PATH
	elif [ "$USE_CAM_AUTOFUCOS" == "1" ]; then
		cp ./permissions/android.hardware.camera.autofucus.xml $LOCAL_HW_PERM_PATH
	else
		cp ./permissions/android.hardware.camera.xml $LOCAL_HW_PERM_PATH
	fi
fi
if [ "$CAMERA_FRONT_SENSOR_GUID" != "" ]; then
	cp ./permissions/android.hardware.camera.front.xml $LOCAL_HW_PERM_PATH
fi
if [ "$USE_GPS" == "1" ]; then
	cp ./permissions/android.hardware.location.gps.xml $LOCAL_HW_PERM_PATH
fi
if [ "$USE_SENSOR_ACCEL" == "1" ]; then
	cp ./permissions/android.hardware.sensor.accelerometer.xml $LOCAL_HW_PERM_PATH
fi
if [ "$USE_SENSOR_COMPASS" == "1" ]; then
	cp ./permissions/android.hardware.sensor.compass.xml $LOCAL_HW_PERM_PATH
fi
if [ "$USE_SENSOR_GYRO" == "1" ]; then
	cp ./permissions/android.hardware.sensor.gyroscope.xml $LOCAL_HW_PERM_PATH
fi
if [ "$USE_SENSOR_LIGHT" == "1" ]; then
	cp ./permissions/android.hardware.sensor.light.xml $LOCAL_HW_PERM_PATH
fi
if [ "$USE_SENSOR_PROXIMITY" == "1" ]; then
	cp ./permissions/android.hardware.sensor.proximity $LOCAL_HW_PERM_PATH
fi
if [ "$USE_SENSOR_BAROMETER" == "1" ]; then
	cp ./permissions/android.hardware.sensor.barometer $LOCAL_HW_PERM_PATH
fi
if [ "$USE_SENSOR_NFC" == "1" ]; then
	cp ./permissions/android.hardware.nfc.xml $LOCAL_HW_PERM_PATH
fi
if [ "$USE_WIFI" == "1" ]; then
	cp ./permissions/android.hardware.wifi.xml $LOCAL_HW_PERM_PATH
fi
if [ "$USE_WIFI_DIRECT" == "1" ]; then
	cp ./permissions/android.hardware.wifi.direct.xml $LOCAL_HW_PERM_PATH
fi
if [ "$USE_USB_HOST" == "1" ]; then
	cp ./permissions/android.hardware.usb.host.xml $LOCAL_HW_PERM_PATH
fi
if [ "$USE_USB_ACCESSORY" == "1" ]; then
	cp ./permissions/android.hardware.usb.accessory.xml $LOCAL_HW_PERM_PATH
fi
if [ "$USE_TELEPHONY" == "1" ]; then
	cp ./permissions/android.hardware.telephony.gsm.xml $LOCAL_HW_PERM_PATH
fi

#------------------------------------------------
# Create ext4 lbh binary image
#------------------------------------------------
export PATH=$PATH:./bin
rm -f ./$LBHIMAGE_FILENAME
./bin/mkuserimg.sh -s ./lbh $LBHIMAGE_FILENAME ext4 lbh $LBHIMAGE_PARTITION_SIZE


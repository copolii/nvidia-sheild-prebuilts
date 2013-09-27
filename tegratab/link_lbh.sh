#!/system/bin/sh

# Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

# link_lbh.sh
#
# This script reads LBH ID from LBH partition and
# create symbolic link of /data/lbh/* with lbh_id prefixed
# to /system/etc/lbh/*

FILES="nvaudio_conf.xml
	   nvaudio_tune.xml
	   audioConfig_qvoice_icera_pc400.xml
       nvaudio_fx.xml"
LBH_ID=/lbh/.lbh_id
LBH_CLASS=/lbh/.lbh_class

if [ ! -f "$LBH_CLASS" ]; then
	lbhid=`cat $LBH_ID`
else
	lbhid=`cat $LBH_CLASS`
fi

# if reading LBH_ID fails, fallback to default
if [ "$lbhid" == "" ]; then
    lbhid="0000"
fi
for src in $FILES
    do
        if [ -f "/system/etc/lbh/${lbhid}_${src}" ] && [ ! -f "/data/lbh/${src}" ]; then
            ln -s /system/etc/lbh/${lbhid}_${src} /data/lbh/${src}
        fi
    done

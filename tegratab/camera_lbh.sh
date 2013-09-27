#!/system/bin/sh

# Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

RCAM=`getprop ro.nvidia.hw.rcam`
if [ "$RCAM" == "s_OV5693" ]; then
    /system/bin/otp-ov5693 apply-af apply-awb-lsc
fi

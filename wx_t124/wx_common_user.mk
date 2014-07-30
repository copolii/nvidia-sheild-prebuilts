# NVIDIA Tegra5 "Ardbeg" development system
#
# Copyright (c) 2013, NVIDIA Corporation.  All rights reserved.
#
# AndroidProducts.mk is included before BoardConfig.mk, variable essential at
# start of build and used in here should always be intialized in this file

# shared for all wx_* makefile except diagnostic makefile

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/../common/init.cal.rc:root/init.cal.rc


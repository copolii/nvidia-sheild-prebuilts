#!/system/bin/sh

# Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

USER_GUIDE_DST_DIR=$EMULATED_STORAGE_SOURCE/0/nvidia
USER_GUIDE_SRC_FILE=/system/media/TegraNOTE7UserGuide.pdf
USER_GUIDE_DST_FILE=$USER_GUIDE_DST_DIR/TegraNOTE7UserGuide.pdf
USER_GUIDE_COPY_DONE_FILE=$USER_GUIDE_DST_DIR/.user_guide_copy_done

if [ -d $EMULATED_STORAGE_SOURCE/0 ]; then
    if [ -f "$USER_GUIDE_SRC_FILE" ]; then
        if [ ! -f "$USER_GUIDE_COPY_DONE_FILE" ]; then
            mkdir -p $USER_GUIDE_DST_DIR
            cp $USER_GUIDE_SRC_FILE $USER_GUIDE_DST_FILE
            echo "user guide copy done" > $USER_GUIDE_COPY_DONE_FILE
        fi
    fi
fi

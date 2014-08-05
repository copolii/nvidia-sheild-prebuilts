ifneq (,$(filter $(NV_TN_SKU),tn7_114gp_2014 tn7_114np_2014))
    PRODUCT_COPY_FILES += \
        device/nvidia/tegratab/touchscreen/maxim/tn7_2014/touch_fusion:system/vendor/bin/touch_fusion \
        device/nvidia/tegratab/touchscreen/maxim/tn7_2014/touch_fusion.cfg:system/vendor/firmware/touch_fusion.cfg \
        device/nvidia/tegratab/touchscreen/maxim/tn7_2014/maxim_fp35.bin:system/vendor/firmware/maxim_fp35.bin
else
    PRODUCT_COPY_FILES += \
        device/nvidia/tegratab/touchscreen/maxim/touch_fusion:system/vendor/bin/touch_fusion \
        device/nvidia/tegratab/touchscreen/maxim/touch_fusion.cfg:system/vendor/firmware/touch_fusion.cfg \
        device/nvidia/tegratab/touchscreen/maxim/maxim_fp35.bin:system/vendor/firmware/maxim_fp35.bin
endif

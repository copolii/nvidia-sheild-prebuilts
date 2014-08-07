#
# Copyright (c) 2013-2014 NVIDIA Corporation.  All rights reserved.
#

ifneq ($(TARGET_SIMULATOR),true)
LOCAL_PATH:= $(call my-dir)
include $(NVIDIA_DEFAULTS)

nvflash_cfg_names := np np_2014 gp gp_2014
ifeq ($(NV_TN_SKU),tn7_114gp)
nvflash_cfg_default := gp
endif
ifeq ($(NV_TN_SKU),tn7_114gp_2014)
nvflash_cfg_default := gp_2014
endif
ifeq ($(NV_TN_SKU),tn7_114np)
nvflash_cfg_default := np
endif
ifeq ($(NV_TN_SKU),tn7_114np_2014)
nvflash_cfg_default := np_2014
endif
ifeq ($(NV_TN_SKU),kalamata)
nvflash_cfg_default := gp
endif
ifeq ($(NV_TN_SKU),flaxen)
nvflash_cfg_default := gp
endif
nvflash_cfg_default_target := $(PRODUCT_OUT)/flash.cfg

ifneq ($(wildcard vendor/nvidia/tegra/tegratab/partition-data),)
sedoptionnp := -e "s/name=LBH/name=LBH\nfilename=lbh_np.img/" \
	-e "s/name=NCT/name=NCT\n\#filename=nct_np.txt/"

sedoptionnp_2014 := -e "s/name=LBH/name=LBH\nfilename=lbh_np.img/" \
	-e "s/tegra114-tegratab.dtb/tegra114-tegratab-p1988.dtb/" \
	-e "s/name=NCT/name=NCT\n\#filename=nct_np.txt/"

sedoptiongp := -e "s/name=LBH/name=LBH\nfilename=lbh_gp.img/" \
	-e "s/name=NCT/name=NCT\n\#filename=nct_gp.txt/"

sedoptiongp_2014 := -e "s/name=LBH/name=LBH\nfilename=lbh_gp.img/" \
	-e "s/tegra114-tegratab.dtb/tegra114-tegratab-p1988.dtb/" \
	-e "s/name=NCT/name=NCT\n\#filename=nct_gp.txt/"
else
sedoptionnp := -e "s/name=LBH/name=LBH\nfilename=lbh_np.img/" \
	-e "s/name=NCT/name=NCT\n\#filename=nct_np.txt/" \
	-e "s/factory_ramdisk.img/boot.img/"

sedoptionnp_2014 := -e "s/name=LBH/name=LBH\nfilename=lbh_np.img/" \
	-e "s/tegra114-tegratab.dtb/tegra114-tegratab-p1988.dtb/" \
	-e "s/name=NCT/name=NCT\n\#filename=nct_np.txt/" \
	-e "s/factory_ramdisk.img/boot.img/"

sedoptiongp := -e "s/name=LBH/name=LBH\nfilename=lbh_gp.img/" \
	-e "s/name=NCT/name=NCT\n\#filename=nct_gp.txt/" \
	-e "s/factory_ramdisk.img/boot.img/"

sedoptiongp_2014 := -e "s/name=LBH/name=LBH\nfilename=lbh_gp.img/" \
	-e "s/tegra114-tegratab.dtb/tegra114-tegratab-p1988.dtb/" \
	-e "s/name=NCT/name=NCT\n\#filename=nct_gp.txt/" \
	-e "s/factory_ramdisk.img/boot.img/"
endif

sedoptionsigned := -e "s/bootloader.bin/bootloader_signed.bin/"

define nvflash-cfg-populate-lbh
$(foreach _lbh,$(nvflash_cfg_names), \
  $(eval _target := $(PRODUCT_OUT)/flash_$(_lbh).cfg) \
  $(eval _target_signed := $(PRODUCT_OUT)/flash_$(_lbh)_signed.cfg) \
  $(eval _out2 := $(if $(call streq,$(_lbh),$(nvflash_cfg_default)),| tee $(nvflash_cfg_default_target),)) \
  mkdir -p $(dir $(_target)); \
  sed $(sedoption$(_lbh)) < $(NVFLASH_CFG_BASE_FILE) $(_out2) > $(_target); \
  sed $(sedoptionsigned) < $(NVFLASH_CFG_BASE_FILE) $(_target) > $(_target_signed); \
)
endef

LOCAL_MODULE := nvflash_cfg_populator
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_SUFFIX := -timestamp
include $(BUILD_SYSTEM)/base_rules.mk
$(LOCAL_BUILT_MODULE): $(NVFLASH_CFG_BASE_FILE)
	@echo "Generating flash config file"; \
	mkdir -p $(dir $@); \
	touch -t 200001010000.00 $@;
	$(hide) $(call nvflash-cfg-populate-lbh)

endif # !TARGET_SIMULATOR

#
# Copyright (C) 2025 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

DEVICE_PATH := device/xiaomi/sm8750_thales

# Rules
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_NINJA_USES_ENV_VARS += RTIC_MPGEN
BUILD_BROKEN_PLUGIN_VALIDATION := soong-libaosprecovery_defaults soong-libguitwrp_defaults soong-libminuitwrp_defaults soong-vold_defaults

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := oryon

# Power
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
PRODUCT_PLATFORM := sun
TARGET_BOOTLOADER_BOARD_NAME := $(PRODUCT_PLATFORM)
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := xiaomi_sm8750
TARGET_BOARD_PLATFORM_GPU := qcom-adreno830
QCOM_BOARD_PLATFORMS += xiaomi_sm8750

# Kernel
TARGET_KERNEL_ARCH            := arm64
TARGET_KERNEL_HEADER_ARCH     := arm64
BOARD_KERNEL_IMAGE_NAME       := Image
BOARD_BOOT_HEADER_VERSION     := 4
BOARD_KERNEL_PAGESIZE         := 4096
TARGET_KERNEL_CLANG_COMPILE   := true
TARGET_PREBUILT_KERNEL        := $(DEVICE_PATH)/prebuilt/kernel
BOARD_MKBOOTIMG_ARGS          += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS          += --pagesize $(BOARD_KERNEL_PAGESIZE)

# Ramdisk use lz4
BOARD_RAMDISK_USE_LZ4 := true

# A/B
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    init_boot \
    vendor_boot \
    dtbo \
    vbmeta \
    vbmeta_system \
    odm \
    product \
    system \
    system_ext \
    system_dlkm \
    vendor \
    vendor_dlkm

# Verified Boot
BOARD_AVB_ENABLE := true

# Partitions
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# Workaround for error copying vendor files to recovery ramdisk
TARGET_COPY_OUT_VENDOR := vendor

TARGET_COPY_OUT_ODM := odm
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USES_VENDOR_DLKMIMAGE := true
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600

# Dynamic Partition
BOARD_SUPER_PARTITION_SIZE := 11811160064
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := $(shell echo $$(($(BOARD_SUPER_PARTITION_SIZE) - 4194304)))
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm odm system_dlkm

# System as root
BOARD_ROOT_EXTRA_FOLDERS := firmware persist

# File systems
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Extras
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab

# Crypto
AERA_INCLUDE_CRYPTO := true
AERA_INCLUDE_CRYPTO_FBE := true
AERA_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true
AERA_INCLUDE_OMAPI := true
AERA_USE_FSCRYPT_POLICY := 2
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Tool
AERA_INCLUDE_7ZA := true
AERA_INCLUDE_ZSTD := true
AERA_INCLUDE_REPACKTOOLS := true
AERA_INCLUDE_RESETPROP := true
AERA_INCLUDE_LIBRESETPROP := true
AERA_INCLUDE_LPDUMP := true
AERA_INCLUDE_LPTOOLS := true

# Debug
TARGET_USES_LOGD := true
AERA_INCLUDE_LOGCAT := true
TARGET_RECOVERY_DEVICE_MODULES += debuggerd
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/debuggerd
TARGET_RECOVERY_DEVICE_MODULES += strace
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/strace
TARGET_RECOVERY_DEVICE_MODULES += prebuilt

# Fastbootd
AERA_INCLUDE_FASTBOOTD := true
AERA_UI_ADAPTIVE_RESOLUTION := true

# AERA display
AERA_THEME := portrait_hdpi
AERA_FRAMERATE := 120
AERA_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
AERA_MAX_BRIGHTNESS := 2047
AERA_DEFAULT_BRIGHTNESS := 250
AERA_NO_SCREEN_BLANK := true
AERA_SCREEN_BLANK_ON_BOOT := true
TARGET_USES_VULKAN := true

# Other AERA configurations
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
AERA_EXCLUDE_DEFAULT_USB_INIT := true
AERA_ENABLE_FS_COMPRESSION := true
AERA_INCLUDE_NTFS_3G := true
AERA_USE_DMCTL := true
AERA_USE_TOOLBOX := true
TARGET_USES_MKE2FS := true
AERA_INPUT_BLACKLIST := "hbtp_vm"
AERA_EXTRA_LANGUAGES := true
AERA_DEFAULT_LANGUAGE := en
AERA_EXCLUDE_APEX := true
AERA_SUPPORT_INPUT_AIDL_HAPTICS := true
AERA_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := "IVibrator/vibratorfeature"
AERA_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true
AERA_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true

# Xiaomi SM8750 module order derived from the stock X15 vendor_dlkm image.
# The GPU and audio modules are loaded before the post-decrypt Wi-Fi set so
# graphics and haptics are available during the native unlock flow.
# Include the stock SDCA microphone and amplifier tuning drivers as well.
AERA_LOAD_VENDOR_MODULES := "rproc_qcom_common.ko qcom_q6v5.ko qcom_q6v5_pas.ko qcom_sysmon.ko synx-driver.ko msm_hw_fence.ko msm_kgsl.ko q6_notifier_dlkm.ko spf_core_dlkm.ko audpkt_ion_dlkm.ko gpr_dlkm.ko audio_pkt_dlkm.ko q6_dlkm.ko adsp_loader_dlkm.ko audio_prm_dlkm.ko q6_pdr_dlkm.ko pinctrl_lpi_dlkm.ko swr_dlkm.ko swr_ctrl_dlkm.ko snd_event_dlkm.ko wcd_core_dlkm.ko mbhc_dlkm.ko sdca_registers_dlkm.ko wcd9xxx_dlkm.ko stub_dlkm.ko swr_dmic_dlkm.ko swr_haptics_dlkm.ko hdmi_dlkm.ko lpass_cdc_wsa2_macro_dlkm.ko lpass_cdc_wsa_macro_dlkm.ko lpass_cdc_va_macro_dlkm.ko lpass_cdc_rx_macro_dlkm.ko lpass_cdc_tx_macro_dlkm.ko lpass_cdc_dlkm.ko wsa884x_dlkm.ko wsa883x_dlkm.ko wcd938x_dlkm.ko wcd938x_slave_dlkm.ko wcd939x_dlkm.ko wcd939x_slave_dlkm.ko wcd9378_dlkm.ko wcd9378_slave_dlkm.ko lpass_bt_swr_dlkm.ko qmp_dlkm.ko machine_dlkm.ko aw882xx_dlkm.ko cs35l43_dlkm.ko fs19xx_dlkm.ko tas25xx_dlkm.ko tfa98xx_dlkm.ko sia91xx_dlkm.ko sia91xx_tuning_dlkm.ko frpc-adsprpc.ko synaptics_tcm2.ko xiaomi_touch.ko nxp-nci.ko stm_st54se_gpio.ko stm_nfc_i2c.ko qcom-hv-haptics.ko cs40l26-i2c.ko"
# The sound card includes WCN Bluetooth links. btfmcodec registers its ASoC
# component only after a stock SoundWire/Slimbus hardware endpoint registers.
# Keep their power/CNSS dependencies in the post-decryption module phase.
AERA_POST_DECRYPT_MODULES := "smem-mailbox.ko cnss_prealloc.ko cnss_nl.ko wlan_firmware_service.ko cnss_plat_ipc_qmi_svc.ko cnss_utils.ko cnss2.ko gsim.ko rmnet_mem.ko ipam.ko rfkill.ko cfg80211.ko qca_cld3_peach_v2.ko btpower.ko btfmcodec.ko btfm_slim_codec.ko bt_fm_swr.ko"
AERA_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true
AERA_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone1/temp" # CPU-0-0-0
AERA_BACKUP_EXCLUSIONS := /data/fonts,/data/adb/ap,/data/adb/ksu

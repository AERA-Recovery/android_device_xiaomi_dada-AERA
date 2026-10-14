#
# Copyright (C) 2025 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Configure base.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Configure core_64_bit_only.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Configure virtual_ab_ota compression_with_xor.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression_with_xor.mk)

# Configure emulated_storage.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Configure twrp config common.mk
$(call inherit-product, vendor/twrp/config/common.mk)

# Configure AERA for the Xiaomi SM8750 family.
$(call inherit-product, $(DEVICE_PATH)/aera_sm8750_thales.mk)

# API
BOARD_SHIPPING_API_LEVEL := 35
PRODUCT_SHIPPING_API_LEVEL := 35
PRODUCT_TARGET_VNDK_VERSION := 35

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Enable Fuse Passthrough
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true

# Otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(DEVICE_PATH)/security/releasekey

# Required modules
AERA_REQUIRED_MODULES += \
    prebuilt

PRODUCT_PACKAGES += \
    aera-thales-audio-bridge \
    aera-thales-audio-service \
    aera-browser-jail \
    lpflash \
    lpmake \
    lpunpack

# The EGL/GLES and allocator closure below comes from the Xiaomi 15 stock
# dump, not from the OnePlus SM8750 stack.
PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.egl=adreno

# These recovery libraries must remain visible while Android's /vendor and
# /odm are temporarily mounted for module loading and version inspection.
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/root/vendor/lib64/libnativewindow.so:recovery/root/system/lib64/libnativewindow.so \
    $(DEVICE_PATH)/recovery/root/vendor/lib64/libui.so:recovery/root/system/lib64/libui.so \
    $(DEVICE_PATH)/recovery/root/vendor/lib64/libcxx.so:recovery/root/system/lib64/libcxx.so \
    $(DEVICE_PATH)/recovery/root/vendor/lib64/libbinder_ndk-sdk35.so:recovery/root/system/lib64/libbinder_ndk-sdk35.so

# GPU firmware must remain available while recovery inspects Android /vendor.
PRODUCT_COPY_FILES += $(foreach fw,gen80000_zap.mbn gen80000_gmu.bin gen80000_aqe.fw gen80000_sqe.fw,\
    $(DEVICE_PATH)/recovery/root/vendor/firmware/$(fw):recovery/root/system/etc/firmware/$(fw))

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Inherit some common twrp stuff.
$(call inherit-product, vendor/twrp/config/common.mk)
$(call inherit-product, $(TOPDIR)bootable/recovery/default/device.mk)

# Inherit from cusco device
$(call inherit-product, device/motorola/cusco/device.mk)

# Device identifier
PRODUCT_DEVICE := cusco
PRODUCT_NAME := twrp_cusco
PRODUCT_BRAND := motorola
PRODUCT_MODEL := Motorola Edge 50 Fusion
PRODUCT_MANUFACTURER := motorola
PRODUCT_GMS_CLIENTID_BASE := android-motorola

# Device version
TW_DEVICE_VERSION := Cusco V1.0  # OK
#TW_THEME := device/motorola/cusco/themes/ui.xml  # Comentado

# Screen
TW_SCREEN_BLANK_ON_BOOT := true
TW_MAX_BRIGHTNESS := 255  # Verifica este valor
TW_DEFAULT_BRIGHTNESS := 180
TARGET_SCREEN_DENSITY := 393
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2400

# Partitions
TW_HAS_NO_RECOVERY_PARTITION := false  # ¡CORREGIDO!

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_FBE := true

# NTFS
TW_INCLUDE_NTFS_3G := true

# Repack tools
TW_INCLUDE_REPACKTOOLS := true

# Input
TW_INPUT_BLACKLIST := "hbtp_vm"

# Toolbox
TW_USE_TOOLBOX := true

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 12.1.0

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="TWRP for Cusco V1.0"

BUILD_FINGERPRINT := motorola/cusco/cusco:12/V1UUS35H.15-41-3/d5d29:user/release-keys  # Intenta encontrar el de Android 12 si es posible

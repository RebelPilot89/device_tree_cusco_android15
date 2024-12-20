# Copyright (C) 2020 The Android Open Source Project
# Copyright (C) 2020 The TWRP Open Source Project
# Copyright (C) 2020 SebaUbuntu's TWRP device tree generator
# Copyright (C) 2022-juic3b0x
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, $(TOPDIR)bootable/recovery/default/device.mk)

# Device identifier
PRODUCT_DEVICE := cusco
PRODUCT_NAME := twrp_cusco
PRODUCT_BRAND := motorola
PRODUCT_MODEL := Motorola Edge 50 Fusion
PRODUCT_MANUFACTURER := motorola

# Device version
TW_DEVICE_VERSION := 1.0-cusco

# Screen
TW_SCREEN_BLANK_ON_BOOT := true
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 180

# Partitions
TW_HAS_NO_RECOVERY_PARTITION := false
TW_HAS_NO_BOOT_PARTITION := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x08000000 # Ejemplo: 128MB (Ajustar al tamaño real)
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x08000000 # Ejemplo: 128MB (Ajustar al tamaño real)
BOARD_RECOVERY_ALWAYS_MOUNT := /system /vendor /odm /product /system_ext
BOARD_RECOVERY_ONLY_MOUNT := /mnt/vendor/persist

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
PLATFORM_VERSION := 16.1.0
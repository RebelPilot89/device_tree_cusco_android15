#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from cusco device
$(call inherit-product, device/motorola/cusco/device.mk)

PRODUCT_DEVICE := cusco
PRODUCT_NAME := omni_cusco
PRODUCT_BRAND := motorola
PRODUCT_MODEL := motorola edge 50 fusion
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="cusco-user 12 V1UU35H.15-15-4 cf4ce4 release-keys"

BUILD_FINGERPRINT := motorola/cusco/cusco:12/V1UU35H.15-15-4/cf4ce4:user/release-keys

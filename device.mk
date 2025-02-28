#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/motorola/cusco

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

# (Comentamos los paquetes twrp_* por ahora)
# PRODUCT_PACKAGES += \
#     bootctrl.parrot \  # Probablemente innecesario
#     libgptutils \ # Ya se incluye abajo
#     libz        \  # Ya se incluye abajo
#     libcutils      # Ya deberia estar incluido

# PRODUCT_PACKAGES += \
#     otapreopt_script \ #Probablemente innecesarios
#     cppreopts.sh \  #Probablemente innecesarios
#     update_engine \   #Probablemente innecesarios
#     update_verifier \ #Probablemente innecesarios
#     update_engine_sideload #Probablemente innecesarios

#Agregamos los paquetes necesarios para compilar, si no estan, los incluimos, si estan, no pasa nada.
PRODUCT_PACKAGES += \
    libz \
    libgptutils \
    libcutils

#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/cusco

# Para compilar con un manifiesto mínimo
ALLOW_MISSING_DEPENDENCIES := true

# Configuraciones A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    odm \
    system \
    product \
    system_ext \
    vendor \

# Indicar que no se usa el recovery como boot
BOARD_USES_RECOVERY_AS_BOOT := false

# Arquitectura
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic  # Verifica si 'generic' es la variante correcta
TARGET_CPU_VARIANT_RUNTIME := cortex-a78  # Confirma que coincide con tu CPU

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55  # Verifica la variante secundaria
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55  # Confirma si es correcto

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := cusco
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true  # Verifica si el dispositivo usa UEFI

# Pantalla
TARGET_SCREEN_DENSITY := 393 # Asegúrate de que sea el DPI correcto
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2400

# Kernel - precompilado
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/zkernel  # Usamos zkernel

# Nombre de la imagen del kernel (no crítico)
BOARD_KERNEL_IMAGE_NAME := zkernel

# DTB
BOARD_PREBUILT_DTBIMAGE := $(DEVICE_PATH)/prebuilt/dtb  # Usamos el dtb extraído
BOARD_MKBOOTIMG_ARGS += --dtb $(BOARD_PREBUILT_DTBIMAGE)

# DTBO
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img  # ¡Usamos dtbo.img!
BOARD_MKBOOTIMG_ARGS += --dtbo $(BOARD_PREBUILT_DTBOIMAGE)

# mkbootimg args
BOARD_MKBOOTIMG_ARGS += --base 0x80000000
BOARD_MKBOOTIMG_ARGS += --pagesize 4096
BOARD_MKBOOTIMG_ARGS += --kernel_offset 0x00080000
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset 0x01000000
BOARD_MKBOOTIMG_ARGS += --tags_offset 0x00100000
BOARD_MKBOOTIMG_ARGS += --ramdisk $(DEVICE_PATH)/prebuilt/ramdisk-new.img  # ¡Usamos el ramdisk modificado!


# Kernel command line:
BOARD_KERNEL_CMDLINE += video=vfb:640x400,bpp=32,memsize=3072000 printk.devkmsg=on firmware_class.path=/vendor/firmware_mnt/image bootconfig
BOARD_KERNEL_CMDLINE += kasan.stacktrace=off
BOARD_KERNEL_CMDLINE += kvm-arm.mode=protected
BOARD_KERNEL_CMDLINE += cgroup_disable=pressure
BOARD_KERNEL_CMDLINE += cgroup.memory=nokmem
BOARD_KERNEL_CMDLINE += console=null
BOARD_KERNEL_CMDLINE += loglevel=6
BOARD_KERNEL_CMDLINE += sched_walt_rotate_tasks=1
BOARD_KERNEL_CMDLINE += sched_upmigrate_min_nice=-20
BOARD_KERNEL_CMDLINE += sched_downmigrate_min_nice=19

# Particiones
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296  # Verifica el tamaño real
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 134217728  # Verifica el tamaño real
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SUPER_PARTITION_SIZE := 7381975040  # Confirmado por ti en bytes
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor odm
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 6663821312  # Verifica si este tamaño es correcto

# Plataforma
TARGET_BOARD_PLATFORM := sm6450    
TARGET_BOARD_AUDIO_PLATFORM := parrot  

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_HAS_RECOVERY_PARTITION := true  # Tienes partición de recovery
TARGET_NO_RECOVERY := false
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab

# Nivel de parche de seguridad (ajusta según corresponda)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
PLATFORM_VERSION := 12.1.0

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Configuración de TWRP
#TW_THEME := device/motorola/cusco/themes/ui.xml  # Si usas un tema personalizado
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_CRYPTO := true
TW_USE_NEW_MINADBD := true
TW_EXCLUDE_SUPERSU := true
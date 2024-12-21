#!/bin/bash
#
# Copyright (C) 2024 The TWRP Personal Proyect
# Copyright (C) 2024 The Meridian Project
#
#  Apache-2.0
#

#!/bin/bash

set -e

DEVICE=cusco
VENDOR=motorola

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
            CLEAN_VENDOR=false
            ;;
        -k | --kang )
            KANG="--kang"
            ;;
        -s | --section )
            SECTION="${1}"; shift
            ;;
        * )
            SRC="${1}"
            ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

# Extract the proprietary files
extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

# Mount the partitions
mount /dev/block/bootdevice/by-name/system /mnt/system
mount /dev/block/bootdevice/by-name/vendor /mnt/vendor
mount /dev/block/bootdevice/by-name/product /mnt/product
mount /dev/block/bootdevice/by-name/odm /mnt/odm

# Define the destination paths
TARGET_COPY_OUT_SYSTEM="/system"
TARGET_COPY_OUT_VENDOR="/vendor"
TARGET_COPY_OUT_PRODUCT="/product"
TARGET_COPY_OUT_ODM="/odm"

# Function to copy files to their respective destinations
function extract_files() {
    local SRC=$1
    local DST=$2
    if [ -d "$SRC" ]; then
        cp -r $SRC/* $DST/
    else
        echo "Directory $SRC not found."
    fi
}

# Extract files from the mounted partitions
extract_files "/mnt/system" "$TARGET_COPY_OUT_SYSTEM"
extract_files "/mnt/vendor" "$TARGET_COPY_OUT_VENDOR"
extract_files "/mnt/product" "$TARGET_COPY_OUT_PRODUCT"
extract_files "/mnt/odm" "$TARGET_COPY_OUT_ODM"

# Unmount the partitions
umount /mnt/system
umount /mnt/vendor
umount /mnt/product
umount /mnt/odm

# Run the setup makefiles script
"${MY_DIR}/setup-makefiles.sh"

echo "Extraction complete."

#!/bin/bash
#
# Copyright (C) 2024 The TWRP Personal Project
# Copyright (C) 2024 The Meridian Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
#

# Salir en caso de error
set -e

# Directorio donde se encuentra el dump de firmware (ajusta la ruta si es necesario)
OTA_DIR=~/moto

# Directorios de salida para cada partición (ajusta las rutas si es necesario)
SYSTEM_PATH=../../../vendor/motorola/cusco/proprietary/system
VENDOR_PATH=../../../vendor/motorola/cusco/proprietary/vendor
PRODUCT_PATH=../../../vendor/motorola/cusco/proprietary/product
ODM_PATH=../../../vendor/motorola/cusco/proprietary/odm

# Puntos de montaje para cada partición (ajusta las rutas si es necesario)
SYSTEM_MNT=/mnt/system
VENDOR_MNT=/mnt/vendor
PRODUCT_MNT=/mnt/product
ODM_MNT=/mnt/odm

# Archivo de lista de archivos propietarios
PROP_FILES="proprietary-files.txt"

# Verificar que el archivo proprietary-files.txt existe
if [ ! -f "$PROP_FILES" ]; then
    echo "Archivo $PROP_FILES no encontrado!"
    exit 1
fi

# Verificar que las imágenes existen
for img in system.img vendor.img product.img odm.img; do
    if [ ! -f "$OTA_DIR/$img" ]; then
        echo "Imagen $img no encontrada en $OTA_DIR!"
        exit 1
    fi
done

# Montar las particiones al principio
echo "Montando particiones..."
sudo mkdir -p "$SYSTEM_MNT" "$VENDOR_MNT" "$PRODUCT_MNT" "$ODM_MNT"

sudo mount -o loop,ro "$OTA_DIR/system.img" "$SYSTEM_MNT"
if [ $? -ne 0 ]; then
    echo "Error al montar system.img en $SYSTEM_MNT"
    exit 1
fi

sudo mount -o loop,ro "$OTA_DIR/vendor.img" "$VENDOR_MNT"
if [ $? -ne 0 ]; then
    echo "Error al montar vendor.img en $VENDOR_MNT"
    exit 1
fi

sudo mount -o loop,ro "$OTA_DIR/product.img" "$PRODUCT_MNT"
if [ $? -ne 0 ]; then
    echo "Error al montar product.img en $PRODUCT_MNT"
    exit 1
fi

sudo mount -o loop,ro "$OTA_DIR/odm.img" "$ODM_MNT"
if [ $? -ne 0 ]; then
    echo "Error al montar odm.img en $ODM_MNT"
    exit 1
fi

echo "Particiones montadas correctamente."

# Función para extraer archivos
extract_file() {
    local SOURCE_PATH=$1
    local DEST_PATH=$2

    # Obtener la partición de la ruta de origen
    local SOURCE_PARTITION=$(echo "$SOURCE_PATH" | cut -d '/' -f 1)

    echo "Extrayendo $SOURCE_PATH a $DEST_PATH"

    # Seleccionar la partición de origen y la ruta de destino
    case "$SOURCE_PARTITION" in
        system)
            SOURCE_MNT="$SYSTEM_MNT"
            DEST_DIR="$SYSTEM_PATH"
            ;;
        vendor)
            SOURCE_MNT="$VENDOR_MNT"
            DEST_DIR="$VENDOR_PATH"
            ;;
        product)
            SOURCE_MNT="$PRODUCT_MNT"
            DEST_DIR="$PRODUCT_PATH"
            ;;
        odm)
            SOURCE_MNT="$ODM_MNT"
            DEST_DIR="$ODM_PATH"
            ;;
        *)
            echo "Error: Partición de origen desconocida: $SOURCE_PARTITION"
            exit 1
            ;;
    esac

    # Crear el directorio de destino si no existe
    mkdir -p "$DEST_DIR/$DEST_PATH"

    # Copiar el archivo
    sudo cp -f "$SOURCE_MNT/$SOURCE_PATH" "$DEST_DIR/$DEST_PATH"

    if [ $? -ne 0 ]; then
        echo "Error al extraer $SOURCE_PATH"
        exit 1
    fi
}

# Desmontar particiones al final, incluso si hay errores
trap "sudo umount '$SYSTEM_MNT'" EXIT
trap "sudo umount '$VENDOR_MNT'" EXIT
trap "sudo umount '$PRODUCT_MNT'" EXIT
trap "sudo umount '$ODM_MNT'" EXIT

# Extraer archivos listados en proprietary-files.txt
while IFS=":" read -r SOURCE_PARTITION SOURCE_PATH DEST_PATH; do
    extract_file "$SOURCE_PATH" "$DEST_PATH"
done < "$PROP_FILES"

echo "Extracción de archivos completada."

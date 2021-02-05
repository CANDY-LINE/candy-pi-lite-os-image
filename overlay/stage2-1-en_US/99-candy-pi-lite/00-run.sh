#!/bin/bash -e

# Set CANDY Pi Lite OS Image Release Version Name file
echo -e "Name:${IMG_NAME}\n\rVersion:${IMG_VERSION}" > ${ROOTFS_DIR}/boot/candy-pi-lite-os-image_${IMG_VERSION}

# Set release version and OS image name
mkdir -p ${ROOTFS_DIR}/opt/candy-line/os-image
echo "${IMG_NAME}" > ${ROOTFS_DIR}/opt/candy-line/os-image/name
echo "${IMG_VERSION}" > ${ROOTFS_DIR}/opt/candy-line/os-image/version

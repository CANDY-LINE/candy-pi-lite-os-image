#!/bin/bash -e

FIRMWARE_DIR=${ROOTFS_DIR}/tmp/firmware
mkdir -p ${FIRMWARE_DIR}

# ref: https://github.com/monome/norns-image/pull/76/commits/a62b057daefbabc6f5f4fc1a11a740e34fa38692
# copy specific version of Raspberry firmware to tmp
RPI_FIRMWARE_VERSION=
RPI_FIRMWARE_PACKAGES=( raspberrypi-bootloader raspberrypi-kernel raspberrypi-kernel-headers libraspberrypi0 libraspberrypi-bin libraspberrypi-dev libraspberrypi-doc )

i=0
for PACKAGE in "${RPI_FIRMWARE_PACKAGES[@]}"
do
  DEB="${PACKAGE}_${RPI_FIRMWARE_VERSION}-1_armhf.deb"
  curl -sSLO "https://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/${DEB}"
  mv -f ${DEB} ${FIRMWARE_DIR}/${i}_${DEB}
  let i=i+1
done

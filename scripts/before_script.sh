#!/usr/bin/env bash

DEPS_DIR=$(pwd)/deps
PIGEN_DIR=${DEPS_DIR}/pi-gen
MOVIDIUS=${MOVIDIUS:-0}
CANDY_PI_LITE_VERSION=${CANDY_PI_LITE_VERSION:-"10.2.1"}
CANDY_RED_HASH=${CANDY_RED_HASH:-"9.9.3"}
RPI_FIRMWARE_VERSION=${RPI_FIRMWARE_VERSION:-"1.20210108"}
NODEJS_VERSION="12.20.1"
BOOT_APN=${BOOT_APN:-""}
BUTTON_EXT=${BUTTON_EXT:-""}
BASE_ROOT_MARGIN=${BASE_ROOT_MARGIN:-"400"}

function clean_setup {
  if [ "${NO_CLEAN}" != "1" ]; then
    git submodule update --init --recursive
    pushd ${PIGEN_DIR}
    git reset --hard HEAD
    git clean -f -d
    popd
  fi
}

function add_config {
  if [ -n "${!1}" ]; then
    echo "[add_config] ${1} => [${!1}]"
    echo "export $1=${!1}" >> ${PIGEN_DIR}/config
  fi
}

function create_config {
  IMG_NAME=${2:-candy-pi-lite-raspbian}
  echo "IMG_NAME=${IMG_NAME}" > ${PIGEN_DIR}/config
  pushd ${PIGEN_DIR}
  GIT_HASH=$(git rev-parse HEAD)
  popd
  add_config GIT_HASH
  add_config FIRST_USER_NAME
  add_config FIRST_USER_PASS
  add_config ENABLE_SSH
  add_config TARGET_HOSTNAME
  add_config NODEJS_VERSION
}

function configure_stages {
  touch ${PIGEN_DIR}/stage{3,4,5}/SKIP
  rm -f ${PIGEN_DIR}/stage{2,3,4,5}/EXPORT_NOOBS
  rm -f ${PIGEN_DIR}/stage{2,3,4,5}/EXPORT_IMAGE
  pushd $(pwd)/overlay
  for STAGE in $(ls -d stage*); do
    cp -fr ${STAGE} ../deps/pi-gen/
  done
  popd
  sed -i -e "s/raspberrypi-kernel/device-tree-compiler/g" ${PIGEN_DIR}/stage0/02-firmware/01-packages
  sed -i -e "s/RPI_FIRMWARE_VERSION=/RPI_FIRMWARE_VERSION=${RPI_FIRMWARE_VERSION}/g" ${PIGEN_DIR}/stage0/02-firmware/01-run.sh
  sed -i -e "s/libraspberrypi-bin libraspberrypi0 raspi-config/raspi-config/g" ${PIGEN_DIR}/stage1/03-install-packages/00-packages
  sed -i -e "s/libraspberrypi-dev libraspberrypi-doc libfreetype6-dev/libfreetype6-dev/g" ${PIGEN_DIR}/stage2/01-sys-tweaks/00-packages
  sed -i -e "s/RPI_FIRMWARE_VERSION=/RPI_FIRMWARE_VERSION=${RPI_FIRMWARE_VERSION}/g" ${PIGEN_DIR}/stage0/02-firmware/01-run-chroot.sh
  sed -i -e "s/raspberrypi-kernel/device-tree-compiler/g" ${PIGEN_DIR}/stage0/02-firmware/01-packages
  sed -i -e "s/ 0\.2 \+ 200 \* 1024 \* 1024/ 0.2 + ${BASE_ROOT_MARGIN} * 1024 * 1024/g" ${PIGEN_DIR}/export-image/prerun.sh
}

function configure_scripts {
  sed -i -e "s/CANDY_PI_LITE_VERSION=/CANDY_PI_LITE_VERSION=${CANDY_PI_LITE_VERSION}/g" ${PIGEN_DIR}/stage2-1-en_US/99-candy-pi-lite/00-run-chroot.sh
  sed -i -e "s/CANDY_RED_HASH=/CANDY_RED_HASH=${CANDY_RED_HASH}/g" ${PIGEN_DIR}/stage2-1-en_US/99-candy-pi-lite/00-run-chroot.sh
  if [ -n "${BOOT_APN}" ]; then
    sed -i -e "s/BOOT_APN=iijmobile.biz-ipv4v6/BOOT_APN=${BOOT_APN}/g" ${PIGEN_DIR}/stage2-1-en_US/99-candy-pi-lite/00-run-chroot.sh
    echo "[INFO] BOOT_APN => ${BOOT_APN}"
  else
    echo "[ERROR] BOOT_APN is now mandatory."
    exit 1
  fi
  if [ -n "${BUTTON_EXT}" ]; then
    sed -i -e "s/BUTTON_EXT=0/BUTTON_EXT=${BUTTON_EXT}/g" ${PIGEN_DIR}/stage2-1-en_US/99-candy-pi-lite/00-run-chroot.sh
  fi
}

function apply_macos_support {
  if [ `uname` = "Darwin" ]; then
    # Use sed -E rather than sed -r
    sed -i -e "s/sed -r/sed -E/g" ${PIGEN_DIR}/build-docker.sh
    # Use a python code rather than realpath
    PYTHON="python"
    PYTHON_TEST=`${PYTHON} -V`
    if [ "$?" != "0" ]; then
      PYTHON="python3"
      PYTHON_TEST=`${PYTHON} -V`
      if [ "$?" != "0" ]; then
        echo "[ERROR] Python is missing"
        exit 1
      fi
    fi
    sed -i -e "s/CONFIG_FILE=\$(realpath -s \"\$CONFIG_FILE\")/CONFIG_FILE=\$(${PYTHON} -c \"import os\; print(os.path.realpath('\$CONFIG_FILE'))\")/g" ${PIGEN_DIR}/build-docker.sh
  fi
}

function use_32bit_image {
  # in order to apply the workaround for a qemu issue
  # https://github.com/RPi-Distro/pi-gen/issues/271#issuecomment-556812205
  sed -i -e "s/FROM debian:buster/FROM i386\\/debian:buster/g" ${PIGEN_DIR}/Dockerfile
}

clean_setup
create_config
configure_stages
configure_scripts
use_32bit_image
apply_macos_support

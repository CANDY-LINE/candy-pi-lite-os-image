#!/usr/bin/env bash

DEPS_DIR=$(pwd)/deps
PIGEN_DIR=${DEPS_DIR}/pi-gen
MOVIDIUS=${MOVIDIUS:-0}

function clean_setup {
  git submodule update --init --recursive
  pushd ${PIGEN_DIR}
  git reset --hard HEAD
  git clean -f -d
  popd
}

function create_config {
  IMG_NAME=${2:-candy-pi-lite-raspbian}
  echo "IMG_NAME=${IMG_NAME}" > ${PIGEN_DIR}/config
  pushd ${PIGEN_DIR}
  GIT_HASH=$(git rev-parse HEAD)
  popd
  echo "GIT_HASH=${GIT_HASH}" >> ${PIGEN_DIR}/config
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
}

function configure_scripts {
  cp -f $(pwd)/scripts/common ${PIGEN_DIR}/scripts
  if [ "${MOVIDIUS}" != "1" ]; then
    rm -fr ${PIGEN_DIR}/stage2-0-movidius
  fi
  if [ "${DEVICE_MANAGEMENT_ENABLED}" != "1" ]; then
    rm -fr ${PIGEN_DIR}/stage2-2-dm
  fi
  if [ -n "${CANDY_RED_HASH}" ]; then
    sed -i -e "s/CANDY_RED_HASH=latest/CANDY_RED_HASH=${CANDY_RED_HASH}/g" ${PIGEN_DIR}/stage2-1-en_US/99-candy-pi-lite/00-run-chroot.sh
    if [ "${DEVICE_MANAGEMENT_ENABLED}" = "1" ] && [ "${CANDY_RED_HASH}" = "develop" ] ; then
      rm -f ${PIGEN_DIR}/stage2-1-en_US/EXPORT_IMAGE
      rm -fr ${PIGEN_DIR}/stage2-3-ja_JP
    fi
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
        echo "Python is missing"
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

#!/usr/bin/env bash

DEPS_DIR=$(pwd)/deps
PIGEN_DIR=${DEPS_DIR}/pi-gen

function update_sibmodules {
  git submodule update --init --recursive
}

function create_config {
  IMG_NAME=${2:-candy-pi-lite-raspbian}
  echo "IMG_NAME=${IMG_NAME}" > ${PIGEN_DIR}/config
}

function configure_stages {
  touch ${PIGEN_DIR}/stage{3,4,5}/SKIP
  rm -f ${PIGEN_DIR}/stage{3,4,5}/EXPORT_*
  pushd $(pwd)/overlay
  cp -r stage* ../deps/pi-gen/
  popd
}

update_sibmodules
create_config
configure_stages

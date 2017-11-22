#!/usr/bin/env bash

DEPS_DIR=$(pwd)/deps
PIGEN_DIR=${DEPS_DIR}/pi-gen

function clean_setup {
  git submodule update --init --recursive
  pushd ${PIGEN_DIR}
  git reset --hard HEAD
  git clean -f -d
  popd
}

clean_setup

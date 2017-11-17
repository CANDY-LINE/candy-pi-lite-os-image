#!/bin/bash -e

install -v -m 644 files/locale.gen ${ROOTFS_DIR}/etc/

install -v -d ${ROOTFS_DIR}/etc/default/
install -v -m 644 files/keyboard ${ROOTFS_DIR}/etc/default/
install -v -m 644 files/locale ${ROOTFS_DIR}/etc/default/

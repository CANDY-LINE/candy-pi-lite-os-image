#!/bin/bash -e

mv ${ROOTFS_DIR}/usr/lib/node_modules/candy-red/services/systemd/environment ${ROOTFS_DIR}/usr/lib/node_modules/candy-red/services/systemd/environment.bak
install -v -m 600 files/environment ${ROOTFS_DIR}/usr/lib/node_modules/candy-red/services/systemd/

#!/bin/bash -e

install -v -m 644 files/locale.gen ${ROOTFS_DIR}/etc/

install -v -d	${ROOTFS_DIR}/etc/default/
install -v -m 644 files/keyboard ${ROOTFS_DIR}/etc/default/
install -v -m 644 files/locale ${ROOTFS_DIR}/etc/default/

install -v -m 644 files/welcome-flow.json ${ROOTFS_DIR}/usr/lib/node_modules/candy-red/dist/

if [ -f "${ROOTFS_DIR}/usr/lib/node_modules/candy-red/services/systemd/environment.bak" ]; then
    mv ${ROOTFS_DIR}/usr/lib/node_modules/candy-red/services/systemd/environment.bak ${ROOTFS_DIR}/usr/lib/node_modules/candy-red/services/systemd/environment
fi

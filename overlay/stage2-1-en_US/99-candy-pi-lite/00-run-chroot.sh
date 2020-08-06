# on_chroot

# CANDY Pi Lite and CANDY RED

CANDY_PI_LITE_VERSION=
CANDY_RED_HASH=
BOOT_APN=iijmobile.biz-ipv4v6
BUTTON_EXT=0

if [ ! -f "/opt/candy-line/candy-pi-lite/uninstall.sh" ]; then
    if [ "${CANDY_RED_HASH}" = "latest" ]; then
        curl -vsL https://raw.githubusercontent.com/CANDY-LINE/candy-pi-lite-service/${CANDY_PI_LITE_VERSION}/install.sh | BUTTON_EXT=${BUTTON_EXT} BOOT_APN="${BOOT_APN}" BOARD=RPi FORCE_INSTALL=1 CANDY_PI_LITE_APT_GET_UPDATED=1 bash
        if [ "$?" != "0" ]; then
            echo "FAILED TO INSTALL candy-pi-lite-service@${CANDY_PI_LITE_VERSION}"
            exit 1
        fi
    else
        # CANDY RED@${CANDY_RED_HASH} with development dependencies
        curl -vsL https://raw.githubusercontent.com/CANDY-LINE/candy-pi-lite-service/${CANDY_PI_LITE_VERSION}/install.sh | BUTTON_EXT=${BUTTON_EXT} BOOT_APN="${BOOT_APN}" CANDY_RED=0 BOARD=RPi FORCE_INSTALL=1 CANDY_PI_LITE_APT_GET_UPDATED=1 bash
        if [ "$?" != "0" ]; then
            echo "FAILED TO INSTALL candy-pi-lite-service@${CANDY_PI_LITE_VERSION}"
            exit 1
        fi
        CANDY_RED_APT_GET_UPDATED=1 LOCAL_INSTALL=0 npm install -g --unsafe-perm --production https://github.com/CANDY-LINE/candy-red/archive/${CANDY_RED_HASH}.tar.gz
        if [ "$?" != "0" ]; then
            echo "FAILED TO INSTALL candy-red@${CANDY_RED_HASH}"
            exit 1
        fi
        pushd /usr/lib/node_modules/candy-red
        # Install all dependencies and run prepare stage script
        LOCAL_INSTALL=0 DEVEL=true npm install --unsafe-perm
        popd
    fi

    # Always Enable UFW
    sed -i -e "s/ENABLED=no/ENABLED=yes/g" /etc/ufw/ufw.conf

    # Clean cache files
    npm cache clean --force
fi

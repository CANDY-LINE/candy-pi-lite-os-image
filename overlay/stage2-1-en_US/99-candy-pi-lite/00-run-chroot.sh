# on_chroot

# CANDY Pi Lite and CANDY RED

CANDY_PI_LITE_VERSION=master
CANDY_RED_HASH=latest

if [ "${CANDY_RED_HASH}" = "latest" ]; then
    curl -vsL https://raw.githubusercontent.com/CANDY-LINE/candy-pi-lite-service/${CANDY_PI_LITE_VERSION}/install.sh | BOARD=RPi FORCE_INSTALL=1 CANDY_PI_LITE_APT_GET_UPDATED=1 bash
else
    # CANDY RED@${CANDY_RED_HASH}
    curl -vsL https://raw.githubusercontent.com/CANDY-LINE/candy-pi-lite-service/${CANDY_PI_LITE_VERSION}/install.sh | CANDY_RED=0 BOARD=RPi FORCE_INSTALL=1 CANDY_PI_LITE_APT_GET_UPDATED=1 bash
    CANDY_RED_APT_GET_UPDATED=1 LOCAL_INSTALL=0 npm install -g --unsafe-perm --production https://github.com/CANDY-LINE/candy-red/archive/${CANDY_RED_HASH}.tar.gz
fi

# Always Enable UFW
sed -i -e "s/ENABLED=no/ENABLED=yes/g" /etc/ufw/ufw.conf

# Sense HAT node and SmartMesh node
pip install pillow pyserial

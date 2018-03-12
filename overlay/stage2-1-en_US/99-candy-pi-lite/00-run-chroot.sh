# on_chroot

# CANDY Pi Lite and CANDY RED

CANDY_PI_LITE_VERSION=master

curl -sL \
  https://raw.githubusercontent.com/CANDY-LINE/candy-pi-lite-service/${CANDY_PI_LITE_VERSION}/install.sh | \
  BOARD=RPi \
  FORCE_INSTALL=1 \
  CANDY_PI_LITE_APT_GET_UPDATED=1 \
  bash

# Enable UFW
if ufw status | grep inactive > /dev/null 2>&1; then
  ufw --force enable
fi

# Sense HAT node
pip install pillow

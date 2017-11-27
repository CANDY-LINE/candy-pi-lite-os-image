# on_chroot

# CANDY Pi Lite and CANDY RED

CANDY_PI_LITE_VERSION=master

curl -sL \
  https://raw.githubusercontent.com/CANDY-LINE/candy-pi-lite-service/${CANDY_PI_LITE_VERSION}/install.sh | \
  FORCE_INSTALL=1 \
  CANDY_PI_LITE_APT_GET_UPDATED=1 \
  bash

# Sense HAT node
pip install pillow

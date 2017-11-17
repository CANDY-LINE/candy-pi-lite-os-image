# on_chroot

CANDY_PI_LITE_VERSION=master

curl -sL \
  https://raw.githubusercontent.com/CANDY-LINE/candy-pi-lite-service/${CANDY_PI_LITE_VERSION}/install.sh | \
  ENABLE_WATCHDOG=1 \
  BOARD=RPi \
  FORCE_INSTALL=1 \
  bash

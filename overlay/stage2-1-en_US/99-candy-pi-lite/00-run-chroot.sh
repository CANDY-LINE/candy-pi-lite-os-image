# on_chroot

CANDY_PI_LITE_VERSION=master

curl -sL \
  https://raw.githubusercontent.com/CANDY-LINE/candy-pi-lite-service/${CANDY_PI_LITE_VERSION}/install.sh | \
  FORCE_INSTALL=1 \
  bash

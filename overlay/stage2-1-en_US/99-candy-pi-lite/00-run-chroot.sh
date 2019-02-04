# on_chroot

# CANDY Pi Lite and CANDY RED

CANDY_PI_LITE_VERSION=master

curl -sL \
  https://raw.githubusercontent.com/CANDY-LINE/candy-pi-lite-service/${CANDY_PI_LITE_VERSION}/install.sh | \
  BOARD=RPi \
  FORCE_INSTALL=1 \
  CANDY_PI_LITE_APT_GET_UPDATED=1 \
  bash

# Prepare package.json
cd /opt/candy-red/.node-red
echo '{"name": "node-red-project","version": "0.0.1","description": "A Node-RED Project"}' > package.json
npm init --yes

# Always Enable UFW
sed -i -e "s/ENABLED=no/ENABLED=yes/g" /etc/ufw/ufw.conf

# Sense HAT node and SmartMesh node
pip install pillow pyserial

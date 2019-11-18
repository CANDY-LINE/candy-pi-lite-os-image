# on_chroot

# CANDY Pi Lite and CANDY RED

CANDY_PI_LITE_VERSION=master

# Workaround for the SSL error
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
curl -vsL https://raw.githubusercontent.com/CANDY-LINE/candy-pi-lite-service/${CANDY_PI_LITE_VERSION}/install.sh | BOARD=RPi FORCE_INSTALL=1 CANDY_PI_LITE_APT_GET_UPDATED=1 bash

# Always Enable UFW
sed -i -e "s/ENABLED=no/ENABLED=yes/g" /etc/ufw/ufw.conf

# Sense HAT node and SmartMesh node
pip install pillow pyserial

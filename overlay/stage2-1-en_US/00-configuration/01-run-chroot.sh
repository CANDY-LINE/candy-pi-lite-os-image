# on_chroot

rm -f /etc/localtime
ln -s /usr/share/zoneinfo/UTC /etc/localtime

locale-gen

# ARMv6 Binaries Tweak: https://github.com/nodejs/build/issues/1677#issuecomment-486204349

# Node.js for ARMv7+
# NODEJS_BASE_URL=https://nodejs.org/dist/v
# NODEJS_ARCH=armv7l
# Node.js for ARMv6
NODEJS_BASE_URL=https://unofficial-builds.nodejs.org/download/release/v
NODEJS_ARCH=armv6l

apt-get remove -y nodered nodejs nodejs-legacy npm
rm -f \
  /usr/bin/node \
  /usr/bin/npm \
  /usr/sbin/node \
  /usr/sbin/npm \
  /usr/local/bin/node \
  /usr/local/bin/npm

cd /tmp
wget ${NODEJS_BASE_URL}${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-${NODEJS_ARCH}.tar.gz
tar zxf node-v${NODEJS_VERSION}-linux-${NODEJS_ARCH}.tar.gz
cd node-v${NODEJS_VERSION}-linux-${NODEJS_ARCH}/
cp -R * /usr/
rm -f /usr/CHANGELOG.md /usr/LICENSE /usr/README.md
rm -f /tmp/node-v${NODEJS_VERSION}-linux-${NODEJS_ARCH}.tar.gz
rm -fr /tmp/node-v${NODEJS_VERSION}-linux-${NODEJS_ARCH}/
rm -f /usr/CHANGELOG.md
rm -f /usr/LICENSE
rm -f /usr/README.md

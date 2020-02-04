# on_chroot

rm -f /etc/localtime
ln -s /usr/share/zoneinfo/UTC /etc/localtime

locale-gen

# ARMv6 Binaries Tweak: https://github.com/nodejs/build/issues/1677#issuecomment-486204349

# Node.js v11 or before
# ARMv6_NODEJS_BASE_URL=https://nodejs.org/dist/v
# Node.js v12 or later
ARMv6_NODEJS_BASE_URL=https://unofficial-builds.nodejs.org/download/release/v

ARMv6_NODEJS_VERSION="12.14.1"

apt-get remove -y nodered nodejs nodejs-legacy npm
rm -f \
  /usr/bin/node \
  /usr/bin/npm \
  /usr/sbin/node \
  /usr/sbin/npm \
  /usr/local/bin/node \
  /usr/local/bin/npm

cd /tmp
wget ${ARMv6_NODEJS_BASE_URL}${ARMv6_NODEJS_VERSION}/node-v${ARMv6_NODEJS_VERSION}-linux-armv6l.tar.gz
tar zxf node-v${ARMv6_NODEJS_VERSION}-linux-armv6l.tar.gz
cd node-v${ARMv6_NODEJS_VERSION}-linux-armv6l/
cp -R * /usr/
rm -f /usr/CHANGELOG.md /usr/LICENSE /usr/README.md
rm -f /tmp/node-v${ARMv6_NODEJS_VERSION}-linux-armv6l.tar.gz
rm -fr /tmp/node-v${ARMv6_NODEJS_VERSION}-linux-armv6l/
rm -f /usr/CHANGELOG.md
rm -f /usr/LICENSE
rm -f /usr/README.md

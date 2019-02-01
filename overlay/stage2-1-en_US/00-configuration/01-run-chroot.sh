# on_chroot

rm -f /etc/localtime
ln -s /usr/share/zoneinfo/UTC /etc/localtime

locale-gen

ARMv6_NODEJS_VERSION="8.15.0"

apt-get remove -y nodered nodejs nodejs-legacy npm
rm -f \
  /usr/bin/node \
  /usr/bin/npm \
  /usr/sbin/node \
  /usr/sbin/npm \
  /usr/local/bin/node \
  /usr/local/bin/npm

cd /tmp
wget https://nodejs.org/dist/v${ARMv6_NODEJS_VERSION}/node-v${ARMv6_NODEJS_VERSION}-linux-armv6l.tar.gz
tar zxf node-v${ARMv6_NODEJS_VERSION}-linux-armv6l.tar.gz
cd node-v${ARMv6_NODEJS_VERSION}-linux-armv6l/
cp -R * /usr/
rm -f /tmp/node-v${ARMv6_NODEJS_VERSION}-linux-armv6l.tar.gz
rm -fr /tmp/node-v${ARMv6_NODEJS_VERSION}-linux-armv6l/
rm -f /usr/CHANGELOG.md
rm -f /usr/LICENSE
rm -f /usr/README.md

# on_chroot

rm -f /etc/localtime
ln -s /usr/share/zoneinfo/UTC /etc/localtime

locale-gen

ARMv6_NODEJS_VERSION="6.12.3"

cd /tmp
wget https://nodejs.org/dist/v${ARMv6_NODEJS_VERSION}/node-v${ARMv6_NODEJS_VERSION}-linux-armv6l.tar.gz
tar zxf node-v${ARMv6_NODEJS_VERSION}-linux-armv6l.tar.gz
cd node-v${ARMv6_NODEJS_VERSION}-linux-armv6l/
cp -R * /usr/
rm -f /tmp/node-v${ARMv6_NODEJS_VERSION}-linux-armv6l.tar.gz
rm -fr /tmp/node-v${ARMv6_NODEJS_VERSION}-linux-armv6l/

# on_chroot

# Install CANDY RED Plugin module

pushd /usr/lib/node_modules/candy-red
npm install --unsafe-perm ./plugin.tgz
rm -f ./plugin.tgz
popd

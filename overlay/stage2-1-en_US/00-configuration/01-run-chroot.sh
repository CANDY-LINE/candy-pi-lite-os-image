# on_chroot

rm -f /etc/localtime
ln -s /usr/share/zoneinfo/UTC /etc/localtime

locale-gen

curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -

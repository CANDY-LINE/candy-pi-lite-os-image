# on_chroot

rm -f /etc/localtime
ln -s /usr/share/zoneinfo/UTC /etc/localtime

locale-gen

# on_chroot

rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Japan /etc/localtime

locale-gen

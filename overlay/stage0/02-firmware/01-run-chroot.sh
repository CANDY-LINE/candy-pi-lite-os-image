# on_chroot

FIRMWARE_DIR=/tmp/firmware
pushd ${FIRMWARE_DIR}

for PACKAGE_DEB in `ls *.deb`
do
  dpkg -i ${PACKAGE_DEB}
  PACKAGE=`echo ${PACKAGE_DEB} | cut -d _ -f 2`
  echo "${PACKAGE} hold" | dpkg --set-selections
  dpkg --get-selections ${PACKAGE}
done

popd
rm -fr ${FIRMWARE_DIR}

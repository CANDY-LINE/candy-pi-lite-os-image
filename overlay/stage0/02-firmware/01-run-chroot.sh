# on_chroot

FIRMWARE_DIR=/tmp/firmware
pushd ${FIRMWARE_DIR}

# ref: https://github.com/monome/norns-image/pull/76/commits/a62b057daefbabc6f5f4fc1a11a740e34fa38692
# install specific version of Raspberry firmware and userland tools
RPI_FIRMWARE_VERSION="1.20200601-1"

for PACKAGE_DEB in `ls *.deb`
do
  dpkg -i ${PACKAGE_DEB}
  PACKAGE=`echo ${PACKAGE_DEB} | cut -d _ -f 2`
  echo "${PACKAGE} hold" | dpkg --set-selections
  dpkg --get-selections ${PACKAGE}
done

popd
rm -fr ${FIRMWARE_DIR}

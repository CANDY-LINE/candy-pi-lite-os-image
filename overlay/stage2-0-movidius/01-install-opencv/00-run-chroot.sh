# on_chroot

# OpenCV
OPENCV_VERSION=3.4.0
JOBS=${JOBS:-4}
cd /opt
wget -O opencv.zip https://github.com/Itseez/opencv/archive/${OPENCV_VERSION}.zip
unzip opencv.zip
rm -f opencv.zip
wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/${OPENCV_VERSION}.zip
unzip opencv_contrib.zip
rm -f opencv_contrib.zip
cd /opt/opencv-${OPENCV_VERSION}/
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D BUILD_DOCS=OFF \
      -D BUILD_EXAMPLES=OFF \
      -D BUILD_PERF_TESTS=OFF \
      -D BUILD_TESTS=OFF \
      -D INSTALL_C_EXAMPLES=OFF \
      -D INSTALL_PYTHON_EXAMPLES=OFF \
      -D INSTALL_TESTS=OFF \
      -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib-${OPENCV_VERSION}/modules \
      ..
make -j${JOBS}
make install
ldconfig

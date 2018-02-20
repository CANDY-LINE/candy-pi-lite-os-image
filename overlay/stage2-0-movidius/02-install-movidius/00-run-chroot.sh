# on_chroot

# Movidius SDK without examples
mkdir -p /opt/movidius.github.io
cd /opt/movidius.github.io
git clone http://github.com/Movidius/ncsdk
cd ncsdk
make prereqs
./install.sh

# PYTHONPATH for pi user
echo -e "export PYTHONPATH=\"\${PYTHONPATH}:/opt/movidius/caffe/python\"" >> /home/pi/.bashrc

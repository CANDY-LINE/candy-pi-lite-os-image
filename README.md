candy-pi-lite-os-image
===

Raspbian OS image builder for [CANDY Pi Lite Board](https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=https%3A%2F%2Fwww.candy-line.io%2F製品一覧%2Fcandy-pi-lite%2F&edit-text=&act=url)

# Supported Raspberry Pi

ARMv6/ARMv7 boards are available for this image.

- [Raspberry Pi Zero (Pin Header is required)](https://www.raspberrypi.org/products/raspberry-pi-zero/)
- [Raspberry Pi Zero W (Pin Header is required)](https://www.raspberrypi.org/products/raspberry-pi-zero/)
- [Raspberry Pi Zero WH](https://www.raspberrypi.org/blog/zero-wh/)
- [Raspberry Pi 1 Model A+](https://www.raspberrypi.org/products/raspberry-pi-1-model/)
- [Raspberry Pi 1 Model B+](https://www.raspberrypi.org/products/raspberry-pi-1-model-b/)
- [Raspberry Pi 2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)
- [Raspberry Pi 3 Model A+](https://www.raspberrypi.org/products/raspberry-pi-3-model-a-plus/)
- [Raspberry Pi 3 Model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)
- [Raspberry Pi 3 Model B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
- [Raspberry Pi 4 Model B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/)

# Raspbian OS Version

- Raspbian Buster Version September 2019 (Release date: 2019-09-26, Kernel: v4.19) with some library updates at the time of the image creation

# Features

- [Raspbian OS Lite (Raspbian Buster Lite)](https://www.raspberrypi.org/downloads/raspbian/) based image with software updates
- [CANDY Pi Lite Board Service](https://github.com/CANDY-LINE/candy-pi-lite-service) is installed
- [CANDY RED](https://github.com/CANDY-LINE/candy-red), a Node-RED based software dedicated to [CANDY Pi Lite Board](https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=https%3A%2F%2Fwww.candy-line.io%2F製品一覧%2Fcandy-pi-lite%2F&edit-text=&act=url) and [CANDY EGG Cloud Service](https://translate.google.com/translate?hl=en&sl=ja&tl=en&u=https%3A%2F%2Fwww.candy-line.io%2F製品一覧%2Fcandy-red-egg%2F), is installed
- `ufw` is enabled (denying from all traffic on `ppp0` and `wwan0`)
- Hardware watchdog is enabled
- Node.js v12 (armv6l) is installed (in Active LTS)
- `ssh` is **DISABLED** by default. Place an empty file as `/boot/ssh` to enable it
- Extra Debian Packages
  - `git`
  - `screen`
  - `fswebcam`
  - `sense-hat`
- Extra Python Packages
  - `pillow`
  - `pyserial`

## Distributions

- `*-en_US` suffix image contains US Keyboard Layout with UTC timezone and en_US.UTF-8 locale
- `*-ja_JP` suffix image contains Japanese Keyboard Layout with JST timezone and ja_JP.UTF-8 locale and CJK fonts

# How to flash the image

Use [balenaEtcher](https://www.balena.io/etcher/) for burning the image, which is a cross-platform app.

# How to build images

```
# create a tag for the version then push it to remote

RELEASE_VERSION=8.0.0

FIRST_USER_NAME="pi" \
  FIRST_USER_PASS="raspberry" \
  ENABLE_SSH="0" \
  BOOT_APN="my-apn" \
  ./scripts/before_script.sh

time ./scripts/build_img.sh

GITHUB_OAUTH_TOKEN=YOUR_GITHUB_OAUTH_TOKEN \
  TAG_NAME=${RELEASE_VERSION} \
  ./scripts/deploy_zip.sh
```

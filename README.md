candy-pi-lite-os-image
===

Raspbian OS image builder for [CANDY Pi Lite Board](https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=https%3A%2F%2Fwww.candy-line.io%2F製品一覧%2Fcandy-pi-lite%2F&edit-text=&act=url)

# Supported Raspberry Pi

ARMv6/ARMv7 boards are available for this image.

- [Raspberry Pi Zero (Pin Header is required)](https://www.raspberrypi.org/products/raspberry-pi-zero/)
- [Raspberry Pi Zero W (Pin Header is required)](https://www.raspberrypi.org/products/raspberry-pi-zero/)
- [Raspberry Pi Zero WH](https://www.raspberrypi.org/blog/zero-wh/)
- [Raspberry Pi  Model A+](https://www.raspberrypi.org/products/raspberry-pi-1-model/)
- [Raspberry Pi  Model B+](https://www.raspberrypi.org/products/raspberry-pi-1-model-b/)
- [Raspberry Pi2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)
- [Raspberry Pi3 Model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)

# Raspbian OS Version

- Raspbian Stretch Version 2017-11-29 (Kernel v4.9) with some library updates at the time of the image creation

# Features

- [Raspbian OS Lite (RASPBIAN STRETCH LITE)](https://www.raspberrypi.org/downloads/raspbian/) based image with software updates
- [CANDY Pi Lite Board Service](https://github.com/CANDY-LINE/candy-pi-lite-service) is installed
- [CANDY RED](https://github.com/CANDY-LINE/candy-red), a Node-RED based software dedicated to [CANDY Pi Lite Board](https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=https%3A%2F%2Fwww.candy-line.io%2F製品一覧%2Fcandy-pi-lite%2F&edit-text=&act=url) and [CANDY EGG Cloud Service](https://translate.google.com/translate?hl=en&sl=ja&tl=en&u=https%3A%2F%2Fwww.candy-line.io%2F製品一覧%2Fcandy-red-egg%2F), is installed
- `ufw` is enabled (denying from all traffic on `ppp0` and `wwan0`)
- Hardware watchdog is enabled
- Node.js v6 (armv6l) is installed (in Maintenance LTS)
- `ssh` is **DISABLED** by default. Place an empty file as `/boot/ssh` to enable it
- Extra Packages
  - `git`
  - `screen`
  - `fswebcam`
  - `sense-hat`

## Distributions

- `*-en_US` suffix image contains US Keyboard Layout with UTC timezone and en_US.UTF-8 locale
- `*-ja_JP` suffix image contains Japanese Keyboard Layout with JST timezone and ja_JP.UTF-8 locale

# How to flash the image

Use [Etcher](https://etcher.io) for burning the image, which is a cross-platform app.

# Revision History

* 2.2.1
  - CANDY Pi Lite Board Service 3.0.1

* 2.2.0
  - CANDY Pi Lite Board Service 3.0.0
  - CANDY RED 6.0.0

* 2.1.4
  - Fix an issue where `ufw` was inactive

* 2.1.3
  - CANDY Pi Lite Board Service 2.0.2

* 2.1.2
  - Remove nodejs package

* 2.1.1
  - CANDY Pi Lite Board Service 2.0.1

* 2.1.0
  - ARMv6 Raspberry Pi Boards(Zero/Zero W/Zero WH/Model A+/Model B+) Support
  - CANDY Pi Lite Board Service 2.0.0
  - CANDY RED 5.6.1

* 2.0.1
  - CANDY Pi Lite Board Service 1.8.2
  - CANDY RED 5.6.1

* 2.0.0
  - Update Base Raspbian Stretch version to `2017-11-29-raspbian-stretch`
  - CANDY Pi Lite Board Service 1.8.0
  - CANDY RED 5.6.1

* 1.3.0
  - CANDY Pi Lite Board Service 1.7.3
  - CANDY RED 5.5.0

* 1.2.0
  - CANDY Pi Lite Board Service 1.7.2
  - CANDY RED 5.5.0

* 1.1.0
  - Sense HAT support
  - Improve package installation time

* 1.0.0
  - Initial Release

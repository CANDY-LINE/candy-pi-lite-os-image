candy-pi-lite-os-image
===

Raspbian OS image builder for [CANDY Pi Lite Board](https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=https%3A%2F%2Fwww.candy-line.io%2F製品一覧%2Fcandy-pi-lite%2F&edit-text=&act=url)

# Supported Raspberry Pi

ARMv7+ boards are available for this image.

- [Raspberry Pi2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/)
- [Raspberry Pi3 Model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)

# Raspbian OS Version

- Raspbian Stretch Version 2017-09-07 (Kernel v4.9) with some library updates at the time of the image creation

# Features

- [Raspbian OS Lite (RASPBIAN STRETCH LITE)](https://www.raspberrypi.org/downloads/raspbian/) based image with software updates
- [CANDY Pi Lite Board Service](https://github.com/CANDY-LINE/candy-pi-lite-service) is installed
- [CANDY RED](https://github.com/CANDY-LINE/candy-red), a Node-RED based software dedicated to [CANDY Pi Lite Board](https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=https%3A%2F%2Fwww.candy-line.io%2F製品一覧%2Fcandy-pi-lite%2F&edit-text=&act=url) and [CANDY EGG Cloud Service](https://translate.google.com/translate?hl=en&sl=ja&tl=en&u=https%3A%2F%2Fwww.candy-line.io%2F製品一覧%2Fcandy-red-egg%2F), is installed
- ufw is enabled (denying from all traffic on `ppp0` and `wwan0`)
- Hardware watchdog is enabled
- Node.js v6 is installed (in Maintenance LTS)
- `ssh` is **DISABLED** by default. Place am empty file to `/boot/ssh` to enable ssh
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

* 1.0.0
  - Initial Release

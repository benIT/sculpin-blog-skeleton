---
draft: true
title: Install a nextcloud box
categories:
    - system
    - linux
tags:
    - debian
    - raspberry

---

- [burn a usb drive](/blog/2017/06/12/create-a-debian-iso-live-usb-drive). [Here is a fully configured box](https://ownyourbits.com/2017/02/13/nextcloud-ready-raspberry-pi-image/)

- [take a look about connecting to pi over ethernet](/blog/2017/06/15/connect-to-raspberry-over-ethernet)

- [change keyboard layout](https://raspberrypi.stackexchange.com/questions/10060/raspbian-keyboard-layout) if needed before getting crazy:
    sudo vi /etc/default/keyboard
    XKBLAYOUT="fr"
    
- enable usb device automount: `nc-automount` in `sudo nextcloudpi-config`

- format usb-drive as ext4 `msdos` partition table if necessary using gparted

- change nc-database to the flashdrive using `sudo nextcloudpi-config` then `nc-database`

- change nc-datadir to the flashdrive using `sudo nextcloudpi-config` then `nc-datadir`

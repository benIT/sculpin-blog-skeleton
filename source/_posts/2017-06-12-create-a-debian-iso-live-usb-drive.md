---
title: Create a debian live usb drive
categories:
    - system
    - linux
tags:
    - debian

---

##Download a debian 8 iso

- Download a debian iso from [debian official site](https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/)

##Format your usb key and flag it as bootable

- install gparted: `sudo apt-get install gparted`
- identify your usb drive with: `fdisk -l`
- format it as `ntfs`(so the drive can be used with windows too)
- flag it as 'boot'
- unmount the key

##Burn it to a usb flash drive

Copy iso file to key using `dd`

    sudo dd bs=4M if=debian-live-8.8.0-amd64-gnome-desktop.iso of=/dev/sdb

- eject the key
- restart PC anc check from BIOS that PC will boot from usb devices at first
- install debian
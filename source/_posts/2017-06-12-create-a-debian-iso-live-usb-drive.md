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

##Set up sources.list

After install from live usb whitout internet, edit as follow `/etc/apt/sources.list`
	# deb cdrom:[Debian GNU/Linux 8 _Jessie_ - Official Snapshot amd64 LIVE/INSTALL Binary 20170506-15:01]/ jessie main

	#deb cdrom:[Debian GNU/Linux 8 _Jessie_ - Official Snapshot amd64 LIVE/INSTALL Binary 20170506-15:01]/ jessie main

	# Line commented out by installer because it failed to verify:
	#deb http://security.debian.org/ jessie/updates main
	# Line commented out by installer because it failed to verify:
	#deb-src http://security.debian.org/ jessie/updates main

	deb http://ftp.fr.debian.org/debian/ jessie main contrib non-free
	deb http://security.debian.org/ jessie/updates main contrib non-free


Update the package index:

	apt-get update

And upgrade packages:

	apt-get upgrade

Let's check everything is ok by installing a common packages:

	apt-get install -y vim git
	
##sudoerfile 
Add the existing 'ben' user to the 'sudo' group:

	su
	adduser ben sudo
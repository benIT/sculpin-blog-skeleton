---
title: Linux multiusb live
categories:
    - linux
---
## Purpose
This post deals with creating a multi linux iso live usb drive. [source](https://itsfoss.com/multiple-linux-one-usb/)

##  Procedure

* format your drive to fat32
* [download MultiBootUsb](https://github.com/mbusb/multibootusb/releases/download/v8.8.0/python3-multibootusb_8.8.0-1_all.deb)
* install it : `dpkg -i python3-multibootusb_8.8.0-1_all.deb`
* check if all python dependencies are satisfied, if not try install missing with `sudo apt install python3-pyqt5 p7zip-full python3-pyudev`
* enjoy : you can now burn several iso using the GUI. Great tool!
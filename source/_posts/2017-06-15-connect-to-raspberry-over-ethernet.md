---
title: Connect to raspberry pi from linux host using a simple ethernet cable
categories:
    - system
    - linux
tags:
    - debian
    - raspberry

---

##On debian host machine

- run `gnome-nettool` and share the connection:
![network conf](/images/wired.png)

- Mount the raspberry pi SD card, and edit the `cmdline.txt` file adding:
 
    ip=169.254.6.100

- *The pi and the debian PC must on the same subnetwork ie: `169.254.6.XXX`*

- Check the connectivity:

        ping 169.254.6.100


##On raspberry pi machine
-insert SD card and boot pi

- enable ssh:
 
        sudo raspi-config 
    
- `Interfacing Options` then `SSH`


##SSH IT !

From the debian pc:

    ssh pi@169.254.6.100
    
    
    nc-automount in sudo nextcloudpi-config
    
    format usb-drive as ext4 `msdos` partition table if necessary using gparted

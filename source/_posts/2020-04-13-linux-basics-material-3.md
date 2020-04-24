---
title: linux basics: material 3 - FHS: Filesystem Hierarchy Standard
categories:
    - linux
    - linux basics
tags:

---

### Programs folder

* /bin: exec for all users
* /sbin: exec for admins only
* /lib: lib for programs

### System folders

* /boot: for system boot
* /usr: for all non essential files to system running. example: GUI
* /usr/local: folder that is not impacted when system upgrades. Used to store manually compiled programs
* /opt: optional programs installed by packages
* /etc: editable text configuration. Configuration files
* /srv: should contain services data. not respected

### users data folder

* /home/XXX: data for user XXX
* /root: home for root user

### Variable data

* /var: for logs, mail
* /tmp: temp files

### Mount folders

* /mnt : for mounting tempo FS. Example: /mnt/data, /mnt/samba
* /media: mount folder for removable media: USB stick...

#### Virtual FS

* /dev
* /proc
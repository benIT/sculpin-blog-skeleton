---
title: linux basics: material 4 - Create a fake hard drive with `dd` and `losetup`
categories:
    - linux
    - linux basics
tags:

---

 

* create a file of the partition size with `dd` command
* associate it to a loop device with `losetup` command
* partition it with `fdisk`

### dd command

utility to copy files/partition
create a file named `my-hd-file`
  
Create a 100Mo file filed with 0 from /dev/zero: 
    
    touch my-hd-file
	dd if=/dev/zero of=my-hd-file bs=1024000 count=1
	1+0 records in
	1+0 records out
	1024000 bytes (1.0 MB, 1000 KiB) copied, 0.0318375 s, 32.2 MB/s
	root@raspbeeerry:~# dd if=/dev/zero of=my-hd-file bs=1024000 count=100
	100+0 records in
	100+0 records out
	102400000 bytes (102 MB, 98 MiB) copied, 0.749057 s, 137 MB/s

### Loop device 

In Unix-like operating systems, a loop device, vnd (vnode disk), or lofi (loop file interface) is a pseudo-device that makes a file accessible as a block device.

* `losetup -f` to identify next available loop device number  => `/dev/loop0`
* `losetup -a`: list all loop devices


	root@raspbeeerry:~# losetup -a
	root@raspbeeerry:~# losetup -f
	/dev/loop0
	root@raspbeeerry:~# losetup /dev/loop0 my-hd-file
	root@raspbeeerry:~# losetup -a
	/dev/loop0: [2049]:2752537 (/root/my-hd-file)
	root@raspbeeerry:~# 
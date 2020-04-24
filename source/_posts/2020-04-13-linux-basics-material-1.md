---
title: linux basics: material 1 - command & kernel
categories:
    - linux
    - linux basics
tags:

---

## Linux material command

* `free`: for memory information
* `uname`: material information

see dedicated virtual FS such as : /dev, /proc...

## Special pseudo drives 

* `/dev/null`: black hole
* `/dev/zero`: returns zeros
* `/dev/full`: emulate a full  hard drive


## About linux kernel

The kernel gives a material abstraction layer to software layer. 

## About linux kernel modules

The linux kernel is monolithic but some modules can be loaded/unloaded such as driver


* `lsmod` : list kernel modules
* `modprobe`: load/unload/manage kernel modules
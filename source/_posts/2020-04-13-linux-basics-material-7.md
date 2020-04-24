---
title: linux basics: material 7 - formatting
categories:
    - linux
    - linux basics
tags:

---

## Formatting

BE CAREFUL: FORMATTING WILL ERASE ALL EXISTING DATA!

formatting means create a FS.

    mkfs.ext4 /dev/sdb1
    mkfs -t ext4 /dev/sdb1


check a disk with mkfs, looks for bad element meaning the diskend of life:
    
    mkfs -t ext4 -c /dev/sdb1

-m: % reserved space to prevent user to fullfill disk.


### SWAP formatting

    mkswap /dev/sdbX #format
    swapon /dev/sdbX #tell system to use it as swap
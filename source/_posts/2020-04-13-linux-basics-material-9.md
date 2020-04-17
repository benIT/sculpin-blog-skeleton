---
title: linux basics: material - mount FS - 9/10
categories:
    - linux
    - linux basics
tags:

---
### mount

mounting a FS means associate it to the linux tree, in a particular folder.

From man:

All files accessible in a Unix system are arranged in one big tree, the
file hierarchy, rooted at /.  These files can be spread out  over  sev‐
eral  devices.  The mount command serves to attach the filesystem found
on some device to the big file tree.
 
     mkdir -p /mnt/test
     mount /dev/sdb1 /mnt/test
     cd /mnt/test/
     touch f1 f2 f3
     umount /mnt/test 
     mount /dev/sdb1 /mnt/test
     ls /mnt/test/


    mount -a: mount all FS /etc/fstab 

* -r: ro
* -t ext4: specify FS ext type
* -L alabel: mount the FS matching the given label
* -U aUUID: mount the FS matching the given UUID

### list mounted FS

    mount -l 

### mount options    

    mount -o auto

* remount    
* ro
* rw
* loop: for loopback block device    
* auto/noauto: auto mount the FS at startup or mount -a
* user: specify user allowed to mount/unmount the FS

mount FS in RO mode:

     mount -o ro /dev/sdb1 /mnt/test/
     ls /mnt/test/
     f1  f2 f3  lost+found
     date >> /mnt/test/f1
     -su: /mnt/test/f1: Read-only file system

remount it in RW mode (without unmount!):

     mount -o rw,remount /dev/sdb1 /mnt/test/
     date >> /mnt/test/f1



## umount

    umount /dev/sdb1
 
 or

    umount /mnt/test

* -a: all
* -f: forcee
* -r: if fails, remount in ro

------------------------------------------

### fstab

/etc/fstab is used to automount FS




## FS Summary

* partitioning a disk means divide it into several spaces: see `fdisk` or `parted` 
* formatting means creating a FS on partition: see `mkfs`
* FS can  be analysed with `dumpe2fs`, tuned with `tune2fs` 
* FS can  be checked with `fsck` 
* mount means attaching a device in a particular folder of the linux tree: see `mount`
* FS mount can be automated with `/etc/fstab` file

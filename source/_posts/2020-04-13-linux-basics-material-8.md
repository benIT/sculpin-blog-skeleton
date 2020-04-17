---
title: linux basics: material - FS tools - 8/10
categories:
    - linux
    - linux basics
tags:

---
## FS tools

### dumps FS informations: dumpe2fs

inode: means a file

    dumpe2fs -h /dev/sda1
 
 outputs:

    Filesystem OS type:       Linux
    Inode count:              9707520 #max number of files
    Block count:              38812416 #max number of blocks
    Reserved block count:     1940620
    Free blocks:              33756140 #
    Free inodes:              9545389  #

### tune FS settings: tune2fs

!! never use on a mounted FS !!

tune2fs

#### set number of mount before checking FS

    tune2fs -c 3 /dev/sdb1

=>

    tune2fs 1.43.4 (31-Jan-2017)
    Setting maximal mount count to 3

#### set time interval before checking FS

    tune2fs -i 60d /dev/sdb1
    
=>


    tune2fs 1.43.4 (31-Jan-2017)
    Setting interval between checks to 5184000 seconds


check:

    dumpe2fs -h /dev/sdb1 | grep interval

#### set number of reserved blocks

prevent user to fullfill FS

    tune2fs -m 3 /dev/sdb1

=>    

    tune2fs 1.43.4 (31-Jan-2017)
    Setting reserved blocks percentage to 3% (14667 blocks)



#### debugfs

!! never use on a mounted FS !!

dumpe + tune FS

    debugfs -w /dev/sdb1

##### FS stats

   stats

=>

    Filesystem volume name:   <none>
    Last mounted on:          /media/pi/CDROM
    Filesystem UUID:          41d6539d-342e-4c2b-93f3-c941525d29b3
    Filesystem magic number:  0xEF53
    Filesystem revision #:    1 (dynamic)
    Filesystem features:      has_journal ext_attr resize_inode dir_index filetype needs_recovery extent 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize metadata_csum
    Filesystem flags:         signed_directory_hash 
    Default mount options:    user_xattr acl
    Filesystem state:         clean
    Errors behavior:          Continue
    Filesystem OS type:       Linux
    Inode count:              122400
    Block count:              488907
    Reserved block count:     14667
    Free blocks:              471589
    Free inodes:              122388
    First block:              0
    Block size:               4096
    Fragment size:            4096
    Group descriptor size:    64
    Reserved GDT blocks:      238

##### File stats

    stat test.txt

=>

    Inode: 13   Type: regular    Mode:  0644   Flags: 0x80000
    Generation: 1782112958    Version: 0x00000000:00000001
    User:     0   Group:     0   Project:     0   Size: 5
    File ACL: 0    Directory ACL: 0
    Links: 1   Blockcount: 8
    Fragment:  Address: 0    Number: 0    Size: 0
     ctime: 0x5e95a4c1:dc281c1c -- Tue Apr 14 13:55:45 2020
      atime: 0x5e95a4c1:dc281c1c -- Tue Apr 14 13:55:45 2020
       mtime: 0x5e95a4c1:dc281c1c -- Tue Apr 14 13:55:45 2020
       crtime: 0x5e95a4c1:dc281c1c -- Tue Apr 14 13:55:45 2020
       Size of extra inode fields: 32
       Inode checksum: 0x8be005b7
       EXTENTS:
       (0):33008



lsdel: list deleted file 
undel: undelete a file



### FSCK

fsck - check and repair a Linux filesystem

!! never use on a mounted FS !!

    fsck -v /dev/sdb1

=> 
    
    fsck from util-linux 2.29.2
     e2fsck 1.43.4 (31-Jan-2017)
     /dev/sdb1: clean, 13/122400 files, 17319/488907 blocks (check after next mount)
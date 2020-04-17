---
title: linux basics: material - partitioning with fdisk - 6/10
categories:
    - linux
    - linux basics
tags:

---

## fdisk command

about partitions: 

* Primary partition are limited to 4.
* Extended partitions are container for logical partitions.

fdisk "fixed disk" is the traditional linux partitioning utility.
Take a look at the following interactive output that creates:
* loop0p1  primary partition of 10M
* loop0p2  primary partition of 20M
* loop0p3  primary EXTENDED partition with all remaining space
* loop0p5  primary partition of 20M


    root@raspbeeerry:~# fdisk /dev/loop0 

    Welcome to fdisk (util-linux 2.29.2).
    Changes will remain in memory only, until you decide to write them.
    Be careful before using the write command.
    
    Device does not contain a recognized partition table.
    Created a new DOS disklabel with disk identifier 0xd1d1a072.
    
    Command (m for help): m
    
    Help:
    
    DOS (MBR)
    a   toggle a bootable flag
    b   edit nested BSD disklabel
    c   toggle the dos compatibility flag
    
    Generic
    d   delete a partition
    F   list free unpartitioned space
    l   list known partition types
    n   add a new partition
    p   print the partition table
    t   change a partition type
    v   verify the partition table
    i   print information about a partition
    
    Misc
    m   print this menu
    u   change display/entry units
    x   extra functionality (experts only)
    
    Script
    I   load disk layout from sfdisk script file
    O   dump disk layout to sfdisk script file
    
    Save & Exit
    w   write table to disk and exit
    q   quit without saving changes
    
    Create a new label
    g   create a new empty GPT partition table
    G   create a new empty SGI (IRIX) partition table
    o   create a new empty DOS partition table
    s   create a new empty Sun partition table

	Command (m for help): p
	Disk /dev/loop0: 97.7 MiB, 102400000 bytes, 200000 sectors
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0xd1d1a072

	Command (m for help): n
	Partition type
	   p   primary (0 primary, 0 extended, 4 free)
	   e   extended (container for logical partitions)
	Select (default p): p
	Partition number (1-4, default 1): 
	First sector (2048-199999, default 2048): 
	Last sector, +sectors or +size{K,M,G,T,P} (2048-199999, default 199999): +10M

	Created a new partition 1 of type 'Linux' and of size 10 MiB.

	Command (m for help): p
	Disk /dev/loop0: 97.7 MiB, 102400000 bytes, 200000 sectors
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0xd1d1a072

	Device       Boot Start   End Sectors Size Id Type
	/dev/loop0p1       2048 22527   20480  10M 83 Linux

	Command (m for help): n
	Partition type
	   p   primary (1 primary, 0 extended, 3 free)
	   e   extended (container for logical partitions)
	Select (default p): p
	Partition number (2-4, default 2): 
	First sector (22528-199999, default 22528): 
	Last sector, +sectors or +size{K,M,G,T,P} (22528-199999, default 199999): +20M    

	Created a new partition 2 of type 'Linux' and of size 20 MiB.

	Command (m for help): p
	Disk /dev/loop0: 97.7 MiB, 102400000 bytes, 200000 sectors
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0xd1d1a072

	Device       Boot Start   End Sectors Size Id Type
	/dev/loop0p1       2048 22527   20480  10M 83 Linux
	/dev/loop0p2      22528 63487   40960  20M 83 Linux

	Command (m for help): w
	The partition table has been altered.
	Calling ioctl() to re-read partition table.
	Re-reading the partition table failed.: Invalid argument

	The kernel still uses the old table. The new table will be used at the next reboot or after you run partprobe(8) or kpartx(8).

	root@raspbeeerry:~# fdisk /dev/loop0 

	Welcome to fdisk (util-linux 2.29.2).
	Changes will remain in memory only, until you decide to write them.
	Be careful before using the write command.


	Command (m for help): p
	Disk /dev/loop0: 97.7 MiB, 102400000 bytes, 200000 sectors
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0xd1d1a072

	Device       Boot Start   End Sectors Size Id Type
	/dev/loop0p1       2048 22527   20480  10M 83 Linux
	/dev/loop0p2      22528 63487   40960  20M 83 Linux

	Command (m for help): n
	Partition type
	   p   primary (2 primary, 0 extended, 2 free)
	   e   extended (container for logical partitions)
	Select (default p): e
	Partition number (3,4, default 3): 
	First sector (63488-199999, default 63488): 
	Last sector, +sectors or +size{K,M,G,T,P} (63488-199999, default 199999): 

	Created a new partition 3 of type 'Extended' and of size 66.7 MiB.

	Command (m for help): p
	Disk /dev/loop0: 97.7 MiB, 102400000 bytes, 200000 sectors
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0xd1d1a072

	Device       Boot Start    End Sectors  Size Id Type
	/dev/loop0p1       2048  22527   20480   10M 83 Linux
	/dev/loop0p2      22528  63487   40960   20M 83 Linux
	/dev/loop0p3      63488 199999  136512 66.7M  5 Extended

	Command (m for help): n
	All space for primary partitions is in use.
	Adding logical partition 5
	First sector (65536-199999, default 65536): 
	Last sector, +sectors or +size{K,M,G,T,P} (65536-199999, default 199999): +30M

	Created a new partition 5 of type 'Linux' and of size 30 MiB.

	Command (m for help): p
	Disk /dev/loop0: 97.7 MiB, 102400000 bytes, 200000 sectors
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0xd1d1a072

	Device       Boot Start    End Sectors  Size Id Type
	/dev/loop0p1       2048  22527   20480   10M 83 Linux
	/dev/loop0p2      22528  63487   40960   20M 83 Linux
	/dev/loop0p3      63488 199999  136512 66.7M  5 Extended
	/dev/loop0p5      65536 126975   61440   30M 83 Linux

	Command (m for help): w
	The partition table has been altered.
	Calling ioctl() to re-read partition table.
	Re-reading the partition table failed.: Invalid argument

	The kernel still uses the old table. The new table will be used at the next reboot or after you run partprobe(8) or kpartx(8).

	root@raspbeeerry:~# fdisk -l
	Disk /dev/sda: 149.1 GiB, 160041885696 bytes, 312581808 sectors
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0x6484e662

	Device     Boot     Start       End   Sectors   Size Id Type
	/dev/sda1  *         2048 310501375 310499328 148.1G 83 Linux
	/dev/sda2       310503422 312580095   2076674  1014M  5 Extended
	/dev/sda5       310503424 312580095   2076672  1014M 82 Linux swap / Solaris


	Disk /dev/loop0: 97.7 MiB, 102400000 bytes, 200000 sectors
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0xd1d1a072

	Device       Boot Start    End Sectors  Size Id Type
	/dev/loop0p1       2048  22527   20480   10M 83 Linux
	/dev/loop0p2      22528  63487   40960   20M 83 Linux
	/dev/loop0p3      63488 199999  136512 66.7M  5 Extended
	/dev/loop0p5      65536 126975   61440   30M 83 Linux
	root@raspbeeerry:~# free
		      total        used        free      shared  buff/cache   available
	Mem:        1020528      100940      352364       27400      567224      753912
	Swap:       1140728           0     1140728
	root@raspbeeerry:~# fdisk -l
	Disk /dev/sda: 149.1 GiB, 160041885696 bytes, 312581808 sectors
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0x6484e662

	Device     Boot     Start       End   Sectors   Size Id Type
	/dev/sda1  *         2048 310501375 310499328 148.1G 83 Linux
	/dev/sda2       310503422 312580095   2076674  1014M  5 Extended
	/dev/sda5       310503424 312580095   2076672  1014M 82 Linux swap / Solaris


	Disk /dev/loop0: 97.7 MiB, 102400000 bytes, 200000 sectors
	Units: sectors of 1 * 512 = 512 bytes
	Sector size (logical/physical): 512 bytes / 512 bytes
	I/O size (minimum/optimal): 512 bytes / 512 bytes
	Disklabel type: dos
	Disk identifier: 0xd1d1a072

	Device       Boot Start    End Sectors  Size Id Type
	/dev/loop0p1       2048  22527   20480   10M 83 Linux
	/dev/loop0p2      22528  63487   40960   20M 83 Linux
	/dev/loop0p3      63488 199999  136512 66.7M  5 Extended
	/dev/loop0p5      65536 126975   61440   30M 83 Linux



todo : see GNU parted that is a most advanced partition editor 


##  File System types

### Linux FS

* ext
* ext2: no journal: for small spaces
* ext3: journal
* ext4: last version of ext FS
* reiserfs
* jfs
* xfs

### FS from others OS

* FAT: legacy from dos/windows 95. file size limited to 4GO. works well with linux, mac, windws
* NTFS: from windows 2000
* HFS: hierarchical FS

## Formatting

BE CAREFUL: FORMATTING WILL ERASE ALL EXISTING DATA!

formatting means create a FS.


    mkfs.ext4 /dev/sdb1
    mkfs -t ext4 /dev/sdb1


check a disk with mkfs, looks for bad element meaning the diskend of life:
    
    mkfs -t ext4 -c /dev/sdb1

-m: % reserved space to prevent user to fullfill disk.


### SWAP partitioning

    mkswap /dev/sdbX #format
    swapon /dev/sdbX #tell sustem to use it as swap


-----------------------------------------

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



-----------------------------------------------

### mount

mount a FS means associate it to the linux tree, in a particular folder.

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

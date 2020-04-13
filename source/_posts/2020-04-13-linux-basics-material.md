---
title: linux basics: material
categories:
    - linux
    - linux basics
tags:

---

## Linux material command

free: for memory information
uname: material information

see dedicated virtual FS such as : /dev, /proc...

## Special pseudo drives 

/dev/null: black hole
/dev/zero: returns zeros
/dev/full: emulate a full  hard drive


---------------------------------------
## About linux kernel

The kernel gives a material abstraction layer to software layer. 

## About linux kernel modules

The linux kernel is monolithic but some modules can be loaded/unloaded such as driver


lsmod : list kernel modules
modprobe: load/unload/manage kernel modules


------------------------------------
## Linux hard drives naming

* floppy: /dev/fd
* fake hd: /dev/loop
* CD,DVD: /dev/sr
* IDE: /dev/hdX
* SATA: same as SCSI
* SCSI: /dev/sdX

## Partionning

partition table in MDR format
MBR: 4 partitions MAX
MBR contains partition table 

Extended partitions in EBR


---------------------------------

## FHS: Filesystem Hierarchy Standard

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

---------------------------------
## Create a hard drive with dd command

### dd command

utility to copy files/partition
create a file nammed `my-hd-file`
  
  dd if=/dev/zero of=my-hd-file bs=1024 count=10

### Loop device 

In Unix-like operating systems, a loop device, vnd (vnode disk), or lofi (loop file interface) is a pseudo-device that makes a file accessible as a block device.

use `losetup -f` to identify next available loop device number  => `/dev/loop0`
`losetup -a`: list all loop devices

  losetup /dev/loop0 my-hd-file


  
  -------------------------------------------------------------
  
  ## Steps to create a partition 

* create a file of the partition size with `dd` command
* associate it to a loop device with `losetup` command
* partition it with `fdisk`

Create a 100Mo file filed with 0 from /dev/zero

	dd if=/dev/zero of=my-hd-file bs=1024000 count=1
	1+0 records in
	1+0 records out
	1024000 bytes (1.0 MB, 1000 KiB) copied, 0.0318375 s, 32.2 MB/s
	root@raspbeeerry:~# dd if=/dev/zero of=my-hd-file bs=1024000 count=100
	100+0 records in
	100+0 records out
	102400000 bytes (102 MB, 98 MiB) copied, 0.749057 s, 137 MB/s


	root@raspbeeerry:~# losetup -a
	root@raspbeeerry:~# losetup -f
	/dev/loop0
	root@raspbeeerry:~# losetup /dev/loop0 my-hd-file
	root@raspbeeerry:~# losetup -a
	/dev/loop0: [2049]:2752537 (/root/my-hd-file)
	root@raspbeeerry:~# 


## fdisk command

about partitions: 

Primary partition are limited to 4.
Extended partitions are container for logical partitions.

fdisk "fixed disk" is the traditional linux partioning utility.
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


---
title: rpi dev 2 - extend RPI storage with a USB drive
categories:
    - linux
    - rpi
    - dev
tags:

---

## purpose

create 3 partitions of 8Go for :

* /var/www
* /mnt/gitea
* /var/lib/postgresql/

### Create 3 partitions on the USB drive of 8Go

    root@raspberrypi:~# fdisk /dev/sda
    
=>
    
    Command (m for help): o
    Created a new DOS disklabel with disk identifier 0x78494e0c.
    
    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p): p
    Partition number (1-4, default 1): 1
    First sector (2048-60063743, default 2048): 
    Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-60063743, default 60063743): +8G
    
    Created a new partition 1 of type 'Linux' and of size 8 GiB.
    
    Command (m for help): n
    Partition type
       p   primary (1 primary, 0 extended, 3 free)
       e   extended (container for logical partitions)
    Select (default p): p
    Partition number (2-4, default 2): 2
    First sector (16779264-60063743, default 16779264): 
    Last sector, +/-sectors or +/-size{K,M,G,T,P} (16779264-60063743, default 60063743): +8G
    
    Created a new partition 2 of type 'Linux' and of size 8 GiB.
    
    Command (m for help): n
    Partition type
       p   primary (2 primary, 0 extended, 2 free)
       e   extended (container for logical partitions)
    Select (default p): p
    Partition number (3,4, default 3): 
    First sector (33556480-60063743, default 33556480): 
    Last sector, +/-sectors or +/-size{K,M,G,T,P} (33556480-60063743, default 60063743): +8G
    
    Created a new partition 3 of type 'Linux' and of size 8 GiB.
    
    Command (m for help): w
    The partition table has been altered.
    Calling ioctl() to re-read partition table.
    Syncing disks.

### Check

    root@raspberrypi:~# fdisk -l /dev/sda

=>

    Disk /dev/sda: 28.7 GiB, 30752636928 bytes, 60063744 sectors
    Disk model: Ultra           
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x78494e0c
    
    Device     Boot    Start      End  Sectors Size Id Type
    /dev/sda1           2048 16779263 16777216   8G 83 Linux
    /dev/sda2       16779264 33556479 16777216   8G 83 Linux
    /dev/sda3       33556480 50333695 16777216   8G 83 Linux


### create ext4 filesystem for each partitions with explicit labels

    mkfs.ext4 -L pi-git /dev/sda1
    mkfs.ext4 -L pi-web /dev/sda2
    mkfs.ext4 -L pi-pgsql /dev/sda3

## Check

    root@raspberrypi:~# ls -l /dev/disk/by-label/

=>

    total 0
    lrwxrwxrwx 1 root root 15 Apr 28 18:17 boot -> ../../mmcblk0p1
    lrwxrwxrwx 1 root root 10 Apr 29 11:02 pi-git -> ../../sda1
    lrwxrwxrwx 1 root root 10 Apr 29 11:05 pi-pgsql -> ../../sda3
    lrwxrwxrwx 1 root root 10 Apr 29 11:05 pi-web -> ../../sda2
    lrwxrwxrwx 1 root root 15 Apr 28 18:17 rootfs -> ../../mmcblk0p2


## Mount

    mkdir -p /var/www
    mkdir -p /mnt/gitea
    mkdir -p /var/lib/postgresql/
    
    
add to `/etc/fstab. [see fstab resource](https://debian-facile.org/doc:systeme:fstab):

    LABEL=pi-git  /mnt/gitea				ext4    defaults  0       2
    LABEL=pi-web  /var/www					ext4    defaults  0       2
    LABEL=pi-pgsql  /var/lib/postgresql			ext4    defaults  0       2

mount:

    mount -a
    
check: 
        
    root@raspberrypi:~#  df -h

=> 
    
    Filesystem      Size  Used Avail Use% Mounted on
    /dev/root        15G  1.3G   13G  10% /
    devtmpfs        459M     0  459M   0% /dev
    tmpfs           464M     0  464M   0% /dev/shm
    tmpfs           464M  6.3M  457M   2% /run
    tmpfs           5.0M  4.0K  5.0M   1% /run/lock
    tmpfs           464M     0  464M   0% /sys/fs/cgroup
    /dev/mmcblk0p1  253M   53M  200M  21% /boot
    tmpfs            93M     0   93M   0% /run/user/1000
    /dev/sda1       7.9G   36M  7.4G   1% /mnt/gitea
    /dev/sda2       7.9G   36M  7.4G   1% /var/www
    /dev/sda3       7.9G   36M  7.4G   1% /var/lib/postgresql
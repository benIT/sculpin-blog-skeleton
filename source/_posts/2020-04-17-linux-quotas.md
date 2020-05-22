---
title: linux basics: quotas
categories:
    - linux
    - linux basics
tags:

---
## quotas

Quota specifications: 

* number of inode (inode: pointer to file)
* number of block

Types:

* hard: block user when quota is reached
* soft: inform user that is about to reached the quota

### install quotas

    apt install quota
    
### Enable quotas

#### Check config supports quota

    grep QUOTA /boot/config-*

=>

    CONFIG_NFT_QUOTA=m
    CONFIG_NETFILTER_XT_MATCH_QUOTA=m
    CONFIG_XFS_QUOTA=y
    CONFIG_QUOTA=y
    CONFIG_QUOTA_NETLINK_INTERFACE=y
    CONFIG_PRINT_QUOTA_WARNING=y
    # CONFIG_QUOTA_DEBUG is not set
    CONFIG_QUOTA_TREE=m
    CONFIG_QUOTACTL=y
    CONFIG_QUOTACTL_COMPAT=y

#### Mount options
    
Check quota are enable in /etc/fstab at the 4th column: `usrquota`, `grpquota` option must be specified:

    UUID=e248b430-aed3-4586-8a9f-2444515376e7 /               ext4    errors=remount-ro,acl,usrquota,grpquota 0 

### Enable 

    quotacheck -ugm /

check quota files have been created:

    ls /aquota.*
    /aquota.group  /aquota.user

this will fix the following error: `edquota: Cannot open quotafile //aquota.user: No such file or directory No filesystems with quota detected.`

turn it on:

    quotaon -v /

=>
    
    /dev/sda1 [/]: group quotas turned on
    /dev/sda1 [/]: user quotas turned on


### Quota commands

check quotas:

    quotacheck -a

display all quotas:
    
    repquota -a 

edit quota:

** do not edit `/etc/quotatab` file directly but use:

    edquota -u foo
    edquota -g foogrp
    
### edit grace period

grace period is the quantity of time that the system allows you to exceed the soft limit without blocking you.
After that, user will be considered as he exceeded the hard limit.

    edquota -t

### Service

    /etc/init.d/quota start
    service quota start



## Test it !

### As root

    Disk quotas for user foo (uid 1001):
      Filesystem                   blocks       soft       hard     inodes     soft     hard
      /dev/sda1                        16          0          0          4        5        6          


Here, our foo user has:
* currently consumed 4 inodes on the FS
* a quota soft limit set to 5 inodes
* a quota hard  limit set to 6 inodes


### As final user

#### Reach the soft limit
    foo@debian:~$ touch file 
    foo@debian:~$ touch file 2
    sda1: warning, user file quota exceeded.
    
#### Reach the hard limit
    
    foo@debian:~$ touch file 3
    sda1: write failed, user file limit reached.
    touch: cannot touch '3': Disk quota exceeded
    
### Report

    root@debian:~# repquota /
    
=>
    
    *** Report for user quotas on device /dev/sda1
    Block grace time: 7days; Inode grace time: 7days
                            Block limits                File limits
    User            used    soft    hard  grace    used  soft  hard  grace
    ----------------------------------------------------------------------
    root      -- 3645544       0       0         113922     0     0       
    man       --    1496       0       0            157     0     0       
    lp        --   11980       0       0              1     0     0       
    _apt      --      12       0       0              3     0     0       
    systemd-timesync --       4       0       0              2     0     0       
    avahi-autoipd --       4       0       0              1     0     0       
    speech-dispatcher --       4       0       0              1     0     0       
    colord    --       8       0       0              2     0     0       
    lightdm   --      32       0       0              8     0     0       
    ben       --   56020       0       0           1295     0     0       
    foo       -+      16       0       0              6     5     6  6days


## Resources

* https://www.digitalocean.com/community/tutorials/how-to-set-filesystem-quotas-on-debian-10
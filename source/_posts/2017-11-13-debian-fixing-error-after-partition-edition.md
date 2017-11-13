---
title: Debian:  fixing error: 'A start job is running for dev-disk-...'
categories:
    - linux
tags:

---

## Error encountered

After editing partitions to enlarge my vagrant box. The following error is encountered and the machine took 1min30 to boot:

    A start job is running for dev-disk-by\x2duuid
    
## Solution
    
### List machine partition by-uuid
    
    vagrant@moodle-prod:~$ ls -l /dev/disk/by-uuid/
    total 0
    lrwxrwxrwx 1 root root 10 Nov 13 08:49 a01bd0bf-1ffc-400d-b383-d74354750926 -> ../../sda2
    lrwxrwxrwx 1 root root 10 Nov 13 08:49 db36bd9a-c8f7-4b02-bb1a-81e4913a21d7 -> ../../sda1

### Check `/etc/fstab` file

    vagrant@moodle-prod:~$ sudo cat /etc/fstab
    # /etc/fstab: static file system information.
    #
    # Use 'blkid' to print the universally unique identifier for a
    # device; this may be used with UUID= as a more robust way to name devices
    # that works even if disks are added and removed. See fstab(5).
    #
    # <file system> <mount point>   <type>  <options>       <dump>  <pass>
    # / was on /dev/vda1 during installation
    UUID=db36bd9a-c8f7-4b02-bb1a-81e4913a21d7 /               ext4    errors=remount-ro 0       1
    # swap was on /dev/vda5 during installation
    UUID=8d7d9300-7fd3-4a5a-bfd1-9bc61a20fabd none            swap    sw              0       0
    /dev/sr0        /media/cdrom0   udf,iso9660 user,noauto     0       0


### SWAP UUID has changed
Problem: SWAP UID has changed

    # swap was on /dev/vda5 during installation
    UUID=8d7d9300-7fd3-4a5a-bfd1-9bc61a20fabd none            swap    sw     


Edit this line with the new UUID (change '8d7d9300-7fd3-4a5a-bfd1-9bc61a20fabd' to 'a01bd0bf-1ffc-400d-b383-d74354750926') in `/etc/fstab`:

	UUID=a01bd0bf-1ffc-400d-b383-d74354750926 none            swap    sw              0       0


## Check

Everything is now fine! Error solved!

[source](https://www.debian-fr.org/t/demarrage-a-start-job-is-running-for-dev-disk-by-x2duuid/64527)
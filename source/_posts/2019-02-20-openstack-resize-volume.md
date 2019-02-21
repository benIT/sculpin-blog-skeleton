---
title: Openstack: resize volume and partition size on a running instance
categories:
    - linux
    - openstack
---

## Context
This post deals with how to increase a volume attached to a server instance on openstack. [See openstack volume ressource](https://docs.openstack.org/cinder/rocky/cli/cli-manage-volumes.html#).

## Test database

To test everything goes well, a test database is setup:

	sudo -u postgres
	sudo -u postgres psql -c "create database webapp";
	sudo -u postgres psql -d webapp -c "CREATE TABLE account(user_id serial PRIMARY KEY,username VARCHAR (50) UNIQUE NOT NULL,created_on TIMESTAMP NOT NULL);" ;
	sudo -u postgres psql -d webapp -c "INSERT INTO account (username,created_on ) VALUES ('foo','2019-01-01') ;" ;
	sudo -u postgres psql -d webapp -c "INSERT INTO account (username,created_on ) VALUES ('bar','2019-01-02') ;" ;

Check command:
	
	sudo -u postgres psql -d webapp -c "SELECT * FROM account" ;

returns:

     user_id | username |     created_on      
    ---------+----------+---------------------
           1 | foo      | 2019-01-01 00:00:00
           2 | bar      | 2019-01-02 00:00:00
    (2 rows)

## Switch off automatic volume mount in `/etc/fstab `

    ssh demo

Comment lines in `/etc/fstab` that concern the volume you want to increase: 

    sudo vim /etc/fstab 

    #/dev/vdb1 /data ext4 defaults 0 0
    #/data/pgsql /var/lib/postgresql none bind 0 0

    sudo reboot

##Check 

    ssh demo

Check that they are no more mount point that depend on the volume we are going to manipulate.
    
    df -h
    Filesystem      Size  Used Avail Use% Mounted on
    udev            992M     0  992M   0% /dev
    tmpfs           201M  4,5M  197M   3% /run
    /dev/vda1       4,9G  1,9G  2,9G  40% /
    tmpfs          1003M  8,0K 1003M   1% /dev/shm
    tmpfs           5,0M     0  5,0M   0% /run/lock
    tmpfs          1003M     0 1003M   0% /sys/fs/cgroup
    
## Stop your applications if needed

	sudo service apache2 stop
	sudo service postgresql stop

## Increase our volume size

identify your target server and target volume with `openstack volume list` and `openstack server list`

    TARGET_SERVER=ed864066-ed73-46e0-b551-5bfca9873af6
    TARGET_VOLUME=1be3646a-3bb5-40fc-b9eb-6ab803b60d2c
    VOLUME_SIZE=25

## Detach volume from server
   
    openstack server remove volume $TARGET_SERVER $TARGET_VOLUME
    
*At this point, the device should NOT be visible when you execute: `ls -l /dev/vd*`*.    

## Increase volume size
   
    openstack volume set $TARGET_VOLUME --size $VOLUME_SIZE

## Attach volume to server

    openstack server add volume $TARGET_SERVER $TARGET_VOLUME --device /dev/vdb

*At this point, the device should BE visible when you execute: `ls -l /dev/vd*`*.    

## Manage partition on your openstack server

Let's configure the partition to use all the volume space.

	ssh demo
	sudo parted /dev/vdb resizepart 1 100%
	sudo e2fsck -f /dev/vdb1
	sudo resize2fs /dev/vdb1

## Restore `/etc/fstab`

uncomment the lines:

    /dev/vdb1 /data ext4 defaults 0 0
    /data/pgsql /var/lib/postgresql none bind 0 0

reboot: `sudo reboot`
	
## Check your fs

### Check volume size and partition size

	sudo fdisk -l
	
	Disk /dev/vdb: 25 GiB, 26843545600 bytes, 52428800 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x0e1b27a4
    
    Device     Boot Start      End  Sectors Size Id Type
    /dev/vdb1        2048 52428799 52426752  25G 83 Linux


### Check database

Use our test command to check our database:
    
    ssh demo
	sudo -u postgres psql -d webapp -c "SELECT * FROM account" ;

check data are ok:

     user_id | username |     created_on      
    ---------+----------+---------------------
           1 | foo      | 2019-01-01 00:00:00
           2 | bar      | 2019-01-02 00:00:00
    (2 rows)
---
title: Install a nextcloud box with NextCloudPi
categories:
    - system
    - linux
tags:
    - debian
    - raspberry

---
Here is exposed steps to setup a nextcloud box on RPI [consuming the nextCloudPi image](https://ownyourbits.com/2017/02/13/nextcloud-ready-raspberry-pi-image/) . enjoy ;)
 
##Nextcloudbox setup

- [burn a usb drive](/blog/2017/06/12/create-a-debian-iso-live-usb-drive). [NextCloudPi](https://ownyourbits.com/2017/02/13/nextcloud-ready-raspberry-pi-image/) offers a fully configured box.

- insert sd card and boot. Default credentials are: `pi`/`raspberry`

- [change keyboard layout](https://raspberrypi.stackexchange.com/questions/10060/raspbian-keyboard-layout) if needed before getting crazy:
    
    - edit the `XKBLAYOUT="fr"` directive in `/etc/default/keyboard`:
    
    
    - reboot: `sudo reboot now`
    
- enable usb device automount:
    
        sudo nextcloudpi-config
        
    then: `nc-automount` > `active=yes`
        
Wait a few seconds and check your drive is mounted using:
        
        sudo fdisk -l
        

##Test it!

###Locally
- In order to test it you can [take a look about connecting to pi over ethernet](/blog/2017/06/15/connect-to-raspberry-over-ethernet). *That's pretty nice to connect to RPI with a simple ethernet cable.*

###Behind a router/internet connection

- Plug RPI to your router

- Go to the admin panel

- Perform port redirection to the RPI: external 443/internal 443.

###It works, yeah! beer time!
Enter the RPI @IP in your web browser (`https://10.42.0.100` in my case), after adding a security exception because of self signed certificate, you should see:

![screenshot](/images/nextcloud/nextcloud-login.png)

*credentials: admin/ownyourbits*


##External storage setup
- format your usb-drive as `ext4` and create a `msdos` partition table if necessary using gparted. The partition must be a linux partition kind to support linux right management. 

- change nc-database to the flashdrive: `sudo nextcloudpi-config` > `nc-database`

- change nc-datadir to the flashdrive using: `sudo nextcloudpi-config` > `nc-datadir` 
        
If everything goes well, you should see that data and database are stored in `/media/USBdrive/ncdata` and `/media/USBdrive/ncdatabase`
        
##Enable and set up WIFI 
You can enable and select your WIFI connection in:
        `sudo nextcloudpi-config` > `nc-wifi` > `ACTIVE=YES`  

##Enable SSH
 
SSH is not enabled by default, enable it in: `sudo raspi-config` > `5 Interfacing Options` > `P2 SSH`
You can now ssh the rpi machine:
  
        ssh pi@10.42.0.100
        
Default rpi credentials are *pi/raspberry*, CHANGE IT by running: `passwd`
        
##Troubleshooting

###Trusted domains issue

Fix it in editing `nexcloud/config/config.php`: 
        
        ...
        'trusted_domains' =>
        array(
            ...
            3 => '10.42.0.100'
        )
        ...

![screenshot](/images/nextcloud/nextcloud-trusted-domains.png)

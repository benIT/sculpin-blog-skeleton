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
    
    - edit /etc/default/keyboard:
    
            sudo vi /etc/default/keyboard
    
    - set as follow:

            XKBLAYOUT="fr"
        
    - reboot:
        
            sudo reboot now
    
- enable usb device automount:
    
        sudo nextcloudpi-config
        
    then:
        
        nc-automount
        
    then:
        
        active=yes
        
Wait a few seconds and check your drive is mounted using:
        
        sudo fdisk -l
        


##Test it!

###Localy
- In order to test it you can [take a look about connecting to pi over ethernet](/blog/2017/06/15/connect-to-raspberry-over-ethernet). *That's pretty nice to connect to RPI with a simple ethernet cable.*

###Behind a router/internet connection

- Plug RPI to your router

- Go to the admin panel

- Perform port redirection to the RPI: external 443/internal 443.

###It works, yeah! beer time!
Enter the RPI @IP in your web browser (`https://169.254.6.100` in my case), after adding a security exception because of self signed certificate, you should see:

![screenshot](/images/nextcloudLogin.png)

*credentials: admin/ownyourbits*


##External storage setup
- format your usb-drive as `ext4` and create a `msdos` partition table if necessary using gparted. The partition must be a linux partition kind to support linux right management. 

- change nc-database to the flashdrive:
    
        sudo nextcloudpi-config
    
    then:
     
        nc-database

- change nc-datadir to the flashdrive using:

        sudo nextcloudpi-config
    
    then: 
    
        nc-datadir
        
If everything goes well, you should see that data and database are stored in: 
        
        /media/USBdrive/ncdata
        /media/USBdrive/ncdatabase
---
title: Installing nextcloud on RPI device
categories:
    - RPI
tags:
    - privacy
    - security

---
##Install Raspbian

###Install OS
- [download Raspbian](https://www.raspberrypi.org/downloads/raspbian/)
- [burn it to the RPI SD card](/blog/2017/06/12/create-a-debian-iso-live-usb-drive)

###Basic configuration
- enable SSH: `sudo raspi-config` > `Interfacing Options` > `SSH`
- change default password

##Install Nextcloud

###Nextcloud Stack

The following script will install the full stack. Run it as follow:

        chmod +x nextcloud.sh
        ./nextcloud.sh

Provisioning script from github:
        
<script src="https://gist.github.com/benIT/2828f3ffcf0cca7953489e2d35d1d010.js"></script>

###Tuning

Check settings here `https://nextcloud.local/index.php/settings/admin/`:

####Enable PHP7.0 opcache
Add this in `/etc/php/7.0/apache2/php.ini`: 

        opcache.enable=1
        opcache.enable_cli=1
        opcache.interned_strings_buffer=8
        opcache.max_accelerated_files=10000
        opcache.memory_consumption=128
        opcache.save_comments=1
        opcache.revalidate_freq=1

####PHP7.0 apcu
    
        sudo apt-get install php7.0-apcu -y

Check this file exists:
        
        cat  /etc/php/7.0/mods-available/apcu.ini


Finally, add this in `nextcloud/config/config.php`:

        'memcache.local' => '\OC\Memcache\APCu',


## USB drive

In this case, I have an usb external hard drive. I need to [fix it mount point](https://kwilson.io/blog/force-your-raspberry-pi-to-mount-an-external-usb-drive-every-time-it-starts-up/) to be always the location in order to configure it in Nextcloud.

Edit  `/etc/fstab`: 
    
    /DEV/SDA1       /MEDIA/WESTERN-DIGITAL-1-TO     EXT4    DEFAULTS        0       0
    sudo chown -R root:www-data /media/western-digital-1-to/
    chmod g+rwx /media/western-digital-1-to/

##Nextcloud trusted domains

Edit `trusted_domains` settings in `/var/www/nextcloud/config` if needed

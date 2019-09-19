---
title: Run multiple php versions on the same server with PHP-FPM and apache2
categories:
    - php
    - apache2
tags:

---
## Purpose

The aim of this post is to run several php versions on the same server.

This installation has been performed on debian 9 stretch.

This post has been mainly inspired [from this source](https://tecadmin.net/install-multiple-php-version-apache-ubuntu/)

## About `php-fpm`

PHP-FPM (FastCGI Process Manager) allows communication between a webserver and a PHP process based on FastCGI protocol.

In this post, PHP-FPM listen to a socket file to communicate with apache.


## Add `sury` repo to get both `php-5.6` and `php7.x` packages

Since debian strech did not have php5 packages, we have to add an extra repo to our apt sources.list to get those packages ([source here](https://stackoverflow.com/questions/46378017/install-php5-6-in-debian-9)):

    apt-get install apt-transport-https lsb-release ca-certificates
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg --no-check-certificate
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
    apt-get update
    
## About the apache2 library that communicates with php fpm process     
    
These libs are not required anymore: `libapache2-mod-fastcgi`, `libapache2-mod-fcgid` since there are now `proxy_fcgi` and `proxy` apache modules.
    
### Apache2 modules  
    
    a2enmod actions alias proxy_fcgi

## Install php fpm module for php 5.6    

    apt-get install php5.6-fpm
    
Checkout in `/etc/php/5.6/fpm/pool.d/www.conf` the directive that contains the socket path where php-fpm is listening: 
    
    listen = /run/php/php5.6-fpm.sock

## Install php fpm module for php 7.1
     
    apt-get install php7.1-fpm

Checkout in `/etc/php/7.1/fpm/pool.d/www.conf` the directive that contains the socket path where php-fpm is listening: 
    
    listen = /run/php/php7.1-fpm.sock
        
## Test    

### Create test apps

    mkdir -p /var/www/html/php5.6 /var/www/html/php7.1
    echo "<?php phpinfo(); ?>" > /var/www/php56/index.php
    echo "<?php phpinfo(); ?>" > /var/www/php71/index.php
    
### Virtual hosts

    a2dissite 000-default.conf    

### Edit local DNS file

Edit `/etc/hosts`:

    10.11.12.13 php56.test
    10.11.12.13 php71.test
    
#### PHP 5.6 virtual host

    cp 000-default.conf php56.conf 
    a2ensite php56.conf
    
Edit `/etc/apache2/sites-available/php56.conf`:

    <VirtualHost *:80>
        ServerName php56.test
        DocumentRoot /var/www/php56
        <Directory /var/www/php56>
            Options -Indexes +FollowSymLinks +MultiViews
            AllowOverride All
            Require all granted
        </Directory>
        <FilesMatch \.php$>
            # Apache 2.4.10+ can proxy to unix socket
            SetHandler "proxy:unix:/var/run/php/php5.6-fpm.sock|fcgi://localhost/"
        </FilesMatch>
        ErrorLog ${APACHE_LOG_DIR}/php56-error.log
        CustomLog ${APACHE_LOG_DIR}/php56-access.log combined
    </VirtualHost>
    
Reload :

    systemctl reload apache2    
    
    
Check with your browser:

![screenshot](/images/multiple-php-versions/56.png)
    

#### PHP 7.1 virtual host    

    cp 000-default.conf php71.conf
    a2ensite php71.conf
    
Edit `/etc/apache2/sites-available/php71.conf`:

    <VirtualHost *:80>
        ServerName php56.test
        DocumentRoot /var/www/php56
        <Directory /var/www/php56>
            Options -Indexes +FollowSymLinks +MultiViews
            AllowOverride All
            Require all granted
        </Directory>
        <FilesMatch \.php$>
            # Apache 2.4.10+ can proxy to unix socket
            SetHandler "proxy:unix:/var/run/php/php7.1-fpm.sock|fcgi://localhost/"
        </FilesMatch>
        ErrorLog ${APACHE_LOG_DIR}/php71-error.log
        CustomLog ${APACHE_LOG_DIR}/php71-access.log combined
    </VirtualHost>    
    
Reload :

    systemctl reload apache2    
    
    
Check with your browser:

![screenshot](/images/multiple-php-versions/71.png)    

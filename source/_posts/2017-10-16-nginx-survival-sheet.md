---
draft: true
title: Apache2 survival sheet
categories:
    - nginx
tags:

---

In this post, the most common Nginx commands that I use are listed. This is not really interesting but I'm bored of asking google for it every week!

[source](https://www.geek17.com/fr/content/debian-9-stretch-installer-et-configurer-la-derniere-version-de-nginx-et-php-7-fpm-63)

    sudo apt-get install -y nginx
    
    sudo apt-get install -y php7.0-fpm php7.0-gd php7.0-mysql php7.0-cli php7.0-common php7.0-curl php7.0-opcache php7.0-json php7.0-imap php7.0-mbstring php7.0-xml php7-pgsql php7.0-sqlite
    
    sudo apt-get install -y postgresql

    
## Vagrant tips for dev env

In the following files change `www-data` to `vagrant`:
* /etc/php/7.0/fpm/php-fpm.conf
* /etc/php/7.0/fpm/pool.d/www.conf

## Restart services

    sudo service nginx restart && sudo service php7.0-fpm restart
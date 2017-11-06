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
    
    sudo apt-get install -y php7.0-fpm php7.0-gd php7.0-mysql php7.0-cli php7.0-common php7.0-curl php7.0-opcache php7.0-json php7.0-imap php7.0-mbstring php7.0-xml php7-pgsql
    
    sudo apt-get install -y postgresql

    
    ###############################################################
    #nodeJS
    ###############################################################
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo npm install gulp jshint gulp-jshint bower grunt -g
    ###############################################################

    sudo apt-get install postgresql -y

cache + history + ssh
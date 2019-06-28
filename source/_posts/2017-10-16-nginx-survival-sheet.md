---
title: Nginx survival sheet
categories:
    - nginx
    - survival sheet
tags:
    
---

In this post, the most common Nginx commands that I use are listed. This is not really interesting but I'm bored of asking google for it every week!

[source](https://www.geek17.com/fr/content/debian-9-stretch-installer-et-configurer-la-derniere-version-de-nginx-et-php-7-fpm-63)

    sudo apt-get install -y nginx
    
    sudo apt-get install -y php7.0-fpm
    
    sudo apt-get install -y php7.0-gd php7.0-mysql php7.0-cli php7.0-common php7.0-curl php7.0-opcache php7.0-json php7.0-imap php7.0-mbstring php7.0-xml php7-pgsql php7.0-sqlite
    

    
## Vagrant tips for dev env

In the following files change `www-data` to `vagrant`:

* /etc/php/7.0/fpm/php-fpm.conf
* /etc/php/7.0/fpm/pool.d/www.conf

## Restart services

    sudo service nginx restart && sudo service php7.0-fpm restart
    
    
## Vhost    

### Create a vhost file 

In ` /etc/nginx/sites-available/default` file:

    server {
        listen 80;
        listen [::]:80;
        server_name www.massonweb.fr;
        # enforce https
        return 301 https://$server_name$request_uri;
    }
    
    server {
        listen 443 ssl http2;
        listen [::]:443 ssl http2;
        server_name massonweb.fr;
    
        ssl_certificate /etc/letsencrypt/live/massonweb.fr/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/massonweb.fr/privkey.pem;
     
        root /var/www/html;
     
        index index.php index.html;
     
        access_log /var/log/nginx/default-access_log;
        error_log /var/log/nginx/default-error_log;
     
        location / {
            try_files $uri $uri/ /index.php?$args;
        }
     
        location ~ \.php$ {
            try_files $uri =404;
            fastcgi_index index.php;
            fastcgi_pass unix:/run/php/php7.0-fpm.sock;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include /etc/nginx/fastcgi_params;
        }
    }

### Enable  vhost

    sudo ln -s /etc/nginx/sites-available/default  /etc/nginx/sites-enabled/default    
    sudo service nginx restart
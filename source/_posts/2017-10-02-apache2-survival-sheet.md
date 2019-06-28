---
title: Apache2 survival sheet
categories:
    - apache2
    - survival sheet
tags:

---

In this post, the most common Apache2 commands that I use are listed. This is not really interesting but I'm bored of asking google for it every week!


## Virtual host

##Enable a vhost

    a2ensite video-app
    
##Disable  a vhost

    a2dissite video-app
        
## Modules

### List enables/loaded modules

    apache2ctl -M

### Enable a module 

    sudo a2enmod rewrite
    
## Server status
    apache2ctl status
 
 
## Securing a vhost with a basic authentication

install utils:

    apt-get install apache2 apache2-utils
    
Generate password for user ben:

    htpasswd -c /etc/apache2/.htpasswd ben
    
    cat /etc/apache2/.htpasswd
     
output:
     
     ben:$apr1$ULdWsbYp$eawlgBJZvKhr7L8V1NWGD/

Secure your vhost:

        LISTEN 10000 
        <VirtualHost *:10000> 
                ServerAdmin webmaster@localhost
                DocumentRoot /home/pi/projects/videoapp/web/
                 <Directory /home/pi/projects/videoapp>
                        Options Indexes FollowSymLinks
                        AllowOverride All
                        AuthType Basic
                        AuthName "Restricted Content"
                        AuthUserFile /etc/apache2/.htpasswd
                        Require valid-user
                </Directory>
                ErrorLog /error-videoapp.log
                CustomLog /access-videoapp.log combined
        </VirtualHost>

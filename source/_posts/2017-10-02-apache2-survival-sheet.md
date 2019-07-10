---
title: Apache2 survival sheet
categories:
    - apache2
    - survival sheet
tags:

---

## Virtual hosts

Virtual hosts allow to run several sites on the same server. 

### Several sites on the same machine

Make use of the `ServerName` directive to match the right site.

In `/etc/apache2/sites-enabled/foo.conf`:

        <VirtualHost *:80> 
                ServerName foo.local
                ServerAdmin webmaster@localhost
                DocumentRoot /home/pi/projects/foo/
                ErrorLog /foo.log
                CustomLog /access-foo.log combined
        </VirtualHost>


In `/etc/apache2/sites-enabled/bar.conf`:

        <VirtualHost *:80> 
                ServerName bar.local
                ServerAdmin webmaster@localhost
                DocumentRoot /home/pi/projects/bar/
                ErrorLog /bar.log
                CustomLog /access-bar.log combined
        </VirtualHost> 
        
When an http request corresponding to the `ServerName` value is received, the right answer is served according to the vhost.conf.       
### Enable a vhost

    a2ensite video-app
    
### Disable  a vhost

    a2dissite video-app
        
## Modules

### List enables/loaded modules

    apache2ctl -M

### Enable a module 

    sudo a2enmod rewrite
    
## Server status

    apache2ctl status
 
## Security
 
###  Hide server version

In `/etc/apache2/conf-available/security.conf`:

    ServerTokens Prod
    ServerSignature Off

### Prevent site encapsulation in an external iframe

In `/etc/apache2/conf-available/security.conf`:
    
    Leader set X-Frame-Options: "sameorigin" 
 
### Secure a vhost with a basic authentication

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
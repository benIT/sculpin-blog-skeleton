---
title: Setting up a cool php development environment
categories:
    - php
tags:
    - development
    

---
In this post, I list the components of my dev environment. This list can be useful when initializing a new project or starting a new job.

##Make use of a cool virtualisation solution

I choose [Vagrant](https://www.vagrantup.com/). Take the time to create cool provisioning scripts. In case of problem, you will be able to set up quickly your env!
**VERSION your provisioning scripts!**

##Reproduce the exact same stack than the prod env 

 - OS
 - php version
 - php.ini conf: /etc/php5/apache2/php.ini & /etc/php5/cli/php.ini
 - apache version
 - apache VHOST
 - db version
 - system permission
 
**Keep one VM/project do not host several projects under the same VM. If you need a laboratory VM, create a dedicated one!**

##Turn on debug mode and error printing

Edit in php.ini files:

        error_reporting = E_ALL ^ E_NOTICE ^ E_WARNING
        display_errors = on        
                
 Restart apache:
                
        sudo service apache2 restart
            
##Make use of a cool source control 

I use gitlab: git+wiki+tracker. When you commit, do not forget to make link between commit and ticket reference.

##Make use of a cool PHP IDE

I use [PHPSTORM](https://www.jetbrains.com/phpstorm/) because of:

 - debugger integration
 - completion
 - external tools integration
 - framework integration
 - database integration
 - live templates
 - source control integration

##Set up a cool debugger

I use XDEBUG embed in vagrant VM with PHPSTORM on host machine which is very very very nice.

 - [ressource to set up vagrant with phpstorm](https://confluence.jetbrains.com/display/PhpStorm/Working+with+Advanced+Vagrant+features+in+PhpStorm)
 
 - [bookmarle generator](https://www.jetbrains.com/phpstorm/marklets/)

On the guest machine :

        sudo apt-get install -y php-pear php5-dev
        sudo pecl install xdebug

php.ini file: 

        [xdebug]
        zend_extension=/usr/lib/php5/20131226/xdebug.so
        xdebug.remote_enable=1
        xdebug.remote_host=10.0.2.2
        xdebug.remote_port=9000


##Set up a mailer

Setting up `sendMail` is quiet complicated whereas setting up `ssmtp` is easy. 

[Follow that tutorial to install ssmtp.](http://www.tuto-linux.com/tutoriel/ssmtp-installation-et-configuration/)


Do not forget to [edit google lesssecureappsoption](https://myaccount.google.com/lesssecureapps?pli=1)


##Set up a cool build tool

I use [Phing](https://www.phing.info/) to build and deploy.
    
    wget -q http://www.phing.info/get/phing-latest.phar
    sudo mv phing-latest.phar /usr/local/lib/phing.phar
    chmod +x /usr/local/lib/phing.phar
    sudo ln -s /usr/local/lib/phing.phar /usr/local/bin/phing
    

## Things that must be under source control

- Provisioning script
- Source code
- Build job
- *VM configuration (alias, conf file) can also be versioned.*  
 
**With that you should be able to automate deployment and rebuild solution from scratch!**
---
title: Configure xdebug with phpstorm with a vagrant box
categories:
    - dev
    - phpstorm
    - xdebug
tags:

---

After loosing a few hours reconfiguring xdebug, phpstorm and vagrant, I found this [great ressource](https://www.theodo.fr/blog/2016/08/configure-xdebug-phpstorm-vagrant/). Here are my notes about it:

*phpstorm is installed on the hostmachine and the app is running in a vagrant box.*

##Vagrant guest machine setup
    
    sudo apt-get install php5-xdebug
    
Edit `/etc/php5/mods-available/xdebug.ini` :
            
    xdebug.remote_enable=true
    xdebug.remote_connect_back=true
    xdebug.idekey=MY_AWESOME_KEY

##Phpstorm setup

###Setup 'php remote debug' configuration

![screenshot](/images/xdebug/storm-xdebug-vagrant-1-remote-debug-conf.png)

###Setup 'server' configuration

![screenshot](/images/xdebug/storm-xdebug-vagrant-2-server-conf.png)

##Browser plugin

- install a browser [plugin such as this one](https://addons.mozilla.org/en-US/firefox/addon/the-easiest-xdebug/)
- configure the ide key, here: `MY_AWESOME_KEY`
- it is also possible to use [bookmarklets](https://www.jetbrains.com/phpstorm/marklets/) 

##Enjoy!

- Puts breakpoints 
- Enable cookie using web browser extension or bookmarklet
![screenshot](/images/xdebug/storm-xdebug-vagrant-3-breakpoints.png)
- Click on the bug icon called 'debug mode'
- You can now enjoy the debugger (inspect variables, control the execution flow)
![screenshot](/images/xdebug/storm-xdebug-vagrant-4-debugger-running.png)
 
---
title: rpi dev 6 - System logs
categories:
    - linux
    - security
    - rpi
tags:

---
## interesting logs

* /var/log/auth.log
* /var/log/ufw.log
* /var/log/apache2/*access.log
* /var/log/apache2/*error.log

## tools

### lnav - ncurses-based log file viewer

From man: The  log  file navigator, lnav, is an enhanced log file viewer that takes advantage of any semantic information that can be gleaned from the files being viewed, such as timestamps and log levels

    apt install -y lnav

    lnav /var/log/auth.log /var/log/ufw.log /var/log/apache2/*access.log


### ezservermonitor

Install webapp: 

    wget https://www.ezservermonitor.com/esm-web/downloads/version/2.5 -O ezservermonitor.zip
    
Configure in `conf/esm.config.json`

    
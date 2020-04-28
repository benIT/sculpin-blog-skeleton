---
title: rpi dev 4 - UFW
categories:
    - linux
    - security
    - rpi
tags:

---
## enable/disable

    ufw logging on
    ufw disable
    ufw enable

## log file

    tail -f /var/log/ufw.log

## Print FW rules

    ufw status verbose
    ufw status numbered

## Common rules

### Block all INcoming & outgoing trafic

    ufw default deny incoming
    ufw default deny outgoing

### Allow common services

    ufw allow out 53 comment 'DNS'
    ufw allow out 465 comment 'SMTP'
    ufw allow ntp

### Allow all INcomming requests on all ports from an @IP range

    ufw allow from 192.168.1.0/24

### Allow all INcomming requests on all ports from an @IP

    ufw allow from XXX.XXX.XXX.XXX

### Allow INcomming requests on specific port from an @IP

    ufw allow from XXX.XXX.XXX.XXX to any port 80
    ufw allow from XXX.XXX.XXX.XXX to any port 3000

### For apt and software installation

use that to allow apt, for instance `apt install -y lnav`: 

    ufw allow out 80/tcp comment 'allow OUT 80 temporary for apt' && ufw allow out 443/tcp comment 'allow OUT 443 temporary for apt'

remove:

    ufw delete allow out 80/tcp && ufw delete allow out 443/tcp
    
OR: 

    ufw default allow outgoing
    
remove:

    ufw default deny outgoing
         
## Reset all rules

    ufw reset
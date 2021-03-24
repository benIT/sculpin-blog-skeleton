---
title: Fix static @IP on RPI
categories:
    - rpi
    - linux
tags:
---

## GET DNS servers @IPs

    cat /etc/resolv.conf 

=>

    nameserver 89.2.0.1
    nameserver 89.2.0.2

## Set up fix @IP

In `/etc/dhcpcd.conf`, add the following lines:
    

    interface eth0
    static ip_address=192.168.0.13
    static routers=192.168.0.1
    static domain_name_servers=89.2.0.1 89.2.0.2
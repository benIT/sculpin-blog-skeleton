---
title: rpi dev 1 - Setup a development server with a RPI 3
categories:
    - linux
    - rpi
    - dev
tags:

---

## Summary 

* install [Raspbian Buster Lite](https://www.raspberrypi.org/downloads/raspbian/): `dd if=2020-02-13-raspbian-buster-lite.img of=/dev/mmcblk0`
* setup minimal configuration: from `raspi-config`, set `locale`, `keyboard layout`, `timezone`, `wifi-country` 
* update it : `apt update && apt upgrade`
* [secure your RPI](https://www.raspberrypi.org/documentation/configuration/security.md): create admin user, remove default pi user, setup ssh
* fix your RPI private @IP: in my case, I do this in the admin section of my router
* buy a domain name from a registrar
* edit your DNS zone from your registrar to add `A record` that will link your domain name and your router public @IP
* edit your router DMZ section to redirect incoming traffic to your device, here the RPI. You can make use of NAT rules too and port redirections
* [install a GITHUB like app, gitea](/blog/2020/04/01/rpi-dev-gitea) 
* [get SSL certificates from let's encrypt](/blog/2020/04/01/rpi-dev-lets-encrypt-certificates)
* [secure it with firewall rules](/blog/2020/04/01/rpi-dev-ufw)
* [setup smtp](/blog/2020/04/01/rpi-dev-ssmtp)
* [check logs](/blog/2020/04/01/rpi-dev-system-logs)
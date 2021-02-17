---
title: wireshark basics
categories:
    - hacking
    - linux
tags:
---


## install 

    sudo apt install wireshark -y

answer yes to allow wireshark execution question for non super user.

    sudo usermod -aG wireshark $(whoami)

logout and login

## Add src & destination port columns

right clock "column preferences" and add "source port" & "destination port"

## sniff post request on a uri pattern

    http.request.method == "POST" && http.request.uri contains login 

## Scan LAN

Let's use nmap to san lan and choose the @IP machine to listen. Here it's a RPI.

    sudo nmap -sT -O 192.168.1.0/24

=>

    Starting Nmap 7.60 ( https://nmap.org ) at 2021-02-17 10:09 CET
    Nmap scan report for XYZ-eth0 (192.168.1.68)
    Host is up (0.0030s latency).
    Not shown: 994 closed ports
    PORT     STATE SERVICE
    21/tcp   open  ftp
    22/tcp   open  ssh
    80/tcp   open  http
    443/tcp  open  https
    3000/tcp open  ppp
    5432/tcp open  postgresql
    MAC Address: B8:27:EB:39:1D:77 (Raspberry Pi Foundation)


## Wireshark over ssh via sshdump

### Install tools on the remote server

    apt install -y tcpdump

#### Allow tcpdump execution for non superuser

    sudo groupadd pcap
    sudo usermod -a -G pcap $USER
    sudo chgrp pcap /usr/sbin/tcpdump
    sudo chmod 750 /usr/sbin/tcpdump
    sudo setcap cap_net_raw,cap_net_admin=eip /usr/sbin/tcpdump


logout & login

check this command is running without error:

    tcpdump -A port '(80 or 443)'

When this part is ok, we can now use wireshark to use tcp dump over ssh. This can be checked with an ssh command:

    ssh XXX@192.168.1.68 "sudo tcpdump"

## Configure wireshark to listen over ssh


From the main menu, select ssh remote capture: sshdump

Fill in the windows 

We can now capture packets.

## Wireshark filters

    http
    ip.dst == 192.168.1.68
    ip.src == 192.168.1.68
    http.request.method == "POST" 
    http.request.method == "POST" && http.request.uri contains login
    tcp.port==80
    tcp.port==443
---
title: Connect to raspberry pi from linux host using a simple ethernet cable
categories:
    - system
    - linux
tags:
    - debian
    - raspberry

---
This post describes how to connect a RPI to a linux station with a simple ethernet cable.
 
##On debian host machine

- run `gnome-nettool`, change the edit the wired connection and edit IPv4 settings.
    - Change the `DHCP` default method 
        ![network conf](/images/rpi/ethernet-connection/wired-dhcp.png)
        
        to `shared with other computer`:
        ![network conf](/images/rpi/ethernet-connection/wired-shared.png)
- power off the RPI

        sudo halt
    
- mount the RPI SD card to the host PC 

- identify the PC eth0 @IP adress:

        sudo ifconfig
        
In my case: `10.42.0.1`
        
- edit the `cmdline.txt` located on the `boot` partition file adding:
 
        ip=10.42.0.100

- *The pi and the debian PC must on the same subnetwork ie: `10.42.0.XXX`*

- insert SD card and boot RPI

- check the connectivity:

        ping 169.254.6.100
        --- 10.42.0.100 ping statistics ---
        6 packets transmitted, 6 received, 0% packet loss, time 4999ms
        rtt min/avg/max/mdev = 0.326/0.351/0.392/0.028 ms



##On the RPI machine

- enable ssh:
 
        sudo raspi-config 
    
- `Interfacing Options` then `P2 SSH`


##SSH IT !

From the debian pc:

    ssh pi@169.254.6.100
    
That was it! You are now connected over SSH on the RPI:    
    
    The authenticity of host '10.42.0.100 (10.42.0.100)' can't be established.
    ECDSA key fingerprint is ca:cc:0c:80:ab:1a:b4:a9:4b:2b:a8:1a:fa:b4:7e:23.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added '10.42.0.100' (ECDSA) to the list of known hosts.
    pi@10.42.0.100's password: 
    
 
    
    NextCloudPi v0.12.8 is up to date
    Last login: Fri May 26 18:34:10 2017
    
    SSH is enabled and the default password for the 'pi' user has not been changed.
    This is a security risk - please login as the 'pi' user and type 'passwd' to set a new password.
    pi@raspberrypi:~ $

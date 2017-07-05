---
title: First steps with Veracrypt
categories:
    - veracrypt
tags:
    - privacy
    - security

---
##Why Vercrypt?
It's :

- [secure](https://www.nextinpact.com/news/91703-veracrypt-comment-chiffrer-et-cacher-fichiers-disque-dur-externe-ou-clef-usb.htm) (based on truecrypt audit and security fix)
- [open source](https://github.com/veracrypt/VeraCrypt)
- [french](https://www.nextinpact.com/news/91703-veracrypt-comment-chiffrer-et-cacher-fichiers-disque-dur-externe-ou-clef-usb.htm)

##Download

- [download from official site](https://veracrypt.codeplex.com/wikipage?title=Downloads#Title)

##Create a container based on keyfile authentication

In this example, my container is called `animals` and has been created from Veracrypt GUI. 
This container has no password, it based on key system. The key has been generated from Veracrypt GUI.

- The container is called `animals`
- The key is called `animals-key`

##Add files to container

        cd veracrypt
        veracrypt animals --keyfiles=animals-key --password=''
        tar -cvzf animals.tgz /home/ben/Images/animals-wallpapers
        cp animals.tgz /media/veracrypt1/
        veracrypt -d

##Let's backup it on a friend RPI!
        
        rsync -avzh ben@XXX.XXX.XXX.XXX:/home/ben/veracrypt /home/ben/veracrypt        
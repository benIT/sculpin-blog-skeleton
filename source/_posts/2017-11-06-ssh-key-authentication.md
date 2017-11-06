---
title: SSH key authentication
categories:
    - ssh
tags:

---

Access your server using ssh key authentication.

If you loose your time, typing password, this is for you:

## Generate ssh authentication keys on the client side

    ssh-keygen -t rsa

## Create a .ssh folder on the server

    ssh pi@192.168.1.84 mkdir -p .ssh

## Grant the client to access to the server using public key

    cat .ssh/id_local.pub | ssh pi@192.168.1.84 'cat >> .ssh/authorized_keys'

## Connect to server without password

    ssh pi@192.168.1.84

That's it, you can now access your server whithout typing your password!
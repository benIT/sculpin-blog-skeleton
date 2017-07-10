---
title: Vagrant share ssh agent between host and guests
categories:
    - vagrant
tags:

---

##Why?

In this way you can share from your host multiple ssh keys without copy/paste its on each VM. All ssh key are centralised and that's better when working with a lot of VM. 

##How to?

###On the host side

In `~/.ssh/config`:
 
    #share ssh agentwith VM
    Host *
     ForwardAgent yes 


###On the guest side

In `Vagrantfile`:
    
    config.ssh.forward_agent = true
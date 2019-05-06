---
title: RIP a password protected archive with John the Ripper
categories:
    - hacking
    - kali
---
## Install KALI

First, [intall a kali headless VM with vagrant](https://www.kali.org/news/announcing-kali-for-vagrant/).

Grant large CPUs and RAM resources to the VM. For instance, in `Vagrantfile`:

    # Create a forwarded port
    config.vm.network "forwarded_port", guest: 80, host: 8080
    
    # Create a private network. In VirtualBox, this is a Host-Only network
    config.vm.network "private_network", ip: "192.168.33.101"
    
    # VirtualBox specific settings
    config.vm.provider "virtualbox" do |vb|
    # Hide the VirtualBox GUI when booting the machine
    vb.gui = false
    
    # Customize the amount of memory on the VM:
    vb.memory = "8192"
    vb.cpus= "5"
    end
    
    # Provision the machine with a shell script
    config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y crowbar
    SHELL
    end
 
## Generate a test archive

    echo "foo bar" > file.txt
    zip -P pass archive.zip file.txt

**Thus, our archive is protected with the password: `pass`**
  
Test password protection:
  
    unzip archive.zip 
    Archive:  archive.zip
    [archive.zip] file.txt password: 


## RIP archive.zip

### Get password hash with zip2john


    zip2john archive.zip > hash.txt
    
Prints :

    ver 1.0 efh 5455 efh 7875 archive.zip/file.txt PKZIP Encr: 2b chk, TS_chk, cmplen=20, decmplen=8, crc=13DDB427
    
### RIP hash

    john hash.txt
    
Prints:        

    Using default input encoding: UTF-8
    Loaded 1 password hash (PKZIP [32/64])
    Will run 2 OpenMP threads
    Proceeding with single, rules:Wordlist
    Press 'q' or Ctrl-C to abort, almost any other key for status
    Warning: Only 4 candidates buffered for the current salt, minimum 8
    needed for performance.
    Warning: Only 5 candidates buffered for the current salt, minimum 8
    needed for performance.
    Warning: Only 6 candidates buffered for the current salt, minimum 8
    needed for performance.
    Warning: Only 4 candidates buffered for the current salt, minimum 8
    needed for performance.
    Almost done: Processing the remaining buffered candidate passwords, if any
    Proceeding with wordlist:/usr/share/john/password.lst, rules:Wordlist
    pass             (archive.zip/file.txt)
    1g 0:00:00:00 DONE 2/3 (2019-05-06 09:53) 50.00g/s 2109Kp/s 2109Kc/s 2109KC/s 123456..Peter
    Use the "--show" option to display all of the cracked passwords reliably
    Session completed

### And archive password is...

    pass             (archive.zip/file.txt)

### Tips

If you run `john` again, you will get:

    john hash.txt
    Using default input encoding: UTF-8
    Loaded 1 password hash (PKZIP [32/64])
    No password hashes left to crack (see FAQ)

This means that the password has already been ripped, to print password check `.john/john.pot` file or use `--show` option:

    john hash.txt --show
    archive.zip/file.txt:pass:file.txt:archive.zip::archive.zip
    
    1 password hash cracked, 0 left
     
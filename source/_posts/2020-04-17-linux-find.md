---
title: linux basics: find & locate
categories:
    - linux
    - linux basics
tags:

---
## find 

### Usual commands

    find / -name "*.c"
    find / -maxdepth 4 -name "*.c"
    find / -size +1M
    find / -group ben
    find / -user ben
    
### File type
    
    find /etc/ -type d
    find /etc/ -type f

### Execute action on file

### without confirmation 
    
    find ~ -type d -exec ls -l {} \;    

* `{}` replace the argument of the command, here it means a file in `ls -l file`
* `\;`: escape the `;` => terminate the `ls -l {}` command

### with confirmation 

    find ~ -type d -ok -exec ls -l {} \; 
    
### operator

#### and `-a`

    find /etc/ \( -type d -a -group root \)

#### or `-o`     

    find ~ \( -name "*txt" -o -name "*.md" \)

#### negation `!`      

    find ~ ! -name "*.md"
    
## locate

* faster than find
* only works on file name
* use a db 


    locate README.md
    updatedb
### modern locate    
    mlocate README.md

### secure locate    
    slocate README.md

the locate command is a symlink to one of these programs:
    
    ls -l /usr/bin/locate
    lrwxrwxrwx 1 root root 24 avril 21 13:09 /usr/bin/locate -> /etc/alternatives/locate
    
    ls -l /etc/alternatives/locate
    lrwxrwxrwx 1 root root 16 avril 21 13:09 /etc/alternatives/locate -> /usr/bin/mlocate
---
title: linux basics: file permissions - advanced 2
categories:
    - linux
    - linux basics
tags:

---

##  SUID: Set-user Identification permission

usage:

    chmod u+s prg.sh
    chmod 4[rwx][rwx][rwx] prg.sh
    
Specfic to executable file. 

When a command or script with SUID bit set is run, its effective UID becomes that of the owner of the file, rather than of the user who is running it.

The setuid permission displayed as an “s” in the owner’s execute field.

[see this ressource](https://www.thegeekdiary.com/what-is-suid-sgid-and-sticky-bit/): 
When a command or script with SUID bit set is run, its effective UID becomes that of the owner of the file, rather than of the user who is running it.
    
    chmod u+s prg.sh
    chmod 4[rwx][rwx][rwx] prg.sh

create a file:

    root@raspbeeerry:/home/pi# touch prg.sh
    root@raspbeeerry:/home/pi# ls -l prg.sh 
    -rw-r--r-- 1 root root 0 Apr 16 15:06 prg.sh

add execution right for all:

    root@raspbeeerry:/home/pi# chmod a+x prg.sh 
    root@raspbeeerry:/home/pi# ls -l prg.sh 
    -rwxr-xr-x 1 root root 0 Apr 16 15:06 prg.sh

set SUID, note the lower 's' when X right: 

    root@raspbeeerry:/home/pi# chmod u+s prg.sh 
    root@raspbeeerry:/home/pi# ls -l prg.sh 
    -rwsr-xr-x 1 root root 0 Apr 16 15:06 prg.sh

remove execution right for all, note the upper 'S' when no X right:

    root@raspbeeerry:/home/pi# chmod a-x prg.sh 
    root@raspbeeerry:/home/pi# ls -l prg.sh 
    -rwSr--r-- 1 root root 0 Apr 16 15:06 prg.sh


## SGID: Set-group identification permission

usage:

    chmod g+s prg.sh
    chmod 2[rwx][rwx][rwx] prg.sh

[see this ressource](https://www.thegeekdiary.com/what-is-suid-sgid-and-sticky-bit/): 
When SGID permission is set on a directory, files created in the directory belong to the group of which the directory is a member.
– For example if a user having write permission in the directory creates a file there, that file is a member of the same group as the directory and not the user’s group.
– This is very useful in creating shared directories.
– The setgid permission displays as an “s” in the group’s execute field.

## Rights on folder

*r: allow to list
*w: allow to create/delete files
*x: allow to traverse

## Sticky bit permission

usage:

    chmod +t folder
    chmod 1[rwx][rwx][rwx] prg.sh

[see this ressource](https://www.thegeekdiary.com/what-is-suid-sgid-and-sticky-bit/): 
The sticky bit is primarily used on shared directories.
* without the sticky bit : user with Write permission on a folder can create/delete other users files
* with the sticky bit : user with Write permission on a folder are allowed to create new files but not to delete files



Example:

as root, create a folder with sticky bit: 

    root@raspbeeerry:/home/pi# mkdir test-folder
    root@raspbeeerry:/home/pi# chmod a+w test-folder/
    root@raspbeeerry:/home/pi# ls -ld test-folder/
    drwxrwxrwx 2 root root 4096 Apr 16 14:53 test-folder/
    root@raspbeeerry:/home/pi# touch test-folder/a
    root@raspbeeerry:/home/pi# ls -l permissions.txt ^C
    root@raspbeeerry:/home/pi# ^C
    root@raspbeeerry:/home/pi# chmod +t test-folder/


as another user, let's try to create/delete file inside the folder with the sticky bit: 

    pi@raspbeeerry ~ $ touch test-folder/b
    pi@raspbeeerry ~ $ ls -l test-folder/
    total 0
    -rw-r--r-- 1 root root 0 Apr 16 14:58 a
    -rw-r--r-- 1 pi   pi   0 Apr 16 14:59 b
    pi@raspbeeerry ~ $ rm test-folder/a
    rm: remove write-protected regular empty file 'test-folder/a'? 

as root, let's remove the sticky bit:

    root@raspbeeerry:/home/pi# chmod -t test-folder/

as another user, retry to delete file created by another user:

    pi@raspbeeerry ~ $ rm -f  test-folder/a
    @raspbeeerry ~ $ ls -l test-folder/
    total 0
    -rw-r--r-- 1 pi pi 0 Apr 16 14:59 b
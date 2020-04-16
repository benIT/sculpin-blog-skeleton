---
title: linux basics: files 
categories:
    - linux
    - linux basics
tags:

---

## file ownership

File ownership is managed by a user owner and a group owner.
See `ls -l` or `ls -n`

Examples: 
    
    chown user:group file #change owner and group
    chown user file # change only owner
    chown :group file #change only group, same as chgrp command

## Linux POSIX rights

POSIX is a standard.

## List rights

    ls -l

Type code:

* -: file
* d: folder
* l: symlink
* p: pipe. used to make 2 programs communicate
* s: socket. used to make 2 programs communicate + network management + bidirectional
* b: block device, ie write block by block
* c: character device, ie write char by char

9 bits: 3 User + 3 Group + 3 Other

## chmod


* u: for user
* g: for group
* o: for others
* a: for all

* +: add right
* -: remove right
* =: set right


* r: read. 2^2 => 4
* w: write.2^1 => 2
* x: execute.2^0 => 1

    
    chmod u+r,g-r file.txt
    chmod a=rwx file.txt
    chmod 740 file.txt


## Special rights

###  SUID: specfic to executable file. When runned by a user, will be runned with file owner rights

    chmod u+s prg.sh

create a file:

    root@raspbeeerry:/home/pi# touch prg.sh
    root@raspbeeerry:/home/pi# ls -l prg.sh 
    -rw-r--r-- 1 root root 0 Apr 16 15:06 prg.sh

add execution right for all, note the lower 's' when X right:

    root@raspbeeerry:/home/pi# chmod a+x prg.sh 
    root@raspbeeerry:/home/pi# ls -l prg.sh 
    -rwxr-xr-x 1 root root 0 Apr 16 15:06 prg.sh

set SUID: 

    root@raspbeeerry:/home/pi# chmod u+s prg.sh 
    root@raspbeeerry:/home/pi# ls -l prg.sh 
    -rwsr-xr-x 1 root root 0 Apr 16 15:06 prg.sh

remove execution right for all, note the upper 'S' when no X right:

    root@raspbeeerry:/home/pi# chmod a-x prg.sh 
    root@raspbeeerry:/home/pi# ls -l prg.sh 
    -rwSr--r-- 1 root root 0 Apr 16 15:06 prg.sh


### SGID: same for group

    chmod g+s prg.sh

### Rights on folder

*r: allow to list
*w: allow to create/delete files
*x: allow to traverse

### Sticky bit

* withouy the sticky bit : user can create/delete files
* with the sticky bit : user with Write permission on a folder are allowed to create new files but not to delete files


    chmod +t folder
    chmod -t folder


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



octal notation:

basic rights:

    rwx rwx rwx

special rights:

    sst rwx rwx rwx


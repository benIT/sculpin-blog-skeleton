---
title: linux basics: file permissions - umask - 4 
categories:
    - linux
    - linux basics
tags:

---
## print umask

    umask -S
    u=rwx,g=rwx,o=rx

    umask -p
    umask 0002

default rights when a file is created are:

* file: 0666
* folder : O777

**The calculated rights for new files are the default rights - the umask: 0666-0002=0664**

    touch umasktest
    ls -l umasktest 
    -rw-rw-r-- 1 ordinateur ordinateur 0 avril 21 14:30 umasktest

## modify umask

    umask 0022
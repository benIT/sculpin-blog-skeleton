---
title: linux basics: file permissions - POSIX rights - 1 
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

Type codes:

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


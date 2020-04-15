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


---
title: linux basics: get command help
categories:
    - linux
    - linux basics
tags:

---

## `whereis` command

search in several location `/usr/bin`... and returns exec file and related resources such as man, config.

    whereis sl
    sl: /usr/games/sl /usr/share/man/man6/sl.6.gz
    
    
## `which` command

only search in $PATH and only return path to exec:

    which sl
    /usr/games/sl

## `type` command

return how a command is interpreted:

    type -a echo
    echo is a shell builtin
    echo is /usr/bin/echo
    echo is /bin/echo


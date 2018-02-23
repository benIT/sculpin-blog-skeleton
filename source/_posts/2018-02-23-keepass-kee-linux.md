---
title: Install keepass and kee on inux
categories:
    - privacy

---

## install keepass2

    sudo apt-get install keepass2

## install firefox addon 'kee'

[download it here](https://addons.mozilla.org/fr/firefox/addon/keefox/?src=search)

## download KeePassRPC.plgx plugin

q
    sudo mkdir /usr/lib/keepass2/plugins
    sudo cp 'KeePassRPC.plgx' '/usr/lib/keepass2/plugins/'
    sudo apt-get install mono-complete

## Restart keepass and firefox

you should be prompt about kee to authorize keepass
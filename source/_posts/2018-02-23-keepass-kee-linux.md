---
title: Install keepass and kee on linux
categories:
    - privacy

---

## install keepass2

    sudo add-apt-repository ppa:jtaylor/keepass
    sudo apt-get update && sudo apt-get install keepass2

## install firefox addon 'kee'

- [download it here](https://addons.mozilla.org/fr/firefox/addon/keefox/?src=search)
- [kee doc here](https://github.com/kee-org/KeeFox/wiki/en-|-Getting-started#linux) with linux keepass requirement.

## download KeePassRPC.plgx plugin

[download KeePassRPC.plgx plugin](https://github.com/kee-org/keepassrpc/releases)

    sudo mkdir /usr/lib/keepass2/plugins
    sudo cp 'KeePassRPC.plgx' '/usr/lib/keepass2/plugins/'
    sudo apt-get install mono-complete

## Restart keepass and firefox

you should be prompt about kee to authorize keepass
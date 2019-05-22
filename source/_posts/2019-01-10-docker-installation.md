---
title: Install Docker on ubuntu 16.04
categories:
    - linux
    - docker

---

## Install Docker CE for Ubuntu

See [official documentation](https://docs.docker.com/install/linux/docker-ce/ubuntu/).


## Run docker as a non-root user

See [official documentation](https://docs.docker.com/install/linux/linux-postinstall/).

## Configure docker to be used behind a http proxy

Create the following file `/etc/systemd/system/docker.service.d/http-proxy.conf` and edit it:

    [Service]
    Environment=http_proxy=http://user:pass@ip:port
    Environment=https_proxy=http://user:pass@ip:port

## Test

    docker run hello-world
    
    
## Install docker-compose

See [official documentation](https://docs.docker.com/compose/install/).

currently, I use docker-compose `v1.23.2`

    sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version
    
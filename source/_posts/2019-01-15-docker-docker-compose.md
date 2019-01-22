---
title: Docker 101: docker-compose
categories:
    - linux
    - docker
---



# Docker compose

Purpose: compose is a tool designed to create multi-containers app.

## Install

    sudo apt install python-pip
    pip install docker-compose

## docker-compose.yml

The magic happens in a file named `docker-compose.yml`
    
## Run
    
    docker-compose up -d

## Stop
    
    docker-compose down -v
    
## Networking

`docker-compose` handles the creation a private network:

    Creating network "n-tiers_default" with the default driver
    Creating object-cache ... done
    Creating pgsql        ... done
    Creating web          ... done
     
# Example

Better than words, take a look at this [repo that illustrates a classical n-tiers web app](https://github.com/benIT/docker-compose-n-tiers)
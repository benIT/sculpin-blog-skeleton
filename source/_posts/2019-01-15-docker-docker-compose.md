---
title: Docker 101: docker-compose
categories:
    - linux
    - docker
draft: true
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
    
    
# Development
      
replace this section to get your changes from your host sync with your container : 
    
    image: benit/debian-web

by:

    build:
      context: .
      args:
        - http_proxy
        - https_proxy
        - no_proxy

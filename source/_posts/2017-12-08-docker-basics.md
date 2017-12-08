---
title: Docker basics
categories:
    - docker
tags:

---


## Containers

A container is a way to create isolated env that can run code while sharing a single OS.

### Run a container

    docker container run -p 9999:80 httpd:2.4


The `--detach` flag can be used to run the container in background:

    docker container run --detach -p 9999:80 httpd:2.4


### List containers

    docker container ls

### Run commands on container
 
    docker container exec my_container_name du -mh
    
### Attaching a Shell to a Container

To get a shell inside the container:

    docker container exec -it my_container_name /bin/bash
    
    PATH=$PATH:/usr/games/
    export PATH
    
    

## Dockerfiles

Dockerfile -> create an image -> to generate a container

Inside a file named `Dockerfile`.
### Dockerfile example

    FROM httpd:2.4
    EXPOSE 80
    RUN apt-get update && apt-get install -y fortunes
    COPY page.html /var/www/html/
    LABEL maintainer="moby-dock@example.com"


### Building an Image From a Dockerfile


    docker image build --tag web-server:1.0 .

End the command with a single . so it knows to look for the Dockerfile in the same folder that the command is run in.
    
    docker image ls


    docker container run -p 80:80 web-server:1.0
    
    
## Volumes

It is possible to copy files into a container but files will be lost when container stops. 

    docker container cp page.html my_container_name:/var/www/html/.

A better solution is to use volumes.
Data volumes expose files on your host machine to the container.

    
### Creating a Volume

    docker run -d -p 80:80 -v /my-files:/var/www/html web-server:1.1
    
Shared folder  between `/my-files` on host machine and the `html` folder in the container

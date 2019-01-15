---
title: Docker 101: networking
categories:
    - linux
    - docker

---

# Docker running containers inside a bridge network

The purpose of this post is to isolate each tiers of our app into different containers.

We will create a private network and run containers inside this private network.
        
[This article is largely inspired by this great resource.](https://docker-curriculum.com/#webapps-with-docker)    

## Networking

### Create an isolated private bridge network
    
    docker network create web-net    
    
### Inspect the private network

    docker network inspect web-net
    
### Run a container inside the private bridge network with `--net` option

    docker run --name pgsql-web --rm  -d --net web-net postgres:latest
    docker run --name debian-web --rm -p 80:80 --net web-net -d benit/debian-web:latest
    

### Inspect the private network to get IPs of containers of the private network
    
    docker network inspect web-net

gives:
    
     "Containers": {
                "3729ccbb14e514fd6c8b571ed9c985c28293cb5bfdb10c6c233773f50d6ba763": {
                    "Name": "debian-web",
                    "EndpointID": "c370cab93cdd2ac9f30f568a1709b8c998d2ca36106d5423b484a20aadbff84f",
                    "MacAddress": "02:42:ac:12:00:03",
                    "IPv4Address": "172.18.0.3/16",
                    "IPv6Address": ""
                },
                "61bcf5cd9838c8c2e66beef73a04a2704a3be7e2085a5c6b4ad58bd78f12a138": {
                    "Name": "pgsql-web",
                    "EndpointID": "128f50ead4974a725c04551cb284fec2c733a48375a4819096b0b623ff2af4ac",
                    "MacAddress": "02:42:ac:12:00:02",
                    "IPv4Address": "172.18.0.2/16",
                    "IPv6Address": ""
                }
            },

    
## Putting it all together 

  
### Let's create a database

    docker container exec pgsql-web psql -U postgres -c "create database webapp";
    docker container exec pgsql-web psql -U postgres -d webapp -c "CREATE TABLE account(user_id serial PRIMARY KEY,username VARCHAR (50) UNIQUE NOT NULL,created_on TIMESTAMP NOT NULL);" ;
    docker container exec pgsql-web psql -U postgres -d webapp -c "INSERT INTO account (username,created_on ) VALUES ('foo','2019-01-01') ;" ;
    docker container exec pgsql-web psql -U postgres -d webapp -c "INSERT INTO account (username,created_on ) VALUES ('bar','2019-01-02') ;" ;
    
    
### Connect database container from webserver container

    docker container exec -it debian-web  psql -U postgres -h 172.18.0.2 -d webapp -c "select * from account;" ;
    
gives:
    
     user_id | username |     created_on      
    ---------+----------+---------------------
           1 | foo      | 2019-01-01 00:00:00
           2 | bar      | 2019-01-02 00:00:00
    (2 rows)
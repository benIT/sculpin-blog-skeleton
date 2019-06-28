---
title: PostgreSQL survival sheet
categories:
    - database
    - pgsql
    - survival sheet
tags:

---

In this post, the most common pgsql commands that I use are listed. This is not really interesting but I'm bored of asking google for it every week!


## Start psql command line utility

Using the `postgres` superuser: 
    
    sudo -u postgres psql

## Exit

    postgres=# \q

    
## List databases

    postgres=# \l+
    
output:

                                                                        List of databases
        Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   |  Size   | Tablespace |                Description                 
    ------------+----------+----------+-------------+-------------+-----------------------+---------+------------+--------------------------------------------
     clipbucket | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |                       | 6532 kB | pg_default | 
     moodle     | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |                       | 6532 kB | pg_default | 
     postgres   | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |                       | 6532 kB | pg_default | default administrative connection database
     template0  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +| 6409 kB | pg_default | unmodifiable empty database
                |          |          |             |             | postgres=CTc/postgres |         |            | 
     template1  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +| 6532 kB | pg_default | default template for new databases
                |          |          |             |             | postgres=CTc/postgres |         |            | 
     testdb     | testdb   | UTF8     | en_US.UTF-8 | en_US.UTF-8 |                       | 6724 kB | pg_default | 
     videoapp   | videoapp | UTF8     | en_US.UTF-8 | en_US.UTF-8 |                       | 6724 kB | pg_default | 
    (7 rows)



## Drop database

    postgres=# DROP DATABASE testdeploy;

output:    
    
    postgres=# DROP DATABASE
    
## List users

    postgres=# \du+

output :

                                       List of roles
       Role name    |                   Attributes                   | Member of | Description 
    ----------------+------------------------------------------------+-----------+-------------
     clipbucket     |                                                | {}        | 
     manuel         | Create DB                                      | {}        | 
     moodle         |                                                | {}        | 
     postgres       | Superuser, Create role, Create DB, Replication | {}        | 
     testdb         | Create DB                                      | {}        | 
     testdeploy     | Create DB                                      | {}        | 
     testdeploytest | Create DB                                      | {}        | 
     videoapp       | Create DB                                      | {}        | 


## Drop user

    postgres=# DROP USER testdeploy;

output: 

    DROP ROLE

## Create user

    postgres=# CREATE USER videoapp WITH PASSWORD 'videoapp' CREATEDB ;

Note : This user has privilege to create a db.    
    
output: 
    
    CREATE ROLE


## List DB tables

### Switch database    

    postgres=# \c videoapp

output:

    You are now connected to database "videoapp" as user "postgres".

### List tables

    videoapp=# \dt+

output:

                             List of relations
     Schema |    Name     | Type  |  Owner   |    Size    | Description 
    --------+-------------+-------+----------+------------+-------------
     public | fos_user    | table | videoapp | 8192 bytes | 
     public | tag         | table | videoapp | 0 bytes    | 
     public | video       | table | videoapp | 8192 bytes | 
     public | videos_tags | table | videoapp | 0 bytes    | 
    (4 rows)

## Privileges

### Connect as `postgres` superuser

    PGPASSWORD="P@ss0rd" psql -U postgres -h 10.11.12.13 -p 5432

### Grant Privileges

    GRANT CONNECT ON DATABASE app_database TO app_user;
    \c app_database
    GRANT USAGE ON SCHEMA public TO app_user;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO app_user;
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app_user;

## Config files

## Determine which config file is in use

    SHOW config_file ;

## Determine which hba file is in use

    SHOW hba_file;
    
## Connection
    
### Remote connection

In `postgresql.conf`:

    listen_addresses = '*'
    
        
In `pg_hba.conf`:

    host  all  all 0.0.0.0/0 md5

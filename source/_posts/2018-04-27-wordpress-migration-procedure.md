---
title: Wordpress migration procedure
categories:
    - wordpress

---

## Extract source site filesystem

    tar -czf mySite.tgz /var/www/mySite

## Extract source site database


    mysqldump -u mySite -p mySite > mySite.sql

## Transfert source fs and db to target site

- Extract tar archive

        tar -czf mySite.tgz

- Import database

## Migrate database

Wordpress stores url in database, some of them can be serialized so wa can't just replace them with a bash script.

The best and easier way is to use this project [interconnectit/Search-Replace-DB](https://github.com/interconnectit/Search-Replace-DB) :

- download it
- upload it to the wordpress root
- open a browser at the matching url
- fill the form to migrate your database




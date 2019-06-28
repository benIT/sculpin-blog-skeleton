---
title: Moodle migration procedure
categories:
    - moodle
    - dev
tags:

---
In this post is described how to export you moodle app and import it on another environment.

##Export from the source database

         sudo -u postgres pg_dump moodle > /vagrant/shared/dump/moodle-database-exported.sql

##Migrate database

 Here I sustitute the string 'moodle-dev' by 'moodle-deploy' from 'moodle-database-exported.sql' and write it to 'database-to-import.sql':

         sed 's/moodle-dev/moodle-deploy/g' moodle-database-exported.sql > database-to-import.sql

##Let's tar db and filesystem

        tar -cvzf moodle-to-import.tgz database-to-import.sql moodle moodledata/
        exit
        mv ~/vagrant/vagrant-moodle/shared/moodle-to-import.tgz ~/vagrant/vagrant-moodle-deploy/shared/

##Cleanup the target machine
Connect on the target machine. here target database is also named 'moodle':

         cd /vagrant/shared
         rm -rf moodle moodledata/
         sudo -u postgres psql -c "DROP DATABASE moodle"
         sudo -u postgres psql -c "CREATE DATABASE moodle"

##Import db and filesystem on the target database


        sudo tar -xzf moodle-to-import.tgz
        sudo -u postgres psql --set ON_ERROR_STOP=on moodle < database-to-import.sql

##Migrate the config.php file

        sed -i 's/moodle-dev/moodle-deploy/g' moodle/config.php

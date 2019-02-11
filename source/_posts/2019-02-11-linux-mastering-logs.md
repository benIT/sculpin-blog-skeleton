---
title: Linux logs
categories:
    - linux
---
## Purpose

The aim of is post is to manipulate linux system logs.

Logging is an important part of IT system and must be understand.

## Test program

The following program named `program.sh` is used to test log services:

	echo I am $(whoami) and up from  $(uptime)

## Logs

Logs are managed with a service named `rsyslog`
	
	sudo service rsyslog status


## Activate cron log

In `sudo vim /etc/rsyslog.conf`, uncomment this line:

	cron.*                          /var/log/cron.log

Restart `systemctl`:

    sudo systemctl restart rsyslog

This doesn't log your program output, but logs your cron information.

Considering the following crontab that runs every minute:

	* * * * * /home/debian/prog.sh

Let's check `cron.log` details:

	sudo tail -f /var/log/cron.log

	Feb 11 10:09:01 sandbox CRON[25182]: (root) CMD (  [ -x /usr/lib/php/sessionclean ] && if [ ! -d /run/systemd/system ]; then /usr/lib/php/sessionclean; fi)
	Feb 11 10:09:01 sandbox CRON[25183]: (debian) CMD (/home/debian/prog.sh)
	Feb 11 10:10:01 sandbox CRON[25243]: (debian) CMD (/home/debian/prog.sh)
	Feb 11 10:11:01 sandbox CRON[25373]: (debian) CMD (/home/debian/prog.sh)
	Feb 11 10:12:01 sandbox CRON[25396]: (debian) CMD (/home/debian/prog.sh)
	Feb 11 10:13:01 sandbox CRON[25405]: (debian) CMD (/home/debian/prog.sh)
	Feb 11 10:14:01 sandbox CRON[25415]: (debian) CMD (/home/debian/prog.sh)
	Feb 11 10:15:01 sandbox CRON[25439]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
	Feb 11 10:15:01 sandbox CRON[25441]: (debian) CMD (/home/debian/prog.sh)
	Feb 11 10:16:02 sandbox CRON[25459]: (debian) CMD (/home/debian/prog.sh)

## Log rotation

Log rotation is managed with a service named `logrotate`

	cat /var/lib/logrotate/status | grep apache

	"/var/log/apache2/access.log" 2019-2-8-6:25:2
	"/var/log/apache2/other_vhosts_access.log" 2018-5-29-6:0:0
	"/var/log/apache2/error.log" 2019-2-11-6:25:1


Let's check apache2 webserver log rotation configuration :

	cat /etc/logrotate.d/apache2 
	/var/log/apache2/*.log {
		daily
		missingok
		rotate 14
		compress
		delaycompress
		notifempty
		create 640 root adm
		sharedscripts
		postrotate
		        if /etc/init.d/apache2 status > /dev/null ; then \
		            /etc/init.d/apache2 reload > /dev/null; \
		        fi;
		endscript
		prerotate
			if [ -d /etc/logrotate.d/httpd-prerotate ]; then \
				run-parts /etc/logrotate.d/httpd-prerotate; \
			fi; \
		endscript
	}


## Example with `program.sh`

### Program log location

We will tell our program to write here: `/var/log/prog.sh/log`. Let's create this file with the right permissions: 

    sudo mkdir /var/log/prog.sh/
    sudo touch /var/log/prog.sh/log
    sudo chmod ugo+rw /var/log/prog.sh/log

### Program crontab

	* * * * * /home/debian/prog.sh >> /var/log/prog.sh/log
	
### Program log rotation

Edit `/etc/logrotate.d/program.sh` :

    /var/log/program.sh/*.log {
            daily
            missingok
            rotate 5
            compress
            delaycompress
            notifempty
            create 644 root root
    }
	
[Great doc here](https://doc.ubuntu-fr.org/logrotate#exemple).


### Check log rotation

    ls /var/log/prog.sh/
    
    
## Another example with a cronjob from a webapp named `moodle` 

### Moodle log location
    sudo mkdir /var/log/moodle
    sudo touch /var/log/moodle/cron.log
    sudo chmod -R ug+rw /var/log/moodle/
    
### Moodle crontab

This job must be run from `www-data` user, so we need the crontab too to be run from `www-data` user:

    sudo crontab -u www-data -e

edit as follow:     
    
    #run moodle cron every hour
    0 * * * * php /data/moodle/admin/cli/cron.php >> /var/log/moodle/cron.log 2>&1

**Important stderr has been redirected to stdout with `2&1`** and all that is printed in a file.

### Moodle log rotation

Edit `/etc/logrotate.d/moodle` :

    /var/log/moodle/*.log {
            daily
            missingok
            rotate 5
            compress
            delaycompress
            notifempty
            create 640 www-data www-data
    }    
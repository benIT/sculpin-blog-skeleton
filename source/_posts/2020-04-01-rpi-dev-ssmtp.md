---
title: rpi dev 5 - setup ssmpt with netcourrier
categories:
    - linux
    - rpi
    - dev
tags:

---
## install

    apt-get install ssmtp
    apt-get install mailutils

## configure

edit `/etc/ssmtp/ssmtp.conf`: 

	root=
	mailhub=mail.net-c.com:465
	hostname=myhost.com
	AuthUser=usermail@netc.fr
	AuthPass=ENTER-SMTP-PASSWORD-HERE
	FromLineOverride=YES
	UseTLS=YES

## Test

echo "Hello world email body" | mail -s "Test Subject" test@mail.fr

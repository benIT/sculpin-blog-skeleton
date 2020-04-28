---
title: rpi dev 3 - get let's encrypt certificates with certbot
categories:
    - linux
    - rpi
    - dev
tags:

---

## Usage

    apt-get install -y certbot python-certbot-apache

    certbot certonly --webroot --webroot-path /var/www/html --domain mydomain.com --email me@mail.com

### Renewal

    certbot renew --dry-run

if fails because of FW:

    ufw allow 80/tcp comment 'allow IN 80 temporary'
    ufw allow 443/tcp comment 'allow IN 443 temporary'

    certbot renew --dry-run #launch renewal again

    ufw delete allow 80/tcp && ufw delete allow 443/tcp
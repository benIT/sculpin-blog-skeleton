---
title: rpi dev 2 - Install GITEA
categories:
    - linux
    - rpi
    - dev
tags:

---
### Apache2

    apt-get install -y apache2
    a2enmod ssl rewrite actions alias proxy_fcgi proxy proxy_http

### PostgreSQL

    CREATE DATABASE gitea;
    CREATE USER gitea_user WITH ENCRYPTED PASSWORD 'pass123';    
    GRANT CONNECT ON DATABASE gitea TO gitea_user;
    \c gitea;
    GRANT USAGE ON SCHEMA public TO gitea_user;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO gitea_user;
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO gitea_user;
    
### GITEA app

    apt-get install git
    adduser --disabled-login --gecos 'Gitea' git

### Setup Apache2 reverse proxy

    a2enmod proxy
    a2enmod proxy_http

Configure reverse proxy directives [source](https://www.digitalocean.com/community/questions/how-do-i-setup-gitea-with-a-domain-name-or-sub-domain) : 

    ProxyPreserveHost On
    ProxyRequests off
    ProxyPass / http://localhost:3000/
    ProxyPassReverse / http://localhost:3000/


`gitea.com.conf` file:

	<VirtualHost *:80>
		ServerName mygitea.com
		Redirect permanent / https://mygitea.com
	</VirtualHost>

	<VirtualHost *:443>
		ServerName mygitea.com
		ProxyPreserveHost On
		ProxyRequests off
		ProxyPass / http://localhost:3000/
		ProxyPassReverse / http://localhost:3000/

		ServerAdmin webmaster@localhost
		DocumentRoot /var/www/html
		SSLengine on
		SSLCertificateKeyFile /etc/letsencrypt/live/mygitea.com/privkey.pem
		SSLCertificateFile    /etc/letsencrypt/live/mygitea.com/cert.pem

		ErrorLog ${APACHE_LOG_DIR}/gitea-error.log
		CustomLog ${APACHE_LOG_DIR}/gitea-access.log combined
		Include conf-available/serve-cgi-bin.conf
	</VirtualHost>
	
	
### Configuration

* disable registration form
* mark repo as private
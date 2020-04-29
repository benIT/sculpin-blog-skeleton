---
title: rpi dev 3 - Install GITEA
categories:
    - linux
    - rpi
    - dev
tags:

---
## GIT itself

    apt-get install git
    adduser --disabled-login --gecos 'Gitea' git
    
### GITEA app

    cd /mnt/gitea/
    wget https://dl.gitea.io/gitea/1.4.0/gitea-1.4.0-linux-arm-7 -O gitea
    chmod +x gitea
    chown -R git: /mnt/gitea
    
check its running at https://192.X.X.X:3000 with : `./gitea web` 

#### GITEA systemd service

In `/etc/systemd/system/gitea.service`: 

    [Unit]
    Description=Gitea (Git with a cup of tea)
    After=syslog.target
    After=network.target
    
    [Service]
    # Modify these two values ​​and uncomment them if you have
    # repos with lots of files and get to HTTP error 500 because of that
    ###
    # LimitMEMLOCK=infinity
    # LimitNOFILE=65535
    RestartSec=2s
    Type=simple
    User=git
    Group=git
    WorkingDirectory=/mnt/gitea
    ExecStart=/mnt/gitea/gitea web
    Restart=always
    Environment=USER=git 
    HOME=/mnt/gitea/gitea
    
    [Install]
    WantedBy=multi-user.target

enable service:

    systemctl enable gitea.service
    systemctl start gitea.service
    
reboot and check service is running.

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
		SSLCertificateChainFile /etc/letsencrypt/live/mygitea.com/fullchain.pem

		ErrorLog ${APACHE_LOG_DIR}/gitea-error.log
		CustomLog ${APACHE_LOG_DIR}/gitea-access.log combined
		Include conf-available/serve-cgi-bin.conf
	</VirtualHost>
	
	
### Configuration

### from GUI

* disable registration form
* mark repo as private

### from CLI

edit `custom/conf/app.ini` and `systemctl restart gitea.service`
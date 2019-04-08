---
title: Install REDMINE 3.X with PgSQL and Apache2 on debian 9
categories:
    - redmine
---
## Resources

* http://www.redmine.org/projects/redmine/wiki/howto_install_redmine_on_ubuntu_step_by_step
* http://www.redmine.org/projects/redmine/wiki/redmineinstall

## Tested version

    pg_config --version
    PostgreSQL 11.2 (Debian 11.2-1.pgdg90+1)

    ruby -v
    ruby 2.3.3p222 (2016-11-21) [x86_64-linux-gnu]

## Server packages

### Debian packages

	sudo apt-get install apache2 libapache2-mod-passenger ruby ruby-dev
	sudo apt install postgresql-server-dev-all

### Ruby GEMs

    sudo -E gem install bundler -v 1.17.3

## Database 

    CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD 'redmine' NOINHERIT VALID UNTIL 'infinity';
    CREATE DATABASE redmine WITH ENCODING='UTF8' OWNER=redmine;

## App

	tar -xzf redmine-3.4.10.tar.gz
	cd redmine-3.4.10/
	mv config/database.yml.example  config/database.yml
	cd ..
	mv redmine-3.4.10/ /var/www/redmine


Edit `config/database.yml.example` : 

	# PostgreSQL configuration example
	production:
	  adapter: postgresql
	  database: redmine
	  host: localhost
	  username: redmine
	  password: "redmine"

And rename it:
    
    mv config/database.yml.example  config/database.yml

### Dependencies

    bundle install --without development test

### Setup

    bundle exec rake generate_secret_token
    RAILS_ENV=production bundle exec rake db:migrate
    RAILS_ENV=production REDMINE_LANG=fr bundle exec rake redmine:load_default_data


    mkdir -p tmp tmp/pdf public/plugin_assets
    sudo chown -R www-data: files log tmp public/plugin_assets
    sudo chmod -R 755 files log tmp public/plugin_assets

## Apache2

### Permissions & ownership

    sudo chown -R www-data: /var/www/
    sudo chmod -R 755 /var/www/

### Configuration of passenger.conf
  
Add the following line to `/etc/apache2/mods-available/passenger.conf`:

    PassengerDefaultUser www-data
    
### Virtual Host

Edit `/etc/apache2/sites-enabled/000-default.conf`:

    <VirtualHost *:80>
        #ServerName www.example.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/redmine/public/
            #MaxRequestLen 20971520
    
            <Directory "/var/www/redmine/public">
                    Options Indexes ExecCGI FollowSymLinks
                    Order allow,deny
                    Allow from all
                    AllowOverride all
            </Directory>
    
        ErrorLog ${APACHE_LOG_DIR}/redmine.error.log
        CustomLog ${APACHE_LOG_DIR}/redmine.access.log combined
    </VirtualHost>

## Test

REDMINE should be running, login with `admin`/`admin`.  
---
title: Apache2 customize index page
categories:
    - Apache2
---

## Customize the default apache2 page index page

Apache2 index option is highly customizable. [See this official resource.](http://httpd.apache.org/docs/2.2/mod/mod_autoindex.html)

With the following code:

    <VirtualHost *:80>
            DocumentRoot /data/moodle_versions
        <Directory />
            Options FollowSymLinks
            AllowOverride None
        </Directory>
        <Directory /data/moodle_versions/>
            Options Indexes FollowSymLinks MultiViews
            AllowOverride All
            Require all granted
            allow from all
            AddDescription "Installation de moodle 3.5.4 LTS standard" moodle_354
            AddDescription "Installation de moodle 3.6.4 à des fins de test" moodle_364
            IndexStyleSheet "style.css"
            HeaderName header.html
            ReadmeName footer.html
            IndexIgnore *.html
            IndexIgnore *.css
        </Directory>
            ServerAdmin webmaster@localhost
            ErrorLog ${APACHE_LOG_DIR}/error.log
            CustomLog ${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>
    
    
You can turn the default page:

![screenshot](/images/apache2/default.png)

to this one:

![screenshot](/images/apache2/custom.png)

    
---
title: PHP survival sheet
categories:
    - php
    - dev
    - survival sheet
tags:

---
## Identify different `php.ini` files

This `find` command:
    
    find /etc -name php.ini 

returns:
    
    /etc/php/7.1/apache2/php.ini
    /etc/php/7.1/cli/php.ini

## Identify loaded php.ini files from command line

This command:

    php --ini

returns:

    Configuration File (php.ini) Path: /etc/php/7.1/cli
    Loaded Configuration File:         /etc/php/7.1/cli/php.ini
    Scan for additional .ini files in: /etc/php/7.1/cli/conf.d
    Additional .ini files parsed:      /etc/php/7.1/cli/conf.d/10-mysqlnd.ini,
    /etc/php/7.1/cli/conf.d/10-opcache.ini,
    /etc/php/7.1/cli/conf.d/10-pdo.ini,
    /etc/php/7.1/cli/conf.d/15-xml.ini,
    ...
    
## Get configuration values from the command line

This command returns:

    php -i | grep upload_max_filesize

returns: 
    
    upload_max_filesize => 2M => 2M
    
Common configuration to change in `php.ini` files:

    memory_limit
    max_execution_time
    max_input_time
    post_max_size
    upload_max_filesize
    
    display_errors
    html_errors
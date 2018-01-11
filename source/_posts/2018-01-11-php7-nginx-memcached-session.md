---
title: Setting up a memcached server with PHP7.X and a NGINX webserver 
categories:
    - memcached
    - PHP7
tags:

---

## Memcached server side

This server has private @IP : 192.168.33.14

### Install memcached:
    
    sudo apt-get install memcached

In `/etc/memcached.conf`, set up memory to 256 Mo:

    -m 256
    
In `/etc/memcached.conf`, set up listening private @IP of the server:

    # Specify which IP address to listen on. The default is to listen on all IP addresses
    # This parameter is one of the only security measures that memcached has, so make sure
    # it's listening on a firewalled interface.
    #-l 127.0.0.2
    -l 192.168.33.14

    
## Web server side

This server has private @IP : 192.168.33.11


### Install PHP extension
 
On the server that hosts nginx + php7.0:

    sudo apt-get install -y php-memcached
    
### Configure PHP

In `/etc/php/7.0/fpm/php.ini`:

    [Session]
    ; Handler used to store/retrieve data.
    ; http://php.net/session.save-handler
    #session.save_handler = files
    session.save_handler = memcached
    session.save_path = 'tcp://192.162.33.14:11211'

### Restart services

    sudo service php7.0-fpm restart && sudo service nginx restart
    
### Check config    
    
Create a phpinfo.php that calls `phpinfo()` and check memcached configuration.

### Checking

### Checking sessions are well handled by memcached

Let's write a simple script to check sessions:
    
    session_start();
    if(!isset($_SESSION['visit']))
    {   
        echo "This is the first time you're visiting this server\n";
        $_SESSION['visit'] = 0;
    }   
    else
            echo "Your number of visits: ".$_SESSION['visit'] . "\n";

    $_SESSION['visit']++;

    echo "Server IP: ".$_SERVER['SERVER_ADDR'] . "\n";
    echo "Client IP: ".$_SERVER['REMOTE_ADDR'] . "\n";
    print_r($_COOKIE);


### Checking memcached key/value server

Let's write a simple script to key/value access:

    $mem = new Memcached();
    $mem->addServer("192.168.33.14", 11211);
    $result = $mem->get("blah");
    if ($result) {
        echo $result;
    } else {
        echo "No matching key found yet. Let's start adding that now!";
        $mem->set("blah", "I am data!  I am held in memcached!") or die("Couldn't save anything to memcached...");
    }   
    
    
## Sources
 
 * https://www.digitalocean.com/community/tutorials/how-to-share-php-sessions-on-multiple-memcached-servers-on-ubuntu-14-04
 * http://www.servermom.org/install-use-memcached-nginx-php-7-ubuntu-16-04/3670/

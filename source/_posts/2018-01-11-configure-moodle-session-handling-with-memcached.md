---
title: Configure moodle 3.x session handling with memcached
categories:
    - memcached
    - moodle
tags:

---

This procedure has been tested on Moodle [version 3.0.6+](https://github.com/moodle/moodle/commit/7223cd2518ad3b37901b736d6b62e7badd4ecaa1) with a dedicated memcached server which @IP:port is 192.168.33.14:11211 

## Set up a  memcached server

see [this post](/blog2018-01-11-php7-nginx-memcached-session).

## Configure moodle

Configure [session handling](https://docs.moodle.org/30/en/Session_handling#Memcached) in `config.php`:

    /********************************************/
    //MEMCACHED SETUP
    $CFG->session_handler_class = '\core\session\memcached';
    $CFG->session_memcached_save_path = '192.168.33.14:11211';
    $CFG->session_memcached_prefix = 'memc.sess.key.';
    $CFG->session_memcached_acquire_lock_timeout = 120;
    $CFG->session_memcached_lock_expire = 7200;       // Ignored if memcached extension <= 2.1.0
    /********************************************/
    
    
## Checkings

## Moodle cookie

If you print out your cookie from your debug tool in your bowser, you well see a cookie named `MoodleSession`

In my case it has value `4gp94gr17g78jnh97a6mfml0b4`

## Moodle database

Now let's check if there is still record in DB for your cookie session: 

    SELECT * FROM mdl_sessions WHERE sid='4gp94gr17g78jnh97a6mfml0b4';

returns: 
 
    2507694	0	4gp94gr17g78jnh97a6mfml0b4	48521		1515679016	1515681908	192.168.33.1	192.168.33.1

    
What ??? I was expecting to have no more entries in the mdl_sessions table.
After searching a little bit more, I found the explanation [here](https://moodle.org/mod/forum/discuss.php?d=326352):

    Normally when you have sessions stored in Memcache/d there will still be a record of the session written to mdl_sessions. The session data is not written to the database, it's only written to the memcache/d server itself. The performance gain is seen because the session data is not written every page view for every user, and thus the table rows are not continually being locked and unlocked.
    
## memcached server

Let's check if there is a key/value record for ou session: 

<script src="https://gist.github.com/benIT/2e63d3541f4f46d9a47777d467549d2e.js"></script>

run it: 

    php memcached.php | grep 4gp94gr17g78jnh97a6mfml0b4
    
prints: 

    key: memc.sess.key.4gp94gr17g78jnh97a6mfml0b4

which means that our session is written in memcached! That's ok!
    
    
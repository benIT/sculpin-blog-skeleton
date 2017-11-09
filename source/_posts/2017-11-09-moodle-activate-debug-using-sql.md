---
title: Moodle 3.X: activate debug whithout GUI
categories:
    - moodle
tags:

---

If you need to activate debug but you cannot access moodle admin page, this article is for you:


## Step 1: note original settings

	SELECT name, value
	FROM mdl_config
	where name ='debug' or name ='debugdisplay'
	;

for instance : 

	debug	0
	debugdisplay	0

## Step 2 : setup debug config in db

	UPDATE mdl_config SET VALUE = 32767 WHERE name = 'debug';
	UPDATE mdl_config SET VALUE = 1 WHERE name = 'debugdisplay';

## Step 3: clear cache from CLI

	php  moodle/admin/cli/purge_caches.php


## Step 4: restore original settings
	
	UPDATE mdl_config SET VALUE = 0 WHERE name = 'debug';
	UPDATE mdl_config SET VALUE = 0 WHERE name = 'debugdisplay';

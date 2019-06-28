---
title: Setting up angularjs and chartjs in Moodle 3.X
categories:
    - Moodle
    - angularjs
    - js
tags:

---

I was wondering how can I integrate angularjs to my moodle plugin. 
Moodle isn't designed as frontend/backend, so how can I integrate angularjs with smashing moodle?
I create a POOC, let's checkout that:

- Create a custom template page : [the custom template](https://github.com/benIT/moodle_report_angularjspooc/blob/master/templates/reportindex_page.mustache) will be only used to put `ng-app` directive 

- Load [all javascript](https://github.com/benIT/moodle_report_angularjspooc/blob/master/index.php#L26) in the template page

- Write PHP AJAX or Moodle Webservice to expose data:
 In my case, I didn't care about exposing webservices so I choose to [write a simple ajax page](https://github.com/benIT/moodle_report_angularjspooc/blob/master/ajax.php).

- Write your [angularjs code](https://github.com/benIT/moodle_report_angularjspooc/tree/master/angular)
 
- Enjoy angularjs on moodle ! In this cas, we will use this to generate beautiful reports with Charts.js


 **[The Repository is available at github.](https://github.com/benIT/moodle_report_angularjspooc)**

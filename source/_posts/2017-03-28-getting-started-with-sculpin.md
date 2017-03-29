---
title: Getting started with Sculpin
categories:
    - Sculpin

---
##Download, install and configure

[Sculpin](https://sculpin.io/) is a static site generator written in PHP. It converts Markdown files, Twig templates and standard HTML into a static HTML site that can be easily deployed.
As this site, it can be hosted on GITHUB pages.

 - fork the [sculpin-blog-skeleton repo](https://github.com/sculpin/sculpin-blog-skeleton)
 - clone the repo and install Sculpin dependencies: 

         git clone git@github.com:benIT/github-blog.git         
         cd github-blog
         composer install

 - edit blog settings in app/config/sculpin_site.yml
 - run a local webserver on port 8000 to see your edits
 
         php vendor/bin/sculpin generate --watch --server
         
 - add content in `/source/_posts` folder

##Create content
 
 
 - edit your post content
 - check result at localhost:8000
 - when result is enough good, generate site using :
 
        php vendor/bin/sculpin generate --env=prod
        
 - Your site html content should be available at `output_prod`, it's the content of that folder that must be hosted on your github page

         
##Deploy on github         
         
     
 

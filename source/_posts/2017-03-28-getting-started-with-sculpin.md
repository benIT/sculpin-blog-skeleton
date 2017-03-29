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

###About github pages

You can host html generaed  at 3 different locations :
 - on `master` branch 
 - or `master` branch in `docs` folder
 - on `gh-pages` branch
 
 **But for your personal pages, you can only host in repo named `benit.github.io` on the `master` branch. 
 This means, that we need 2 repos : one for source control and another one for hosting our github pages.**
 Thus, I create the following repos : `github-blog.git` and `benit.github.io`
 
###How to publish the content to the repo that hosts your github pages ?
 
 I edit [the shell script named `publish.sh`](https://github.com/benIT/github-blog/blob/master/publish.sh).
 The script is in charge of:
 
 - generating the html
 - rsyncing the `output_prod` folder with the `benit.github.io`. 
 - commiting 
 - pushing
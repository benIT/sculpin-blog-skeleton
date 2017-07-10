# benit.github.io static site

The purpose of this site is just to share technical stuffs around open-source and web technologies. 

## Under the hood

This site is powered by [Sculpin](http://sculpin.io) and has been forked from [sculpin/sculpin-blog-skeleton](https://github.com/sculpin/sculpin-blog-skeleton)

## How does it work?

There as 2 repos:

- one for hosting sculpin app: `github-blog.git`
- one for hosting sculpin generated html on github pages: `benit.github.io.git`

And a publish script that will rsync and commit on both repos: `publish.sh`
### Install    
    
    git clone git@github.com:benIT/github-blog.git
    git clone git@github.com:benIT/benit.github.io.git
    cd github-blog
    composer install

### Run sculpin's built in webserver     
    
    cd github-blog/ && php vendor/bin/sculpin generate --watch --server
        
### Publish    

    ./publish.sh "your commit message"

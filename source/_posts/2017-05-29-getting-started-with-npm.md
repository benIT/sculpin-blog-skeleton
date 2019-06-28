---
title: Getting started with npm
categories:
    - node
    - npm
    - dev
    - js
tags:

---
##npm global configuration file

 		vim ~/.npmrc

##list npm globally installed modules

		npm list -g

##Install modules globally

    sudo npm install -g my-module

    sudo npm install -g gulp-autoprefixer gulp-clean gulp-concat gulp-cssbeautify gulp-csscomb gulp-csso gulp-if gulp-jshint gulp-less gulp-load-plugins gulp-ng-annotate gulp-rename gulp-uglify minimist
    ls /usr/local/lib/node_modules
    
##Install modules locally

Modules will be installed in `node_modules` folder.

###dev modules with --save-dev option
    npm install --save-dev gulp-cssbeautify gulp-csscomb gulp-csso gulp-jshint gulp-less gulp-load-plugins gulp-rename

###non dev modules with --save option
    npm install angular-i18n --save
    

##Link our project modules to the global installed node modules
    cd my-app
    npm link gulp-autoprefixer gulp-clean gulp-concat gulp-cssbeautify gulp-csscomb gulp-csso gulp-if gulp-jshint gulp-less gulp-load-plugins gulp-ng-annotate gulp-rename gulp-uglify minimist
    npm install 

##Speed up npm

`npm install` can be very long, so let's try to speed up that!

###Disable progress

    npm config set progress false
    
###Setting up a local cache server 
Inspired from this [ressource](http://willcodefor.beer/setup-your-own-npm-cache-server/).

####Installing npm-proxy-cache

    sudo apt-get install -y nodejs npm
    npm config set prefix '~/.npm-packages'  
    export PATH="$PATH:$HOME/.npm-packages/bin"
    npm install -g forever npm-proxy-cache  
    ln -s /usr/bin/nodejs /usr/bin/node
    
####Starting the cache server
    sudo forever /usr/local/lib/node_modules/npm-proxy-cache/bin/npm-proxy-cache  -e -t 600000 -h localhost

You should see that the server is running on 8080 port:

    [2017-05-29 13:13:11.725] [INFO] proxy - Listening on localhost:8080 [6172]


####Configuring npm-proxy-cache

    npm config set proxy http://localhost:8080/  
    npm config set https-proxy http://localhost:8080
    npm config set strict-ssl false  
    
####Testing the cache server
    cd my-app
    rm -rf node_modules
    npm install
    
####Automating server boot 
todo

####Yeah, it works!
    
    [2017-05-29 13:13:11.725] [INFO] proxy - Listening on localhost:8080 [6172]
    [2017-05-29 13:18:55.662] [INFO] proxy - cache https://registry.npmjs.org/angular-route
    [2017-05-29 13:18:55.679] [INFO] proxy - cache https://registry.npmjs.org/angular-i18n
    [2017-05-29 13:18:55.702] [INFO] proxy - cache https://registry.npmjs.org/angularjs-datepicker
    [2017-05-29 13:18:55.703] [INFO] proxy - cache https://registry.npmjs.org/bootstrap
    [2017-05-29 13:18:55.711] [INFO] proxy - cache https://registry.npmjs.org/chart.js
    [2017-05-29 13:18:55.714] [INFO] proxy - cache https://registry.npmjs.org/jquery
    [2017-05-29 13:18:55.716] [INFO] proxy - cache https://registry.npmjs.org/isteven-angular-multiselect
    [2017-05-29 13:18:55.719] [INFO] proxy - cache https://registry.npmjs.org/gulp
    [2017-05-29 13:18:55.723] [INFO] proxy - cache https://registry.npmjs.org/gulp-autoprefixer
    ...
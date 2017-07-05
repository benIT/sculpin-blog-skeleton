#!/bin/bash
SCULPIN_REPO_PATH=/vagrant/shared/github-blog
GITHUB_PAGE_REPO_PATH=/vagrant/shared/benit.github.io

#check commit message
if [ $# -ne 1 ]; then
    echo "commit message required"
    exit 1;
fi

eval `ssh-agent -s` && ssh-add ~/.ssh/id_rsa_github
if [ $? -ne 0 ]; then
    echo "ssh error"
    exit 1;
fi


#generate html for github pages
cd $SCULPIN_REPO_PATH
vendor/bin/sculpin generate --env=prod

#synchronize with repo that host github pages on master branch
rsync -a --exclude .git $SCULPIN_REPO_PATH/output_prod/ $GITHUB_PAGE_REPO_PATH --delete
read -p "Content generated and sync. Do you want to both commit and push to blog repo and github pages repo with commit message : $1" -n 1 -r

#commit to the repo that version our blog source code
git add -A
git commit -m "$1"
git push origin master


#commit to repo that host github pages on master branch
cd $GITHUB_PAGE_REPO_PATH
git add -A
git commit -m "$1"
git push origin master
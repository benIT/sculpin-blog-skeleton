---
title: GIT rebase
categories:
    - GIT
---

The aim of this post is to understand and get confortable with the git rebase command.

[Definition](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase):

> Rebasing is the process of moving or combining a sequence of commits to a new base commit. Rebasing is most useful and easily visualized in the context of a feature branching workflow.
 
## Create a git repo

	mkdir rebase-test && cd rebase-test
	git init

output: 
 
	Initialized empty Git repository in /home/bmn/rebase-test/.git/

## Create one commit on `master` branch

	echo "first content from master" >> README.md
	git add README.md 
	git commit -m "first commit"

output:
	
	[master (root-commit) dc5f8d2] first commit
	1 file changed, 1 insertion(+)
	create mode 100644 README.md

## Create a `feature` branch from that commit

	git checkout -b feature
	Switched to a new branch 'feature'

## Create one commit on the `feature` branch

	echo "introducing a new feature" >> README.md

Check file:

	cat README.md

output:	 

	first content from master
	introducing a new feature


	git commit -am "add feature line"

output:
	
	[feature 2212653] add feature line
	1 file changed, 1 insertion(+)



## Check repo graph

	nohup gitg &

![screenshot](/images/git-rebase/graph1.png)

## Create a new commit on master branch

	git checkout master 
	Switched to branch 'master'

Check file:

	cat README.md 
	first content from master

	vim README.md # add a title line for example
	cat README.md

output:
	 
	# Master title
	first content from master

Commit that:

	git commit -am "add master title"

output:

	[master ec82793] add master title
	 1 file changed, 1 insertion(+)


>Let's say that `master` branch has a new commit because work on master has been delivered. Let's rebase the `feature` branch to this new commit, to get the new content from `master` and play the commit from `feature` branch.

## Let's rebase the `feature` branch on the `master` branch

Let's move on our `feature` branch:

	git checkout feature 

output:

	Switched to branch 'feature'

And now the rebase operation itself:

	git rebase -i master 

![screenshot](/images/git-rebase/rebase.png)


output:

	Successfully rebased and updated refs/heads/feature.


*Our `feature` branch starts now from `master` head commit and now git is replaying all the commit from our `feature` branch from this point.*

The result is the following:

The file `README.ms` now contains the commits from `master` + the commit from `feature`.

## Let's check feature branch content

	cat README.md 

output:

	# Master title
	first content from master
	introducing a new feature

## Let's check `master` branch content

	git checkout master 

output:

	Switched to branch 'master'


    cat README.md

output:

	# Master title
	first content from master

## Check repo graph

	nohup gitg &

![screenshot](/images/git-rebase/graph2.png)


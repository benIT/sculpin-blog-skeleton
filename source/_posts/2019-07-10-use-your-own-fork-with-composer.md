---
title: Use your own fork with composer
categories:
    - PHP
    - dev
    - composer
---
Resources:

* https://getcomposer.org/doc/04-schema.md#minimum-stability
* https://stackoverflow.com/a/13500676/1632809
##Context

* Original project: [https://github.com/KnpLabs/KnpGaufretteBundle](https://github.com/KnpLabs/KnpGaufretteBundle)

* My fork: [https://github.com/benIT/KnpGaufretteBundle.git](https://github.com/benIT/KnpGaufretteBundle.git)

* My branch name: `benIT-gaufrette-1.0`. This one contains my commits.

##Composer

My `composer.json` file that tracks my fork with ly branch.

Note: branch must be prefixed bt `dev-`. In this case: `dev-benIT-gaufrette-1.0`:
    
    {
      "name": "root/test-composer",
      "repositories": [
        {
          "type": "vcs",
          "url": "https://github.com/benIT/KnpGaufretteBundle.git"
        }
      ],
      "require": {
        "knplabs/knp-gaufrette-bundle": "dev-benIT-gaufrette-1.0"
      },
      "minimum-stability": "dev",
      "prefer-stable": true
    }



The following directive :

    "minimum-stability": "dev",
    "prefer-stable": true

prevents this kind of error related to minimum stability:

      Problem 1
        - Installation request for knplabs/knp-gaufrette-bundle dev-benIT-gaufrette-1.0 -> satisfiable by knplabs/knp-gaufrette-bundle[dev-benIT-gaufrette-1.0].
        - knplabs/knp-gaufrette-bundle dev-benIT-gaufrette-1.0 requires knplabs/gaufrette ^1.0 -> satisfiable by knplabs/gaufrette[1.x-dev] but these conflict with your requirements or minimum-stability.

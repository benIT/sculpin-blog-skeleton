---
title: PHPSTORM search & replace with regexp
categories:
    - phpstorm
    - regexp
---
## Context

I have a list of 10K of #ID,and need to add a `,` at the end of each line to process them in a SQL query. 

## data input

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    ...

## the trick

Hit `ctrl+R` to launch the `search & replace action`.

Search the following pattern:

    (.*)$
    
And replace it with:

    $1,

![screenshot](/images/phpstorm/search-replace-regexp.png)


## data output

    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    ...,
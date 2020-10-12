---
title: Linux install CA cert file 
categories:
    - linux
tags:
---

Self signed certificates throw error and can make CLI scripts fail. Here is the procedure to use to import cert file at a system level.

 
Tested with debian 10.

    cp my-cert-file.crt /usr/local/share/ca-certificates
    update-ca-certificates
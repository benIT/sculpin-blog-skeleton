---
title: RIP a md5 hash with john the ripper
categories:
    - hacking
    - kali
---

## RIP a md5 hash

    echo "ca50dfb151104b1ee005d68fa9a970ce" > md5-to-crack
    john --format=raw-md5 md5-to-crack --show

returns:

    john --format=raw-md5 md5-to-crack --show
    ?:dolorem
    
    1 password hash cracked, 0 left


Password for hash `ca50dfb151104b1ee005d68fa9a970ce` is `dolorem`
    
---
title: RIP linux user password with John the Ripper
categories:
    - hacking
    - kali
---

## Add a new user

    sudo useradd -r foo
    sudo passwd foo
    Enter new UNIX password: 
    Retype new UNIX password: 
    passwd: password updated successfully
    
## Password hash file

Linux user password hash are stored here: `/etc/shadow`

## Rip it!

    sudo john /etc/shadow
    Created directory: /root/.john
    Using default input encoding: UTF-8
    Loaded 3 password hashes with 3 different salts (sha512crypt, crypt(3) $6$ [SHA512 256/256 AVX2 4x])
    Cost 1 (iteration count) is 5000 for all loaded hashes
    Will run 5 OpenMP threads
    Proceeding with single, rules:Wordlist
    Press 'q' or Ctrl-C to abort, almost any other key for status
    vagrant          (vagrant)
    Warning: Only 3 candidates buffered for the current salt, minimum 20
    needed for performance.
    toor             (root)
    Warning: Only 14 candidates buffered for the current salt, minimum 20
    needed for performance.
    Warning: Only 6 candidates buffered for the current salt, minimum 20
    needed for performance.
    Warning: Only 16 candidates buffered for the current salt, minimum 20
    needed for performance.
    Warning: Only 17 candidates buffered for the current salt, minimum 20
    needed for performance.
    Warning: Only 3 candidates buffered for the current salt, minimum 20
    needed for performance.
    Almost done: Processing the remaining buffered candidate passwords, if any
    Warning: Only 15 candidates buffered for the current salt, minimum 20
    needed for performance.
    Proceeding with wordlist:/usr/share/john/password.lst, rules:Wordlist
    foobar           (foo)
    3g 0:00:00:01 DONE 2/3 (2019-05-06 10:39) 1.570g/s 1806p/s 1808c/s 1808C/s 1234qwer..ford
    Use the "--show" option to display all of the cracked passwords reliably
    Session completed
    
### And user password is...
    
    foobar           (foo)
    
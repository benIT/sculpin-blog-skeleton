---
title: linux basics: file permissions 3 - ACL
categories:
    - linux
    - linux basics
tags:

---

ACL usage: when POSIX rights are too limited. Check ACL support is enabled:
 
    grep ACL /boot/config* | grep -i ext4
    
install package: 
    
    apt install acl
    
Enable if needed in `/etc/fstab`, with option `acl`

create a test file: `touch test`
create a test user: `adduser testuser`
create a group user: `groupadd testgroup`

## getfacl

    getfacl test

    # file: test
    # owner: root
    # group: root
    user::rw-
    group::r--
    other::r--

## setfacl

Let's say we want to give an extra `rw` permissions to our `testuser` without using POSIX rights:

    setfacl -m u:testuser:rw test

check that:
    
    getfacl test
    # file: test
    # owner: root
    # group: root
    user::rw-
    user:testuser:rw-
    group::r--
    mask::rw-
    other::r--

Let's say we want to give an extra `rwx` permissions to our `testgroup` without using POSIX rights:

    setfacl -m g:testgroup:rwx test
    
check that: 

    getfacl test
    # file: test
    # owner: root
    # group: root
    user::rw-
    user:testuser:rw-
    group::r--
    group:testgroup:rwx
    mask::rwx
    other::r--

It is possible to edit POSIX rights without specifying user or group:


    setfacl -m g::r test
    getfacl test
    # file: test
    # owner: root
    # group: root
    user::rw-
    user:testuser:rw-
    group::r--
    group:testgroup:rwx
    mask::rwx
    other::r--

same for user: 

    setfacl -m u::r test
    getfacl test
    # file: test
    # owner: root
    # group: root
    user::r--
    user:testuser:rw-
    group::r--
    group:testgroup:rwx
    mask::rwx
    other::r--

### ACL on folder

* -d: inheritance. file in folder will inherit folder ACL
* -R: recursive

    
    mkdir test-folder
    setfacl -dm u:testuser:rwx test-folder/

check:

    getfacl test-folder/
    # file: test-folder/
    # owner: root
    # group: root
    user::rwx
    group::r-x
    other::r-x
    default:user::rwx
    default:user:testuser:rwx
    default:group::r-x
    default:mask::rwx
    default:other::r-x

check child file inherits ACL from parent folder: 
    
    touch test-folder/a
    getfacl test-folder/a
    # file: test-folder/a
    # owner: root
    # group: root
    user::rw-
    user:testuser:rwx		#effective:rw-
    group::r-x			#effective:r--
    mask::rw-
    other::r--


Recursive mode is not linked to file.

### Delete ACL


#### Delete all ACLs

    setfacl -b test
    
There is no more ACL rights, only POSIX rights:
    
    getfacl test
    # file: test
    # owner: root
    # group: root
    user::r--
    group::r--
    other::r--

#### Delete default ACLs with `-k`

    getfacl test-folder/
    # file: test-folder/
    # owner: root
    # group: root
    user::rwx
    group::r-x
    other::r-x
    default:user::rwx
    default:user:testuser:rwx
    default:group::r-x
    default:mask::rwx
    default:other::r-x

delete: `setfacl -k test-folder/
`
check: `getfacl test-folder/`

    # file: test-folder/
    # owner: root
    # group: root
    user::rwx
    group::r-x
    other::r-x

#### Delete a particular ACL with `-x`

    setfacl -x u:testuser test
    
## Mask
    
A mask is a logical AND operator. The effective rights will result of the logical AND operation of the right mask and the user or group ACL. Check the `#effective:` in `getfacl` output:

Let a `rwx` ACL to `testuser`: 

    setfacl -m u:testuser:rwx test

Let a `rw` mask ACL:

    setfacl -m m::rw test

Check rights:
    
     getfacl test
    # file: test
    # owner: root
    # group: root
    user::r--
    user:testuser:rwx               #effective:rw-
    group::r--
    mask::rw-
    other::r--

For testuser: 

    user:testuser:rwx               #effective:rw

The effective rights are the result of the logical AND operation, thus `rw`

## ACL hierarchy

mask > user ACL > group ACL > owner group ACL > POSIX rights
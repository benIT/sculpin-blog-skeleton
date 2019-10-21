---
title: Bash scripting course notes
categories:
    - linux
    - apache2
tags:

---

# Shell/bash course

https://urfist.unistra.fr/uploads/media/command_memento_fr.pdf

* BSD: berkely univsersity. public/research
* system V: private, constructors: DEC, SUN
* POSIX: standard on all system

## Change shell

	usermod -s /bin/bash formation
	chsh

	[root@localhost ~]# useradd ben
	[root@localhost ~]# passwd ben
	Changement de mot de passe pour l'utilisateur ben.
	Nouveau mot de passe : 
	MOT DE PASSE INCORRECT : Le mot de passe comporte moins de 8 caractères
	Retapez le nouveau mot de passe : 
	passwd : mise à jour réussie de tous les jetons d'authentification.
	[root@localhost ~]# usermod -s /bin/ksh ben
	[root@localhost ~]# tail -4 /etc/passwd
	tcpdump:x:72:72::/:/sbin/nologin
	formation:x:1000:1000:Formation:/home/formation:/bin/bash
	vboxadd:x:988:1::/var/run/vboxadd:/bin/false
	ben:x:1001:1001::/home/ben:/bin/ksh

### Switch user: su

Make use of the `-` to get user env
	[root@localhost ~]# su - ben
	Dernière connexion : lundi  7 octobre 2019 à 09:46:27 CEST sur pts/0

## Text shell

	ctrl + alt + F1 => graphical shell mode
	ctrl + alt + F[2-6] => text shell mode

## File type

	- file
	d directory
	l link
	c char I/O hardware
	b block I/O hardware
	p pipe : inter process (local)
	s socket : inter process (network)


## tty
terminal teletype

	[formation@localhost ~]$ tty
	/dev/pts/0
	[formation@localhost ~]$ echo "hello"
	hello
	[formation@localhost ~]$ echo "hello" > /dev/pts/1

## Env var
available in:

* new window
* new shell
* new script

env: list env var
set: env + pre param shell

## File command

	[formation@localhost ~]$ file /bin/ls
	/bin/ls: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, BuildID[sha1]=c5ad78cfc1de12b9bb6829207cececb990b3e987, stripped
	[formation@localhost ~]$ file foo.pdf 
	foo.pdf: ASCII text
	[formation@localhost ~]$ mv foo.pdf foo.md
	[formation@localhost ~]$ file foo.md 
	foo.md: ASCII text

## special bits

### setuid
when present on an executable file, the programm is executed with the identity of the file owner

	[formation@localhost ~]$ which passwd 
	/usr/bin/passwd
	[formation@localhost ~]$ ls -l /usr/bin/passwd 
	-rwsr-xr-x. 1 root root 27832 10 juin   2014 /usr/bin/passwd

	chmod 4555 prog.sh 
	[formation@localhost ~]$ ls -l prog.sh 
	-r-sr-xr-x. 1 formation formation 0  7 oct.  10:56 prog.sh

### setgid
idem for group


### sticky bit: t

only owner can destroy folder (add resistance to destruction).

	ls -ld /tmp/
	drwxrwxrwt. 15 root root 4096  7 oct.  10:59 /tmp/


## Groups

create first group
then create user, and assign group

    groupadd friends
    groupadd painters

    useradd foo -g firends -G painters

## $PATH
contains paths of executables path

	PATH=$PATH:/new/location/exec

## find command

	find /dev - type l -name "*or*" -exec file {} \;


## locate command
locate file2Search
updatedb

## Command IO

* stdin: <1
* stdout: >1
* stderr: >2

2>&1: recirect stderr to stdout
1>&2: redirect stdout to stderr

	ls -l file 1> out
	ls -l file doesNotExist 2> error 1>out
	ls -l file &> out



## tree
tree of files

## pstree
tree of ps 

    ps clax
    ps -ef

## bash debug mode

bash -vx script.sh
 
## command return code

$? == 0 ok
$? != 0 ko

## logical operators

### AND &&
if left part is OK

    ls && echo "ls done"
 
### OR ||
if left part fails

    ls -l inexistant || echo "inexistant file does not exist"

### Together
concatenate if exists,else copy
    
    ls -l mypasswd && cat /etc/passwd >> mypasswd || cp /etc/passwd mypasswd



    cut -d":" -f1,3 /etc/passwd | tr ':' ' ' > users-id


cat /etc/group | cut -d":" -f1,3 | sort | nl
cut -d: -f1,3 /etc/group|sort -t: -n -k2 | nl

## Terminal movement utilities

ctrl+a
ctrl+e
alt+d

## Vim

filetype  indent plugin on
gg=G => indent all file


## source VS ./
source script: execute in current shell
./script: execute in a child shell

## nohut
run a script whithout deconnexion
nohup ./script.sh &


## exec command
exec date
print date and kill exit current process


## signals

* ctrl + c: 
* ctrl + z:
* ctrl + d:
When killing a parent process with child process, children are adopted by systemd PID #1.
example
eyes &
ctrl+d
ps aux
eyes has PPID=1

## jobs command

### foreground + ctrl-c

	[formation@localhost ~]$ xeyes &
	[1] 19078
	[formation@localhost ~]$ jobs
	[1]+  En cours d'exécution   xeyes &
	[formation@localhost ~]$ fg %1
	xeyes
	^C
	[formation@localhost ~]$ 

### kill it

	[formation@localhost ~]$ xeyes &
	[1] 19207
	[formation@localhost ~]$ kill %1
	[1]+  Complété              xeyes

## trap

	[root@localhost ~]# trap -l
	 1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
	 6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
	11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
	16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
	21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
	26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
	31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
	38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
	43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
	48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
	53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
	58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
	63) SIGRTMAX-1	64) SIGRTMAX	


## Loop

### sequence command
    seq 5
    1
    2
    3
    4
    5

    for i in $(seq 5); do echo $i; done

## Return code

$?
value ok: 0

shift: process & remove first value of array parameter
shift.sh 

    #!/bin/bash
    while test $# -ne 0
    do
        echo "current paramater: $1 - nb remaning paramter "$#
        shift 1
    done


bash shift.sh aa bb cc

    current paramater: aa - nb remaning paramter 3
    current paramater: bb - nb remaning paramter 2
    current paramater: cc - nb remaning paramter 1



##arithmetic expression : (( expr ))
    
    echo $(( 2+2+6+6 ))
    16

    ((i=i+1))

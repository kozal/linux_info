# linux

## Distributions

linux distribution
: put togather some sw in ana installation disk

- Red Hat and Family
  - CentOS
  - Fedora
- Ubuntu and Family
  - Linux Mint
  - Debian
- SUSE and Family
  - Suse Leap

Red Hat: Licensed to enterprices and helped to
CentOS: License free Red Hat. Spin off of Red Hat
Fedora: Develop and bring sw. Red Hat is developed

Ubuntu: strong in end user and education. good UI and driver support
Mint: Spin off of Ubuntu
Debian: where Ubuntu is coming from

SUSE: Like Red Hat, automovie, health organisations

Kali: Specialized linux distribution focused on security

Android: a Linux distribution

Unix: an OS invented in early 1970s. 1992 Linus Torv. started project to provide free Unix.

Most companies convert Unix to Linux

sda: squsy? device a

in ubuntu root is disabled. with sudo, an ordinary account can have administrative privileges

## connect linux

1. GUI login
2. Console login
3. SSH: secure shell connect linux remotely. like telnet but secure

## User Space vs Kernel Space

User space: No direct access to HW. Users live here.

Kernel space: Direct access to HW with no limitation via modules (drivers). User root lives in Kernel space

sudo: "super user do". user is getting administrative privileges.

permissions: helps user to deal with files in HW. user can access eg: `/dev/sda`

syscall: to expose specific functionality to user

## hede

terminal: command line interface

in UBuntu, the first user is Admin.

```bash
# login as root in ubuntu with user pass
$ sudo -i
# in centOS with root pass
$ su -
```

Make a user admin:

```bash
root@AOK-T480:~# id omer
uid=1000(omer) gid=1000(omer) groups=1000(omer),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),113(lpadmin),128(sambashare),999(docker)
# add user to group wheel
root@AOK-T480:~# usermod -aG whell omer
```

```bash
# reveal current ip configuration
$ ip a
```

## ssh

not every distro allows ssh by default.

```bash
# connect with ssh
$ ssh omer@192.168.1.2
```

create public private key
```bash
$ ssh-keygen
$ ssh-copy-id omer@192.168.1.111
$ ssh omer@192.168.1.111
# -X command option is about GUI. forwarding GUI to local from remote
$ ssh omer@192.168.1.111 -X
```

## file system

In Linux everything is a file.

root filesystem directory structure comes from linux foundation

```bash
$ cd /
$ ls
bin boot dev etc home lib proc var ...
# info about files hierarchy
$ main hier
```

boot
: grub -> bootloader
vmlinuz... -> linux kernek

/etc
: for text based configuration files. not binary db giles like reg in win

/var
: normally filled automatically by processes. /var/log systemlogs

/dev
: devices. hw is addressed as 

/proc
: info about

book: beginning linux command line

## vi

nano is not always installed

```bash
vimtutor
```

vim is more enhanced then vi, vim: vi improved

1. every linux system is vi installed
2. 3

- Insert mode: i
- Command mode: Esc
- :wq! write, quit, dont ask anything
- :q! quit with no questions
- u undo
- dd delete this line
- gg top of doc
- GG bottom of doc
- / search
- n next in search
- N previous in search

## Commands

- Commands are interpreted by bash shell
- Case matters

### history

repeat command

```bash
$ history
# repeat 38th command
$ !38
# repeat last command
$ !!
```

search in history

```bash
$ history | grep -i ifconfig
```

history is kept in `.bash_history`

### man

`command --help`
`man -k`

man is compatible for the distro you are using, google may not.

```bash
# all document
$ man useradd
# shorter
$ useradd --help
```

```bash
$ man -k
```

```bash
$ man man
1   Executable programs or shell commands
2   System calls (functions provided by the kernel)
3   Library calls (functions within program libraries)
4   Special files (usually found in /dev)
5   File formats and conventions eg /etc/passwd
6   Games
7   Miscellaneous   (including  macro  packages  and  conventions),  e.g.  man(7), groff(7)
8   System administration commands (usually only for root)
9   Kernel routines [Non standard]

$ man -k user | grep 1
```

## Users

### Permissions

based on ownership

every linux file has user owner and group owner and others

- first check, are you the owner?
- second, are you in the same group of other
- third you are others

```bash
$ ls -lF /etc/passwd
-rw-r--r-- 1 root root 2330 Kas 12 20:33 /etc/passwd
```

#### basic permissions r,w,x

on directory is obvious
on directory, x: you can use cd, r: you can ls, w: you can add delete file

#### change permissions

```bash
chmod g+w sales
chmod o-rx sales
chmod 770 sales
```

```bash
# login as linda
$ su - linda
```

## network operations

```bash
$ ip route show
$ ping 8.8.8.8
```

## installing sw

repos are created by linux distros

ubuntu: `apt`

search package:
```bash
$ apt search nmap
```

## process managament

```bash
$ top
```

`apt` is newer version of `apt-get`
`ip` is newer version of `ifconfig`

clear: ctrl+l

# Ubuntu notes

## path

```bash
$ echo $PATH
# from alias
$ path

# add to end of PATH
$ export PATH=$PATH:directory
```

## shell environment

A **login shell** session is one in which we are prompted for our user name and password; when we start a virtual console session.

| File            | Contents                                                                                                                                                       |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| /etc/profile    | A global configuration script that applies to all users.<br> *employs /etc/bash.bashrc and files in /etc/profile.d*                                            |
| ~/.bash_profile | A user's personal startup file.<br> Can be used to extend or override settings in the global configuration script.                                             |
| ~/.bash_login   | If ~/.bash_profile is not found, bash attempts to read this script.                                                                                            |
| ~/.profile      | If neither ~/.bash_profile nor ~/.bash_login is found, bash attempts to read this file.<br> This is the default in Debian-based distributions, such as Ubuntu. |

A **non-login shell** session typically occurs when we launch a terminal session in the GUI.

non-login shells also inherit the environment from their parent process

| File             | Contents                                                                                                           |
| ---------------- | ------------------------------------------------------------------------------------------------------------------ |
| /etc/bash.bashrc | A global configuration script that applies to all users.                                                           |
| ~/.bashrc        | A user's personal startup file.<br> Can be used to extend or override settings in the global configuration script. |

~/.bashrc
: almost always read. Non-login shells read it by default and most startup files for login shells are written to read the ~/.bashrc file as well.

## date time

```bash
$ date
Sal Kas 20 15:04:18 +03 2018
# custom format
$ date +"%A, %B %-d, %Y"
Salı, Kasım 20, 2018
# for back-up
$ date +%Y%m%d
20181211
```

### correcting time

```bash
sudo timedatectl set-timezone UTC
```

## view kernel messages

```bash
$ dmesg
```

## remove non-empty dir

```bash
$ rm -rf mydir
```

## set ip

set ip address to a specific interface

```bash
$ sudo ifconfig enp0s31f6 down
$ sudo ifconfig enp0s31f6 up
$ sudo ifconfig enp0s31f6 192.168.2.2
```

## ping

ping from specific interface

```bash
$ ping -I enp0s31f6 192.168.2.1
```

## rooting

```bash
# view routing table
$ route -n
$ netstat -rn

# add routing
$ route add -net <network_address> gw <gateway> <interface_name>
```

## tree

`tree -L 2 -u -g -p -d`

Prints the directory tree in a pretty format up to depth 2 (-L 2). Print user (-u) and group (-g) and permissions (-p). Print only directories (-d).

```bash
# depth 1
$ tree -L 1
.
├── file_1
├── file_2
├── dir_1
└── file_n
# depth 2, only directories
$ tree /etc -L 2 -d
/etc
├── acpi
│   └── events
├── alternatives
└── led
    └── led2
```

## ls

`ls` is `ls .` lists files in current dir.

`ls -d` is `ls -d .`. Only to confirm if a directory exists (`.` in this case). It does not lists the subdirs.

```bash
# list one file per line
$ ls -1 /usr/
bin
games
include

# List directories only
$ ls -d */
# List with long format
$ ls -l
# Show all files (hidden)
$ ls -a
# Show all files excluding current dir '.' and parent dir '..'
$ ls -A
# list long format with readable file size
$ ls -lh
# add an info char to end / to dirs, * to exec ...
$ ls -lF
# confirm file and diectory exists
$ ls Makefile
Makefile
$ ls -d /opt
/opt
# find home dir of any user eg:root
$ ls -d ~root
```

## cp

`-R`, `--recursive`
: copy directories recursively

Copy contents of one directory to another existing dir 
- including hidden files and folders, excluding directory itself (with use of `.`)
- excluding hidden files and folders and directory itself (with use of `*`)

```bash
# including hidden files and folders
$ cp -R f1/. f2/
# excluding hidden files and folders
$ cp -R f1/* f5/
```

Copy one directory into another existing dir including hidden files and folders

```bash
$ cp -R f1 f3
```

`-u`, `--update`
: copy only when the SOURCE file is newer than the destination file or when the destination file is missing.

`-v`, `--verbose`
: explain what is being done

```bash
# sync two folders:
$ cp -r -u -v <source_folder> <dest_folder>
```

`-s`, `--symbolic-link`
: make symbolic links instead of copying

## mkdir

```bash
$ mkdir newdir/newdir2 -p
```

## top

display Linux processes

- help: `h` or `?`
- quit: `q`
- Refresh-Display: `Enter` or `Space`
- Change-Delay-Time-interval: `d` or `s`
- Sort by:
  - %MEM: `M`
  - PID: `N`
  - %CPU: `P`
  - TIME+: `T`
- Reverse/Normal-Sort-Field toggle: `R`

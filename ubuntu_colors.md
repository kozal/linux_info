# Ubuntu Colors

## LS Color with dircolor

view the lines in `~/.bashrc`

```bash
$ cat .bashrc | grep "dircolors" -C 3
```

```bash
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
```

checks with `test` if `~/.dircolors` file exists.
if exists, evaluates `dircolors -b ~/.dircolors`, meaning: read `dircolors` `~/.dircolors` file.
if not exists, evaluates `dircolors -b`, meaning: load default `dircolors`

so we can fill `~/.dircolors` as we want to change `ls` colors. but when we do that like:

```bash
LS_COLORS="ow=01;34"
```

and source it, it gives error

```bash
# source .bashrc
$ source ~/.bashrc
invalid line; missing second token
# or read dircolors from .dircolors
$ dircolors -b ~/.dircolors
invalid line; missing second token
```

instead we first fill the `~/.dircolors` with default `dircolors` by

```bash
$ dircolors -p > .dircolors
```

then in `~/.dircolors` change line

```bash
#OTHER_WRITABLE 34;42 # dir that is other-writable (o+w) and not sticky
OTHER_WRITABLE 01;34 # dir that is other-writable (o+w) and not sticky
```

## PS1  (Prompt String 1)

in `~/.bashrc` change

```bash
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
```

to

```bash
Color_Off="\[\033[0m\]"       # Text Reset
BYellow="\[\033[1;33m\]"      # Yellow
BGreen="\[\033[1;32m\]"       # Green
BIYellow="\[\033[1;93m\]"     # Yellow
IYellow="\[\033[0;93m\]"      # Yellow
Time24hm="\A"                 # 24-hour HH:MM

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="\[\033]0;\w\007\]";            # header of window
    PS1+="${Color_Off}\n";              # newline
    PS1+="${IYellow}omer";              # user name
    PS1+="${Color_Off}@${Time24hm} ";   # time
    PS1+="${Color_Off}in ";
    PS1+="${BGreen}\W";                 # working dir
    PS1+="${Color_Off}\n\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
```

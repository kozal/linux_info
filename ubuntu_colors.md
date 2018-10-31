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

## PS1 (Prompt String 1)

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
Red="\[\033[0;31m\]"          # Red
BRed="\[\033[1;31m\]"         # Red
Yellow="\[\033[0;33m\]"       # Yellow
BYellow="\[\033[1;33m\]"      # Yellow
Green="\[\033[0;32m\]"        # Green
BGreen="\[\033[1;32m\]"       # Green
Cyan="\[\033[0;36m\]"         # Cyan
BCyan="\[\033[1;36m\]"        # Cyan

Time24hm="\A"                 # 24-hour HH:MM

parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='${debian_chroot:+($debian_chroot)}'
    PS1+="\[\033]0;\w\007\]";           # header of window
    PS1+="${Color_Off}\n";              # newline
    PS1+="${Yellow}\u";                 # user name
    PS1+="${Color_Off}@${Time24hm} ";   # time
    PS1+="${Color_Off}in ";
    PS1+="${Cyan}\w";                   # working dir all
    #PS1+="${BGreen}\W";                # working dir base
    PS1+="${Red} \$(parse_git_branch)" # git branch
    PS1+="${Color_Off}\n\$ "            # next line and prompt sign
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
```

not sure if `PS1='${debian_chroot:+($debian_chroot)}'` is needed.

if you forget to put `\` backslash before the `$(parse_git_branch)`, it will be evaluated only once and wotn be updated.

## Git configuration

To deal with line endings:
Linux should be enough.

File has CRLF line-ends in windows, LF in Unix.

```bash
# On Linux:
$ git config --global core.autocrlf input
# On Windows:
$ git config --global core.autocrlf true
```

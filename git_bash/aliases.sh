# Some good standards, which are not used if the user
# creates his/her own .bashrc/.bash_profile

# --show-control-chars: help showing Korean or accented characters
alias ls='ls -F --color=auto --show-control-chars'
alias ll='ls -l'

case "$TERM" in
xterm*)
    # The following programs are known to require a Win32 Console
    # for interactive usage, therefore let's launch them through winpty
    # when run inside `mintty`.
    for name in node ipython php php5 psql python2.7
    do
        case "$(type -p "$name".exe 2>/dev/null)" in
        ''|/usr/bin/*) continue;;
        esac
        alias $name="winpty $name.exe"
    done
    ;;
esac

# some more ls aliases
alias ll='ls -hAlF'  # long excluding . ..
alias la='ls -halF'  # long all
alias l='ls -lF'    # long
alias lsd="ll | grep --color=never '^d'" # only directories
alias lsd='ls -d */' # only directories

# enable color for commands
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
	
# directory shortcuts
alias desk='cd /c/Users/omer/Desktop'
alias down='cd /c/Users/omer/Downloads'
alias home='cd /etc/profile.d'
# alias gitdir='cd /d/GitHub'

# commands
# alias c='clear'
alias expl='explorer.exe .'
alias path='echo -e ${PATH//:/\\n}'
# alias ffmpeg='ffmpeg -hide_banner'
# alias ffprobe='ffprobe -hide_banner'
# make commands
alias make='mingw32-make'
alias mka="make all"
alias mkc="make clean"
alias mkr="make run"
alias mkar="make all && clear && make run"

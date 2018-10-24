if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# High Intensity
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensity
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensity backgrounds
On_IBlack="\[\033[0;100m\]"   # Gray
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White


# Various variables you might want for your PS1 prompt instead
Time12h="\T"				  # 12-hour HH:MM:SS
Time12a="\@"				  # 12-hour am/pm
Time24hms="\t"				  # 24-hour HH:MM:SS
Time24hm="\A"				  # 24-hour HH:MM
dateWMD=\d					  # the  date  in "Weekday Month Date"
PathDir="\w"				  # cwd
PathBase="\W"				  # basename of working dir
NewLine="\n"
Jobs="\j"					  # num jobs
user="\u"					  # username
cons_n="\l"     			  # the basename of the shell's terminal
shell_n="\s"     			  # the name of the shell

if test -f ~/.config/git/git-prompt.sh
then
	. ~/.config/git/git-prompt.sh
else
	# PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
	# PS1="$PS1"'\n'                 # new line
	# PS1="$PS1"'\[\033[32m\]'       # change to green
	# PS1="$PS1"'\u@\h '             # user@host<space>
	# PS1="$PS1"'omer '    			 # user@host<space>
	# PS1="$PS1"'\[\033[35m\]'       # change to purple
	# PS1="$PS1"'$MSYSTEM '          # show MSYSTEM
	# PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
	# PS1="$PS1"'\w'                 # current working directory
    PS1="\[\033]0;\w\007\]";        # header of window
    PS1+="${Color_Off}\n";          # newline
    PS1+="${BYellow}omer";          # user name
    PS1+="${Color_Off}@${Time24hm} ";	# time
    # PS1+="${BPurple}\H ";         # host
    PS1+="${Color_Off}in ";
    # PS1+="${BGreen}\w"; 			# working dir
    PS1+="${BGreen}\W";             # working dir
	if test -z "$WINELOADERNOEXEC"
	then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"
		then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			PS1="$PS1"'\[\033[36m\]'  # change color to cyan
			PS1="$PS1"'`__git_ps1`'   # bash function
		fi
	fi
	# PS1="$PS1"'\[\033[0m\]'        # change color
	# PS1="$PS1"'\n'                 # new line
	# PS1="$PS1"'$ '                 # prompt: always $
	PS1+="${Color_Off}\n\$ "
fi

MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc

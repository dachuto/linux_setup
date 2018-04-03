strUTF8Len () { # unused
	local save_LANG=$LANG
	local save_LC_ALL=$LC_ALL
	LANG=C
	LC_ALL=C
	local bytlen=${#1}
	LANG=${save_LANG}
	LC_ALL=${save_LC_ALL}
	echo ${bytlen}
}

RESET=$(tput sgr0)
BOLD=$(tput bold)
RED=$(tput setaf 1)
WHITE=$(tput setaf 7)
DARK_GREY=$(tput setaf 8)
GREEN=$(tput setaf 10)
NICE_BLUE=$(tput setaf 12)

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="verbose"
GIT_PS1_DESCRIBE_STYLE="branch"

PS1_GIT_INFO=''
PS1_EXIT_COLOR=''
PS1_EXIT_STATUS=''
PS1_TIME_DATE=''

__prompt_command() {
	local EXIT_STATUS="$?" # This needs to be first!
	PS1_GIT_INFO=$(__git_ps1)
	if [ ${EXIT_STATUS} == 0 ]; then
		PS1_EXIT_COLOR="${GREEN}"
		PS1_EXIT_STATUS='✔'
	else
		PS1_EXIT_COLOR="${RED}"
		PS1_EXIT_STATUS='✖'
	fi
	PS1_TIME_DATE=$(date '+%X %d/%m')
}

PS1='\[${BOLD}\] \[${PS1_EXIT_COLOR}\]${PS1_EXIT_STATUS} \[${NICE_BLUE}\]${PS1_TIME_DATE} \[${WHITE}\]\u \[${DARK_GREY}\]@\H \[${GREEN}\]${PS1_GIT_INFO} \[${NICE_BLUE}\]\w \[${DARK_GREY}\]# \[${RESET}\]'
PROMPT_COMMAND=__prompt_command
PROMPT_COMMAND="${PROMPT_COMMAND}; history -a"

set_terminal_title() {
	echo -ne "\e]0;${1}\a"
}

[[ ${WORKSPACE_TAB_DIR} ]] && cd ${WORKSPACE_TAB_DIR}
[[ ${WORKSPACE_TAB_HISTFILE} ]] && HISTFILE=${WORKSPACE_TAB_HISTFILE}
[[ ${WORKSPACE_TAB_TITLE} ]] && set_terminal_title ${WORKSPACE_TAB_TITLE}

# history and directories related stuff
shopt -s histappend
HISTCONTROL=ignoreboth
HISTFILESIZE=100000
HISTSIZE=100000

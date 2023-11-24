# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# CUSTOM START

shopt -s cmdhist
shopt -s nocaseglob
shopt -s autocd
shopt -s globstar

bind -x '"\C-e":"ls"'
bind '"\C-n":"\C-kcd ..\C-m"'

HISTCONTROL="erasedups:ignoreboth"
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

export ANDROID_HOME=/home/user/.android
export HISTFILE=/home/user/.cache/bash/bash_history
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/11.0/bin
export LESS="-g -i -R -S -z-4 -F -K -r --use-color -x4"

alias up="f DNF && sudo dnf distro-sync -y && f Flatpak && flatpak update -y && f fwupd && sudo fwupdmgr update -y"
alias ls="ls --color=always -XNAh --group-directories-first --time-style=+'%d.%m.%Y %H:%M'"
alias diff="git -P diff --color=always -U0"
alias grep="grep --color=always -i"
alias dmesg="dmesg --color=always"
alias ip="ip -color=always"
alias mkdir="mkdir -p"
alias unzip="unzip -q"
alias free="free -m"
alias zip="zip -rq"
alias sudo="sudo "
alias rm="rm -rf"
alias cp="cp -ri"
alias df="df -h"
alias dnf="dnf5"

nnn() {
	export NNN_TRASH=2
	export NNN_TMPFILE="/home/user/.config/nnn/.lastd"
	command nnn "$@"
	. "$NNN_TMPFILE"
}

f() {
	echo $''$3$'\e[2;'$C$'m'$2$'['$3$'\e[m'$2$''$3$'\e[1;'$C$'m'$2$''$1$''$3$'\e[m'$2$''$3$'\e[2;'$C$'m'$2$']'$3$'\e[m'$2$' '
}
B=(92 93 94 96 91 95)
if [[ $(who am i) =~ \([-a-zA-Z0-9\.]+\)$ ]]; then
	export C=${B[5]}
elif [ $USER == "root" ]; then
	export C=${B[4]}
else
	C=${B[RANDOM%4]}
fi
PS1=$(f "\w" "\]" "\[")
PS2=$(f ">" "\]" "\[")
export SUDO_PROMPT=$(f "p")

# CUSTOM END

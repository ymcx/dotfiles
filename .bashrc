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

export NNN_TRASH=2
export ANDROID_HOME=/home/user/.android
export HISTFILE=/home/user/.cache/bash/bash_history
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/11.0/bin
export LESS="-g -i -R -S -z-4 -F -K -r --use-color -x4"
export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json

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

alias va="NVIM_APPNAME=nvim-chad nvim"
alias vs="NVIM_APPNAME=nvim-astr nvim"
alias vh="NVIM_APPNAME=nvim-lazy nvim"
alias vt="lvim"
alias vg="nvim"

nnn ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}

# CUSTOM END

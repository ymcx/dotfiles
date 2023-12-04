bind \cx "cd ..; commandline -f repaint"
bind \cs "ls; commandline -f repaint"

if test -n (echo (who am i))
    set prompt_color $fish_color_error
else
    set prompt_color $fish_color_command
end

set -Ux EDITOR hx
set -Ux NNN_TRASH 2
set -Ux fish_greeting
set -Ux ANDROID_HOME $HOME/.android
set -Ux NNN_TMPFILE /home/user/.config/nnn/.lastd

alias up="echo '> DNF' && sudo dnf distro-sync -y && echo '> Flatpak' && flatpak update -y && echo '> fwupd' && sudo fwupdmgr update -y"
alias ls="ls --color=always -XNAh --group-directories-first --time-style=+'%d.%m.%Y %R'"
alias grep="grep --color=always -i"
alias ip="ip -color=always"
alias mkdir="mkdir -p"
alias unzip="unzip -q"
alias free="free -m"
alias zip="zip -rq"
alias rm="rm -rf"
alias cp="cp -r"
alias df="df -h"
alias dnf="dnf5"

function fish_title
    echo [(prompt_pwd)]"                    "
end

function fish_prompt
    printf "%s>%s " (set_color -o $prompt_color) (set_color normal)
end

function nnn
    command nnn $argv
    . "$NNN_TMPFILE"
end

function sudo
    if functions -q -- $argv[1]
        set -l new_args (string join " " -- (string escape -- $argv))
        set argv fish -c "$new_args"
    end
    command sudo $argv
end

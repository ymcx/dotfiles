bind \cs "echo && ls; commandline -f repaint"
bind \cx "cd ..; commandline -f repaint"
bind \r "save_cursor_and_exec"
bind \cr "restore_cursor"

if test -n (echo (who am i))
    set prompt_color $fish_color_error
else
    set prompt_color $fish_color_command
end

alias up="echo '> DNF' && sudo dnf distro-sync -y && sudo dnf autoremove -y && echo '> Flatpak' && flatpak update -y && echo '> fwupd' && sudo fwupdmgr update -y"
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
    string join "" (prompt_pwd) (string repeat -n 1000 " ")
end

function fish_prompt
    printf "%s⟪%s⟫%s " (set_color $prompt_color -o) (prompt_pwd) (set_color normal)
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

function save_cursor_and_exec
    set -g SAVED_CURSOR (commandline --cursor)
    commandline -f execute
end

function restore_cursor
    commandline --cursor $SAVED_CURSOR
end

bind \cs "echo && ls; commandline -f repaint"
bind \cx "echo && cd ..; commandline -f repaint"

if test -n (echo (who am i))
    set prompt_color $fish_color_error
else
    set prompt_color $fish_color_command
end

alias mkdir="mkdir -p"
alias unzip="unzip -q"
alias zip="zip -rq"
alias diff="delta"
alias rm="rm -rf"
alias cp="cp -r"
alias ip="ip -c"
alias dnf="dnf5"
alias cat="bat"
alias vi="nvim"
alias ls="eza"

function fish_title
    echo (prompt_pwd) (string repeat -n 830 " ")
end

function fish_prompt
    printf "%s[%s]%s " (set_color $prompt_color -o) (prompt_pwd) (set_color normal)
end

function nnn
    command nnn $argv
    . $NNN_TMPFILE
end

function sudo
    if functions -q -- $argv[1]
        set -l new_args (string join " " -- (string escape -- $argv))
        set argv fish -c "$new_args"
    end
    command sudo $argv
end

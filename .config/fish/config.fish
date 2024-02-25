bind \cs "echo && ls   ; commandline -f repaint"
bind \ca "echo && ls -l; commandline -f repaint"
bind \cx "cd ..        ; commandline -f repaint"

if set -q SSH_TTY
  set fish_color_prompt $fish_color_cwd_root
else
  set fish_color_prompt $fish_color_cwd
end

function fish_prompt
  printf "%s[%s]%s " (set_color $fish_color_prompt) (prompt_pwd) (set_color normal)
end

function sudo
  if functions -q -- $argv[1]
    set argv fish -c "$argv"
  end
  command sudo $argv
end


alias ls="eza --group-directories-first --time-style=+'%d.%m.%Y %R' -a --octal-permissions"
alias wake="sudo ether-wake 74:56:3c:23:a0:86"
alias ips="sh ~/.config/hypr/script.sh ips"
alias vm="sh ~/.config/hypr/script.sh vm"
alias open="gio open > /dev/null"
alias trash="gio trash"
alias mkdir="mkdir -p"
alias unzip="unzip -q"
alias zip="zip -rq"
alias rm="rm -rf"
alias cp="cp -r"
alias ip="ip -c"
alias top="btop"
alias cat="bat"
alias grep="rg"
alias vi="$EDITOR"

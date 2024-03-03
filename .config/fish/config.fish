bind \cs "echo && ls   ; commandline -f repaint"
bind \ca "echo && ls -l; commandline -f repaint"
bind \cx "cd ..        ; commandline -f repaint"
bind \cz "cd -         ; commandline -f repaint"

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

alias do="sh ~/.config/hypr/script.sh"

alias mkdir="mkdir -p"
alias unzip="unzip -q"
alias zip="zip -rq"
alias rm="rm -rf"
alias cp="cp -r"

alias ls="eza --group-directories-first --time-style=+'%d.%m.%Y %R' -a --octal-permissions"
alias cat="bat"
alias grep="rg"
alias vi="hx"

zoxide init --cmd cd fish | source

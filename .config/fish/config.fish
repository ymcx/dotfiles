bind \cs "echo && ls; commandline -f repaint"
bind \cx "cd ..; commandline -f repaint"

if set -q SSH_TTY
  set fish_color_prompt $fish_color_cwd_root
else
  set fish_color_prompt $fish_color_cwd
end

function findaddr
  set ip (hostname -I | awk '{print $1}' | cut -d "." -f 4)
  for i in (seq 101 109 | grep -v $ip)
    ping -c 1 -W 0.02 -q -s 1 192.168.8."$i" | awk '/ 0% / {print a} {a = $2}'
  end
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

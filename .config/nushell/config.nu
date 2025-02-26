def --wrapped hx [...i] {
  let scheme = (gsettings get org.gnome.desktop.interface color-scheme)
  if $scheme == "'default'" {
    ^hx -c ~/.config/helix/config-light.toml ...$i
  } else {
    ^hx ...$i
  }
}

let completer = {|i|
  fish -c $'complete -C "($i | str join " " | str replace (char dq) \(char dq))"'
  | from tsv --flexible --noheaders --no-infer --trim all
  | rename value description
}

$env.config.use_kitty_protocol = true
$env.config.show_banner = false
$env.config.table.trim.methodology = "truncating"
$env.config.table.trim.truncating_suffix = "..."
$env.config.history.file_format = "sqlite"
$env.config.history.isolation = true
$env.config.footer_mode = "never"
$env.config.highlight_resolved_externals = true
$env.config.completions.external.completer = $completer

alias diff = diff --color=always
alias ls = ls -a
alias cp = cp -r
alias rm = rm -r

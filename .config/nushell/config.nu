$env.config.use_kitty_protocol = true
$env.config.show_banner = false
$env.config.table.trim.methodology = "truncating"
$env.config.table.trim.truncating_suffix = "..."
$env.config.datetime_format.table = "%d/%m/%y %H:%M"
$env.config.filesize.format = "b"
$env.config.history.file_format = "sqlite"
$env.config.history.isolation = true
$env.config.footer_mode = "never"
$env.config.highlight_resolved_externals = true

alias ls = ls -a
alias cp = cp -r
alias rm = rm -r

def --wrapped disown [...args] {
  sh -c "$@ 1>/dev/null 2>/dev/null &" "" ...$args
}

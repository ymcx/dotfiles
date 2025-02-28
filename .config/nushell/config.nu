def update-theme [] {
  let theme = if (gsettings get org.gnome.desktop.interface color-scheme) == "'default'" {
    "nord_light"
  } else {
    "nord"
  }
  $'inherits = "($theme)"' | save -f ~/.config/helix/themes/nord.toml
}

$env.config.use_kitty_protocol = true
$env.config.show_banner = false
$env.config.table.trim.methodology = "truncating"
$env.config.table.trim.truncating_suffix = "..."
$env.config.history.file_format = "sqlite"
$env.config.history.isolation = true
$env.config.footer_mode = "never"

alias diff = diff --color=always
alias ls = ls -a
alias cp = cp -r
alias rm = rm -r

update-theme

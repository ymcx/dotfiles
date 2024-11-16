$env.config = {
    use_kitty_protocol: true
    show_banner: false
    table: {
        trim: {
            methodology: truncating
            truncating_suffix: "..."
        }
    }
    datetime_format: {
        table: "%d/%m/%y %H:%M"
    }
    filesize: {
        format: "b"
    }
    history: {
        file_format: "sqlite"
        isolation: true
    }
    footer_mode: "never"
    highlight_resolved_externals: true
}

alias diff = diff --color=always
alias zip = ^zip -r
alias ls = ls -as
alias cp = cp -r
alias rm = rm -r

def --wrapped disown [...args] {
  sh -c '"$@" >/dev/null 2>&1 &' $args.0 ...$args
}

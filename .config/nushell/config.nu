$env.config = {
    shell_integration: {
        osc2: true
        osc7: true
    }
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
alias ls = ls -a
alias cp = cp -r
alias rm = rm -r

$env.config = {
    shell_integration: {
        osc2: true
        osc7: true
        osc8: true
        osc133: true
    }
    use_kitty_protocol: true
    show_banner: false
    table: {
        show_empty: false
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
    cursor_shape: {
        emacs: block
        vi_insert: block
        vi_normal: block
    }
    history: {
        file_format: "sqlite"
        isolation: true
    }
    footer_mode: "never"
    highlight_resolved_externals: true
}

alias diff = diff --color
alias ls = ls -a
alias cp = cp -r
alias rm = rm -r

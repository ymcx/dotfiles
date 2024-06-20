$env.config = {
    shell_integration: {
        osc2: true
        osc7: true
        osc8: true
        osc9_9: true
        osc133: true
        osc633: true
        reset_application_mode: true
    }
    show_banner: false
    table: {
        index_mode: never
        show_empty: false
        trim: {
            methodology: truncating
        }
        header_on_separator: true
    }
    datetime_format: {
        normal: "%d.%m.%y %H:%M"
        table:  "%d.%m.%y %H:%M"
    }
    filesize: {
        metric: true
        format: "b"
    }
    cursor_shape: {
        emacs: line
        vi_insert: line
        vi_normal: block
    }
    history: {
        file_format: "sqlite"
        isolation: true
    }
    footer_mode: "never"
    use_kitty_protocol: true
    highlight_resolved_externals: true
    completions: {
        external: {
            completer: {|spans|
                fish --command $'complete "--do-complete=($spans | str join " ")"'
                | $"value(char tab)description(char newline)" + $in
                | from tsv --flexible --no-infer
            }
        }
    }
}

alias diff = diff --color
alias ls = ls -a
alias cp = cp -r
alias rm = rm -r

use task.nu

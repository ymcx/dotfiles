$env.config = {
    shell_integration: {
        osc2: true
        osc7: true
        osc8: true
        osc9_9: false
        osc133: true
        osc633: false
        reset_application_mode: true
    }
    use_kitty_protocol: true
    show_banner: false
    table: {
        trim: {
            methodology: truncating
            truncating_suffix: "..."
        }
    }
    completions: {
        external: {
            completer: {|spans|
                fish -c $'complete "-C ($spans | str join " ")"'
                | "value\tdescription\n" + $in
                | from tsv --flexible --no-infer --trim all
            }
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

alias play = nu ~/.config/scripts/play.nu
alias view = nu ~/.config/scripts/view.nu
alias disown = nu ~/.config/scripts/disown.nu
alias ffplay = ffplay -nodisp -autoexit -v warning
alias chafa = chafa --dither=diffusion
alias diff = diff --color=always
alias ls = ls -as
alias cp = cp -r
alias rm = rm -r

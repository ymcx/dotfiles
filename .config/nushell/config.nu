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
                carapace $spans.0 nushell ...$spans | from json
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

alias ffplay = ffplay -nodisp -autoexit -loglevel warning
alias ncplayer = ncplayer -q -s scalehi
alias diff = diff --color=always
alias ls = ls -as
alias cp = cp -r
alias rm = rm -r

def --wrapped disown [...args] {
    sh -c '"$@" >/dev/null 2>&1 &' $args.0 ...$args
}

def play [] {
    for $i in (ls | shuffle) {
        ffplay ($i | get name)
    }
}

def pdf [FILE: string] {
    let SUM = sha256sum $FILE | head -c 64
    pdftoppm -jpeg $FILE /tmp/($SUM)
    ncplayer /tmp/($SUM)*.jpg
}

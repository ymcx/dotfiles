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

alias ffplay = ffplay -nodisp -autoexit -v warning
alias chafa = chafa --dither=diffusion --fit-width
alias diff = diff --color=always
alias ls = ls -as
alias cp = cp -r
alias rm = rm -r

def --wrapped disown [...args] {
    sh -c '"$@" >/dev/null 2>&1 &' $args.0 ...$args
}

def "ffplay -all" [] {
    loop {
        for $i in (ls -m | where type =~ "audio" | get name | shuffle) {
            print -n ($i | str substring 0..70 | fill -w 71)
            print -n "\r"
            ffplay $i
        }
    }
}

def "chafa --pdf" [FILE: string] {
    let SUM = sha256sum $FILE | str substring 0..63
    if not ($"/tmp/($SUM)" | path exists) {
        mkdir $"/tmp/($SUM)"
        pdftoppm -jpeg $FILE /tmp/($SUM)/
    }
    chafa /tmp/($SUM)/*
}

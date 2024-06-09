$env.config = {
    show_banner: false
    table: {
        index_mode: never
        show_empty: false
        trim: {
            methodology: truncating
            truncating_suffix: "..."
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
}

alias google-chrome-stable = nu ~/.config/scripts/chrome.nu
alias google-chrome = google-chrome-stable
alias ls = ls -a
alias ll = ls -l
alias cp = cp -r
alias rm = rm -r

def vm [ACTION: string NAME: string ISO: string] {
    let CORES = nproc
    let MEMORY = awk '/MemTotal/ {printf "%.f", $2/2000}' /proc/meminfo
    match $ACTION {
        "create" => (virt-install --vcpus $CORES -n $NAME -r $MEMORY --cdrom $ISO --osinfo require=off --disk size=32,format=raw)
        "boot"   => (virt-install --vcpus $CORES -n $NAME -r $MEMORY --cdrom $ISO --osinfo require=off --disk none; virsh destroy $NAME; virsh undefine $NAME)
    }
}

def update [] {
    zellij -l ~/.config/zellij/update.kdl
}

def --wrapped ssh [...args] {
    printf '\e]11;#330c0c\e\'
    try {
        ^ssh ...$args
    }
    printf '\e]111\e\'
}

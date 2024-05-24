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
        "create" => (virt-install --vcpus $CORES -n $NAME -r $MEMORY --cdrom $ISO --osinfo require=off --disk size=64,format=raw)
        "boot"   => (virt-install --vcpus $CORES -n $NAME -r $MEMORY --cdrom $ISO --osinfo require=off --disk none; virsh destroy $NAME; virsh undefine $NAME)
    }
}

def update [] {
    zellij -l ~/.config/zellij/update.kdl
}

def ssh [...args: string] {
    printf '\033]11;#2e1d1d\007'
    try {
        ^ssh ...$args
    }
    printf '\033]11;#2d2a2e\007'
}

def run0 [...args: string] {
    printf '\033]11;#2e1d1d\007'
    try {
        ^run0 --background= ...$args
    }
    printf '\033]11;#2d2a2e\007'
}

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

def vm [ACTION: string ISO: string NAME?: string] {
    let CORES = nproc
    let MEMORY = awk '/MemTotal/ {printf "%.f", $2/2000}' /proc/meminfo
    match $ACTION {
        "create" => $"virt-install --connect qemu:///session --os-variant detect=off --virt-type kvm --arch x86_64 --machine q35 --name ($NAME) --boot uefi --cpu mode=maximum,topology.sockets=1,topology.cores=($CORES),topology.threads=1 --vcpus ($CORES) --memory ($MEMORY) --video virtio --graphics spice,listen=none --channel spicevmc --channel unix,target.type=virtio,target.name=org.qemu.guest_agent.0 --console pty,target.type=virtio --sound default --network type=default,model=virtio --controller type=virtio-serial --controller type=usb,model=none --controller type=scsi,model=virtio-scsi --noautoconsole --input type=keyboard,bus=virtio --input type=tablet,bus=virtio --rng /dev/urandom,model=virtio --disk path=/home/user/.local/share/gnome-boxes/images/($NAME).img,format=raw,bus=virtio,cache=writeback,size=64 --cdrom ($ISO)"
        "boot"   => $"qemu-system-x86_64 -cpu host -smp ($CORES) -m ($MEMORY) -vga qxl -machine type=q35,accel=kvm -enable-kvm -cdrom ($ISO)"
    }
}

def update [] {
    zellij -l ~/.config/zellij/update.kdl
}

def ssh [...args: string] {
    printf '\033]11;#2e2626\007'
    try {
        ^ssh ...$args
    }
    printf '\033]11;#2d2a2e\007'
}

def run0 [...args: string] {
    printf '\033]11;#2e2626\007'
    try {
        ^run0 --background= ...$args
    }
    printf '\033]11;#2d2a2e\007'
}

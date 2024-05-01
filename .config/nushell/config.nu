let monokai_pro = {
    separator: "white"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "green" attr: "b" }
    empty: "blue"
    bool: {|| if $in { "cyan" } else { "light_gray" } }
    int: "white"
    filesize: {|e|
        if $e == 0b {
            "white"
        } else if $e < 1kb {
            "cyan"
        } else if $e < 10kb {
            "green"
        } else if $e < 100kb {
            "yellow"
        } else if $e < 1000kb {
            "blue"
        } else {
            "red"
        }
    }
    duration: "white"
    date: {|| (date now) - $in |
        if $in < 1hr {
            "red"
        } else if $in < 24hr {
            "blue"
        } else if $in < 168hr {
            "yellow"
        } else if $in < 720hr {
            "green"
        } else if $in < 8640hr {
            "cyan"
        } else {
            "white"
        }
    }
    range: "white"
    float: "white"
    string: "white"
    nothing: "white"
    binary: "white"
    cellpath: "white"
    row_index: { fg: "green" attr: "b" }
    record: "white"
    list: "white"
    block: "white"
    hints: "dark_gray"
    search_result: { fg: "red" bg: "white" }
    shape_and: { fg: "purple" attr: "b" }
    shape_binary: { fg: "purple" attr: "b" }
    shape_block: { fg: "blue" attr: "b" }
    shape_bool: "cyan"
    shape_custom: "green"
    shape_datetime: { fg: "cyan" attr: "b" }
    shape_directory: "cyan"
    shape_external: "cyan"
    shape_externalarg: { fg: "green" attr: "b" }
    shape_filepath: "cyan"
    shape_flag: { fg: "blue" attr: "b" }
    shape_float: { fg: "purple" attr: "b" }
    shape_garbage: { fg: "white" bg: "red" attr: "b" }
    shape_globpattern: { fg: "cyan" attr: "b" }
    shape_int: { fg: "purple" attr: "b" }
    shape_internalcall: { fg: "cyan" attr: "b" }
    shape_list: { fg: "cyan" attr: "b" }
    shape_literal: "blue"
    shape_match_pattern: "green"
    shape_matching_brackets: { attr: "u" }
    shape_nothing: "cyan"
    shape_operator: "yellow"
    shape_or: { fg: "purple" attr: "b" }
    shape_pipe: { fg: "purple" attr: "b" }
    shape_range: { fg: "yellow" attr: "b" }
    shape_record: { fg: "cyan" attr: "b" }
    shape_ff6188irection: { fg: "purple" attr: "b" }
    shape_signature: { fg: "green" attr: "b" }
    shape_string: "green"
    shape_string_interpolation: { fg: "cyan" attr: "b" }
    shape_table: { fg: "blue" attr: "b" }
    shape_variable: "purple"
    background: "#2d2a2e"
    foreground: "white"
    cursor: "white"
}

$env.config = {
    show_banner: false
    table: {
        show_empty: false
        trim: {
            methodology: truncating
            truncating_suffix: ">"
        }
    }
    datetime_format: {
        normal: '%d.%m.%y %H:%M'
        table:  '%d.%m.%y %H:%M'
    }
    explore: {
        status_bar_background: { fg: "black" bg: "light_gray" }
        command_bar_text: { fg: "light_gray" }
        highlight: { fg: "black" bg: "yellow" }
        status: {
            error: { fg: "white" bg: "red" }
            warn: {}
            info: {}
        }
        table: {
            split_line: { fg: "dark_gray" }
            selected_cell: { bg: "light_blue" }
            selected_row: {}
            selected_column: {}
        }
    }
    history: {
        file_format: "sqlite"
        isolation: true
    }
    filesize: {
        metric: true
    }
    cursor_shape: {
        emacs: line
        vi_insert: line
        vi_normal: block
    }
    color_config: $monokai_pro
    footer_mode: "never"
    shell_integration: true
    use_kitty_protocol: true
    highlight_resolved_externals: true
    hooks: {
        display_output: "table -e"
    }
    menus: [
        {
            name: completion_menu
            only_buffer_difference: false
            marker: ""
            type: {
                layout: columnar
                columns: 6
                col_width: 1
                col_padding: 2
            }
            style: {
                text: green
                selected_text: { attr: r }
                description_text: yellow
                match_text: {}
                selected_match_text: { attr: r }
            }
        }
        {
            name: ide_completion_menu
            only_buffer_difference: false
            marker: ""
            type: {
                layout: ide
                min_completion_width: 0
                max_completion_width: 50
                max_completion_height: 10
                padding: 1
                border: true
                cursor_offset: -2
                description_mode: "prefer_right"
                min_description_width: 0
                max_description_width: 50
                max_description_height: 10
                description_offset: 0
                correct_cursor_pos: true
            }
            style: {
                text: green
                selected_text: { attr: r }
                description_text: yellow
                match_text: {}
                selected_match_text: { attr: r }
            }
        }
        {
            name: history_menu
            only_buffer_difference: false
            marker: ""
            type: {
                layout: list
                page_size: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
        {
            name: help_menu
            only_buffer_difference: false
            marker: ""
            type: {
                layout: description
                columns: 1
                col_width: 1
                col_padding: 0
                selection_rows: 1
                description_rows: 10
            }
            style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
            }
        }
    ]
    keybindings: [
        {
            name: completion_menu
            modifier: none
            keycode: tab
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menu name: completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
        }
        {
            name: ide_completion_menu
            modifier: control
            keycode: char_n
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menu name: ide_completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
        }
        {
            name: history_menu
            modifier: control
            keycode: char_r
            mode: [emacs, vi_insert, vi_normal]
            event: { send: menu name: history_menu }
        }
        {
            name: help_menu
            modifier: none
            keycode: f1
            mode: [emacs, vi_insert, vi_normal]
            event: { send: menu name: help_menu }
        }
        {
            name: completion_previous_menu
            modifier: shift
            keycode: backtab
            mode: [emacs, vi_normal, vi_insert]
            event: { send: menuprevious }
        }
        {
            name: next_page_menu
            modifier: control
            keycode: char_x
            mode: emacs
            event: { send: menupagenext }
        }
        {
            name: undo_or_previous_page_menu
            modifier: control
            keycode: char_z
            mode: emacs
            event: {
                until: [
                    { send: menupageprevious }
                    { edit: undo }
                ]
            }
        }
        {
            name: escape
            modifier: none
            keycode: escape
            mode: [emacs, vi_normal, vi_insert]
            event: { send: esc }
        }
        {
            name: cancel_command
            modifier: control
            keycode: char_c
            mode: [emacs, vi_normal, vi_insert]
            event: { send: ctrlc }
        }
        {
            name: quit_shell
            modifier: control
            keycode: char_d
            mode: [emacs, vi_normal, vi_insert]
            event: { send: ctrld }
        }
        {
            name: clear_screen
            modifier: control
            keycode: char_l
            mode: [emacs, vi_normal, vi_insert]
            event: { send: clearscreen }
        }
        {
            name: search_history
            modifier: control
            keycode: char_q
            mode: [emacs, vi_normal, vi_insert]
            event: { send: searchhistory }
        }
        {
            name: open_command_editor
            modifier: control
            keycode: char_o
            mode: [emacs, vi_normal, vi_insert]
            event: { send: openeditor }
        }
        {
            name: move_up
            modifier: none
            keycode: up
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: menuup }
                    { send: up }
                ]
            }
        }
        {
            name: move_down
            modifier: none
            keycode: down
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: menudown }
                    { send: down }
                ]
            }
        }
        {
            name: move_left
            modifier: none
            keycode: left
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: menuleft }
                    { send: left }
                ]
            }
        }
        {
            name: move_right_or_take_history_hint
            modifier: none
            keycode: right
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: historyhintcomplete }
                    { send: menuright }
                    { send: right }
                ]
            }
        }
        {
            name: move_one_word_left
            modifier: control
            keycode: left
            mode: [emacs, vi_normal, vi_insert]
            event: { edit: movewordleft }
        }
        {
            name: move_one_word_right_or_take_history_hint
            modifier: control
            keycode: right
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: historyhintwordcomplete }
                    { edit: movewordright }
                ]
            }
        }
        {
            name: move_to_line_start
            modifier: none
            keycode: home
            mode: [emacs, vi_normal, vi_insert]
            event: { edit: movetolinestart }
        }
        {
            name: move_to_line_start
            modifier: control
            keycode: char_a
            mode: [emacs, vi_normal, vi_insert]
            event: { edit: movetolinestart }
        }
        {
            name: move_to_line_end_or_take_history_hint
            modifier: none
            keycode: end
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: historyhintcomplete }
                    { edit: movetolineend }
                ]
            }
        }
        {
            name: move_to_line_end_or_take_history_hint
            modifier: control
            keycode: char_e
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: historyhintcomplete }
                    { edit: movetolineend }
                ]
            }
        }
        {
            name: move_to_line_start
            modifier: control
            keycode: home
            mode: [emacs, vi_normal, vi_insert]
            event: { edit: movetolinestart }
        }
        {
            name: move_to_line_end
            modifier: control
            keycode: end
            mode: [emacs, vi_normal, vi_insert]
            event: { edit: movetolineend }
        }
        {
            name: move_up
            modifier: control
            keycode: char_p
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: menuup }
                    { send: up }
                ]
            }
        }
        {
            name: move_down
            modifier: control
            keycode: char_t
            mode: [emacs, vi_normal, vi_insert]
            event: {
                until: [
                    { send: menudown }
                    { send: down }
                ]
            }
        }
        {
            name: delete_one_character_backward
            modifier: none
            keycode: backspace
            mode: [emacs, vi_insert]
            event: { edit: backspace }
        }
        {
            name: delete_one_word_backward
            modifier: control
            keycode: backspace
            mode: [emacs, vi_insert]
            event: { edit: backspaceword }
        }
        {
            name: delete_one_character_forward
            modifier: none
            keycode: delete
            mode: [emacs, vi_insert]
            event: { edit: delete }
        }
        {
            name: delete_one_character_forward
            modifier: control
            keycode: delete
            mode: [emacs, vi_insert]
            event: { edit: delete }
        }
        {
            name: delete_one_character_backward
            modifier: control
            keycode: char_h
            mode: [emacs, vi_insert]
            event: { edit: backspace }
        }
        {
            name: delete_one_word_backward
            modifier: control
            keycode: char_w
            mode: [emacs, vi_insert]
            event: { edit: backspaceword }
        }
        {
            name: move_left
            modifier: none
            keycode: backspace
            mode: vi_normal
            event: { edit: moveleft }
        }
        {
            name: newline_or_run_command
            modifier: none
            keycode: enter
            mode: emacs
            event: { send: enter }
        }
        {
            name: move_left
            modifier: control
            keycode: char_b
            mode: emacs
            event: {
                until: [
                    { send: menuleft }
                    { send: left }
                ]
            }
        }
        {
            name: move_right_or_take_history_hint
            modifier: control
            keycode: char_f
            mode: emacs
            event: {
                until: [
                    { send: historyhintcomplete }
                    { send: menuright }
                    { send: right }
                ]
            }
        }
        {
            name: redo_change
            modifier: control
            keycode: char_g
            mode: emacs
            event: { edit: redo }
        }
        {
            name: undo_change
            modifier: control
            keycode: char_z
            mode: emacs
            event: { edit: undo }
        }
        {
            name: paste_before
            modifier: control
            keycode: char_y
            mode: emacs
            event: { edit: pastecutbufferbefore }
        }
        {
            name: cut_word_left
            modifier: control
            keycode: char_w
            mode: emacs
            event: { edit: cutwordleft }
        }
        {
            name: cut_line_to_end
            modifier: control
            keycode: char_k
            mode: emacs
            event: { edit: cuttoend }
        }
        {
            name: cut_line_from_start
            modifier: control
            keycode: char_u
            mode: emacs
            event: { edit: cutfromstart }
        }
        {
            name: swap_graphemes
            modifier: control
            keycode: char_t
            mode: emacs
            event: { edit: swapgraphemes }
        }
        {
            name: move_one_word_left
            modifier: alt
            keycode: left
            mode: emacs
            event: { edit: movewordleft }
        }
        {
            name: move_one_word_right_or_take_history_hint
            modifier: alt
            keycode: right
            mode: emacs
            event: {
                until: [
                    { send: historyhintwordcomplete }
                    { edit: movewordright }
                ]
            }
        }
        {
            name: move_one_word_left
            modifier: alt
            keycode: char_b
            mode: emacs
            event: { edit: movewordleft }
        }
        {
            name: move_one_word_right_or_take_history_hint
            modifier: alt
            keycode: char_f
            mode: emacs
            event: {
                until: [
                    { send: historyhintwordcomplete }
                    { edit: movewordright }
                ]
            }
        }
        {
            name: delete_one_word_forward
            modifier: alt
            keycode: delete
            mode: emacs
            event: { edit: deleteword }
        }
        {
            name: delete_one_word_backward
            modifier: alt
            keycode: backspace
            mode: emacs
            event: { edit: backspaceword }
        }
        {
            name: delete_one_word_backward
            modifier: alt
            keycode: char_m
            mode: emacs
            event: { edit: backspaceword }
        }
        {
            name: cut_word_to_right
            modifier: alt
            keycode: char_d
            mode: emacs
            event: { edit: cutwordright }
        }
        {
            name: upper_case_word
            modifier: alt
            keycode: char_u
            mode: emacs
            event: { edit: uppercaseword }
        }
        {
            name: lower_case_word
            modifier: alt
            keycode: char_l
            mode: emacs
            event: { edit: lowercaseword }
        }
        {
            name: capitalize_char
            modifier: alt
            keycode: char_c
            mode: emacs
            event: { edit: capitalizechar }
        }
        {
            name: copy_selection
            modifier: control_shift
            keycode: char_c
            mode: emacs
            event: { edit: copyselection }
        }
        {
            name: cut_selection
            modifier: control_shift
            keycode: char_x
            mode: emacs
            event: { edit: cutselection }
        }
        {
            name: select_all
            modifier: control_shift
            keycode: char_a
            mode: emacs
            event: { edit: selectall }
        }
        {
            name: paste
            modifier: control_shift
            keycode: char_v
            mode: emacs
            event: { edit: pastecutbufferbefore }
        }
    ]
}

alias do = sh /home/user/.config/sway/script.sh
alias google-chrome-stable = sh ~/.config/google-chrome-stable.sh
alias google-chrome = sh ~/.config/google-chrome-stable.sh
alias dnf = dnf5
alias ls = ls -a
alias ll = ls -al
alias cp = cp -r
alias rm = rm -r

def ti [] {
    sh "/home/user/Documents/TI-Nspire CX/TI-Nspire/launcher/nspire_run.sh"
}

def wake [] {
    sudo ether-wake "74:56:3c:23:a0:86"
}

def boot [ISO: string] {
    let CORES = nproc
    let MEMORY = awk '/MemTotal/ {printf "%.f", $2/2000}' /proc/meminfo
    qemu-system-x86_64 -cpu host -smp $CORES -m $MEMORY -vga qxl -machine type=q35,accel=kvm -enable-kvm -cdrom $ISO
}

def create [ISO: string NAME: string] {
    let CORES = nproc
    let MEMORY = awk '/MemTotal/ {printf "%.f", $2/2000}' /proc/meminfo
    virt-install --connect qemu:///session --os-variant detect=off --virt-type kvm --arch x86_64 --machine q35 --name $NAME --boot uefi --cpu mode=maximum,topology.sockets=1,topology.threads=1 --vcpus $CORES --memory $MEMORY --video virtio --graphics spice,listen=none --channel spicevmc --channel unix,target.type=virtio,target.name=org.qemu.guest_agent.0 --console pty,target.type=virtio --sound default --network type=default,model=virtio --controller type=virtio-serial --controller type=usb,model=none --controller type=scsi,model=virtio-scsi --noautoconsole --input type=keyboard,bus=virtio --input type=tablet,bus=virtio --rng /dev/urandom,model=virtio --disk path=/home/user/.local/share/gnome-boxes/images/$NAME.img,format=raw,bus=virtio,cache=writeback,size=64 --cdrom $ISO
}

def update [] {
    print "[DNF]"
    sudo dnf distro-sync -yq

    print "\n[JDTLS]"
    let dir = "/home/user/.config/helix/languages/jdtls"
    let current = ($dir | path join latest)
    let latest = (http get "https://api.github.com/repos/eclipse-jdtls/eclipse.jdt.ls/tags" | first | get name | str replace "v" "")
    if ((cat $current) != $latest) {
      let url = "https://download.eclipse.org/jdtls/milestones"
      wget -qO - ($url | path join $latest (curl -sL ($url | path join $latest "latest.txt"))) | tar xz -C $dir
      $latest | save $current -f
    }

    print "\n[KOTLIN]"
    let dir = "/home/user/.config/helix/languages/kotlin"
    let current = ($dir | path join latest)
    let latest = (http get "https://api.github.com/repos/fwcd/kotlin-language-server/tags" | find -v gradle | first | get name)
    if ((cat $current) != $latest) {
        wget -qO - "https://github.com/fwcd/kotlin-language-server/releases/latest/download/server.zip" | bsdtar -xf- -C $dir
        $latest | save $current -f
    }

    print "\n[ANDROID]"
    sdkmanager --update
}

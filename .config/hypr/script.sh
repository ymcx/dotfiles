#! /usr/bin/bash

say() {
  hyprctl dismissnotify
  hyprctl notify -1 2000 0 "$1"
}

background() {
  RESOLUTION=$(xdpyinfo | sed '/dimensions/!d;s/[^0-9]//g')
  HEIGHT=$(echo "$RESOLUTION" | cut -c 5-8)
  WIDTH=$(echo "$RESOLUTION" | cut -c 1-4)
  convert -resize "$WIDTH"x"$HEIGHT"^ -gravity center -extent "$WIDTH"x"$HEIGHT" "$1" ~/.config/background.png
  mv ~/.config/background.png ~/.config/background
}

volume() {
  case "$2" in
    x)
      mute=toggle
    ;;
    +|-)
      mute=0
      wpctl set-volume -l 1 @DEFAULT_AUDIO_"$1"@ 0.06"$2"
    ;;
  esac
  wpctl set-mute @DEFAULT_AUDIO_"$1"@ "$mute"
  level=$(wpctl get-volume @DEFAULT_AUDIO_"$1"@ | sed '/MUTED/d;s/[^0-9]//g;s/^0*//g')
  if [[ -z "$level" ]]; then
    level=0
  fi
  say "$level"%
}

close() {  
  if [ "$(hyprctl activewindow -j | jq -r .class)" = foot ]; then
    ids=$(hyprctl activewindow | awk '/grouped/ {print $2}')
    pids=$(hyprctl clients | grep "$ids" -B 6 | awk '/pid/ {print $2}')
    echo "$pids" | xargs kill
  else
    hyprctl dispatch killactive
  fi
}

screenshot() {
  if [[ "$1" =~ ca|sa ]]; then
    area=$(slurp)
    if [ "$area" = "" ]; then
      return
    fi
    grim -g "$area" - | wl-copy
  elif [[ "$1" =~ cs|ss ]]; then
    grim - | wl-copy
  fi
  if [[ "$1" =~ sa|ss ]]; then
    fileName=$(date +'Screenshot from %Y-%m-%d %H-%M-%S.png')
    wl-paste > ~/Pictures/Screenshots/"$fileName"
    say "Saved as $fileName"
  elif [[ "$1" =~ ca|cs ]]; then
    say "Copied to clipboard"
  fi
}

display() {
  brightnessctl s 1200"$1" -qn242
  say $(($(brightnessctl g)/242))%
}

bluetooth() {
  if [ -z "$1" ]; then
    arg=00:0A:45:03:53:6B
  else
    arg="$1"
  fi
  if [[ $(rfkill | awk '/bluetooth/ {print $4; exit}') = blocked ]]; then
    say "Bluetooth [ON]"
    rfkill unblock bluetooth
    until bluetoothctl power on; do
      sleep 3
    done
    bluetoothctl connect "$arg"
    until [ "$(bluetoothctl devices Connected | wc -c)" -eq 0 ]; do
      sleep 15
    done
  fi
  say "Bluetooth [OFF]"
  until bluetoothctl power off; do
    sleep 3
  done
  rfkill block bluetooth
}

wifi() {
  if [[ $(rfkill | awk '/wlan/ {print $4; exit}') = blocked ]]; then
    say "Wi-Fi [ON]"
    rfkill unblock wifi
  else
    say "Wi-Fi [OFF]"
    rfkill block wifi
  fi
}

wake() {
  if [ -z "$1" ]; then
    arg=74:56:3c:23:a0:86
  else
    arg="$1"
  fi
  sudo ether-wake "$arg"
}

vm() {
  MEM=$(awk '/MemTotal/ {printf "%.f", $2/2000}' /proc/meminfo)
  CORES=$(nproc)
  ISO=$(readlink -f "$3")
  NAME="$4"
  case "$2" in
    create)
      virt-install \
        --connect qemu:///system \
        --os-variant detect=off \
        --virt-type kvm \
        --arch x86_64 \
        --machine q35 \
        --name "$NAME" \
        --boot uefi \
        --cpu mode=maximum,topology.sockets=1,topology.cores="$CORES",topology.threads=1 \
        --vcpus "$CORES" \
        --memory "$MEM" \
        --video virtio \
        --graphics spice,listen=none \
        --channel spicevmc \
        --channel unix,target.type=virtio,target.name=org.qemu.guest_agent.0 \
        --console pty,target.type=virtio \
        --sound default \
        --network type=default,model=virtio \
        --controller type=virtio-serial \
        --controller type=usb,model=none \
        --controller type=scsi,model=virtio-scsi \
        --noautoconsole \
        --input type=keyboard,bus=virtio \
        --input type=tablet,bus=virtio \
        --rng /dev/urandom,model=virtio \
        --disk path=/var/lib/libvirt/images/"$NAME".img,format=raw,bus=virtio,cache=writeback,size=64 \
        --cdrom "$ISO"
    ;;
    boot)
      qemu-system-x86_64 \
        -cpu host \
        -smp "$CORES" \
        -m "$MEM"M \
        -vga qxl \
        -machine type=q35,accel=kvm \
        -enable-kvm \
        -cdrom "$ISO"
    ;;
  esac
}

ips() {
  ip=$(hostname -I | awk '{print $1}' | cut -d . -f 4)
  for i in $(seq 101 121 | grep -v "$ip"); do
    ping -c 1 -W 0.05 -q -s 1 192.168.8."$i" | awk '/ 0% / {print a} {a = $2}'
  done
}

update() {
  sudo dnf distro-sync -y
  sudo dnf autoremove  -y
  if [ "$1" = all ]; then
    # DEPOT HYPR JDTLS SDKMANAGER FLATPAK NPM PIP FWUPD 
    mkdir -p /tmp/updoot
    cd /tmp/updoot || exit
    git -C ~/.android/depot_tools pull
    HLOCK=$(curl -s -qI https://github.com/hyprwm/hyprlock/releases/latest  | awk -F '/' '/^location/ {print substr($NF, 1, length($NF)-1)}')
    HIDLE=$(curl -s -qI https://github.com/hyprwm/hypridle/releases/latest  | awk -F '/' '/^location/ {print substr($NF, 1, length($NF)-1)}')
    HPAPE=$(curl -s -qI https://github.com/hyprwm/hyprpaper/releases/latest | awk -F '/' '/^location/ {print substr($NF, 1, length($NF)-1)}')
    wget https://github.com/hyprwm/hyprlock/releases/latest/download/"$HLOCK".tar.gz  \
         https://github.com/hyprwm/hypridle/releases/latest/download/"$HIDLE".tar.gz  \
         https://github.com/hyprwm/hyprpaper/releases/latest/download/"$HPAPE".tar.gz \
         https://www.eclipse.org/downloads/download.php?file=/jdtls/snapshots/jdt-language-server-latest.tar.gz
    find -- *.gz | xargs -n1 tar -xf
    sudo chmod 755       hypr*/*
    sudo chown root:root hypr*/*
    sudo mv              hypr*/* /usr/local/bin/
    rm -rf ~/.config/helix/languages/jdtls/*
    mv bin config_* features plugins ~/.config/helix/languages/jdtls/ 
    sdkmanager --update
    flatpak update -y
    npm update
    sudo pip list -o | awk '2 < NR {print $1}' | xargs -n1 sudo pip install -U 
         pip list -o | awk '2 < NR {print $1}' | xargs -n1      pip install -U 
    fwupdmgr refresh
    fwupdmgr update -y
  fi
}

case "$1" in
  speakers  ) volume SINK   "$2" ;;
  microphone) volume SOURCE "$2" ;;
  close     ) close              ;;
  screenshot) screenshot    "$2" ;;
  display   ) display       "$2" ;;
  bluetooth ) bluetooth     "$2" ;;
  wifi      ) wifi               ;;
  vm        ) vm            "$@" ;;
  ips       ) ips                ;;
  wake      ) wake          "$2" ;;
  background) background    "$2" ;;
  update    ) update        "$2" ;;
esac

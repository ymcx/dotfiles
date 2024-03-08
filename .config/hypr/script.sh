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
  MEM=$(awk '/MemTotal/ {printf "%.f", $2/2000000}' /proc/meminfo)
  CORES=$(nproc)
  ISO=$(readlink -f "$3")
  case "$2" in
    create)
      NAME="$4"
      OS="$5"
      sudo qemu-img create -f qcow2 /var/lib/libvirt/images/"$NAME".qcow2 64G
      sed "s|CHANGEME1|$NAME|g;s|CHANGEME2|$MEM|g;s|CHANGEME3|$CORES|g;s|CHANGEME4|$ISO|g" ~/.config/libvirt/"$OS".xml > /etc/libvirt/qemu/VM_"$NAME".xml
      sudo virsh create /etc/libvirt/qemu/VM_"$NAME".xml
    ;;
    boot)
      qemu-system-x86_64 -cpu host -smp "$CORES" -m "$MEM"G -vga qxl -machine type=q35,accel=kvm -enable-kvm -cdrom "$ISO"
    ;;
  esac
}

ips() {
  ip=$(hostname -I | awk '{print $1}' | cut -d . -f 4)
  for i in $(seq 101 121 | grep -v "$ip"); do
    ping -c 1 -W 0.02 -q -s 1 192.168.8."$i" | awk '/ 0% / {print a} {a = $2}'
  done
}

update() {
  sudo dnf distro-sync -y
  sudo dnf autoremove -y
  if [ "$1" = all ]; then
    wget https://www.eclipse.org/downloads/download.php?file=/jdtls/snapshots/jdt-language-server-latest.tar.gz -O /tmp/jdtls.tar.gz
    rm -rf ~/.config/helix/languages/jdtls/*
    tar xfz /tmp/jdtls.tar.gz -C ~/.config/helix/languages/jdtls/
    sdkmanager --update
    ls ~/Projects/hypr/ | xargs -I {} git -C ~/Projects/hypr/{} pull
    cmake -DCMAKE_BUILD_TYPE:STRING=Release -S ~/Projects/hypr/hypridle -B ~/Projects/hypr/hypridle/build
    cmake -DCMAKE_BUILD_TYPE:STRING=Release -S ~/Projects/hypr/hyprlock -B ~/Projects/hypr/hyprlock/build
    cmake --build ~/Projects/hypr/hypridle/build --config Release --target hypridle -j "$(nproc)"
    cmake --build ~/Projects/hypr/hyprlock/build --config Release --target hyprlock -j "$(nproc)"
    make all -C ~/Projects/hypr/hyprpaper -j "$(nproc)"
    sudo cp -f ~/Projects/hypr/hyprpaper/build/hyprpaper /usr/bin/
    sudo cmake --install ~/Projects/hypr/hypridle/build
    sudo cmake --install ~/Projects/hypr/hyprlock/build
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

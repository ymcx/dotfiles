wob=$XDG_RUNTIME_DIR/wob.sock

isTerminal() {
  if [ "$(hyprctl activewindow -j | jq -r .class)" = foot ]; then
    return 0
  fi
  return 1
}

say() {
  hyprctl notify -1 5000 0 "$1"
}

volume() {
  case $2 in
    x  ) mute=toggle;;
    +|-) mute=0 && wpctl set-volume -l 1 @DEFAULT_AUDIO_"$1"@ 0.06"$2";;
  esac
  wpctl set-mute @DEFAULT_AUDIO_"$1"@ "$mute"
  echo 0"$(wpctl get-volume @DEFAULT_AUDIO_"$1"@ | grep -v MUTED | sed 's/[^0-9]//g')" > "$wob"
}

close() {  
  if isTerminal; then
    ids=$(hyprctl activewindow | awk '/grouped/ {print $2}')
    pids=$(hyprctl clients | grep "$ids" -B 6 | awk '/pid/ {print $2}')
    echo "$pids" | xargs kill
  else
    hyprctl dispatch killactive
  fi
}

screenshot() {
  if [[ $1 =~ ca|sa ]]; then
    area="-g $(slurp)"
  fi
  grim ${area+"$area"} - | wl-copy
  if [[ $1 =~ sa|ss ]]; then
    fileName=$(date +'Screenshot from %Y-%m-%d %H-%M-%S.png')
    wl-paste > ~/Pictures/Screenshots/"$fileName"
    say "Screenshot has been saved as '$fileName'"
  else
    say "Screenshot has been taken"
  fi
}

display() {
  brightnessctl s 1200"$1" -qn242
  echo $(($(brightnessctl g)/242)) > "$wob"
}

bluetooth() {
  if [[ $(bluetoothctl show | awk '/Powered/ {print $2}') = no ]]; then
    say "Bluetooth has been turned on"
    bluetoothctl power on  
    bluetoothctl connect 00:0A:45:03:53:6B
    while :; do
      if [ "$(bluetoothctl devices Connected | wc -c)" -eq 0 ]; then
        break
      fi
      sleep 15
    done
  fi
  say "Bluetooth has been turned off"
  bluetoothctl power off
}

wifi() {
  if [[ $(rfkill | awk '/wlan/ {print $4}') = unblocked ]]; then
    say "Wifi has been turned off"
  else
    say "Wifi has been turned on"
  fi
  rfkill toggle wifi
}

vm() {
  MEM=$(awk '/MemTotal/ {printf "%.f", $2/2000000}' /proc/meminfo)
  CORES=$(nproc)
  if [ "$2" = create ]; then
    NAME=$3
    OS=$4
    ISO=$(readlink -f "$5")
    sudo qemu-img create -f qcow2 /var/lib/libvirt/images/"$NAME".qcow2 64G
    sed "s|CHANGEME1|$NAME|g; s|CHANGEME2|$MEM|g; s|CHANGEME3|$CORES|g; s|CHANGEME4|$ISO|g" ~/.config/libvirt/"$OS".xml > /tmp/VM_"$NAME".xml
    sudo virsh create /tmp/VM_"$NAME".xml
  elif [ "$2" = boot ]; then
    qemu-system-x86_64 -cpu host -smp "$CORES" -m "$MEM"G -vga qxl -machine type=q35,accel=kvm -enable-kvm -cdrom "$3"
  fi
}

ips() {
  ip=$(hostname -I | awk '{print $1}' | cut -d "." -f 4)
  for i in $(seq 101 109 | grep -v "$ip"); do
    ping -c 1 -W 0.02 -q -s 1 192.168.8."$i" | awk '/ 0% / {print a} {a = $2}'
  done
}

case $1 in
  speakers  ) volume SINK   "$2" ;;
  microphone) volume SOURCE "$2" ;;
  close     ) close              ;;
  screenshot) screenshot    "$2" ;;
  display   ) display       "$2" ;;
  bluetooth ) bluetooth          ;;
  wifi      ) wifi               ;;
  vm        ) vm            "$@" ;;
  ips       ) ips                ;;
esac

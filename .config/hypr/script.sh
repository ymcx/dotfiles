wob="${XDG_RUNTIME_DIR}"/wob.sock

volume() {
  case $2 in
    x  ) mute="toggle";;
    +|-) mute="0"
         wpctl set-volume -l 1 @DEFAULT_AUDIO_"$1"@ 0.06"$2";;
  esac
  wpctl set-mute @DEFAULT_AUDIO_"$1"@ "$mute"
  echo 0"$(wpctl get-volume @DEFAULT_AUDIO_"$1"@ | grep -v MUTED | sed 's/[^0-9]//g')" > "$wob"
}

case $1 in
  tab)
    if [ "$(hyprctl activewindow -j | jq -r '.class')" = "foot" ]; then
      case $2 in
        -) hyprctl dispatch killactive;;
        +) foot -D "$(ls -l /proc/$(($(hyprctl activewindow | awk '/pid/ {print $2}')+1))/cwd | awk '{print $11}')";;
      esac
    fi;;

  close)
    if [ "$(hyprctl activewindow -j | jq -r '.class')" = "foot" ]; then
      kill $(hyprctl clients | grep $(hyprctl activewindow | awk '/grouped/ {print $2}') -B 6 | awk '/pid/ {print $2}')
    else
      hyprctl dispatch killactive
    fi;;    

  screenshot)
    if [[ $2 =~ ca|sa ]]; then
      area="-g $(slurp)"
    fi
    grim ${area:+"$area"} - | wl-copy
    if [[ $2 =~ sa|ss ]]; then
      wl-paste > ~/Pictures/Screenshots/"$(date +'Screenshot from %Y-%m-%d %H-%M-%S.png')"
    fi;;

  speakers)
    volume "SINK" "$2";;
  
  microphone)
    volume "SOURCE" "$2";;
  
  display)
    brightnessctl s 1200"$2" -qn242
    echo $(($(brightnessctl g)/242)) > "$wob";;
esac

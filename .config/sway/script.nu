let WOB = $env.XDG_RUNTIME_DIR | path join wob.sock

def volume [TYPE: string ACTION: string] {
  match $ACTION {
    "x"     => {wpctl set-mute $"@DEFAULT_AUDIO_($TYPE)@" toggle}
    "+"|"-" => {wpctl set-volume -l 1 $"@DEFAULT_AUDIO_($TYPE)@" $"4%($ACTION)"}
  }
  $"0(wpctl get-volume $"@DEFAULT_AUDIO_($TYPE)@" | sed '/MUTED/g;s/[^0-9]//g')\n" | save -f $WOB
}

def brightness [ACTION?: string] {
  brightnessctl s $"25%($ACTION)" -qn1
  brightnessctl g -P | save -f $WOB
}

def screenshot [ACTION: string] {
  if $ACTION not-in [copyarea, savearea, copyscreen, savescreen] {
    return
  }
  if $ACTION in [copyarea, savearea] {
    grim -g (slurp) - | wl-copy
  } else {
    grim - | wl-copy
  }
  if $ACTION in [savescreen, savearea] {
    wl-paste | save ("~/Pictures/Screenshots" | path join (date now | format date "%s%3f.png"))
  }
  "100\n" | save -f $WOB
}

def bluetooth [] {
  if (bluetoothctl show | awk "/Powered/ {print $2}") == no {
    "100\n" | save -f $WOB
    bluetoothctl power on
    bluetoothctl connect 00:0A:45:03:53:6B
  } else {
    "0\n" | save -f $WOB
    bluetoothctl power off
  }
}

def main [ACTION: string REST?: string] {
  match $ACTION {
    speaker    => {volume SINK $REST}
    microphone => {volume SOURCE $REST}
    brightness => {brightness $REST}
    screenshot => {screenshot $REST}
    bluetooth  => {bluetooth}
  }
}

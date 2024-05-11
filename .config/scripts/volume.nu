let WOB = $env.XDG_RUNTIME_DIR | path join wob.sock

def main [TYPE: string ACTION: string] {
  match $ACTION {
    "x"     => {wpctl set-mute $"@DEFAULT_AUDIO_($TYPE)@" toggle}
    "+"|"-" => {wpctl set-volume -l 1 $"@DEFAULT_AUDIO_($TYPE)@" $"10%($ACTION)"}
  }
  $"0(wpctl get-volume $"@DEFAULT_AUDIO_($TYPE)@" | sed '/MUTED/g;s/[^0-9]//g')\n" | save -f $WOB
}

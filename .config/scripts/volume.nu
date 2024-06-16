def main [TYPE: string ACTION: string] {
  match $ACTION {
    "x" => {
      wpctl set-mute $"@DEFAULT_AUDIO_($TYPE)@" toggle
    }
    "+"|"-" => {
      wpctl set-volume $"@DEFAULT_AUDIO_($TYPE)@" $"10%($ACTION)" -l 1
      wpctl set-mute $"@DEFAULT_AUDIO_($TYPE)@" ((wpctl get-volume $"@DEFAULT_AUDIO_($TYPE)@" | awk "{print $2}") == "0.00" | into int)
    }
  }
}

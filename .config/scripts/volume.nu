def main [TYPE: string ACTION: string] {
  match $ACTION {
    "x" => {
      wpctl set-mute $"@DEFAULT_AUDIO_($TYPE)@" toggle
    }
    "+"|"-" => {
      wpctl set-volume $"@DEFAULT_AUDIO_($TYPE)@" $"10%($ACTION)" -l 1
    }
  }
}

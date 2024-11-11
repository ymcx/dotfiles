def main [DEVICE: string ACTION: string] {
  wpctl set-volume $DEVICE $ACTION -l 1
  wpctl set-mute $DEVICE (wpctl get-volume $DEVICE | str contains "0.00" | into int)
}

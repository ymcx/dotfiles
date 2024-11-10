def main [DEVICE: string] {
  if (bluetoothctl info $DEVICE | str contains "Connected: yes") {
    bluetoothctl disconnect $DEVICE
  } else {
    bluetoothctl connect $DEVICE
  }
}

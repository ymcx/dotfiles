def main [DEVICE?: string] {
  if (bluetoothctl show | str contains "Powered: yes") {
    bluetoothctl power off
  } else {
    bluetoothctl power on
    if ($DEVICE | is-not-empty) {
      bluetoothctl connect $DEVICE
    }
  }
}

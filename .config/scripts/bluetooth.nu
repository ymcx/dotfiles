def main [] {
  if (bluetoothctl show | awk "/Powered/ {print $2}") == no {
    bluetoothctl power on
    bluetoothctl connect 00:0A:45:03:53:6B
  } else {
    bluetoothctl power off
  }
}

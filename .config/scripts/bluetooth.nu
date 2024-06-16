def main [] {
  if (bluetoothctl show | awk "/Powered/ {print $2}") == no {
    sudo thinkled 134
    bluetoothctl power on
    bluetoothctl connect 00:0A:45:03:53:6B
  } else {
    sudo thinkled 6
    bluetoothctl power off
  }
}

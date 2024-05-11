let WOB = $env.XDG_RUNTIME_DIR | path join wob.sock

def main [] {
  if (bluetoothctl show | awk "/Powered/ {print $2}") == no {
    "100\n" | save -f $WOB
    bluetoothctl power on
    bluetoothctl connect 00:0A:45:03:53:6B
  } else {
    "0\n" | save -f $WOB
    bluetoothctl power off
  }
}

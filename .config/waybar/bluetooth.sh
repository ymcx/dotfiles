if [[ "$(bluetoothctl show | awk '/Powered/ {print $2}')" == "no" ]]; then
  bluetoothctl power on  
  bluetoothctl connect 00:0A:45:03:53:6B
  while :; do
    if [ $(bluetoothctl devices Connected | wc -c) -eq 0 ]; then
      break
    fi
    sleep 15
  done
fi
bluetoothctl power off

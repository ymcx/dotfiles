if bluetoothctl show | grep -q "Powered:\sno"; then
  bluetoothctl power on
  bluetoothctl connect 00:0A:45:03:53:6B
else
  bluetoothctl power off
fi

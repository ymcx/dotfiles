let BTRY = cat /sys/class/power_supply/BAT0/capacity | into int

if $BTRY <= 10 {
  ectool -w 0x0c -z 0xc0
} else if $BTRY <= 50 {
  ectool -w 0x0c -z 0xa0
} else {
  ectool -w 0x0c -z 0x80
}

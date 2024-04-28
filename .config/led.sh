#!/usr/bin/bash

BTRY=$(cat /sys/class/power_supply/BAT0/capacity)

if [ "$BTRY" -lt 11 ]; then
  ectool -w 0x0c -z 0xc0
elif [ "$BTRY" -lt 51 ]; then
  ectool -w 0x0c -z 0xa0
else
  ectool -w 0x0c -z 0x80
fi

RESOLUTION="$(xdpyinfo | grep 'dimensions' | sed 's/[^0-9]//g')"
HEIGHT="$(echo $RESOLUTION | cut -c 5-8)"
WIDTH="$(echo $RESOLUTION | cut -c 1-4)"
convert -resize "$WIDTH"x"$HEIGHT"\>^ ../background desktop
convert -blur 0x64 -gamma 0.75 desktop lock

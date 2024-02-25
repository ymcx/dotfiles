RESOLUTION="$(xdpyinfo | grep 'dimensions' | sed 's/[^0-9]//g')"
HEIGHT="$(echo $RESOLUTION | cut -c 5-8)"
WIDTH="$(echo $RESOLUTION | cut -c 1-4)"
convert -resize "$WIDTH"x"$HEIGHT"^ -gravity center -extent "$WIDTH"x"$HEIGHT" ~/.config/background ~/.config/backgrounds/background.png
convert ~/.config/backgrounds/background.png ~/.config/backgrounds/gradient_short.png -background None -layers Flatten ~/.config/backgrounds/background.png
mv ~/.config/backgrounds/background.png ~/.config/background

RESOLUTION="$(xdpyinfo | grep 'dimensions' | sed 's/[^0-9]//g')"
HEIGHT="$(echo $RESOLUTION | cut -c 5-8)"
WIDTH="$(echo $RESOLUTION | cut -c 1-4)"
convert -resize "$WIDTH"x"$HEIGHT"^ -gravity center -extent 1920x1080 background background.png
convert background.png background_gradient.png -background None -layers Flatten background.png

let resolution = wlr-randr --json | from json | first | get modes | first
let width  = ($resolution | get width)  - 1
let height = ($resolution | get height) - 1
convert -resize $"($width)x($height)^" -gravity center -extent $"($width)x($height)" ~/.local/share/backgrounds/original ~/.local/share/backgrounds/wallpaper

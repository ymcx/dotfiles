socat -U - UNIX-CONNECT:/run/user/1000/hypr/($env.HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | any {|i|
  if ($i =~ "openwindow|closewindow") {
    hyprctl dispatch focuswindow activewindow -q
  }
}

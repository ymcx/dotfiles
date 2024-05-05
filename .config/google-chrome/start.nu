def --wrapped main [...args: string] {
  google-chrome-stable --ozone-platform-hint=wayland --ozone-platform=wayland --gtk-version=4 ...$args
}

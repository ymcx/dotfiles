let dir = "/home/user/.config/helix/languages/zig"
let currentFile = ($dir | path join latest)
let current = (cat $currentFile)
let latest = (http get "https://api.github.com/repos/zigtools/zls/tags" | first | get name)
if ($current != $latest) {
  print $"Updating Zig LSP from version '($current)' to '($latest)'..."
  let url = "https://github.com/zigtools/zls/releases/latest/download/zls-x86_64-linux.tar.xz"
  wget -O - $url | tar xJ -C $dir
  $latest | save $currentFile -f
} else {
  print $"Zig LSP version '($current)' is up-to-date."
}

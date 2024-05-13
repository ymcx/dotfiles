let dir = "/home/user/.config/helix/languages/kotlin"
let currentFile = ($dir | path join latest)
let current = (cat $currentFile)
let latest = (http get "https://api.github.com/repos/fwcd/kotlin-language-server/tags" | find -v gradle | first | get name)
if ($current != $latest) {
  print $"Updating Kotlin LSP from version '($current)' to '($latest)'..."
  let url = "https://github.com/fwcd/kotlin-language-server/releases/latest/download/server.zip"
  wget -O - $url | bsdtar -xf- -C $dir
  $latest | save $currentFile -f
} else {
  print $"Kotlin LSP version '($current)' is up-to-date."
}

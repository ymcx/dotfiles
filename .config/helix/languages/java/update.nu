let dir = "/home/user/.config/helix/languages/java"
let currentFile = ($dir | path join latest)
let current = (cat $currentFile)
let latest = (http get "https://api.github.com/repos/eclipse-jdtls/eclipse.jdt.ls/tags" | first | get name | str replace "v" "")
if ($current != $latest) {
  print $"Updating Java LSP from version '($current)' to '($latest)'..."
  let url = "https://download.eclipse.org/jdtls/milestones"
  wget -O - ($url | path join $latest (curl -sL ($url | path join $latest "latest.txt"))) | tar xz -C $dir
  $latest | save $currentFile -f
} else {
  print $"Java LSP version '($current)' is up-to-date."
}

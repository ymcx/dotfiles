def main [ACTION: string] {
  match $ACTION {
    "dnf" => {
      sudo dnf autoremove -y
      sudo dnf upgrade -y
    }
    "zellij" => {
      cargo install zellij
    }
    "java" => {
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
    }
    "zig" => {
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
    }
  }
  sleep 1sec
}

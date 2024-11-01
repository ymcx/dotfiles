def prompt [] {
    let dir = match (do -i {$env.PWD | path relative-to $nu.home-path}) {
        null => $env.PWD
        $i => $i
    }
    let ssh = if ($env.SSH_TTY? | is-not-empty) {
        $"(hostname -I | awk '{print $1}'):"
    }
    $"($ssh)($dir)"
}

$env.PROMPT_COMMAND = {|| prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.EDITOR = "hx"
$env.COLORTERM = "truecolor"
$env.ANDROID_HOME = "/home/user/.android/home"
$env.PATH = ["/usr/local/bin", "/usr/local/sbin", "/usr/bin", "/usr/sbin", "/home/user/.local/bin"]
$env.CARAPACE_MATCH = 1

open ~/.config/nushell/nord.toml | load-env

def prompt [] {
    let directory = match (do -i {$env.PWD | path relative-to $nu.home-path}) {
        null => $env.PWD
        '' => '~'
        $relative => ([~ $relative] | path join)
    }
    let color = (if ($env.SSH_TTY? | is-not-empty) {
        ansi purple_bold
    } else {
        ansi green_bold
    })
    $"($color)($directory)(ansi reset)"
}

$env.PROMPT_COMMAND = {|| prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.EDITOR = "hx"
$env.COLORTERM = "truecolor"
$env.ANDROID_HOME = "/home/user/.android/home"
$env.PATH = ["/usr/local/bin", "/usr/local/sbin", "/usr/bin", "/usr/sbin", "/home/user/.local/bin"]

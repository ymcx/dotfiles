def prompt [] {
    let dir = match (do -s {$env.PWD | path relative-to $nu.home-path}) {
        null => $env.PWD
        $i => ('~' | path join $i)
    }
    if ($env.SSH_TTY? | is-not-empty) or (is-admin) {
        $"(ansi red)($dir)"
    } else {
        $dir
    }
}

$env.PROMPT_COMMAND = {|| prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.ANDROID_HOME = "/opt/android-sdk"
$env.EDITOR = hx

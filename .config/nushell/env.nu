def prompt [] {
    match (do -s {$env.PWD | path relative-to $nu.home-path}) {
        null => $env.PWD
        "" => "~"
        $i => ([~ $i] | path join)
    }
}

$env.PROMPT_COMMAND = {prompt}
$env.PROMPT_COMMAND_RIGHT = {null}
$env.PROMPT_INDICATOR = {"> "}
$env.PROMPT_INDICATOR_VI_INSERT = {"> "}
$env.PROMPT_INDICATOR_VI_NORMAL = {"> "}
$env.PROMPT_MULTILINE_INDICATOR = {null}
$env.PATH = ["/usr/local/bin", "/usr/local/sbin", "/usr/bin", "/usr/sbin", "/home/user/.local/bin", "/home/user/.cargo/bin", "/home/user/.android/build-tools/34.0.0"]
$env.ANDROID_HOME = "/home/user/.android"
$env.EDITOR = hx

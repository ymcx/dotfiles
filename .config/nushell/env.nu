def prompt [] {
    match (do -s {$env.PWD | path relative-to $nu.home-path}) {
        null => $env.PWD
        "" => "~"
        $i => ("~" | path join $i)
    }
}

$env.PROMPT_COMMAND = {|| prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.ANDROID_HOME = "/opt/android-sdk"
$env.EDITOR = hx

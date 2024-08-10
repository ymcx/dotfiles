def create_left_prompt [] {
    let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }
    let path_color = (if ($env.SSH_TTY? | is-not-empty) { ansi purple_bold } else { ansi green_bold })
    let separator_color = (if ($env.SSH_TTY? | is-not-empty) { ansi light_purple_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)(ansi reset)"
    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.EDITOR = "hx"
$env.ANDROID_HOME = "/home/user/.android/home"

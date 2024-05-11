def create_prompt [] {
    let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }
    let color = (if not ($env.SSH_TTY? | is-empty) or (is-admin) { ansi red_bold } else { ansi green_bold })
    let path_segment = $"($color)[($dir)] "
    $path_segment | str replace --all (char path_sep) $"($color)(char path_sep)($color)"
}

$env.PROMPT_COMMAND = {|| create_prompt }
$env.PROMPT_COMMAND_RIGHT = {||}
$env.PROMPT_INDICATOR = {||}
$env.PROMPT_INDICATOR_VI_INSERT = {||}
$env.PROMPT_INDICATOR_VI_NORMAL = {||}
$env.PROMPT_MULTILINE_INDICATOR = {||}
$env.PATH = ["/usr/local/bin", "/usr/local/sbin", "/usr/bin", "/usr/sbin", "/home/user/.local/bin", "/home/user/.cargo/bin"]
$env.ANDROID_HOME = "/home/user/.android"
$env.EDITOR = hx

$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
]

$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

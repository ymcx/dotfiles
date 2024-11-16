def prompt [] {
    match (do -s { $env.PWD | path relative-to "/home/user" }) {
        null => $env.PWD
        "" => "~"
        $i => $"~/($i)"
    }
}

$env.PROMPT_COMMAND = {|| prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.EDITOR = "helix"
$env.SSH_AUTH_SOCK = "/run/user/1000/gcr/ssh"

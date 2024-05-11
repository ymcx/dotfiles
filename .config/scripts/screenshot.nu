let WOB = $env.XDG_RUNTIME_DIR | path join wob.sock

def main [ACTION: string] {
  if $ACTION not-in [copyarea, savearea, copyscreen, savescreen] {
    return
  }
  if $ACTION in [copyarea, savearea] {
    grim -g (slurp) - | wl-copy
  } else {
    grim - | wl-copy
  }
  if $ACTION in [savescreen, savearea] {
    wl-paste | save ("~/Pictures" | path join (date now | format date "%s%3f.png"))
  }
  "100\n" | save -f $WOB
}

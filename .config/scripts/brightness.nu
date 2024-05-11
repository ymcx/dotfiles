let WOB = $env.XDG_RUNTIME_DIR | path join wob.sock

def main [ACTION: string] {
  brightnessctl s $"10%($ACTION)" -qn1
  brightnessctl g -P | save -f $WOB
}

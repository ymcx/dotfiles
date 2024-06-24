#!/usr/bin/nu

def paste [] {
  wl-paste | save ("~/Pictures" | path join (date now | format date "%s%3f.png"))
}

def captureScreen [] {
  grim - | wl-copy
}

def captureArea [] {
  grim -g (slurp) - | wl-copy
}

def main [ACTION: string] {
  match $ACTION {
    "copyarea" => {
      captureArea
    }
    "copyscreen" => {
      captureScreen
    }
    "savearea" => {
      captureArea
      paste
    }
    "savescreen" => {
      captureScreen
      paste
    }
  }
}

loop {
  print -n (date now | format date "\r%R")
  sleep 1min
}

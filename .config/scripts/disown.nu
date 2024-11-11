def --wrapped main [...args] {
  sh -c '"$@" >/dev/null 2>&1 &' $args.0 ...$args
}

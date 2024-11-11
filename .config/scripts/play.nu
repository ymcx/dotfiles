def main [] {
    loop {
        for $i in (ls -m | where type =~ "audio" | get name | shuffle) {
            ffplay $i
        }
    }
}

def main [FILE: string] {
  let SUM = sha256sum $FILE | str substring 0..63
  if not ($"/tmp/($SUM)" | path exists) {
    mkdir $"/tmp/($SUM)"
    pdftoppm -jpeg $FILE /tmp/($SUM)/
  }
  chafa --fit-width /tmp/($SUM)/*
}

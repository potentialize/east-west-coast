# used by loss.rb

/^#/ {
  # copy comments
  print $0
}

/loss/ {
  # copy package loss entries
  # NOTE: set 1000 -> display as bar in plot
  printf("%s 1000\n", $1)
}

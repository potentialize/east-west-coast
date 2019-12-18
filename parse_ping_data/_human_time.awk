/^[0-9]+/ {
  # date -ud @1574672117
  "date" | getline d;
  print d
}

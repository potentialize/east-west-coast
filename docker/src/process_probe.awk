BEGIN {
  # do not automatically insert \n on print
  ORS=""

  # print epoch time in front of each probe result
  "date +%s" | getline date
  print date, ""
}

# network down or other issue
/^connect:/ || /^ping:/ {
  print $0
}

# extract data
/^1 packets transmitted,/ {
  if ($4==1) {
      getline
      split($4, metrics, "/")
      print metrics[1]
  }
  else {
      print "loss"
  }
}

END {
  # terminate record manually
  print "\n"
}

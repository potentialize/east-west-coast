- file sizes in human readable format: ls -l -h
- find special cases: cat ams-to-sanfran.txt | grep -E "ping|connect|loss"
- first part of file: head
- last part of file: tail

## gnuplot range nov 26 6:30 to 7:30
gnuplot -c parse_ping_data/plot_range.gp final ams-to-nyc.txt range-nov-26-0630-0730 1574749800 1574753400

## gnuplot frame (ams-nyc)
gnuplot -c parse_ping_data/plot_w_frame.gp final ams-to-nyc.txt frame

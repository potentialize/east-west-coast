#!/usr/bin/env gnuplot

# call program like this: gnuplot -p -c plot.gp 'path/to/data.txt' 'path/to/image.txt'
# e.g. gnuplot -p -c parse_ping_data/plot.gp ping_data/final/nyc-to-sanfran.txt

DATA_ROOT="/home/bruno/potentialize/information_systems_cpe490/east_west_coast/ping_data"

# SCRIPTNAME=ARG0
CAT=ARG1
NAME=ARG2
PREFIX=ARG3
DAY=(ARG4 eq "" ? "full" : ARG4)
MONTH=ARG5


LOGFILE=DATA_ROOT . "/" . CAT . "/" . NAME
LOSSFILE=DATA_ROOT . "/loss/" . NAME

PNGFILE=DATA_ROOT . "/plots/" . PREFIX . "-" . CAT . "-" . DAY . "_" . MONTH . "-" . NAME . ".png"

# colors
RED='red'
BLACK='black'
WHITE='white'

TEXT_COLOR=WHITE
BG_COLOR=BLACK
LOSS_COLOR=WHITE
GRAPH_COLOR='purple'
FRAME_COLOR=RED

# set title NAME
set xlabel "time"
set ylabel "ping (ms)"

set xlabel textcolor rgb TEXT_COLOR
set ylabel textcolor rgb TEXT_COLOR
set border linecolor rgb TEXT_COLOR
set key textcolor rgb TEXT_COLOR

set terminal wxt background rgb BG_COLOR

stats LOGFILE nooutput # get stats
# set xrange [STATS_min_x:STATS_max_x]

set yrange [60:200]

set xdata time

set timefmt "%s" # input time: epoch

if (DAY eq "full") {
    set xrange [1574672115:1575213883] # general min max
    set format x "%b %d" # output time: month day
} else {
    set timefmt "%d/%m/%Y %H:%M" # format for setting ranges
    set xrange [DAY . "/" . MONTH . "/2019 00:00":DAY . "/" . MONTH . "/2019 23:59"] # pick day (1)
    set format x "%H:%M" # output time: month day
    set xlabel "time (" . DAY . " of " . MONTH . ")"
    set timefmt "%s" # reset
}

set terminal wxt size 1366,768 # set window to size of laptop

plot \
    LOGFILE using 1:2 with line lc rgb GRAPH_COLOR title CAT . "/" . NAME, \
    LOSSFILE using 1:2 with impulse lc rgb LOSS_COLOR title "Packet Loss", \
    '-' using 1:2 with impulse lc rgb FRAME_COLOR title "Fragment"
    # 1574748000 1000 # nov 26 6am
    1574749800 1000 # nov 26 6:30am
    # 1574751600 1000 # nov 26 7am
    1574753400 1000# nov 26 7:30am
    EOF

# save plot
set terminal png size 1920,1080 transparent truecolor
set output PNGFILE
replot

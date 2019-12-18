#!/usr/bin/env gnuplot

# call program like this: gnuplot -p -c plot.gp 'path/to/data.txt' 'path/to/image.txt'
# e.g. gnuplot -p -c parse_ping_data/plot.gp ping_data/final/nyc-to-sanfran.txt

DATA_ROOT="/home/bruno/potentialize/information_systems_cpe490/east_west_coast/ping_data"

# SCRIPTNAME=ARG0
CAT=ARG1
FILES=ARG2
PREFIX=ARG3

PNGFILE=DATA_ROOT . "/plots_groups/" . PREFIX . "-" . CAT . "-" . FILES . ".png"

# colors
RED='red'
BLACK='black'
WHITE='white'

TEXT_COLOR=WHITE
BG_COLOR=BLACK
LOSS_COLOR=WHITE
GRAPH_COLOR='purple'

# set title NAME
set xlabel "time"
set ylabel "ping (ms)"

set xlabel textcolor rgb TEXT_COLOR
set ylabel textcolor rgb TEXT_COLOR
set border linecolor rgb TEXT_COLOR
set key textcolor rgb TEXT_COLOR

set terminal wxt background rgb BG_COLOR

set xdata time
set timefmt "%d/%m/%Y %H:%M" # format for setting ranges
set yrange [60:200]

# set xrange ["27/11/2019 00:00":"28/11/2019 00:00"] # pick day (1)

# FILE MIN MAX from stats
# stats LOGFILE nooutput # get stats
# set xrange [STATS_min_x:STATS_max_x]

set timefmt "%s" # input time: epoch
set xrange [1574672115:1575213883] # general min max

set format x "%b %d" # output time: month day
set terminal wxt size 1366,768 # set window to size of laptop

# SO example code:
# colors = "red green #0000FF"
# set for [i=1:words(colors)] linetype i lc rgb word(colors, i)

plot for [FILE in FILES] DATA_ROOT . "/" . CAT . "/" . FILE \
    using 1:2 with line title CAT . "/" . FILE

# save plot
set terminal png size 1920,1080 transparent truecolor
set output PNGFILE
replot

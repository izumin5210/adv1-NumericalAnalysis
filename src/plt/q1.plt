set terminal postscript eps enhanced "Times-Roman,32"
set datafile separator ","

set grid

out = "img/"
src = "data/q1/"

set output out."q1-1.eps"
set xlabel "t"
set ylabel "x"

plot [0:10][:] src."ans.csv" using 1:2 with linespoints title "ans",\
     src."euler.csv" using 1:2 with linespoints title "euler",\
     src."heun.csv" using 1:2 with linespoints title "heun",\
     src."rk.csv" using 1:2 with linespoints title "runge kutta"

set logscale
file = src."error.csv"
set output out."q1-2.eps"
set xlabel "h"
set ylabel "error"

plot file using 1:2 with linespoints title "euler",\
     file using 1:3 with linespoints title "heun",\
     file using 1:4 with linespoints title "runge kutta"

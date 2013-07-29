set terminal postscript eps enhanced "Times-Roman,32"
set datafile separator ","

set grid
unset key

out = "img/"
src = "data/q3/"

set output out."q3-rand.eps"
set xlabel "n"
set ylabel "Random Number"

plot [0:1024][:] src."rand.csv" using 1:2 with points

set output out."q3-tf.eps"
set xlabel "n"
set ylabel "f_{n}"

plot [0:1024][:] src."tf.csv" using 1:2 with points

set output out."q3-ps.eps"
set xlabel "\omega"
set ylabel "power spectrum"

plot src."ps.csv" using 1:2 with lines

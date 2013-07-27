set terminal postscript eps enhanced "Times-Roman,32"
set datafile separator ","

set grid
unset key

out = "img/"
src = "data/q3/"

set output out."q3-tf.eps"
set xlabel "t"
set ylabel "f(t)"

plot [0:25][-1:1] src."tf.csv" using 1:2 with lines,\
#    src."tf.csv" using 1:3 with points

set output out."q3-ps.eps"
set xlabel "k"
set ylabel "power spectrum"

plot src."ps.csv" using 1:2 with lines

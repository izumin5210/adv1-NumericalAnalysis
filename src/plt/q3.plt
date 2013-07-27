set terminal postscript eps enhanced "Times-Roman,32"
set datafile separator ","

set grid
unset key

out = "img/"
src = "data/q3/"

set output out."q3-tf.eps"
set xlabel "t"
set ylabel "f(t)"

plot [0:1024][:] src."tf.csv" using 1:2 with lines,\

set output out."q3-ps.eps"
set xlabel "k"
set ylabel "power spectrum"

plot [0:1024][:] src."ps.csv" using 1:2 with lines

set terminal postscript eps enhanced "Times-Roman,32"
set datafile separator ","

set grid
unset key

out = "img/"
src = "data/q2/"

set xlabel "t"
set ylabel "z"

set output out."q2-tz.eps"
plot src."result.csv" using 1:4 with lines

set xlabel "x"
set ylabel "z"

set output out."q2-xz.eps"
plot src."result.csv" using 2:4 with lines

set xlabel "x"
set ylabel "y"
set zlabel "z"

set output out."q2-xyz.eps"
splot src."result.csv" using 2:3:4 with lines

set xlabel "z_{n}"
set ylabel "z_{n+1}"

set output out."q2-lorenz_map.eps"
plot src."z_max.csv" using 1:2 with points
set terminal postscript eps enhanced "Times-Roman,32"
set datafile separator ","

set grid
unset key

out = "img/"
src = "data/q2/"

set output out."q2-tz.eps"
plot src."result.csv" using 1:4 with lines

set output out."q2-xz.eps"
plot src."result.csv" using 2:4 with lines

set output out."q2-xyz.eps"
splot src."result.csv" using 2:3:4 with lines

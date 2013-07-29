# coding: utf-8
$:.unshift File.dirname(__FILE__)

require 'csv'

def dft(data, n, l)
  result = Array.new
  n.times do |k|
    result << [k*Math::PI/L, data.inject(Complex(0)) { |sum, p| sum += Complex.polar(p[1], -2*k*p[0]*Math::PI/n) }]
  end
  result
end

def power_spectrum(data, l)
  data.map { |p| [p[0], p[1].abs2 / (2*l)] }
end

DATA_DIR = ARGV[0] + '/q3/'
RAND_FILE, TZ_FILE, PS_FILE = 'rand.csv', 'tf.csv', 'ps.csv'

OMEGA, L = 5.026548, 25.0
N = 1024

f = lambda { |t| if (0 <= t and t <= 2*L) then (Math.cos(OMEGA*t)**3)/2 else 0 end }

data = Array.new
r = Random.new(Time.now.to_i)

CSV.open(DATA_DIR+RAND_FILE, 'w') do |csv|
  N.times do |i|
    rand = r.rand(-1.0..1.0)
    data << [i, f.call(2*L/(N-1)*i)+rand]
    csv << [i, rand]
  end
end

CSV.open(DATA_DIR+TZ_FILE, 'w') do |csv|
  data.each { |p| csv << p }
end

CSV.open(DATA_DIR+PS_FILE, 'w') do |csv|
  power_spectrum(dft(data, N, L), L).each { |row| csv << row }
end
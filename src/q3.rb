# coding: utf-8
$:.unshift File.dirname(__FILE__)

require 'csv'

def dft(k, upper_n, fn)
  upper_f = Array.new
  upper_n.times do |n|
    upper_f.push Complex.polar(fn[n], 2*k*n*Math::PI/upper_n)
  end
  upper_f
end

def power_spectrum
end

DATA_DIR = ARGV[0] + '/q3/'
TZ_FILE = "tf.csv"

OMEGA, L = 5.026548, 25.0
N = 1024

f = lambda { |t| if (0 <= t and t <= 2*L) then (Math.cos(OMEGA*t)**3)/2 else 0 end }


CSV.open(DATA_DIR+TZ_FILE, 'w') do |csv|
  r = Random.new(Time.now.to_i)
  N.times do |i|
    csv << [L/N*i, f.call(L/N*i)+r.rand(-1.0..1.0)]
  end
end
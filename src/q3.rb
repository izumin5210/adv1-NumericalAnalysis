# coding: utf-8
$:.unshift File.dirname(__FILE__)

def dft(k, upper_n, f)
  upper_f = Array.new
  upper_n.times do |n|
    upper_f.push Complex.polar(f.call(n), 2*k*n*Math::PI/upper_n)
  end
  upper_f
end

OMEGA, L = 5.026548, 25

f = lambda { |t| if (0 <= t and t <= 2L) then (Math.cos(OMEGA*t)**3)/2 else 0 end }


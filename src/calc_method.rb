# coding: utf-8

EULER = lambda { |dx, t, x, h| x + h * dx.call(t, x) }

HEUN = lambda do |dx, t, x, h|
  k1 = h * dx.call(t, x)
  k2 = h * dx.call(t+h/2, x+k1/2)
  x + k2
end

RUNGE_KUTTA = lambda do |dx, t, x, h|
  k1 = h * dx.call(t, x)
  k2 = h * dx.call(t+h/2, x+k1/2)
  k3 = h * dx.call(t+h/2, x+k2/2)
  k4 = h * dx.call(t+h, x+k3)
  x + (k1 + 2*k2 + 2*k3 + k4) / 6
end


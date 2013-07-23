# coding: utf-8

EULER = lambda { |dx, t, x, h| x + h * dx.call(t, x) }

HEUN = lambda do |dx, t, x, h|
  k = EULER.call(dx, t, x, h)
  x + h/2 * (dx.call(t, x) + dx.call(t+h, k))
end

RUNGE_KUTTA = lambda do |dx, t, x, h|
  k1 = h * dx.call(t, x)
  k2 = h * dx.call(t+h/2, x+k1/2)
  k3 = h * dx.call(t+h/2, x+k2/2)
  k4 = h * dx.call(t+h, x+k3)
  x + (k1 + 2*k2 + 2*k3 + k4) / 6
end


RUNGE_KUTTA_S = lambda do |dx, t, x, h|
  k1 = dx.map { |df| h * df.call(t, x) }
  k2 = dx.map { |df| h * df.call(t+h/2, x.map.with_index { |f, i| f+k1[i]/2 }) }
  k3 = dx.map { |df| h * df.call(t+h/2, x.map.with_index { |f, i| f+k2[i]/2 }) }
  k4 = dx.map { |df| h * df.call(t+h, x.map.with_index { |f, i| f+k3[i] }) }
  x.map.with_index { |f, i| f + (k1[i] + 2*k2[i] + 2*k3[i] + k4[i])/6 }
end

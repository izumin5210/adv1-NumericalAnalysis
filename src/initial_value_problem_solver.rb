# coding: utf-8

require 'bigdecimal'
require 'bigdecimal/util'

class InitialValueProblemSolver
  attr_reader :t, :x
  attr_accessor :method, :h

  def initialize(t0, tn, h, x0, dx, method)
    @t0, @tn, @h, @x0 = t0.to_d, tn.to_d, h.to_d, x0
    @dx = dx
    @method = method
    reset
  end

  def reset
    @t, @x = @t0, @x0
  end

  def step
    @x = @method.call(@dx, @t, @x, @h)
    @t += @h
    # puts "t=#{t}, #{@x.inspect}"
    [@t.to_f, @x]
  end

  def finish?
    @t >= @tn
  end

  def exec
    p = Array.new
    until finish? do p.push step end
    p
  end
end

# coding: utf-8
$:.unshift File.dirname(__FILE__)

require 'csv'
require 'initial_value_problem_solver'
require 'calc_method'

DATA_DIR = ARGV[0] + '/q1/'
ANS_FILE = 'ans.csv'
EULER_FILE = 'euler.csv'
HEUN_FILE = 'heun.csv'
RK_FILE = 'rk.csv'
ERROR_FILE = 'error.csv'

def write(file, solver, method)
  solver.reset
  solver.method = method
  CSV.open(DATA_DIR+file, 'w') do |csv|
    until solver.finish? do csv << solver.step end
  end
end

def calc_error(h, x, solver, method)
  solver.reset
  solver.h, solver.method = h, method
  v = solver.exec.last
  (v[1] - x.call(v[0])).abs 
end

t0, tn, h, x0 = 0.0, 10.0, 0.2, 1.0

dx = lambda { |t, x| Math.cos(t) * x * (2-x) }
x = lambda { |t| 2*Math::E**(2*Math.sin(t)) / (1 + Math::E**(2*Math.sin(t))) }

solver = InitialValueProblemSolver.new(t0, tn, h, x0, dx, EULER)

CSV.open(DATA_DIR+ANS_FILE, 'w') do |csv|
  (t0..tn).step(h) { |ti| csv << [ti, x.call(ti)] }
end

write(EULER_FILE, solver, EULER)
write(HEUN_FILE, solver, HEUN)
write(RK_FILE, solver, RUNGE_KUTTA)

CSV.open(DATA_DIR+ERROR_FILE, 'w') do |csv|
  0.upto(9) do |n|
    h = 0.2 * 2 ** (-n)
    euler_error = calc_error(h, x, solver, EULER)
    heun_error = calc_error(h, x, solver, HEUN)
    rk_error = calc_error(h, x, solver, RUNGE_KUTTA)
    csv << [h, euler_error, heun_error, rk_error]
  end
end

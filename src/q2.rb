# coding: utf-8
$:.unshift File.dirname(__FILE__)

require 'csv'
require 'initial_value_problem_solver'
require 'calc_method'

DATA_DIR = ARGV[0] + '/q2/'
RESULT_FILE = 'result.csv'

h = 0.001
t0, tn = 0.0, 80.0
x0, y0, z0 = 0.0, 1.1, 0.0

SIGMA, R, B = 10.0, 28.0, 8.0/3.0

dx = lambda { |t, x| -SIGMA*x[0] + SIGMA*x[1] }
dy = lambda { |t, x| R*x[0] - x[1] - x[0]*x[2] }
dz = lambda { |t, x| -B*x[2] + x[0]*x[1] }

solver = InitialValueProblemSolver.new(t0, tn, h, [x0, y0, z0], [dx, dy, dz], RUNGE_KUTTA_S)

CSV.open(DATA_DIR+RESULT_FILE, 'w') do |csv|
  until solver.finish?
    x = solver.step
    csv << [x[0], x[1][0], x[1][1], x[1][2]]
  end
end

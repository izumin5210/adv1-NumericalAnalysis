# coding: utf-8
$:.unshift File.dirname(__FILE__)

require 'csv'
require 'matrix'
require 'initial_value_problem_solver'
require 'calc_method'

DATA_DIR = ARGV[0] + '/q2/'
RESULT_FILE = 'result.csv'

h = 0.01
t0, tn = 0.0, 80.0
x0 = Vector[0.0, 1.1, 0.0]

SIGMA, R, B = 10.0, 28.0, 8.0/3.0

dx = lambda do |t, x|
  Vector[
    -SIGMA*x[0] + SIGMA*x[1],
    R*x[0] - x[1] - x[0]*x[2],
    -B*x[2] + x[0]*x[1]
  ]
end

solver = InitialValueProblemSolver.new(t0, tn, h, x0, dx, RUNGE_KUTTA)

CSV.open(DATA_DIR+RESULT_FILE, 'w') do |csv|
  until solver.finish?
    x = solver.step
    csv << [x[0], x[1][0], x[1][1], x[1][2]]
  end
end

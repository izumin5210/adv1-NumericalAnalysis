# coding: utf-8
$:.unshift File.dirname(__FILE__)

require 'csv'
require 'matrix'
require 'initial_value_problem_solver'
require 'calc_method'

DATA_DIR = ARGV[0] + '/q2/'
RESULT_FILE = 'result.csv'
MAX_FILE = 'z_max.csv'

# h = 0.01
h = 0.0001
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

z, z_max = Array.new, Array.new

CSV.open(DATA_DIR+RESULT_FILE, 'w') do |csv|
  until solver.finish?
    print "%07.3f%% \r" % [solver.t.to_f/tn*100]
    x = solver.step
    csv << [x[0], x[1][0], x[1][1], x[1][2]]
    z.push x[1][2]
  end
end

print "\n"

(z.size-2).times { |i| z_max.push z[i+1] if z[i] < z[i+1] and z[i+2] < z[i+1]}

CSV.open(DATA_DIR+MAX_FILE, 'w') do |csv|
  (z_max.size-2).times { |i| csv << [z_max[i], z_max[i+1]] }
end


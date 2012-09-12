require"rubygems"
require"csv"


dates = []
steps = []
weights = []
times = []
modes = []

CSV.foreach("quantified.csv") do |line|
  dates << line[0]
  steps << line[1]
  weights << line[2]
  times << line[3]
  modes << line[4]
end

puts dates.last + steps.last.to_s + weights.last.to_s + times.last.to_s + modes.last.to_s

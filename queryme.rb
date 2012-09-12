require"rubygems"
require"date"
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

def announce_date dates
  if dates.last == Date.today.to_s
    "Today"
  else
    "As of the date " + dates.last
  end
end

def announce_walk steps
  if steps.last.nil?
    ", there was no step data logged."
  else
    ", I logged " + steps.last + " steps."
  end
end

puts announce_date(dates) + announce_walk(steps)

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
    ", there was no steps data logged."
  else
    ", I logged " + steps.last + " steps."
  end
end

def announce_weight weights
  if weights.last.nil?
    " No weight data was logged."
  else
    " I weighed " + weights.last + " pounds "
  end
end

def announce_time times, modes
  if times.last.nil?
    return
  else
    "on " + times.last + modes.last + "."
  end
end

def how_many_days? dates
  dates.size - 1
end

puts announce_date(dates) + announce_walk(steps) + announce_weight(weights) + announce_time(times,modes)

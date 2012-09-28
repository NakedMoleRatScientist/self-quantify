#!/usr/bin/env ruby
require"rubygems"
require"date"
require"csv"

class DataLog
  attr_reader :dates, :steps, :weights, :times
  def initialize 
    @dates = {:title => "dates", :data => []}
    @steps = {:title => "steps", :data => []}
    @weights = {:title => "weights", :data => []}
    @times = {:title => "time", :data => []}
    n = 0
    CSV.foreach("quantified.csv") do |line|
      if n =! 0        
        @dates[:data] << line[0]
        @steps[:data] << line[1]
        @weights[:data] << line[2]
        @times[:data] << line[3]
      end
      n += 1
    end
  end

  def print_weights 
    @weights.each do |w|
      print w.to_s + " , "
    end
  end

end



class AnnounceToday
  def initialize data
    @data = data
  end

  def date 
    if @data.dates.last == Date.today.to_s
      "Today"
    else
      "As of the date " + @data.dates.last
    end
  end

  def step
    if @data.steps.last.nil?
      ", there were no steps data logged."
    else
      ", I logged " + @data.steps.last + " steps."
    end
  end

  def weight
    if @data.weights.last.nil?
      " No weight data was logged."
    else
      " I weighed " + @data.weights.last + " pounds "
    end
  end

  def time 
    if @data.times.last.nil?
      return
    else
      "on " + @data.times.last.to_s + "."
    end
  end

  def announce 
    puts date + step + weight + time
  end
  
end

class WeightAnalyzer  
  def initialize data 
    @weights = data.weights
  end

  def rolling_average 
    sets = @weights.size / 5
    n = 0
    sets.times do
      total = 0
      5.times do
        total += 1
        n += 1
      end
      average = total / 5
    end
  end
end

data = DataLog.new()
today = AnnounceToday.new(data)
analyze_weight = WeightAnalyzer.new(data)

case ARGV[0]
when "today"
  today.announce()
when "analyze"
  analyze_weight.rolling_average
end

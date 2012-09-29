#!/usr/bin/env ruby
require"rubygems"
require"debugger"
require"date"
require"csv"
require"json"

class DataLog
  attr_reader :dates, :steps, :weights, :times
  def initialize 
    @dates = {:title => "dates", :data => []}
    @steps = {:title => "steps", :data => []}
    @weights = {:title => "weights", :data => []}
    @times = {:title => "time", :data => []}
    n = 0
    CSV.foreach("quantified.csv") do |line|
      if n != 0        
        @dates[:data] << line[0]
        @steps[:data] << line[1]
        @weights[:data] << line[2]
        @times[:data] << line[3]
      end
      n += 1
    end
  end

  def last_date 
    return @dates[:data].last
  end

  def last_step 
    return @steps[:data].last
  end

  def last_weight 
    return @weights[:data].last
  end

  def last_time 
    return @times[:data].last
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
    date = @data.last_date
    if date == Date.today.to_s
      "Today"
    else
      "As of the date " + date
    end
  end

  def step
    step = @data.last_step
    if step.nil?
      ", there were no steps data logged."
    else
      ", I logged " + step + " steps."
    end
  end

  def weight
    weight = @data.last_weight
    if weight.nil?
      " No weight data was logged."
    else
      " I weighed " + weight + " pounds "
    end
  end

  def time
    time = @data.last_time
    if time.nil?
      return
    else
      "on " + time + "."
    end
  end

  def announce 
    puts date + step + weight + time
  end
  
end

class WeightAnalyzer  
  def initialize data 
    @weights = data.weights[:data].compact
  end

  def rolling_average
    averages = []
    sets = @weights.size / 5
    n = 0
    sets.times do
      total = 0
      5.times do
        total += @weights[n].to_f
        n += 1
      end
      averages << (total / 5).round(2)
    end
    return averages
  end
end

data = DataLog.new()
today = AnnounceToday.new(data)
analyze_weight = WeightAnalyzer.new(data)

case ARGV[0]
when "today"
  today.announce()
when "analyze"
  puts JSON.generate(analyze_weight.rolling_average)
end

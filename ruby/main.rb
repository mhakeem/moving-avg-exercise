#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'lib/moving_average'

def compute(window_size, values)
  moving_average = MovingAverage.new
  result = moving_average.compute(window_size, values)
  puts "window size: #{window_size}\nvalues: #{values}\nmoving avg: #{result}"
end

def benchmark
  start = Time.now
  yield
  finish = Time.now
  puts "\nTook #{finish-start} seconds"
end

benchmark do
  compute(3, [0, 1, 2, 3])
  puts '-'*10
  compute(5, [0, 1, -2, 3, -4, 5, -6, 7, -8, 9])

  ## uncomment any of the lines bellow to benchmark larger numbers
  # puts '-'*10
  # compute(1000, (1..1_000_000).to_a) 
  ## slow solution: 5.8299844 seconds
  ## better solution: 2.4997761 seconds

  # puts '-'*10
  # compute(10000, (1..1_000_000).to_a) 
  ## slow solution: 30.4428852 seconds
  ## better solution: 2.6338202 seconds
end
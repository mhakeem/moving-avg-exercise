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
end
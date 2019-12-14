# encoding: utf-8
<<~DOC
SPECIFICATION 
A function that accepts inputs for an integer window size and an array of double-precision floating point values, and returns an array of double-precision floating point values. The nth value of the output array should be the average after processing the nth element of the input array. The average should be computed as a cumulative average until the number of elements processed equals the window size, and as a simple moving average using the window size afterward. 

EXAMPLES 
compute(3, [0, 1, 2, 3]) => [0, 0.5, 1, 2]  
 
compute(5, [0, 1, -2, 3, -4, 5, -6, 7, -8, 9]) =>  [0, 0.5, -0.333333333333333, 0.5, -0.4, 0.6, -0.8, 1, -1.2, 1.4]
_______________________

inputs:
----------
1- an integer window size  
2- an array of double-precision floating point values

return:
----------
- an array of double-precision floating point values

specs:
----------
- The nth value of the output array should be the average after processing the nth element of the input array.
- The average should be computed as a cumulative average until the number of elements processed equals the window size, 
- and as a simple moving average using the window size afterward
    
    N   AVG
[   
    0,  0/1       = 0
    1,  (0+1)/2   = 0.5
    2,  (0+1+2)/3 = 1
    3   (1+2+3)/3 = 2 (3 is a window size) 
]

    N   AVG
[
    0,  0/1             = 0
    1,  (0+1)/2         = 0.5
    -2, (0+1-2)/3       = -0.333
    3,  (0+1-2+3)/4     = 0.5
    -4, (0+1-2+3-4)/5   = -0.4
    5,  (1-2+3-4+5)/5   = 0.6
    -6, (-2+3-4+5-6)/5  = -0.8
    7,  (3-4+5-6+7)/5   = 1
    -8, (-4+5-6+7-8)/5  = -1.2
    9   (5-6+7-8+9)/5   = 1.4
]
DOC

class MovingAverage
  def compute(window_size, values)
    check(window_size, values)
    result = []

    values.each_with_index do |value, index|
      raise TypeError, 'found a non-numeric value. values must be an array of floating point numbers' unless value.is_a? Numeric
      count = index + 1

      if count <= window_size
        # cumulative average
        result << mean(values[0..index], count)
      else
        # simple moving average
        result << mean(values[(count-window_size)..index], window_size)
      end
    end
    result
  end

  def mean(values, number)
    values.inject(:+)/number.to_f
  end

  private
  def check(window_size, values)
    size = values.size
    raise TypeError, 'window_size must be an integer' unless window_size.is_a? Integer
    raise TypeError, 'values nust be an array' unless values.is_a? Array
    raise ArgumentError, 'values cannot be an empty array' if values.empty?
    raise ArgumentError, 'window_size cannot be less than 2' if window_size < 2
    raise ArgumentError, 'values cannot have less than 2 items' if size < 2
    raise ArgumentError, 'window_size cannot be greater than the values array size' if window_size > size
  end
end
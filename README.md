# Moving Average Exercise

## Steps to execute the code

### System Requirements
- Ruby (version 2.6 or greater)
    - to install Ruby, choose your OS, and follow the steps until the **Configuring Git** section as described in this link https://gorails.com/setup/ubuntu/18.04.
- OS: Preferably Linux or macOS

**NOTE**: This code was tested with Ruby 2.6.5 on Ubuntu 18.04

### Libraries installation (optional)
The code should run without any library installation if using ruby 2.6. If any issues occur due to missing gems (libraries), run the following command:
```sh
bundle install
```

### Running the code
There are a test suite and the main program. 
#### The test suite
It documents and checks if the code follows the specifications and assumptions. Use the following command to run it:
```sh
rake
```
If that doesn't work, use the following command:
```sh
ruby spec/moving_average_spec.rb
```
#### The main program 
It has an example code that outputs the window size, values array, the results array of moving averages, and the time it took to execute. There are a couple of commented codes so that you can uncomment either of them and check the code performance.
To run it, use the following command:
```sh
ruby main.rb
```

## Solution description
### Assumptions
- According to the specification, the window size is an integer value, so the code raises an exception if given a non-integer value
- Also, as mentioned in the specification, the input array has elements with the type of double-precision float. The code raises an exception if an array element is of a different type than double or integer.
- The code raises an error if an empty array was given
- We force a minimum for `window_size` to be 2 as it makes no sense to have an average for something smaller than that window. So the code raises an exception if the value is smaller than `2`.
- We force a minimum of 2 elements in the `values` array as you need more than 1 element to calculate an average. So the code raises an exception if the array size is smaller than `2`.
- We assume that the window size cannot be greater than the size of the array elements, as it sounds unreasonable to have a window bigger than the total amount of elements in the array. So the code raises an exception if the window is greater than the size of the array elements.

### The solution
The solution is made out of a class called `MovingAverage`. It has a constructor that initializes the `@sum` variable to 0, and the `@result` variable to an empty array. This class has a function called `compute`. It takes 2 arguments: `window_size`, which is an integer, and `values`, which is a double-precision float type array. 

The function starts by checking the arguments for any issues by following the specification requirements and the assumptions described in the **Assumptions** section above.  Once passed, we then start iterating on the `values` array. The code first checks if an element is a double type or else it raises an exception.

We start by keeping track of the array counter with a variable `count`. So, if it is the first element in the loop, the value in `count` becomes 1, which is done by adding 1 to the current element's index. It keeps incrementing the value with each iteration.

The variable `number` is then set to equal to the value in `count`. `number` is what we use to divide it with the sum of elements to calculate the average/mean (e.g. `mean = sum/number`). We then add the current element `value` to the `@sum`  variable.

We then check if `count` is still smaller (not greater) than or equal `window_size`. If that is the case, we call the `mean` function, which calculates the average and passes `@sum` and `number` as arguments. The `mean` outcome is appended to `@results` array. Thus, calculating the cumulative average.

However, if `count` is bigger than `window_size`, we follow the specification by calculating the sum of the recent elements, including the current one, and those elements are within the window size. To do that, we first set `number` to equal `window_size`  to divide the sum with it to get the average. We also subtract a value from `@sum`. That value is not within the current window size but existed in the previous window size in the previous iteration. We get that value by getting its index in the `values` array by subtracting `index` with `window_size`. After that, the new `@sum` with `number` to the `mean` function. The outcome is then appended to `@result`. Thus, calculating a simple moving average.

To illustrate the situation above, we assume that we have a window size of `3`, and an array of `[0, 1, 2, 3]`.
```ruby
# initialized variables
@sum = 0
@result = []

# `compute` parameters
window_size = 3
values = [0, 1, 2, 3]

### iteration 1
# [0, 1, 2, 3]
#  ^
value = 0
index = 0
count = index + 1 = 1
number = count = 1
@sum += value 
# @sum = 0 + 0 = 0
# this simulates as if we are calculating the sum for these array values. the first one in this case
# [0, 1, 2, 3]
#  ^ 

if count > window_size # which is false
    # skip
    # this means we will calculate the cumulative average

@result << mean(0, 1)
# mean -> 0/1 = 0
# @result = [0]

### iteration 2
# [0, 1, 2, 3]
#     ^
value = 1
index = 1
count = index + 1 = 2
number = count = 2
@sum += value  # which is 1
# @sum = 0 + 1 = 1
# this simulates as if we are calculating the sum for these array values
# [0, 1, 2, 3]
#  ^  ^

if count > window_size # which is false
    # skip
    # this means we will calculate the cumulative average

@result << mean(1, 2)
# mean -> 1/2 = 1/2 = 0.5
# @result = [0, 0.5]

### iteration 3
# [0, 1, 2, 3]
#        ^
value = 2
index = 2
count = index + 1 = 3
number = count = 3
@sum += value  # which is 3
# @sum = 1 + 2 = 3
# this simulates as if we are calculating the sum for these array values
# [0, 1, 2, 3]
#  ^  ^  ^

if count > window_size # which is false
    # skip
    # this means we will calculate the cumulative average


@result << mean(3, 3)
# mean -> 3/3 = 3/3 = 1.0
# @result = [0, 0.5, 1.0]

### iteration 4
# [0, 1, 2, 3]
#           ^
value = 3
index = 3
count = index + 1 = 4
number = count = 4
@sum += value  # which is 6
# @sum = 3 + 3 = 6

if count > window_size # which is true
    # this means we will calulate the simple moving average
    number = window_size
    # number = 3
    @sum -= values[index-window_size]
    # index - window_size = 3 - 3 = 0
    # values[0] --> 0
    # @sum = 1+2+3-0 = 6
    # this simulates as if we are calculating the sum for these array values; like shifting to the new values in the array for the given window size
    # [0, 1, 2, 3]
    #     ^  ^  ^

@result << mean(6, 3)
# mean -> 6/3 = 2.0
# @result = [0, 0.5, 1.0, 2.0]
```

### Notes
The given solution is the optimal one, in my opinion. I first applied a naive approach shown below.
```ruby
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
```

The time complexity for that was `O(n*m)` where `n` is the number of elements in the `values` array, and `m` is the window size that recalculated the sum and returned the average whether it was cumulative or simple moving average. So when a window is large, the sum is recalculated iteratively. I realized the slowness after passing a thousand as window size and a million element array shown below.
```ruby
compute(1000, (1..1_000_000).to_a) 
```
It took 5.8299844 seconds with the simple approach. However, it took half of that with the optimal approach, which is 2.4997761 seconds.

I made another test after increasing the window size to ten thousand, as shown below.
```ruby
compute(10000, (1..1_000_000).to_a) 
```
It took 30.4428852 seconds with the naive solution. With the optimized version, it took only 2.6338202 seconds, which is way better than 30 seconds.

You can test on your machine by uncommenting one of these lines in `main.rb`. The execution will vary depending on the machine, but these tests prove that my solution is efficient.

## Time & Space complexity analysis
### Time complexity analysis
`O(n)`, where `n` is the number of elements in the `values` array.

The reason is that we are iterating through each element in the `values` array to calculate the moving average.

### Space complexity analysis
`O(n)`, where `n` is the number of moving average results that equals to the number of elements in the `values` array.

The reason is that we are storing the moving average results in a separate array called `@results` since we are iterating through each element in the `values` array. Also, the specification requires "the nth value of the output array should be the average after processing the nth element of the input array."
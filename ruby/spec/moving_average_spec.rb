# encoding: utf-8

require 'minitest/autorun'
require_relative '../lib/moving_average'

describe MovingAverage do
  before do 
    @moving_average = MovingAverage.new
  end

  describe '#compute' do
    describe 'when given a window size of 3 and an array of [0, 1, 2, 3]' do
      it 'must return an array of averages that equals to [0, 0.5, 1, 2]' do
        _(@moving_average.compute(3, [0, 1, 2, 3])).must_equal [0, 0.5, 1, 2]
      end
    end

    describe 'when given a window size of 5 and an array of [0, 1, -2, 3, -4, 5, -6, 7, -8, 9]' do
      it 'must return an array of averages that equals to [0, 0.5, -0.3333333333333333, 0.5, -0.4, 0.6, -0.8, 1, -1.2, 1.4]' do
        _(@moving_average.compute(5, [0, 1, -2, 3, -4, 5, -6, 7, -8, 9])).must_equal [0, 0.5, -0.3333333333333333, 0.5, -0.4, 0.6, -0.8, 1, -1.2, 1.4]
      end
    end

    describe 'when given a non-inetger value to window_size' do
      it 'must throw a TypeError exception' do
        err = assert_raises(TypeError) { @moving_average.compute('3', [0, 1, 2, 3]) }
        _(err.message).must_match 'window_size must be an integer'
      end
    end

    describe 'when given a non-array argument to values' do
      it 'must throw a TypeError exception' do
        err = assert_raises(TypeError) { @moving_average.compute(3, '[0, 1, 2, 3]') }
        _(err.message).must_match 'values nust be an array'
      end
    end
    
    describe 'when given an empty array for values' do
      it 'must throw a ArgumentError exception' do
        err = assert_raises(ArgumentError) { @moving_average.compute(3, []) }
        _(err.message).must_match 'values cannot be an empty array'
      end
    end
   
    describe 'when given a window_size smaller than 2' do
      it 'must throw a ArgumentError exception' do
        err = assert_raises(ArgumentError) { @moving_average.compute(1, [0, 1, 2, 3]) }
        _(err.message).must_match 'window_size cannot be less than 2'
      end
    end

    describe 'when given a array smaller than 2 to values' do
      it 'must throw a ArgumentError exception' do
        err = assert_raises(ArgumentError) { @moving_average.compute(3, [0]) }
        _(err.message).must_match 'values cannot have less than 2 items'
      end
    end
    
    describe 'when given a window_size to be greater than the size values array' do
      it 'must throw a ArgumentError exception' do
        err = assert_raises(ArgumentError) { @moving_average.compute(5, [0, 1, 2, 3]) }
        _(err.message).must_match 'window_size cannot be greater than the values array size'
      end
    end
    
    describe 'when values has a non-numeric element' do
      it 'must throw a TypeError exception' do
        err = assert_raises(TypeError) { @moving_average.compute(3, [0, '1', 2, 3]) }
        _(err.message).must_match 'ound a non-numeric value. values must be an array of floating point numbers'
      end
    end
  end
end
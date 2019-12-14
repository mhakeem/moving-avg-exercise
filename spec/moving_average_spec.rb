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
  end
end
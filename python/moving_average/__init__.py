class MovingAverage:
    def __init__(self):
        self.__sum = 0
        self.__result = []

    def compute(self, window_size, values):
        self._check(window_size, values)
        
        for index, value in enumerate(values):
            if (type(value) != float) and (type(value) != int):
                raise TypeError('found a non-float value. values must be a list of floating point numbers')
            count = index + 1
            number = count
            self.__sum += value

            if count > window_size:
                number = window_size
                self.__sum -= values[index - window_size]
            
            self.__result.append(self._mean(self.__sum, number))
        
        return self.__result
    
    def _mean(self, sum, number):
        # needed to add float() because unittest was converting into integer
        return sum/float(number)
    
    def _check(self, window_size, values):
        if (type(window_size) != int): raise TypeError('window_size must be an int')
        if (type(values) != list): raise TypeError('values nust be an array')
        size = len(values)
        if size == 0: raise ValueError('values cannot be an empty array')
        if window_size < 2: raise ValueError('window_size cannot be less than 2')
        if size < 2: raise ValueError('values cannot have less than 2 items')
        if window_size > size: raise ValueError('window_size cannot be greater than the values array size')
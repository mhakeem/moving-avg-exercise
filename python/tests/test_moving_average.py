import unittest
from moving_average import MovingAverage

class TestMovingAverage(unittest.TestCase):
    def setUp(self):
        self.moving_average = MovingAverage()

    def test_compute_moving_average_example_1(self):
        result = self.moving_average.compute(3, [0, 1, 2, 3])
        output = [0, 0.5, 1, 2]
        self.assertEqual(result, output)
    
    def test_compute_moving_average_example_2(self):
        result = self.moving_average.compute(5, [0, 1, -2, 3, -4, 5, -6, 7, -8, 9])
        output = [0, 0.5, -0.3333333333333333, 0.5, -0.4, 0.6, -0.8, 1, -1.2, 1.4]
        self.assertEqual(result, output)

    def test_compute_fails_with_non_int_window_size(self):
        err_msg = 'window_size must be an int'
        with self.assertRaises(TypeError) as err:
            self.moving_average.compute('3', [0, 1, 2, 3])
        self.assertEqual(str(err.exception), err_msg)

    def test_compute_fails_with_non_list_values(self):
        err_msg = 'values nust be an array'
        with self.assertRaises(TypeError) as err:
            self.moving_average.compute(3, '[0, 1, 2, 3]')
        self.assertEqual(str(err.exception), err_msg)

    def test_compute_fails_with_an_empty_list_values(self):
        err_msg = 'values cannot be an empty array'
        with self.assertRaises(ValueError) as err:
            self.moving_average.compute(3, [])
        self.assertEqual(str(err.exception), err_msg)

    def test_compute_fails_with_window_size_smaller_than_2(self):
        err_msg = 'window_size cannot be less than 2'
        with self.assertRaises(ValueError) as err:
            self.moving_average.compute(1, [0, 1, 2, 3])
        self.assertEqual(str(err.exception), err_msg)

    def test_compute_fails_with_values_smaller_than_2(self):
        err_msg = 'values cannot have less than 2 items'
        with self.assertRaises(ValueError) as err:
            self.moving_average.compute(3, [0])
        self.assertEqual(str(err.exception), err_msg)

    def test_compute_fails_with_window_size_greater_than_values_list(self):
        err_msg = 'window_size cannot be greater than the values array size'
        with self.assertRaises(ValueError) as err:
            self.moving_average.compute(5, [0, 1, 2, 3])
        self.assertEqual(str(err.exception), err_msg)
    
    def test_compute_fails_with_values_list_is_not_float(self):
        err_msg = 'found a non-float value. values must be a list of floating point numbers'
        with self.assertRaises(TypeError) as err:
            self.moving_average.compute(3, [0, '1', 2, 3])
        self.assertEqual(str(err.exception), err_msg)

if __name__ == '__main__':
    unittest.main()
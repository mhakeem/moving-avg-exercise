import functools
import time
from moving_average import MovingAverage

def timer(func):
    """Print the runtime of the decorated function"""
    @functools.wraps(func)
    def wrapper_timer(*args, **kwargs):
        start_time = time.perf_counter()    # 1
        value = func(*args, **kwargs)
        end_time = time.perf_counter()      # 2
        run_time = end_time - start_time    # 3
        print(f"Finished {func.__name__!r} in {run_time:.4f} secs")
        return value
    return wrapper_timer

@timer
def compute(window_size, values):
    moving_average = MovingAverage()
    result = moving_average.compute(window_size, values)
    print("window size: %s\nvalues: %s\nmoving avg: %s" % (window_size, values, result))

if __name__ == '__main__':
    compute(3, [0, 1, 2, 3])
    print('-'*10)
    compute(5, [0, 1, -2, 3, -4, 5, -6, 7, -8, 9])
    # print('-'*10)
    # compute(1000, list(range(1, 1000000))) 
    # print('-'*10)
    # compute(10000, list(range(1, 1000000))) 
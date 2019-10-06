#! /usr/bin/env python3

import numpy as np
import cost_function

Y_GOLDEN = [0.9, 1.6, 2.4, 2.3, 3.1, 3.6, 3.7, 4.5, 5.1, 5.3]
X = np.arange(0, 10, 1)
my_cost = cost_function.cost_function(X, Y_GOLDEN, (1, 0.5))
print("FOUND: Cost = {:02f} ".format(my_cost))

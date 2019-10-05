#! /usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

def hypothesis_linear(theta0=None, theta1=None, x=None):
    """
    Calculate h_{\theta} (x^{(i)}}
    """
    return theta0 + x*theta1

def cost_function(theta0=None, theta1=None, epsilon=None, golden=None, MAX_STEPS=10):
    """
    Calculate the cost function 
    J(\theta_{0}, \theta_{1}) = \frac{1}{2m} \sum_{i=1}^{m} (h_{\theta}(x^{i})-y^{i})^2
    """

    print("Cost Function theta0={} theta1={} epsilon={} golden={}".format(theta0, theta1, epsilon, golden))
    # Number of training elements
    m = len(golden)
    
    x = np.arange(0, m, 1)
    theta0_range = np.arange(theta0, theta0+MAX_STEPS, epsilon)
    theta1_range = np.arange(theta1, theta1+MAX_STEPS, epsilon)

    # Start this out as HUGE so we should always find a lower cost than this
    final_cost = 10000000000

    # Go through all possible values for theta0 and theta1
    # This is not efficient, this is just trying everything........
    for z0 in theta0_range:
        for z1 in theta1_range:
            # Clear out the per loop values
            sum_diff_squared = 0

            # This is the \sum_{i=1}^{m} loop element
            for i in range(m):
                # find the difference between the calculated value from hypothesis_linear and
                # the actual value stored in the golden array
                diff = hypothesis_linear(z0, z1, x[i]) - golden[i]
                # Square and sum to avoid some being too high and some being too low.
                diff_squared = diff * diff
                sum_diff_squared  =sum_diff_squared + diff_squared
            cost = 1/(2*m) * sum_diff_squared
            #print ("Z0 = {:02f} Z1 = {:02f} Cost = {:02f}".format(z0, z1, cost))
            
            # Find the lowest possible cost
            if (cost < final_cost):
                final_cost = cost
                final_theta0 = z0
                final_theta1 = z1
    return final_cost, final_theta0, final_theta1

Y_GOLDEN = [0.9, 1.6, 2.4, 2.3, 3.1, 3.6, 3.7, 4.5, 5.1, 5.3]
cost, theta0, theta1 = cost_function(-2,-2,0.1, Y_GOLDEN, 10)
print("FOUND: Cost = {:02f} Theta0 = {:02f} Theta1 = {:02f}".format(cost, theta0, theta1))

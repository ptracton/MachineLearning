#! /usr/bin/env python3

import numpy at np
import matplotlib.pyplot as plt


def cost_function(theta0=None, theta1=None, epsilon=None, golden=None):
    """
    Calculate the cost function of a linear equation
    of the form h(theta) = theta0 + theta1*x
    """
    if golden is None:
        return False, False, False

    if theta0 is None:
        theta0 = 0

    if theta1 is None:
        theta1 = 0

    if epsilon is None:
        epsilon = 0.1

    MAX_STEPS = 10
    m = len(golden)
    x = np.arange(0, m, 1)
    theta0_range = np.arange(theta0, theta0+MAX_STEPS, MAX_STEPS)


Y_GOLDEN = [0.9, 1.6, 2.4, 2.3, 3.1, 3.6, 3.7, 4.5, 5.1, 5.3]

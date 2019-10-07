#! /usr/bin/env python3


def hypothesis_linear(theta0=None, theta1=None, x=None):
    return theta0 + x*theta1


def cost_function(X=None, Y=None, theta=None):
    # print("Cost Function X={} Y={} theta={}".format(
    #    X, Y, theta))
    m = len(Y)

    sum_diff_squared = 0
    cost = 0
    diff = 0
    diff_squared = 0
    for i in range(m):
        diff = hypothesis_linear(theta[0], theta[1], X[i]) - Y[i]
        diff_squared = diff * diff
        sum_diff_squared = sum_diff_squared + diff_squared
    cost = 1/(2*m) * sum_diff_squared
    return cost

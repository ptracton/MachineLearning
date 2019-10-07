#! /usr/bin/env python3

import cost_function

from mpl_toolkits import mplot3d
import numpy as np
import matplotlib
matplotlib.rcParams['text.usetex'] = True
import matplotlib.pyplot as plt


def z_function(x, y):
    return np.sin(np.sqrt(x ** 2 + y ** 2))


Y_GOLDEN = [0.9, 1.6, 2.4, 2.3, 3.1, 3.6, 3.7, 4.5, 5.1, 5.3]
X = np.arange(0, 10, 1)

delta = 0.1
theta0_range = np.arange(-1, 2.0, delta)
theta1_range = np.arange(-1, 2.0, delta)
#x = np.linspace(-6, 6, 30)
#y = np.linspace(-6, 6, 30)

X, Y = np.meshgrid(theta0_range, theta1_range)
Z = z_function(X, Y)
print(len(X))
print(X[0])
print(len(X[0]))

print(X[1])
print(len(X[1]))

# print(len(Y))
# print(len(Z[0]))


cost = []
for z0 in theta0_range:
    for z1 in theta1_range:
        cost.append(cost_function.cost_function(
            theta0_range, theta1_range, [z0, z1]))

print(type(cost))
print(cost[0])

fig = plt.figure()
ax = plt.axes(projection="3d")
ax.plot_surface(X, Y, Z, color='green', cmap='winter')
ax.set_xlabel(r'\theta_{0}')
ax.set_ylabel(r'\theta_{1}')
ax.set_zlabel(r'J(\theta_{0}, \theta_{1})')

plt.show()

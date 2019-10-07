#! /usr/bin/env python3

import cost_function

import numpy as np
import matplotlib
matplotlib.rcParams['text.usetex'] = True
import matplotlib.cm as cm
import matplotlib.pyplot as plt


delta = 0.05
theta0_range = np.arange(-1, 2.0, delta)
theta1_range = np.arange(-1, 2.0, delta)
X, Y = np.meshgrid(theta0_range, theta1_range)
Z1 = np.exp(-X**2 - Y**2)
Z2 = np.exp(-(X - 1)**2 - (Y - 1)**2)
Z = (Z1 - Z2) * 2
print(len(Z), Z)

Y_LIST = []
for z0 in theta0_range:
    for z1 in theta1_range:
        Y_LIST.append(cost_function.hypothesis_linear(z0, z1, X))
print(Y_LIST)

fig, ax = plt.subplots()
#CS = ax.contour(X, Y, Z)
CS = ax.contour(X, Y, Y_LIST)
ax.clabel(CS, inline=1, fontsize=10)
ax.set_title('Simplest default with labels')

# Y_GOLDEN = [0.9, 1.6, 2.4, 2.3, 3.1, 3.6, 3.7, 4.5, 5.1, 5.3]
# X = np.arange(0, 10, 1)
# theta0_range = np.arange(-1, 2, 0.5)
# theta1_range = np.arange(-1, 2, 0.5)

# X, Y = np.meshgrid(theta0_range, theta1_range)

# fig, ax = plt.subplots()

# for z0 in theta0_range:
#     for z1 in theta1_range:
#         line = cost_function.hypothesis_linear(z0, z1, X)
#         print(line)
#         CS = ax.contour(X, Y, line)
#         ax.clabel(CS, inline=1, fontsize=10)


plt.show()
# plt.savefig("plot_cost_function.png")

#! /usr/bin/env python3

import cost_function

# https://towardsdatascience.com/an-easy-introduction-to-3d-plotting-with-matplotlib-801561999725

import numpy as np
from mpl_toolkits import mplot3d

import matplotlib.pyplot as plt

fig = plt.figure()
ax = plt.axes(projection="3d")

x = np.linspace(-2, 2, 30)
y = np.linspace(-2, 2, 30)

X, Y = np.meshgrid(x, y)

W = np.ndarray(shape=(30, 30))
row = []
insert = 0
for a in x:
    for b in y:
        cost = cost_function.cost_function(x, y, (a, b))
        print("COST={}".format(cost))
        row.append(cost)

    np.insert(W, insert, row)
    insert = insert + 1
    # print("\n\nW={}".format(W))
    row = []

# print("\n\nW = {}".format(W))
ax = plt.axes(projection='3d')
ax.plot_surface(X, Y, W, rstride=1, cstride=1,
                cmap='viridis', edgecolor='none')
ax.set_title('surface')
plt.show()

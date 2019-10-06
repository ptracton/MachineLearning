#! /usr/bin/env python3

import cost_function

import numpy as np
import matplotlib
matplotlib.rcParams['text.usetex'] = True
import matplotlib.pyplot as plt

Y_GOLDEN = [0.9, 1.6, 2.4, 2.3, 3.1, 3.6, 3.7, 4.5, 5.1, 5.3]
X = np.arange(0, 10, 1)

Y1 = cost_function.hypothesis_linear(0, 0, X)
Y2 = cost_function.hypothesis_linear(1, 0.5, X)
Y3 = cost_function.hypothesis_linear(0.75, 0.75, X)

fig = plt.figure()
ax1 = fig.add_subplot(211)
ax1.set_ylabel('y')
ax1.set_xlabel('x')
ax1.set_title(r'Cost Function for h_{\theta}(x) = \theta_{0} + \theta_{1} * x')

ax1.grid(True)
line0, = ax1.plot(X, Y_GOLDEN, 'ko', label="GOLDEN Data")
line1, = ax1.plot(X, Y1, label=r'\theta_{0} =0, \theta_{1} = 0')
line2, = ax1.plot(X, Y2, label=r'\theta_{0} =1, \theta_{1} = 0.5')
line3, = ax1.plot(X, Y3, label=r'\theta_{0} =0.75, \theta_{1} = 0.75')
plt.legend()
# plt.show()
plt.savefig("plot_cost_function.png")

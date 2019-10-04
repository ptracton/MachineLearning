#! /usr/bin/env python3

import matplotlib.pyplot as plt
import numpy as np

x = np.arange(0, 10, 1)
# y = 0.5x + 1
y = [0.5*v + 1 for v in x]
y2 = [0.9, 1.6, 2.4, 2.3, 3.1, 3.6, 3.7, 4.5, 5.1, 5.3]

print("Data {} {}".format(x, y))

fig = plt.figure()
fig.subplots_adjust(top=0.8)
ax1 = fig.add_subplot(211)
ax1.set_ylabel('y')
ax1.set_xlabel('x')
ax1.set_title('Model Representation')


ax1.plot(x, y2, 'ko', x, y)
ax1.grid(True)
# plt.show()
plt.savefig("model_plot_representation.png")

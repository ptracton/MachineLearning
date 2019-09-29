#! /usr/bin/env python3

import numpy as np

A = np.array(([10, 20], [30, 40], [50, 60]))
B = np.array(([5], [10]))
C = A.dot(B)
print("A = {}".format(A))
print("B = {}".format(B))
print("C = {}".format(C))
# The line below fails since A*B is not B*A
#D = B.dot(A)

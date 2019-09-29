#! /usr/bin/env python3

import numpy as np

A = np.array(([1, 2], [3, 4]))
B = np.array(([11, 12], [13, 14]))
C = A - B
print("A = {}".format(A))
print("B = {}".format(B))
print("C = {}".format(C))

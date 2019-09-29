#! /usr/bin/env python3

import numpy as np

A = np.array(([10, 20], [30, 40]))
x = 10
C = A * x
D = A/x
print("A = {}".format(A))
print("C = {}".format(C))
print("D = {}".format(D))

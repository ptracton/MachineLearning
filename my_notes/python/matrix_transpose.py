#! /usr/bin/env python3

import numpy as np

A = np.array(([1, 2, 0], [0, 5, 6], [7, 0, 9]))
A_trans = A.transpose()
print("A = {}".format(A))
print("A_trans = {}".format(A_trans))

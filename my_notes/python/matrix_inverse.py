#! /usr/bin/env python3

import numpy as np
import numpy.linalg

A = np.array(([1, 2, 0], [0, 5, 6], [7, 0, 9]))
A_inv = numpy.linalg.inv(A)
A_invA = A.dot(A_inv)
print("A = {}".format(A))
print("A_inv = {}".format(A_inv))
print("A_invA = {}".format(A_invA))

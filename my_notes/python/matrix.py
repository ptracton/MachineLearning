#! /usr/bin/env python3

import numpy as np

A = np.array([[1, 2, 3], [3, 4, 5], [7, 8, 9]])
rows, cols = np.shape(A)
print("\nA= {}".format(A))
print("Rows = {} Cols = {}".format(rows, cols))
print("Location 2,3 = {}".format(A[1][2]))

V = np.array([[1], [2], [3], [4], [5], [6], [7], [8]])
rows, cols = np.shape(V)
print("\nV= {}".format(V))
print("Rows = {} Cols = {}".format(rows, cols))
print("Location 6,1 = {}".format(V[5][0]))

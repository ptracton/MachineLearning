#! /usr/bin/env python3

import numpy as np

# Initialize random matrices A and B
A = np.array(([1, 2],
              [4, 5]))
B = np.array(([1, 1],
              [0, 2]))

# Initialize a 2 by 2 identity matrix
I = np.eye(2)

# The above notation is the same as I = [1, 0
#                                         0, 1]

# What happens when we multiply I*A ?
IA = I.dot(A)

# How about A*I ?
AI = A.dot(I)

# Compute A*B
AB = A.dot(B)

# Is it equal to B*A?
BA = B.dot(A)

# Note that IA = AI but AB != BA
print("A = {}".format(A))
print("B = {}".format(B))
print("IA = {}".format(IA))
print("AI = {}".format(AI))
print("AB = {}".format(AB))
print("BA = {}".format(BA))

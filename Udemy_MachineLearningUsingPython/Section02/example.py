#! /usr/bin/env python3

import sklearn
from sklearn.model_selection import train_test_split
import pandas
import numpy as np
import matplotlib.pyplot as mplt

data = pd.read_excel() # Put in path to xls file
print (data.head())


data_csv = pd.read_csv() # put in path to csv file
print (data_csv.head)


dataAction = np.cos(data)
print(dataAction)

dataMax = np.amax(data)
print(dataMax)


#split = np.random.rand(len(data)) <0.6
#trainData = data[split]
#testData = data[split]
#print(trainData)
#print(testData)

# Grab a random 20% of data for test data, the rest is training data
#trainData, testData = train_test_split(data, test_size = 0.2)
#print(trainData)
#print(testData)

mplt.plot(data)
mplt.plot(data_csv)
mplt.xlabel("XLabel")
mplt.ylabel("YLabel")

XSave = np.savetxt('datacos', dataAction)
plotPanda = pd.plotting.boxplot(data)
plotPanda = pd.plotting.scatter_matrix(data)

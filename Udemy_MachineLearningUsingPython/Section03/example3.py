#! /usr/bin/env python3

import sklearn
from sklearn import datasets, linear_model
from sklearn.metrics import mean_squared_error
from sklearn import svm
import pandas as pd
import numpy as np
import matplotlib.pyplot as mplt


# What is load_iris?  what is this data?
# https://scikit-learn.org/stable/datasets/index.html#diabetes-dataset
# https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_diabetes.html#sklearn.datasets.load_diabetes
data = datasets.load_iris()
#print("dataset: ", data)

pandaData = pd.DataFrame(data.data[:, 0:4])
pandaData.columns = ['a', 'b', 'c', 'd']
#print(pandaData)
target  = pd.DataFrame(data.target)
target.columns = ['e']
#print('data:', pandaData)
#print('target:', target)

##########################################
# mdln = linear_model.LinearRegression() #
# mdlgFit = mdln.fit(pandaData, target)  #
#                                        #
# predict = mdln.predict([[1,1,1,1]])    #
# print("Predict Linear:", predict)      #
# print("Coeff:", mdln.coef_)            #
##########################################

# mdlg = linear_model.LogisticRegression()
# mdlgFit = mdlg.fit(pandaData, target)
# predict = mdlg.predict([[0,1,2,2]])
# print("Predict Logistic:", predict)
# print("Coeff:", mdlg.coef_)

svc = svm.SVC(kernel = 'linear', C=0.75).fit(pandaData, target)
svfit = svc.fit(pandaData, target)
predict = svfit.predict([[0,1,2,2]])
print("svfit:", svfit)
print("Predict:", predict)
print("Coeef:", svc.coef_)

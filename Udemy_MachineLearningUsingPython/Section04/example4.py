#! /usr/bin/env python3

import sklearn
from sklearn import datasets, linear_model
from sklearn.metrics import mean_squared_error
from sklearn import svm
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.tree import export_graphviz
from sklearn.cluster import KMeans
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

colormap = np.array(['blue', 'green', 'black'])
mplt.scatter(pandaData.a, pandaData.b, c=colormap[target.e])
mplt.scatter(pandaData.c, pandaData.d, c=colormap[target.e])
mplt.title("Title")
mplt.show()

mdl = KMeans(n_clusters=3, random_state=5).fit(target)
predict = mdl.predict
print("Predict: ", predict)
labels = mdl.labels_
print("Labels: ", labels)
cc = mdl.cluster_centers_
print("Cluster Centers", cc)
mplt.polar(cc, '-or')
mplt.show()

# decTree = DecisionTreeClassifier(criterion='entropy')
# print(decTree)
# fitDecTree = decTree.fit(pandaData, target)
# predict = decTree.predict([[0,1,2,2]])
# print("Predict", predict)
# out = export_graphviz(fitDecTree, out_file="output.dot")


# randomForest = RandomForestClassifier()
# fitRandomForest = randomForest.fit(pandaData, target)
# print("FI:", randomForest.feature_importances_)
# predict = randomForest.predict([[0,1,0,1]])
# print("Predict:", predict)



# mdln = linear_model.LinearRegression() #
# mdlgFit = mdln.fit(pandaData, target)  #
#                                        #
# predict = mdln.predict([[1,1,1,1]])    #
# print("Predict Linear:", predict)      #
# print("Coeff:", mdln.coef_)            #


# mdlg = linear_model.LogisticRegression()
# mdlgFit = mdlg.fit(pandaData, target)
# predict = mdlg.predict([[0,1,2,2]])
# print("Predict Logistic:", predict)
# print("Coeff:", mdlg.coef_)

# svc = svm.SVC(kernel = 'linear', C=0.75).fit(pandaData, target)
# svfit = svc.fit(pandaData, target)
# predict = svfit.predict([[0,1,2,2]])
# print("svfit:", svfit)
# print("Predict:", predict)
# print("Coeef:", svc.coef_)

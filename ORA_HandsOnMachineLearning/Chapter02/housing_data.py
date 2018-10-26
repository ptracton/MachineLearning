#! /usr/bin/env python3

import Housing

import os
import pandas as pd

HOUSING_CSV_PATH = os.getcwd()+"/../handson-ml/datasets/housing/"
HOUSING_CSV_FILE = "housing.csv"

def load_housing_data(housing_path=None):
    """
      In a very unsafe manner load the house csv file into a pandas data frame
      """
    csv_path = os.path.join(housing_path, HOUSING_CSV_FILE)
    return pd.read_csv(csv_path)

#housingData = load_housing_data(HOUSING_CSV_PATH)
#print(housingData.head())
#print(housingData.info())
#print(housingData.describe())
#housingData.hist(bins=50, figsize=(20,15))


housing = Housing.Housing(path="../handson-ml/datasets/housing/")
housing.load_housing_data()
housing.add_id_column()
print(housing.dataFrame.head())
print(housing.dataFrame.info())
print(housing.dataFrame.describe())
housing.split_train_test(0.2)
print(len(housing.trainingData))
print(len(housing.testingData))

housing.split_train_test_by_id(0.2, "index")
print(housing.trainSet)

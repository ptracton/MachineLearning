#! /usr/bin/env python3

import hashlib
import os
import numpy as np
import pandas as pd

class Housing():
    """
    This class is being used to try out the housing examples in Hands On Machine Learning
    with Sci-kit and Tensorflow
    """
    
    def __init__(self, path=".", csvFile="housing.csv"):
        """
        Constructor 
        """
        self.csvFile = os.path.join(path, csvFile)
        self.dataFrame=None
        self.testingData = None
        self.trainingData = None
        self.testSet = None
        self.trainSet = None
        return

    def downloadData(self):
        """
        Download data from github
        """
        return

    def load_housing_data(self):
        """
        In a very unsafe manner load the house csv file into a pandas data frame
        """
        self.dataFrame = pd.read_csv(self.csvFile)
        return

    def split_train_test(self, test_ratio):
        """
        split up our data into testing and training
        """

        shuffled_indices = np.random.permutation(len(self.dataFrame))
        test_set_size = int(len(self.dataFrame) * test_ratio)
        test_indices = shuffled_indices[:test_set_size]
        train_indices = shuffled_indices[test_set_size:]
        self.trainingData = self.dataFrame.iloc[train_indices]
        self.testingData = self.dataFrame.iloc[test_indices]
        return

    def add_id_column(self):
        self.dataFrame.reset_index()
        return
    
    def test_set_check(self, identifier=None, test_ratio=None, hash=None):        
        return hash(np.int64(identifier)).digest()[-1] < 256 * test_ratio

    def split_train_test_by_id(self, test_ratio=None, id_column=None):
        ids = self.dataFrame[id_column]
        in_test_set = ids.apply(lambda id_: self.test_self_check(id_,
                                                                 test_ratio, hashlib.md5))
        self.testSet = self.dataFrame.loc[in_test_set]
        self.trainSet = self.dataFrame.loc[~in_test_set]
        return

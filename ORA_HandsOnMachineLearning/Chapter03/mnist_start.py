#! /usr/bin/env python3

import sklearn.datasets

"""
DeprecationWarning: Function fetch_mldata is deprecated; fetch_mldata was deprecated in version 0.20 and will be removed in version 0.22 warnings.warn(msg, category=DeprecationWarning)
"""
if __name__ == "__main__":
    """
    This is not fast.  We should build a tool to download and store int an sqlite3 db file
    for local access needs
    """
    mnistData = sklearn.datasets.fetch_mldata('MNIST original')
    print(mnistData)

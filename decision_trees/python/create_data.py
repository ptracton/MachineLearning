#! /usr/bin/env python3

import argparse
import pickle

import numpy as np

import matplotlib
import matplotlib.pyplot as plt

import sklearn
import sklearn.datasets

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Create Data')
    parser.add_argument("-D", "--debug",
                        help="Debug this script",
                        action="store_true")

    parser.add_argument("--filename",
                        help="Filename for storing data",
                        default=None,
                        action="store")

    parser.add_argument("--plot",
                        help="Plot data",
                        default=False,
                        action="store_true")

    parser.add_argument("--samples",
                        help="How many samples to generate",
                        default=100,
                        action="store")

    parser.add_argument("--features",
                        help="How many features per sample",
                        default=2,
                        action="store")

    parser.add_argument("--centers",
                        help="The number of centers to generate, or the fixed center locations",
                        default=3,
                        action="store")

    parser.add_argument("--std",
                        help="Standard deviation of the clusters",
                        default=1.0,
                        action="store")

    parser.add_argument("--cmin",
                        help="Center box minimum",
                        default=-10.0,
                        action="store")

    parser.add_argument("--cmax",
                        help="Center box maximum",
                        default=10.0,
                        action="store")

    parser.add_argument("--shuffle",
                        help="Shuffle samples",
                        default=True,
                        action="store_true")

    parser.add_argument("--random_state",
                        help="Determines random number generation for dataset creation. Pass an int for reproducible output across multiple function calls",
                        default=1,
                        action="store")

    args = parser.parse_args()
    if args.debug:
        print(args)



    xblob, yblob=sklearn.datasets.make_blobs(n_samples=int(args.samples),
                                             n_features=int(args.features),
                                             centers = int(args.centers),
                                             random_state = int(args.random_state),
                                             cluster_std = float(args.std),
                                             center_box = (float(args.cmin), float(args.cmax)),
                                             shuffle = args.shuffle,
    )
    #print("XBLOB = {}".format(xblob))
    #print("YBLOB = {}".format(yblob))
    if args.plot:
        plt.scatter(xblob[:,0], xblob[:,1], c=yblob, s=50, cmap='rainbow')
        plt.show()

    if args.filename:
        if args.filename is not None:
            np.savetxt(args.filename+"_x.txt", xblob)
            np.savetxt(args.filename+"_y.txt", yblob)

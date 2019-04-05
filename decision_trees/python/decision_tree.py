#! /usr/bin/env python3

import argparse
import pickle

import numpy as np

import matplotlib
import matplotlib.pyplot as plt

import sklearn
import sklearn.datasets
import sklearn.tree 
import sklearn.linear_model

def create_decision_tree(dt,X,y):
    
    dt.fit(X,y)
    dot_data = StringIO()
    export_graphviz(dt, out_file=dot_data,  
                    filled=True, rounded=True,
                    special_characters=True)

    graph = pydotplus.graph_from_dot_data(dot_data.getvalue())  
    
    return graph.create_png()

def plot_density(model, X, y, ax = None, title='Model'):
    model.fit(X,y)
    df = pd.DataFrame(models['logr'].decision_function(X))
    df.plot(kind='density', ax=ax, title=title)

def plt_clf(model, X, y, ax = None, cmap ='rainbow', title='DT'): 
    ax = ax or plt.gca() # Plot the training points
    ax.scatter( X[:, 0], X[:, 1], c = y, s = 30, cmap = cmap, zorder = 3) 
    ax.axis('tight') 
    ax.axis('off') 
    xlim = ax.get_xlim() 
    ylim = ax.get_ylim() 
    
    # fit the estimator 
    model.fit( X, y) 
    xx, yy = np.meshgrid( np.linspace(* xlim, num = 200), np.linspace(* ylim, num = 200)) 
    Z = model.predict( np.c_[ xx.ravel(), yy.ravel()]). reshape( xx.shape) 
    
    # Create a color plot with the results 
    n_classes = len( np.unique( y)) 
    contours = ax.contourf( xx, yy, Z, alpha = 0.3, levels = np.arange( n_classes + 1) - 0.5, 
                            cmap = cmap, zorder = 1);
    ax.set_title(title)
    ax.set( xlim = xlim, ylim = ylim)

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

    args = parser.parse_args()
    if args.debug:
        print(args)

    xblob = np.loadtxt(args.filename+"_x.txt")
    yblob = np.loadtxt(args.filename+"_y.txt")
    print("XBLOB = {}".format(xblob))
    print("YBLOB = {}".format(yblob))
    #plt.scatter(xblob[:,0], xblob[:,1], c=yblob, s=50, cmap='rainbow')
    #plt.show()

    _,ax = plt.subplots(1,4,figsize=(16,5))
    dt = sklearn.tree.DecisionTreeClassifier()
    plt_clf(dt,xblob,yblob,ax=ax[0],title='DT')
#    logr = sklearn.linear_model.LogisticRegression(solver='lbfgs', multi_class='multinomial', max_iter=10000)

#    dt.fit(xblob, yblob)
#    print(dt)

import os
import numpy as np
import pickle
import matplotlib.pyplot as plt
import flightphase
from scipy.interpolate import UnivariateSpline
import pandas as pd
# flightphase.plot_logics()

# get a sample data
datadir = os.path.dirname(os.path.realpath(__file__))
# dataset = pickle.load(open('Data4Clustering01.csv'), encoding='bytes')

dataset = dataset.to_numpy()

for data in dataset:
    times = np.array(data['posTime'])
    times = times - times[0]
    alts = np.array(data['alt']) / 0.3048
    spds = np.array(data['speed'])  / 0.514444
    # rocs = np.array(data['vh']) / 0.00508

    labels = flightphase.fuzzylabels(times, alts, spds, rocs)

    colormap = {'GND': 'black', 'CL': 'green', 'CR': 'blue',
                'DE': 'orange', 'LVL': 'purple', 'NA': 'red'}

    colors = [colormap[l] for l in labels]

    altspl = UnivariateSpline(times, alts)(times)
    spdspl = UnivariateSpline(times, spds)(times)
    # rocspl = UnivariateSpline(times, rocs)(times)

    plt.subplot(311)
    plt.title('press any key to continue to next example...')
    plt.plot(times, altspl, '-', color='k', alpha=0.5)
    plt.scatter(times, alts, marker='.', c=colors, lw=0)
    plt.ylabel('altitude (ft)')

    plt.subplot(312)
    plt.plot(times, spdspl, '-', color='k', alpha=0.5)
    plt.scatter(times, spds, marker='.', c=colors, lw=0)
    plt.ylabel('speed (kt)')

    # plt.subplot(313)
    # plt.plot(times, rocspl, '-', color='k', alpha=0.5)
    # plt.scatter(times, rocs, marker='.', c=colors, lw=0)
    # plt.ylabel('roc (fpm)')

    plt.tight_layout()
    plt.draw()
    plt.waitforbuttonpress(-1)
    plt.clf()

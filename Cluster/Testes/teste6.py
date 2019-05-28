# print(__doc__)

import numpy as np
import pandas as pd
import seaborn as sb
import matplotlib.pyplot as plt
import sklearn

from itertools import cycle
from mpl_toolkits import mplot3d
from sklearn.cluster import DBSCAN
from sklearn import metrics
from sklearn import preprocessing
from collections import Counter
from collections import OrderedDict
from sklearn.preprocessing import StandardScaler
# from sklearn.cluster import OPTICS, cluster_optics_dbscan
# Constants
MIN_DATA_SIZA = 100  # minimal number of data in a flight
CHUNK_SIZE = 150     # number of icaos to be processed in chunks
TEST_FLAG = True     # if this is a test run
# #############################################################################
# Generate sample data
# making data frame from csv file
df = pd.read_csv('ENGFRA_week.csv', header=0, delimiter=',')

# Define colummns names
df.columns =['hit','icao24','callsign','time',
'lat','lon','heading','alt','estdepartureairport','estarrivalairport','onground'
]

# dropping ALL duplicte values
df.drop_duplicates(subset=['time'], inplace=True)

# Find all ICAO IDs in the dataset
dfcount = df.groupby('icao24').size().reset_index(name='counts')
icaos = dfcount[dfcount.counts>100].icao24.tolist()

print("[2] %d number of valid ICAOs." % len(icaos))

for i in range(0, len(icaos), CHUNK_SIZE):

    print('[3][%d-%d of %d] ICAOs beening processed.' \
            % (i, i+CHUNK_SIZE, len(icaos)))

    chunk = icaos[i: i+CHUNK_SIZE]

    print("  [a] fetching records")

    dfchunk = df[df.icao24.isin(chunk)]
    ids = dfchunk['icao24'].to_numpy()
    lats = dfchunk['lat'].to_numpy()
    lons = dfchunk['lon'].to_numpy()
    alts = dfchunk['alt'].to_numpy()
    hdgs = dfchunk['heading'].to_numpy()
    times = dfchunk['time'].to_numpy()

    #####################################################################
    # Continous fligh path extraction using machine learning algorithms
    #####################################################################

    print("  [b] data scaling")

    # transform the text ids into numbers
    # ------------------------------------
    le = preprocessing.LabelEncoder()
    encoded_ids = le.fit_transform(ids)

    # Apply feature scaling - on altitude, spds, and times
    # ------------------------------------------------------
    mms = preprocessing.MinMaxScaler(feature_range=(0, 1000))
    times_norm = mms.fit_transform(times.reshape((-1, 1)))
    dt = mms.scale_ * 0.5 * 60 * 60   # time interval of 30 mins

    mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
    alts_norm = mms.fit_transform(alts.reshape((-1, 1)))

    print("  [c] creating machine learning dataset.")


    # aggregate data by there ids
    # ----------------------------
    acs = {}
    for i in range(len(ids)):
        if ids[i] not in list(acs.keys()):
            acs[ids[i]] = []

        acs[ids[i]].append([times_norm[i], alts_norm[i], times[i],
                            lats[i], lons[i], int(alts[i]),
                            hdgs[i]])
    print(acs)
    print("  [d] start clustering, and saving results to DB")
    # Apply clustering method
    # ------------------------
    # datam= df.iloc[0:50000,[4,5]]
    cluster = DBSCAN(eps=dt, min_samples=MIN_DATA_SIZA)
    print(cluster)

    acsegs = {}
    total = len(list(acs.keys()))
    count = 0
    print('    * processing ', end=' ')
    for k in list(acs.keys()):
        count += 1
        print('.', end=' ')

        data = np.asarray(acs[k])

        tdata = np.copy(data)
        tdata[:, 1:] = 0
        cluster.fit(tdata)
        labels = cluster.labels_
        n_clusters = np.unique(labels).size
        print("n_clusters : %d" % n_clusters)

        if not TEST_FLAG:
            for i in range(n_clusters):
                mask = labels == i
                c = data[mask, 2:]
                c = c[c[:, 0].argsort()]   # sort by ts

                if len(c) > MIN_DATA_SIZA:
                    mcollflights.insert_one(
                        OrderedDict([
                            ('icao', k),
                            ('ts',   c[:, 0].tolist()),
                            ('lat',  c[:, 1].tolist()),
                            ('lon',  c[:, 2].tolist()),
                            ('alt',  c[:, 3].tolist()),
                            ('hdg',  c[:, 5].tolist()),
                            ])
                    )

        # Plot result
        if TEST_FLAG:
            colorset = cycle(['purple', 'green', 'red', 'blue', 'orange'])
            for i, c in zip(list(range(n_clusters)), colorset):
                mask = labels == i
                ts = data[mask, 0].tolist()
                alts = data[mask, 5].tolist()
                if len(alts) > MIN_DATA_SIZA:
                    plt.plot(ts, alts, 'w', color=c, marker='.', alpha=1.0)

            plt.xlim([0, 1000])
            plt.draw()
            plt.waitforbuttonpress(-1)
            plt.clf()
    print('')

print()
print("[4] All completed")


# # Define colummns names
# df.columns =['hit','icao24','callsign','time',
# 'lat','lon','heading','alt','estdepartureairport','estarrivalairport','onground'
# ]
#
# # Select data for clustering
# datam= df.iloc[0:50000,[4,5]]
# data= df.iloc[0:50000,[4,5,7]]
# print(len(data))
# print(data.head())
# # ##############################################################################
# # Define model
# model = DBSCAN(eps = 53, min_samples = 8).fit(datam)
# # print(model)
#
#
# core_samples_mask = np.zeros_like(model.labels_, dtype=bool)
# core_samples_mask[model.core_sample_indices_] = True
# labels = model.labels_
#
# # Number of clusters in labels, ignoring noise if present.
# n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
# n_noise_ = list(labels).count(-1)
#
# print('Estimated number of clusters: %d' % n_clusters_)
# print('Estimated number of noise points: %d' % n_noise_)
# # print("Homogeneity: %0.3f" % metrics.homogeneity_score(labels_true, labels))
# # print("Completeness: %0.3f" % metrics.completeness_score(labels_true, labels))
# # print("V-measure: %0.3f" % metrics.v_measure_score(labels_true, labels))
# # print("Adjusted Rand Index: %0.3f"
# #       % metrics.adjusted_rand_score(labels_true, labels))
# # print("Adjusted Mutual Information: %0.3f"
# #       % metrics.adjusted_mutual_info_score(labels_true, labels))
# # print("Silhouette Coefficient: %0.3f"
# #       % metrics.silhouette_score(X, labels))
#
#
# outliers_df = pd.DataFrame(data)
#
# # Count outliers
# print(Counter(model.labels_))
# print(outliers_df[model.labels_==-1])
#
#
# data = np.array(data)
#
# #############################################################################
# # Outliers figure
# # fig = plt.figure()
# # ax = fig.add_axes([.1,.1, 1,1, 1,1])
# # colors = model.labels_
#
# # ax.scatter(data[:,0],data[:,1], c=colors, s =10)
# # ax.set_xlabel('lat')
# # ax.set_ylabel('lon')
#
# # fig = plt.figure()
# # ax = plt.axes(projection='3d')
# # colors = model.labels_
# # ax.scatter(data[:,0],data[:,1],data[:,2], c=colors, cmap='viridis', marker ='o', linewidth=0.5);
# # ax.set_xlabel('lat')
# # ax.set_ylabel('lon')
# # ax.set_zlabel('alt')
# #
# #
# #
# #
# #
# #
# #
# #
# #
# # plt.title('DBSCAN for Outliers')
# # #
# # plt.show()

# Importing Modules
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from mpl_toolkits.basemap import Basemap
from sklearn.cluster import DBSCAN
from sklearn.decomposition import PCA
from mpl_toolkits.basemap import Basemap
from sklearn import preprocessing
from scipy import interpolate

CHUNK_SIZE = 95 # number of icaos to be processed in chunks

df = pd.read_csv('ENGFRA_GERNED.csv', header=0, delimiter=',')
df_head = df.head()

mapa = {"hit" : "hit",
    "icao24" : "icao",
    "callsign" : "call",
    "time" : "time",
    "lat" : "lat",
    "lon" : "lon",
    "heading" : "hdg",
    "alt" : "alt",
    "estdepartureairport" : "dptair",
    "estarrivalairport" : "arrair",
    "onground" : "ongrnd"}

df = df.rename(columns = mapa)

print("[1] %d Imported data:" "\n",  df.head())

lat = df['lat']
lon = df['lon']
alt = df['alt']

# Find all ICAO IDs in the dataset
dfcount = df.groupby('icao').size().reset_index(name='counts')
icaos = dfcount[dfcount.counts>100].icao.tolist()
print("[2] %d number of valid ICAOs." % len(icaos))




for i in range(0, len(icaos), CHUNK_SIZE):

    print('[3][%d-%d of %d] ICAOs beening processed.' \
            % (i, i+CHUNK_SIZE, len(icaos)))

    chunk = icaos[i: i+CHUNK_SIZE]

    print("  [a] fetching records")

    dfchunk = df[df.icao.isin(chunk)]
    ids = dfchunk['icao'].to_numpy()
    lats = dfchunk['lat'].to_numpy()
    lons = dfchunk['lon'].to_numpy()
    alts = dfchunk['alt'].to_numpy()
    hdgs = dfchunk['hdg'].to_numpy()
    times = dfchunk['time'].to_numpy()

    print(ids)

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

#
# print(data_org)

# for i in range(0, 1):
#     x = np.arange(0,len(lat()))
#     y = lat
#
#     f = interpolate.interp1d(x,y)
#
#     xnew = np.arange(0,len(lat)-1,0.1)
#     ynew = f(xnew)
# plt.plot(x, y, 'o', xnew, ynew, '-')
# plt.show()





# mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
# lat_norm = mms.fit_transform(lat.values.reshape(-1,1))
#
# mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
# lon_norm = mms.fit_transform(lon.values.reshape(-1,1))
#
# mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
# alt_norm = mms.fit_transform(alt.values.reshape(-1,1))



# X = np.column_stack((lat_norm,lon_norm))
# X = X[20000:30000,[0,1]]
# X_scaled= X
#
# # cluster the data into five clusters
# dbscan = DBSCAN(eps=3, min_samples = 8)
# clusters = dbscan.fit_predict(X_scaled)
#
# # Number of clusters in labels, ignoring noise if present.
# labels = dbscan.labels_
# core_samples_mask = np.zeros_like(dbscan.labels_, dtype=bool)
# core_samples_mask[dbscan.core_sample_indices_] = True
# n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
# n_noise_ = list(labels).count(-1)
#
# print("n_clusters : %d" % n_clusters_)
# print("n_noise : %d" % n_noise_)
# # plot the cluster assignments
# # Black removed and is used for noise instead.
# unique_labels = set(labels)
# colors = [plt.cm.Spectral(each)
#           for each in np.linspace(0, 1, len(unique_labels))]
# for k, col in zip(unique_labels, colors):
#     if k == -1:
#         # Black used for noise.
#         col = [0, 0, 0, 1]
#
#     class_member_mask = (labels == k)
#
#     xy = X[class_member_mask & core_samples_mask]
#     fig = plt.plot(xy[:, 0], xy[:, 1], 'o', markerfacecolor=tuple(col),
#              markeredgecolor='k', markersize=5)
#
#     xy = X[class_member_mask & ~core_samples_mask]
#     fig = plt.plot(xy[:, 0], xy[:, 1], 'o', markerfacecolor=tuple(col),
#              markeredgecolor='k', markersize=5)
#
# plt.title('Estimated number of clusters: %d' % n_clusters_)
# plt.show()
#
# fig.text(0.125, 0.15, "Alejandro Rios - ITA", color='#555555', fontsize=16, ha='left')
# plt.savefig('clust2.pdf', dpi=150, frameon=False, transparent=False, bbox_inches='tight', pad_inches=0.2)

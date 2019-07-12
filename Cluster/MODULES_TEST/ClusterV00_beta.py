# Importing Modules
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from mpl_toolkits.basemap import Basemap
from sklearn.cluster import DBSCAN
from sklearn.decomposition import PCA
from mpl_toolkits.basemap import Basemap
from sklearn import preprocessing
dados = pd.read_csv('ENGFRA_GERNED.csv', header=0, delimiter=',')
dados_head = dados.head()

mapa = {"hit" : "hit",
    "icao24'" : "icao",
    "callsign" : "call",
    "time" : "time",
    "lat" : "lat",
    "lon" : "lon",
    "heding" : "hdg",
    "alt" : "alt",
    "estdepartureairport" : "dptair",
    "estarrivalairport" : "arrair",
    "onground" : "ongrnd"}

dados = dados.rename(columns = mapa)

lat = dados['lat']
lon = dados['lon']
alt = dados['alt']

print(type(lat))
mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
lat_norm = mms.fit_transform(lat.values.reshape(-1,1))

mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
lon_norm = mms.fit_transform(lon.values.reshape(-1,1))

mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
alt_norm = mms.fit_transform(alt.values.reshape(-1,1))

X = np.column_stack((lat_norm,lon_norm))
X = X[20000:30000,[0,1]]
X_scaled= X

# cluster the data into five clusters
dbscan = DBSCAN(eps=3, min_samples = 8)
clusters = dbscan.fit_predict(X_scaled)

# Number of clusters in labels, ignoring noise if present.
labels = dbscan.labels_
core_samples_mask = np.zeros_like(dbscan.labels_, dtype=bool)
core_samples_mask[dbscan.core_sample_indices_] = True
n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
n_noise_ = list(labels).count(-1)

print("n_clusters : %d" % n_clusters_)
print("n_noise : %d" % n_noise_)
# plot the cluster assignments
# Black removed and is used for noise instead.
unique_labels = set(labels)
colors = [plt.cm.Spectral(each)
          for each in np.linspace(0, 1, len(unique_labels))]
for k, col in zip(unique_labels, colors):
    if k == -1:
        # Black used for noise.
        col = [0, 0, 0, 1]

    class_member_mask = (labels == k)

    xy = X[class_member_mask & core_samples_mask]
    fig = plt.plot(xy[:, 0], xy[:, 1], 'o', markerfacecolor=tuple(col),
             markeredgecolor='k', markersize=5)

    xy = X[class_member_mask & ~core_samples_mask]
    fig = plt.plot(xy[:, 0], xy[:, 1], 'o', markerfacecolor=tuple(col),
             markeredgecolor='k', markersize=5)

plt.title('Estimated number of clusters: %d' % n_clusters_)
plt.show()

fig.text(0.125, 0.15, "Alejandro Rios - ITA", color='#555555', fontsize=16, ha='left')
plt.savefig('clust2.pdf', dpi=150, frameon=False, transparent=False, bbox_inches='tight', pad_inches=0.2)

# Importing Modules
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import scipy as sp
import sklearn
import haversine
import matplotlib as mpl
import seaborn as sns
import plotly.graph_objs as go
import plotly.plotly as py
from sklearn.svm import SVC

from mpl_toolkits.mplot3d import Axes3D
from mpl_toolkits.basemap import Basemap
from sklearn.cluster import DBSCAN
from sklearn.decomposition import PCA
from mpl_toolkits.basemap import Basemap
from sklearn.preprocessing import StandardScaler
from haversine import haversine, Unit
from sklearn.svm import LinearSVC
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.model_selection import permutation_test_score
from sklearn.model_selection import StratifiedKFold
from sklearn import metrics
from sklearn import preprocessing
from collections import Counter
from collections import OrderedDict
from scipy import interpolate
from itertools import cycle
from itertools import islice
from datetime import datetime
from geopy.distance import great_circle
from statistics import mean 
from fractions import Fraction as fr 

# Import data
# df = pd.read_csv('ENGFRA_GERNED.csv', header=0, delimiter=',')
df = pd.read_csv('FRAITA_month17.csv', header=0, delimiter=',')
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

# Rename data
df = df.rename(columns = mapa)


# Sort values - organize flights
# query - takes all index with hit = 0 of sorted data
Nflights = df.sort_index().query('hit == 0')

# Number of flights
Numflights = len(Nflights)
print('[1] Number of flights: ', Numflights )

lat_ff = []
lon_ff = []
alt_ff = []
Fly_mtx = np.array([])

# Evaluating great circle distance

lon_FRA = 8.682127
lat_FRA = 50.110924

coor_FRA = (lat_FRA,lon_FRA)

lon_ITA = 12.2461111111
lat_ITA = 41.7997222222

coor_ITA = (lat_ITA,lon_ITA)

# for i in range(71): 
# for i in range(1): 
for i in range(len(Nflights)-1): 

    # Define some parametres
    CHUNK_SIZE = 500 # Size of flight vector

    # Separate vector by flights
    flights = df.iloc[Nflights.index[i]:Nflights.index[i+1]]
    
    # Resizing vector of flights lat and lon
    lat = flights['lat']
    xlat = np.arange(lat.size)
    new_xlat = np.linspace(xlat.min(), xlat.max(), CHUNK_SIZE)
    lat_rz = sp.interpolate.interp1d(xlat, lat, kind='slinear')(new_xlat)

    lon = flights['lon']
    xlon = np.arange(lon.size)
    new_xlon = np.linspace(xlon.min(), xlon.max(), CHUNK_SIZE)
    lon_rz = sp.interpolate.interp1d(xlon, lon, kind='slinear')(new_xlon)

    alt = flights['alt']
    xalt = np.arange(alt.size)
    new_xalt = np.linspace(xalt.min(), xalt.max(), CHUNK_SIZE)
    alt_rz = sp.interpolate.interp1d(xalt, alt, kind='slinear')(new_xalt)

    for j in range(len(lon_rz)-1):

        # Defining cordinates of two points to messure distance      
        coordinates0 = (lat_rz[j],lon_rz[j])
        # Calculating haversine distance between two points in nautical miles
        distance_to_FRA = float(haversine(coor_FRA,coordinates0,unit='nmi'))
        distance_to_ITA = float(haversine(coor_ITA,coordinates0,unit='nmi'))
        
        if distance_to_FRA > 60 and distance_to_ITA > 60:

            lon_f = [lon_rz[j]]
            lat_f = [lat_rz[j]]
            alt_f = [alt_rz[j]]
            
            lat_ff.append(lat_f)
            lon_ff.append(lon_f)
            alt_ff.append(alt_f)


print(len(lat_ff))

mms = preprocessing.MinMaxScaler(feature_range=(0, 1))
lat_norm = mms.fit_transform(lat_ff)

mms = preprocessing.MinMaxScaler(feature_range=(0, 1))
lon_norm = mms.fit_transform(lon_ff)

mms = preprocessing.MinMaxScaler(feature_range=(0, 1))
alt_norm = mms.fit_transform(alt_ff)

np.random.seed(seed=10)

# lat_noise= 1*np.random.random_sample((1000, 1))
# lon_noise = 1*np.random.random_sample((1000, 1))

# lat_norm = np.concatenate((lat_norm,lat_noise),axis=0)
# lon_norm = np.concatenate((lon_norm,lon_noise),axis=0)

X = np.column_stack((lat_norm,lon_norm))
X_scaled= X

# cluster the data into five clusters
# dbscan = DBSCAN(eps=3, min_samples = 8)
dbscan = DBSCAN(eps=0.02, min_samples = 30)
# dbscan = DBSCAN(eps=0.0009, min_samples = 20)
clusters = dbscan.fit_predict(X_scaled)
dbscan.fit(X)
y_pred = dbscan.fit_predict(X)


# Number of clusters in labels, ignoring noise if present.
labels = dbscan.labels_
# print(labels,len(labels))

core_samples = np.zeros_like(labels, dtype=bool)
# print(core_samples,len(core_samples))
core_samples[dbscan.core_sample_indices_] = True



n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
n_noise_ = list(labels).count(-1)
# components_ = dbscan.components_

print('Estimated number of clusters: %d' % n_clusters_)
print('Estimated number of noise points: %d' % n_noise_)
print('Solhouette Coefficient: %0.3f' % metrics.silhouette_score(X_scaled,labels))


# # plot the cluster assignments
# # Black removed and is used for noise instead.
unique_labels = set(labels)
print(unique_labels)
colors = [plt.cm.Spectral(each)
          for each in np.linspace(0, 1, len(unique_labels))]

fig, ax = plt.subplots()
for k, col in zip(unique_labels, colors):
    if k == -1:
        # Black used for noise.
        col = [0, 0, 0, 1]

    # class_member_mask = (labels == 0)
    class_member_mask = (labels == k)
    xy = X[class_member_mask & core_samples]
    fig = plt.plot(xy[:,1],xy[:, 0], 'o', markerfacecolor=tuple(col),
             markersize=0.5)

    # class_member_mask = (labels == 1)
    # xy = X[class_member_mask & core_samples]
    # fig = plt.plot(xy[:,1],xy[:, 0], 'o', markerfacecolor=tuple(col),
    #          markersize=2)

    class_member_mask = (labels == -1)
    xy = X[class_member_mask & ~core_samples]
    fig = plt.plot(xy[:,1],xy[:, 0], 'x', markerfacecolor=tuple(col),
            markersize=0.5)


plt.xlabel('Longitude (scaled)')
plt.ylabel('Latitude (scaled)')
# # plt.legend(('Cluster 1','Cluster2'), loc='lower left', shadow=True)
plt.show()


# for k in zip(unique_labels):
#     class_member_mask1 = (labels == 0)
#     xy1 = X[class_member_mask1 & core_samples]
#     label_clust1 = labels[class_member_mask1]
   
#     class_member_mask2 = (labels == 1)
#     xy2 = X[class_member_mask2 & core_samples]
#     label_clust2 = labels[class_member_mask2]
  
#     class_member_mask3 = (labels == -1)
#     xy3 = X[class_member_mask3 & ~core_samples]
#     label_clust3 = labels[class_member_mask3]

#     class_member_mask4 = (labels > 1)
#     xy4 = X[class_member_mask4 & ~core_samples]
#     label_clust4= labels[class_member_mask4]




# coord_clus = np.concatenate((xy1,xy2,xy3),axis=0)
# label_clus = np.concatenate((label_clust1,label_clust2,label_clust3),axis=0)

# # 
# dados=pd.DataFrame()

# lat_clus = pd.Series(coord_clus[:, 0]) 
# lon_clus = pd.Series(coord_clus[:, 1]) 
# label_clus = pd.Series(label_clus) 

# dados['lat'] = lat_clus
# dados['lon'] = lon_clus
# dados['label'] = label_clus


# x = dados[['lat','lon']]
# y = dados['label']


# # treino_x = x[2000:]
# # treino_y = y[2000:]
# # teste_x = x[:2000]
# # teste_y = y[:2000]

# # print("Treinaremos com %d elementos e testaremos com %d elementos" % (len(treino_x), len(teste_x)))


# # modelo = LinearSVC(max_iter=100000)
# # modelo.fit(treino_x, treino_y)
# # previsoes = modelo.predict(teste_x)

# # acuracia = accuracy_score(teste_y, previsoes) * 100

# # print(acuracia)


# SEED = 20
# np.random.seed(SEED)

# treino_x, teste_x, treino_y, teste_y = train_test_split(x, y,
#                                                          random_state = SEED, test_size = 0.25,
#                                                          stratify = y)
# print("Treinaremos com %d elementos e testaremos com %d elementos" % (len(treino_x), len(teste_x)))

# modelo = LinearSVC()
# modelo.fit(treino_x, treino_y)
# previsoes = modelo.predict(teste_x)
# acuracia = accuracy_score(teste_y, previsoes) * 100
# print("A acurácia foi %.2f%%" % acuracia)


# from sklearn.dummy import DummyClassifier

# dummy_stratified = DummyClassifier(strategy="stratified")
# dummy_stratified.fit(treino_x, treino_y)
# acuracia = dummy_stratified.score(teste_x, teste_y) * 100

# print("A acurácia do dummy stratified foi %.2f%%" % acuracia)


# dummy_mostfrequent = DummyClassifier(strategy="most_frequent")
# dummy_mostfrequent.fit(treino_x, treino_y)
# acuracia = dummy_mostfrequent.score(teste_x, teste_y) * 100

# print("A acurácia do dummy mostfrequent foi %.2f%%" % acuracia)

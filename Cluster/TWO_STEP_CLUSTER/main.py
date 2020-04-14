"""" 
Function  : cluster_two_step
Title     : Two step cluster
Written by: Alejandro Rios
Date      : March/2020
Language  : Python
Aeronautical Institute of Technology
"""
########################################################################################
"""Importing Modules"""
########################################################################################
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from sklearn.cluster import DBSCAN
from sklearn import metrics
from sklearn import preprocessing

# In-House functions
from resize_flights import resize
from resize_flights import resize_norm
from distances_matrix import distances
########################################################################################
"""Airport coordinates"""
########################################################################################
# FRA: lat: 50.110924 | lon: 8.682127
# FCO: lat: 41.7997222222 | lon: 12.2461111111
# CDG: lat: 49.009722 | lon: 2.547778
# LHR: lat: 51.4775 | lon: -0.461389
########################################################################################

# AIRP1 airport coordinates
lat_AIRP1 = 50.110924
lon_AIRP1 = 8.682127
coor_AIRP1 = (lat_AIRP1,lon_AIRP1)

# AIRP2 airport coordinates
lat_AIRP2 = 41.7997222222
lon_AIRP2 = 12.2461111111
coor_AIRP2 = (lat_AIRP2,lon_AIRP2)

########################################################################################
"""Inputs"""
########################################################################################

# Type horizontal = 0, vertical = 1

cluster_type = 1

# Cluster norm: Not norm = 0, norm = 1
cluster_norm = 0
########################################################################################
"""Importing Data"""
########################################################################################

print('[0] Load dataset.\n')
    
df = pd.read_csv('Data4Clustering02.csv', header=0, delimiter=',')
df_head = df.head()

# print(df_head)

Nflights = df.sort_index().query('count == 0')

# Number of flights
Numflights = len(Nflights)

print('- Number of flights: \n', Numflights )

chunk_size = 50 # Size of flight vector

########################################################################################
"""Data scaling"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[1] Data scaling (0-1).\n')

if cluster_norm == 1:
    mms_lat = preprocessing.MinMaxScaler(feature_range=(0, 1))
    df['lat_norm'] = mms_lat.fit_transform(df.lat.values.reshape((-1, 1)))

    mms_lon = preprocessing.MinMaxScaler(feature_range=(0, 1))
    df['lon_norm'] = mms_lon.fit_transform(df.lon.values.reshape((-1, 1)))

    mms_alt = preprocessing.MinMaxScaler(feature_range=(0, 100))
    df['alt_norm'] = mms_alt.fit_transform(df.alt.values.reshape((-1, 1)))

    mms_time = preprocessing.MinMaxScaler(feature_range=(0, 1000))
    df['times_norm'] = mms_time.fit_transform(df.time.values.reshape((-1, 1)))
    dt = mms_time.scale_ * 0.5 * 60 * 60   # time interval of 30 mins

# print(df)
# print(dt)
########################################################################################
"""Re-sizing flight vectors"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[2] Re-sizing flight vectors (same size).\n')

if cluster_norm == 0:
    coordinates_vec = resize(df,Nflights,chunk_size,cluster_type)
elif cluster_norm == 1:
    coordinates_vec = resize_norm(df,Nflights,chunk_size,cluster_type)

########################################################################################
""" Meassuring Hausdorff distance between trajectories  2"""
#######################################################################################
print('--------------------------------------------------------------------------------\n')
print('[3] Meassuring Hausdorff distance between trajectories.\n')

# Distance matrix exist? exist = 1, no exist = 0
d_matrix_exist = 1

if d_matrix_exist == 1:
    D = np.load('d_mat_FRAFCO.npy')
else:
    D = distances(coordinates_vec,d_matrix_exist)
print(D)

########################################################################################
"""Clustering"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[4] Start clustering.\n')

# Not norm
dbscan = DBSCAN(eps=2000, min_samples=30)
# dbscan = DBSCAN(eps=3, min_samples=50)

# Norm
# dbscan = DBSCAN(eps=1800, min_samples=30)
# dbscan = DBSCAN(eps=3, min_samples=50)

cluster_lst = dbscan.fit_predict(D)

# Number of clusters in labels, ignoring noise if present.
labels = dbscan.labels_

core_samples = np.zeros_like(labels, dtype=bool)
core_samples[dbscan.core_sample_indices_] = True

n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
n_noise_ = list(labels).count(-1)
unique_labels = set(labels)


print('- Number of clusters: \n', n_clusters_)
print('- Number of noise points: \n', n_noise_)
print('- Unique labels: \n', unique_labels)  
# print('- Labels: \n', labels)
print('- Silhouette Score: %0.3f' % metrics.silhouette_score(D,labels))


color_lst = plt.rcParams['axes.prop_cycle'].by_key()['color']
color_lst.extend(['firebrick', 'dimgray', 'indigo', 'khaki', 'teal', 'saddlebrown', 
                 'skyblue', 'coral', 'darkorange', 'lime', 'darkorchid', 'olive'])

def plot_cluster(traj_lst, cluster_lst):
    '''
    Plots given trajectories with a color that is specific for every trajectory's own cluster index.
    Outlier trajectories which are specified with -1 in `cluster_lst` are plotted dashed with black color
    '''
    cluster_count = np.max(cluster_lst) + 1
    
    for traj, cluster in zip(traj_lst, cluster_lst):
        
        if cluster == -1:
            # Means it it a noisy trajectory, paint it black
            plt.plot(traj[:, 0], traj[:, 1], c='k', linestyle='dashed',linewidth=0.01)
        
        else:
            plt.plot(traj[:, 0], traj[:, 1], c=color_lst[cluster % len(color_lst)],linewidth=1)


plot_cluster(coordinates_vec, cluster_lst)

plt.show()

########################################################################################
"""Importing Modules"""
########################################################################################
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import scipy as sp
import math
import sklearn
import haversine

from sklearn.cluster import DBSCAN
from sklearn.svm import LinearSVC
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from haversine import haversine, Unit

from sklearn import metrics
from sklearn import preprocessing

from scipy import interpolate
from scipy.spatial.distance import directed_hausdorff

from geopy.distance import great_circle
from geopy.distance import distance

########################################################################################
"""Importing Data"""
########################################################################################

print('[0] Load dataset.\n')
    
# df = pd.read_csv('FRAITA_5day.csv', header=0, delimiter=',')
df = pd.read_csv('Data4Clustering.csv', header=0, delimiter=',')
df_head = df.head()

Nflights = df.sort_index().query('count == 0')

# Number of flights
Numflights = len(Nflights)

print('- Number of flights: \n', Numflights )

########################################################################################
"""Data scaling"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[1] Data scaling (0-1).\n')

mms = preprocessing.MinMaxScaler(feature_range=(0, 1))
df['lat_norm'] = mms.fit_transform(df.lat.values.reshape((-1, 1)))

mms = preprocessing.MinMaxScaler(feature_range=(0, 1))
df['lon_norm'] = mms.fit_transform(df.lon.values.reshape((-1, 1)))

mms = preprocessing.MinMaxScaler(feature_range=(0, 1))
df['alt_norm'] = mms.fit_transform(df.alt.values.reshape((-1, 1)))



########################################################################################
"""Re-sizing flight vectors"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[2] Re-sizing flight vectors (same size).\n')

CHUNK_SIZE = 50 # Size of flight vector
coordinates_vec = []
# for i in range(6): 
for i in range(len(Nflights)-1): 

    # Separate vector by flights
    flights = df.iloc[Nflights.index[i]:Nflights.index[i+1]]

    # Resizing vector of flights lat and lon
    lat = flights['lat_norm']
    xlat = np.arange(lat.size)
    new_xlat = np.linspace(xlat.min(), xlat.max(), CHUNK_SIZE)
    lat_rz = sp.interpolate.interp1d(xlat, lat, kind='slinear')(new_xlat)

    lon = flights['lon_norm']
    xlon = np.arange(lon.size)
    new_xlon = np.linspace(xlon.min(), xlon.max(), CHUNK_SIZE)
    lon_rz = sp.interpolate.interp1d(xlon, lon, kind='slinear')(new_xlon)

    alt = flights['alt_norm']
    xalt = np.arange(alt.size)
    new_xalt = np.linspace(xalt.min(), xalt.max(), CHUNK_SIZE)
    alt_rz = sp.interpolate.interp1d(xalt, alt, kind='slinear')(new_xalt)

    coordinates = np.concatenate((lon_rz[:,None],lat_rz[:,None]),axis=1)
    coordinates = tuple(map(tuple, coordinates))
    coordinates_vec.append(np.vstack(coordinates))



########################################################################################
""" Meassuring Hausdorff distance between trajectories"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[3] Meassuring Hausdorff distance between trajectories.\n')
    
# degree_threshold = 5

# for traj_index, traj in enumerate(coordinates_vec):
    
#     hold_index_lst = []
#     previous_azimuth= 1000
    
#     for point_index, point in enumerate(traj[:-1]):
#         next_point = traj[point_index + 1]
#         diff_vector = next_point - point
#         azimuth = (math.degrees(math.atan2(*diff_vector)) + 360) % 360
        
#         if abs(azimuth - previous_azimuth) > degree_threshold:
#             hold_index_lst.append(point_index)
#             previous_azimuth = azimuth
#     hold_index_lst.append(traj.shape[0] - 1) # Last point of trajectory is always added
    
#     coordinates_vec[traj_index] = traj[hold_index_lst, :]

# print(coordinates_vec)


def hausdorff(u, v):
    d = max(directed_hausdorff(u, v)[0], directed_hausdorff(v, u)[0])
    return d

traj_count = len(coordinates_vec)
D = np.zeros((traj_count, traj_count))

# This may take a while
for i in range(traj_count):
    for j in range(i + 1, traj_count):
        distance = hausdorff(coordinates_vec[i], coordinates_vec[j])
        D[i, j] = distance
        D[j, i] = distance

########################################################################################
"""Cluster Plot Function"""
########################################################################################

color_lst = plt.rcParams['axes.prop_cycle'].by_key()['color']
color_lst.extend(['b', 'dimgray', 'indigo', 'khaki', 'teal', 'saddlebrown', 
                 'skyblue', 'coral', 'darkorange', 'lime', 'darkorchid', 'olive'])

def plot_cluster(traj_lst, cluster_lst):
    '''
    Plots given trajectories with a color that is specific for every trajectory's own cluster index.
    Outlier trajectories which are specified with -1 in `cluster_lst` are plotted dashed with black color
    '''
    cluster_count = np.max(cluster_lst) + 1
    
    for traj, cluster in zip(traj_lst, cluster_lst):
        
        if cluster == -1:
            plt.plot(traj[:, 0], traj[:, 1], c='k', linestyle='dashed',linewidth=0.1)
        elif cluster == 0:
            plt.plot(traj[:, 0], traj[:, 1], c=color_lst[cluster % len(color_lst)], marker='.',linestyle = '--',linewidth=0.1)
        elif cluster == 1:
            plt.plot(traj[:, 0], traj[:, 1], c=color_lst[cluster % len(color_lst)], marker='1',linestyle = '-.',linewidth=0.1)           
        elif cluster == 2:
            plt.plot(traj[:, 0], traj[:, 1], c=color_lst[cluster % len(color_lst)], marker='+',linestyle = ':',linewidth=0.1)
            
    
########################################################################################
"""Clustering"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[4] Start clustering.\n')
# dbscan = DBSCAN(eps=0.8, min_samples=1)
dbscan = DBSCAN(eps=0.5, min_samples=100)
cluster_lst = dbscan.fit_predict(D)

plot_cluster(coordinates_vec, cluster_lst)

# Number of clusters in labels, ignoring noise if present.
labels = dbscan.labels_
# print(labels,len(labels))

core_samples = np.zeros_like(labels, dtype=bool)
core_samples[dbscan.core_sample_indices_] = True

n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
n_noise_ = list(labels).count(-1)
unique_labels = set(labels)


print('- Number of clusters: \n', n_clusters_)
print('- Number of noise points: \n', n_noise_)
print('- Unique labels: \n', unique_labels)  
# print('- Labels: \n', labels)
# print('- Silhouette Score: %0.3f' % metrics.silhouette_score(D,labels))

plt.xlabel('Longitude (scaled)')
plt.ylabel('Latitude (scaled)')

########################################################################################
"""Classifing"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[5] Start classifing.\n')

# Separating cluster results coordinates and labels
for k in zip(unique_labels):
    class_member_mask1 = (labels == 0)
    xy1 = D[class_member_mask1 & core_samples]
    label_clust1 = labels[class_member_mask1]
   
    class_member_mask2 = (labels == 1)
    xy2 = D[class_member_mask2 & core_samples]
    label_clust2 = labels[class_member_mask2]

    class_member_mask3 = (labels == 2)
    xy3 = D[class_member_mask3 & core_samples]
    label_clust3 = labels[class_member_mask3]

    class_member_mask4 = (labels == -1)
    xy4 = D[class_member_mask4 & ~core_samples]
    label_clust4 = labels[class_member_mask4]

Distances = np.concatenate((xy1,xy2,xy3,xy4),axis=0)
label_clus = np.concatenate((label_clust1,label_clust2,label_clust3,label_clust4),axis=0)

# Creating data frame including cluster coordinates and labels
data=pd.DataFrame()
data = pd.DataFrame(data=Distances[:,:]) 
label_clus = pd.Series(label_clus) 
data['label'] = label_clus

# Features
x = data.iloc[:, 0:-1]
# Labels
y = data['label']

# Spliting data for train and test. In this case 
SEED = 15
np.random.seed(SEED)
train_x, test_x, train_y, test_y = train_test_split(x, y,
                                                         random_state = SEED, test_size = 0.25,stratify = y)
print("Training with %d elements and test with %d elements" % (len(train_x), len(test_x)))

model = LinearSVC(class_weight='balanced',max_iter=10000)
model.fit(train_x, train_y)
predictions = model.predict(test_x)
accuracy = accuracy_score(test_y, predictions) * 100
print("Accuracy: %.2f%%" % accuracy)

from sklearn.dummy import DummyClassifier

dummy_stratified = DummyClassifier(strategy="stratified")
dummy_stratified.fit(train_x, train_y)
accuracy = dummy_stratified.score(test_x, test_y) * 100

print("Accuracy of dummy stratified: %.2f%%" % accuracy)

dummy_mostfrequent = DummyClassifier(strategy="most_frequent")
dummy_mostfrequent.fit(train_x, train_y)
accuracy = dummy_mostfrequent.score(test_x, test_y) * 100

print("Accuracy of mostfrequent: %.2f%%" % accuracy)

########################################################################################
"""Testing"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[6] Testing model.\n')

########################################################################################
# Definition of trajectories to test

# Trajectory cluster 0

# lon_FRA = 0.34
# lat_FRA = 0.90

# lon_ITA = 0.83
# lat_ITA = 0.087

# lon0 = 0.52
# lat0 = 0.81

# lon1 = 0.75
# lat1 = 0.62

# lon2 = 0.76
# lat2 = 0.22

# Trajectory cluster 1
# lon_FRA = 0.1
# lat_FRA = 0.87

# lon_ITA = 0.68
# lat_ITA = 0.04

# lon0 = 0.08
# lat0 = 0.69

# lon1 = 0.13
# lat1 = 0.5

# lon2 = 0.49
# lat2 = 0.21

# Trajectory cluster 2

# lon_FRA = 0.15
# lat_FRA = 0.87

# lon_ITA = 0.82
# lat_ITA = 0.07

# lon0 = 0.28
# lat0 = 0.64

# lon1 = 0.53
# lat1 = 0.45

# lon2 = 0.73
# lat2 = 0.22

# Trajectory cluster -1

lon_FRA = 0.83
lat_FRA = 0.99

lon_ITA = 0.96
lat_ITA = 0.06


lon0 = 0.95
lat0 = 0.84

lon1 = 0.93
lat1 = 0.65

lon2 = 0.90
lat2 = 0.19

#  Trajectory cluster -1
# lon_FRA = 0.01
# lat_FRA = 0.88

# lon_ITA = 0.57
# lat_ITA = 0.01


# lon0 = 0.04
# lat0 = 0.25

# lon1 = 0.06
# lat1 = 0.07

# lon2 = 0.45
# lat2 = 0.045


lat = (lat_FRA,
lat0,
lat1,
lat2,
lat_ITA)

lon = (lon_FRA,
lon0,
lon1,
lon2,
lon_ITA)

lat = np.asarray(lat)
lon = np.asarray(lon)

xlat = np.arange(lat.size)
new_xlat = np.linspace(xlat.min(), xlat.max(), CHUNK_SIZE)
lat_test= sp.interpolate.interp1d(xlat, lat, kind='slinear')(new_xlat)

xlon = np.arange(lon.size)
new_xlon = np.linspace(xlon.min(), xlon.max(), CHUNK_SIZE)
lon_test = sp.interpolate.interp1d(xlon, lon, kind='slinear')(new_xlon)

plt.plot(lon_test,lat_test,c='r',linestyle = '-.',linewidth=1)

coordinates_test = np.concatenate((lon_test[:,None],lat_test[:,None]),axis=1)
coordinates_test = tuple(map(tuple, coordinates_test))

D_test = []
# This may take a while
for i in range(traj_count):
    distance_test = hausdorff(coordinates_vec[i], coordinates_test)
    Dist = distance_test
    D_test.append(Dist)

D_test =np.asarray(D_test)
D_test = D_test.reshape((1,traj_count)) 

D_test = pd.DataFrame(D_test) 

teste = D_test.iloc[:, :]

predictions = model.predict(teste)

print('- The test trajectory belongs to cluster: \n', predictions)

print('--------------------------------------------------------------------------------\n')
print('[7] All completed.\n')

plt.show()
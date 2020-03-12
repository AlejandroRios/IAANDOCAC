"""" 
Function  : Cluster and classification function
Title     : Cluster_Classification
Written by: Alejandro Rios
Date      : April/2019
Language  : Python
Aeronautical Institute of Technology
"""
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
import seaborn as sns
import time

from sklearn.cluster import DBSCAN
from sklearn.svm import LinearSVC
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn.preprocessing import StandardScaler
from haversine import haversine, Unit
from mpl_toolkits.basemap import Basemap 
from sklearn.gaussian_process import GaussianProcessClassifier
from sklearn.gaussian_process.kernels import RBF

from sklearn import metrics
from sklearn import preprocessing

from scipy import interpolate

from geopy.distance import great_circle
from geopy.distance import distance

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
"""Base map plot definition"""
########################################################################################
fig, ax = plt.subplots()
m = Basemap(resolution='i', projection='merc', llcrnrlat=40, urcrnrlat=54, llcrnrlon=-5, urcrnrlon=14)
m.drawmapboundary(fill_color='aqua')
m.fillcontinents(color='1.0',lake_color='aqua')
m.drawcoastlines()
m.drawcountries()
parallels = np.arange(0.,81,5.)
m.drawparallels(parallels,labels=[False,True,True,False])
meridians = np.arange(-10.,351.,5.)
m.drawmeridians(meridians,labels=[True,False,False,True])

########################################################################################
"""Importing Data"""
########################################################################################

print('[0] Load dataset.\n')
    
df = pd.read_csv('Data4Clustering02.csv', header=0, delimiter=',')
df_head = df.head()

Nflights = df.sort_index().query('count == 0')

# Number of flights
Numflights = len(Nflights)

print('- Number of flights: \n', Numflights )

########################################################################################
"""Data scaling"""
########################################################################################
# print('--------------------------------------------------------------------------------\n')
# print('[1] Data scaling (0-1).\n')

# mms = preprocessing.MinMaxScaler(feature_range=(0, 1))
# df['lat_norm'] = mms.fit_transform(df.lat.values.reshape((-1, 1)))

# mms = preprocessing.MinMaxScaler(feature_range=(0, 1))
# df['lon_norm'] = mms.fit_transform(df.lon.values.reshape((-1, 1)))

# mms = preprocessing.MinMaxScaler(feature_range=(0, 1))
# df['alt_norm'] = mms.fit_transform(df.alt.values.reshape((-1, 1)))


########################################################################################
"""Re-sizing flight vectors"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[2] Re-sizing flight vectors (same size).\n')

CHUNK_SIZE = 50 # Size of flight vector
coordinates_vec = []
# for i in range(6): 
# for i in range(len(Nflights)-1): 
for i in range(1000):

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

    # coordinates = np.concatenate((lon_rz[:,None],lat_rz[:,None],alt_rz[:,None]),axis=1)
    coordinates = np.concatenate((lon_rz[:,None],lat_rz[:,None]),axis=1)
    coordinates = tuple(map(tuple, coordinates))
    coordinates_vec.append(np.vstack(coordinates))


########################################################################################
""" Meassuring Hausdorff distance between trajectories 1"""
########################################################################################
# from scipy.spatial.distance import directed_hausdorff


# print('--------------------------------------------------------------------------------\n')
# print('[3] Meassuring Hausdorff distance between trajectories.\n')
# start = time.clock() 
# def hausdorff(u, v):
#     d = max(directed_hausdorff(u, v)[0], directed_hausdorff(v, u)[0])
#     return d

# traj_count = len(coordinates_vec)
# D = np.zeros((traj_count, traj_count))

# # This may take a while
# for i in range(traj_count):
#     for j in range(i + 1, traj_count):
#         distance = hausdorff(coordinates_vec[i], coordinates_vec[j])
#         D[i, j] = distance
#         D[j, i] = distance

# print(D)
    

# end = time.clock()  
# print("Processor time (in seconds):", end) 
# print("Time elapsed during the calculation:", end - start) 

########################################################################################
""" Meassuring Hausdorff distance between trajectories  2"""
########################################################################################
# from Hausdurff_Distance import cmax
# print('--------------------------------------------------------------------------------\n')
# print('[3] Meassuring Hausdorff distance between trajectories.\n')
# start = time.clock() 

# def hausdorff(A,B):
#     H_distance = max(cmax(coordinates_vec[i], coordinates_vec[j]),cmax(coordinates_vec[i], coordinates_vec[j]))
#     return(H_distance)


# traj_count = len(coordinates_vec)
# D = np.zeros((traj_count, traj_count))

# # This may take a while
# for i in range(traj_count):
#     for j in range(i + 1, traj_count):
#         # distance = hausdorff(coordinates_vec[i], coordinates_vec[j])
#         distance = hausdorff(coordinates_vec[i], coordinates_vec[j])
#         D[i, j] = distance
#         D[j, i] = distance



# end = time.clock()  
# print("Processor time (in seconds):", end) 

# print("Time elapsed during the calculation:", end - start) 


# np.save('distances_n_norm.npy', D)

D = np.load('distances_n_norm.npy')
########################################################################################
"""Cluster Plot Function"""
########################################################################################

color_lst = plt.rcParams['axes.prop_cycle'].by_key()['color']
color_lst.extend(['b', 'dimgray', 'indigo', 'khaki', 'teal', 'saddlebrown', 
                 'skyblue', 'coral', 'darkorange', 'lime', 'darkorchid', 'olive'])

def plot_cluster(traj_lst, cluster_lst):
    cluster_count = np.max(cluster_lst) + 1
    
    for traj, cluster in zip(traj_lst, cluster_lst):
        
        if cluster == -1:
            x1, y1 = m(traj[:, 0], traj[:, 1])
            # m.plot(*(x1, y1), c='b', linestyle='dashed',linewidth=2)
            p0 = m.plot(*(x1, y1), c='k', linestyle='dashed',linewidth=0.1,alpha=0.5)
        elif cluster == 0:
            x2, y2 = m(traj[:, 0], traj[:, 1])
            p1 = m.plot(*(x2, y2), c=color_lst[cluster % len(color_lst)],linewidth=0.5,alpha=0.5)
        elif cluster == 1:
            x3, y3 = m(traj[:, 0], traj[:, 1])
            p2 = m.plot(*(x3, y3), c=color_lst[cluster % len(color_lst)],linewidth=0.5,alpha=0.5)        
        elif cluster == 2:
            x4, y4 = m(traj[:, 0], traj[:, 1])
            p3 = m.plot(*(x4, y4), c=color_lst[cluster % len(color_lst)],linewidth=0.5,alpha=0.5)
    
    plt.legend((p0[0],p1[0],p2[0],p3[0]),('Outliers','R1 Clust. 0','R1 Clust. 1','R1 Clust. 2'))
            

########################################################################################
"""Centroid Cluster Function"""
########################################################################################
def CG_cluster(traj_lst, cluster_lst):

    latc1 = []
    lonc1 = []
    latc2 = []
    lonc2 = []
    latc3 = []
    lonc3 = []

    for traj, cluster in zip(traj_lst, cluster_lst):

        if cluster == 0:
            latc1.append(np.vstack(traj[:, 0]))
            lonc1.append(np.vstack(traj[:, 1]))

        elif cluster == 1:
            latc2.append(np.vstack(traj[:, 0]))
            lonc2.append(np.vstack(traj[:, 1]))

        elif cluster == 2:
            latc3.append(np.vstack(traj[:, 0]))
            lonc3.append(np.vstack(traj[:, 1]))
    
    meanlatc1 = np.mean(latc1, axis=0)
    meanlonc1 = np.mean(lonc1, axis=0)
    meanlatc2 = np.mean(latc2, axis=0)
    meanlonc2 = np.mean(lonc2, axis=0)
    meanlatc3 = np.mean(latc3, axis=0)
    meanlonc3 = np.mean(lonc3, axis=0)

    return meanlatc1,meanlonc1,meanlatc2,meanlonc2,meanlatc3,meanlonc3

########################################################################################
"""Clustering"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[4] Start clustering.\n')
# dbscan = DBSCAN(eps=0.8, min_samples=1)
dbscan = DBSCAN(eps=3, min_samples=50)
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


# ########################################################################################
# """Classifing"""
# ########################################################################################
# print('--------------------------------------------------------------------------------\n')
# print('[5] Start classifing.\n')

# ########################################################################################
# """Classifing"""
# ########################################################################################
# print('--------------------------------------------------------------------------------\n')
# print('[5] Start classifing.\n')

# # Separating cluster results coordinates and labels
# for k in zip(unique_labels):
#     class_member_mask1 = (labels == 0)
#     xy1 = D[class_member_mask1 & core_samples]
#     label_clust1 = labels[class_member_mask1]
   
#     class_member_mask2 = (labels == 1)
#     xy2 = D[class_member_mask2 & core_samples]
#     label_clust2 = labels[class_member_mask2]

#     class_member_mask3 = (labels == 2)
#     xy3 = D[class_member_mask3 & core_samples]
#     label_clust3 = labels[class_member_mask3]

#     class_member_mask4 = (labels == -1)
#     xy4 = D[class_member_mask4 & ~core_samples]
#     label_clust4 = labels[class_member_mask4]

# Distances = np.concatenate((xy1,xy2,xy3,xy4),axis=0)
# label_clus = np.concatenate((label_clust1,label_clust2,label_clust3,label_clust4),axis=0)



# # Creating data frame including cluster coordinates and labels
# data=pd.DataFrame()
# data = pd.DataFrame(data=Distances[:,:]) 
# label_clus = pd.Series(label_clus) 
# data['label'] = label_clus

# # Features
# x = data.iloc[:, 0:-1]
# # Labels
# y = data['label']

# # Spliting data for train and test. In this case 
# SEED = 0
# np.random.seed(SEED)
# # train_x, test_x, train_y, test_y = train_test_split(x, y,
#                                                         #  random_state = SEED, test_size = 0.25,stratify = y)
# train_x, test_x, train_y, test_y = train_test_split(x, y,
#                                                          random_state = SEED, test_size = 0.10,stratify = y)            
# print("Training with %d elements and test with %d elements" % (len(train_x), len(test_x)))

# # Model to use
# # model = LinearSVC(class_weight='balanced',max_iter=1000000)
# # model = SVC(kernel='linear', C=1)
# # model = SVC(random_state=0, gamma='scale')
# model = GaussianProcessClassifier(random_state=0)

# model.fit(train_x, train_y)
# predictions = model.predict(test_x)
# accuracy = accuracy_score(test_y, predictions) * 100
# print("Accuracy: %.2f%%" % accuracy)

# from sklearn.dummy import DummyClassifier

# dummy_stratified = DummyClassifier(strategy="stratified")
# dummy_stratified.fit(train_x, train_y)
# accuracy = dummy_stratified.score(test_x, test_y) * 100

# print("Accuracy of dummy stratified: %.2f%%" % accuracy)

# dummy_mostfrequent = DummyClassifier(strategy="most_frequent")
# dummy_mostfrequent.fit(train_x, train_y)
# accuracy = dummy_mostfrequent.score(test_x, test_y) * 100

# print("Accuracy of mostfrequent: %.2f%%" % accuracy)

########################################################################################
"""Calculating cluster centroids"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[6] Calculating cluster centroids.\n')

#######################################################################################
meanlatc1,meanlonc1,meanlatc2,meanlonc2,meanlatc3,meanlonc3 = CG_cluster(coordinates_vec, cluster_lst)


meanlatc1 = np.array(meanlatc1).ravel()
meanlonc1 = np.array(meanlonc1 ).ravel()
meanlatc2 = np.array(meanlatc2).ravel()
meanlonc2 = np.array(meanlonc2 ).ravel()
meanlatc3 = np.array(meanlatc3).ravel()
meanlonc3 = np.array(meanlonc3 ).ravel()


data_output=pd.DataFrame()
data_output['lat_clus1'] =  meanlatc1
data_output['lon_clus1'] =  meanlonc1

data_output['lat_clus2'] =  meanlatc2
data_output['lon_clus2'] =  meanlonc2

data_output['lat_clus3'] =  meanlatc3
data_output['lon_clus3'] =  meanlonc3


# Exporting centroids to csv
data_output.to_csv('Centroids02.csv') 



# data['label'] = label_clus

x1, y1 = m(meanlatc1,meanlonc1)
x2, y2 = m(meanlatc2,meanlonc2 )
x3, y3 = m(meanlatc3,meanlonc3 )
# m.plot(*(x1, y1), c='b',linewidth=2)
# m.plot(*(x2, y2), c='dimgray', linestyle='dashed',linewidth=2)
# m.plot(*(x3, y3), c='indigo',linestyle='dashed',linewidth=2)

########################################################################################
"""Plot terminal area and airport location """
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[7] Plot definition .\n')


def radius_for_tissot(dist_km):
    return np.rad2deg(dist_km/6367.)


x,y=m(lon_AIRP2,lat_AIRP2)
x2,y2 = m(lon_AIRP2,lat_AIRP2+1) 
circle1 = plt.Circle((x, y), 170000, color='black',fill=False)
ax.add_patch(circle1)


x,y=m(lon_AIRP1,lat_AIRP1)
x2,y2 = m(lon_AIRP1,lat_AIRP1+1) 
circle1 = plt.Circle((x, y), 170000, color='black',fill=False)
ax.add_patch(circle1)

########################################################################################

lats = [lat_AIRP1, lat_AIRP2]
lons = [lon_AIRP1, lon_AIRP2]
names = ["FRA", "FCO"]
x, y = m(lons,lats)

m.scatter(x, y, 200, color="r", marker="v", edgecolor="k", zorder=0.5)
for i in range(len(names)):
    plt.text(x[i], y[i], names[i], va="top", family="monospace", weight="bold")

plot_cluster(coordinates_vec, cluster_lst)

plt.show()
##############################################################
print('--------------------------------------------------------------------------------\n')
print('[8] All completed.\n')
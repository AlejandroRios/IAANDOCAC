########################################################################################
"""Importing Data"""
########################################################################################
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import scipy as sp
import math
import sklearn
import haversine
import matplotlib as mpl
import seaborn as sns
import plotly.graph_objs as go
import plotly.plotly as py


from mpl_toolkits.mplot3d import Axes3D
from mpl_toolkits.basemap import Basemap

from sklearn.cluster import DBSCAN
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from sklearn.svm import LinearSVC
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.model_selection import permutation_test_score
from sklearn.model_selection import StratifiedKFold
from sklearn.svm import SVC
from haversine import haversine, Unit


from sklearn import metrics
from sklearn import preprocessing

from collections import Counter
from collections import OrderedDict

from scipy import interpolate
# from scipy.spatial import distance
from scipy.spatial.distance import directed_hausdorff

from itertools import cycle
from itertools import islice

from datetime import datetime
from geopy.distance import great_circle
from geopy.distance import distance
from statistics import mean 
from fractions import Fraction as fr 

########################################################################################
"""Importing Data"""
########################################################################################

print('[0] Load dataset.\n')
    
# df = pd.read_csv('FRAITA_5day.csv', header=0, delimiter=',')
df = pd.read_csv('FRAITA_month17.csv', header=0, delimiter=',')
df_head = df.head()

########################################################################################
"""Data manipulation and checks"""
########################################################################################

print('[1] Data manipulation and checks.\n')

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

# Check if data contains null values
# print('Data containing NAN: \n',df.isnull().sum())

# Sort values - organize flights
# query - takes all index with hit = 0 of sorted data
# flights = df.sort_index().query('hit == 0')

# # Number of flights
# Numflights = len(flights)
# print('[1] Number of flights: ', Numflights )

# Size data without filter
print('- Sample size without filters: \n', len(df))


########################################################################################
"""Creating new feature meassuring distance of samples to airports"""
########################################################################################

print('[2] Meassuring distance between samples and airpots.\n')

# Frankfurt airport coordinates
lat_FRA = 50.110924
lon_FRA = 8.682127
coor_FRA = (lat_FRA,lon_FRA)

# Rome airport coordinates
lat_ITA = 41.7997222222
lon_ITA = 12.2461111111
coor_ITA = (lat_ITA,lon_ITA)

lat = np.asarray(df['lat'])
lat = lat[:,None]

lon = np.asarray(df['lon'])
lon = lon[:,None]

Hdist_FRA = []
Hdist_ITA = []

########################################################################################
"""Filtering lat and long data out of lat lon bounds"""
########################################################################################

print('[2.1] First data filter.\n')

# Drop outliers out of lat scale lat < -180, lat > 180
df = df.drop(df[df.lat > 180].index)
df = df.drop(df[df.lat < -180].index)
# Drop outliers out of lon scale lon < -90, lon > 90
df = df.drop(df[df.lon > 90].index)
df = df.drop(df[df.lon < -90].index)

########################################################################################

for idx, row, in df.iterrows():

    Airport_FRA = coor_FRA
    Airport_ITA = coor_ITA

    coord = (lat[idx],lon[idx])
    
    Hdist_FRA.append(distance(coord, Airport_FRA).nm)
    Hdist_ITA.append(distance(coord, Airport_ITA).nm)

    # Hdist_FRA.append(haversine(coord, Airport_FRA, unit='nmi'))
    # Hdist_ITA.append(haversine(coord, Airport_ITA, unit='nmi'))


Hdist_FRA = np.asarray(Hdist_FRA)
Hdist_ITA = np.asarray(Hdist_ITA)
df['Hdist_FRA'] = Hdist_FRA
df['Hdist_ITA'] = Hdist_ITA


########################################################################################
"""Filtering dataset"""
########################################################################################

print('[3] Second data filter avoiding terminal area (60 mn).\n')

# Drop outliers out of lat scale lat < -180, lat > 180
df = df.drop(df[df.lat > 51].index)
df = df.drop(df[df.lat < 42].index)
# Drop outliers out of lon scale lon < -90, lon > 90
df = df.drop(df[df.lon > 13].index)
df = df.drop(df[df.lon < 8].index)

# Identifing and saving data that is out of the terminal area
df = df[df.Hdist_FRA > 60.0]
df = df[df.Hdist_ITA > 60.0]

print('- Sample size filtered: \n', len(df))

########################################################################################
"""Accounting the number of flights"""
########################################################################################

print('[4] Accounting number of flights by icao and call filters.\n')

df['count'] = df.groupby(((df['icao'] != df['icao'].shift(1)) |  (df['call'] != df['call'].shift(1))).cumsum()).cumcount()
df = df.reset_index(drop=True)

Nflights = df.sort_index().query('count == 0')

# Number of flights
Numflights = len(Nflights)

print('- Number of flights: \n', Numflights )

########################################################################################
"""Data scaling"""
########################################################################################

print('[5] Data scaling (0-1).\n')

mms = preprocessing.MinMaxScaler(feature_range=(0, 1))
df['lat_norm'] = mms.fit_transform(df.lat.values.reshape((-1, 1)))

mms = preprocessing.MinMaxScaler(feature_range=(0, 1))
df['lon_norm'] = mms.fit_transform(df.lon.values.reshape((-1, 1)))

mms = preprocessing.MinMaxScaler(feature_range=(0, 1))
df['alt_norm'] = mms.fit_transform(df.alt.values.reshape((-1, 1)))

# df.to_csv('teste.csv')

########################################################################################
"""Re-sizing flight vectors"""
########################################################################################

print('[6] Re-sizing flight vectors (same size).\n')

CHUNK_SIZE = 500 # Size of flight vector
coordinates_vec = []
# for i in range(200): 
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

print('[7] Meassuring Hausdorff distance between trajectories.\n')
    
degree_threshold = 5

for traj_index, traj in enumerate(coordinates_vec):
    
    hold_index_lst = []
    previous_azimuth= 1000
    
    for point_index, point in enumerate(traj[:-1]):
        next_point = traj[point_index + 1]
        diff_vector = next_point - point
        azimuth = (math.degrees(math.atan2(*diff_vector)) + 360) % 360
        
        if abs(azimuth - previous_azimuth) > degree_threshold:
            hold_index_lst.append(point_index)
            previous_azimuth = azimuth
    hold_index_lst.append(traj.shape[0] - 1) # Last point of trajectory is always added
    
    coordinates_vec[traj_index] = traj[hold_index_lst, :]


def hausdorff( u, v):
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
            plt.plot(traj[:, 0], traj[:, 1], c='k', linestyle='dashed',linewidth=0.1)
        
        else:
            plt.plot(traj[:, 0], traj[:, 1], c=color_lst[cluster % len(color_lst)],linewidth=0.2)
    
########################################################################################
"""Clustering"""
########################################################################################

print('[8] Start clustering.\n')

dbscan = DBSCAN(eps=0.8, min_samples=50)
cluster_lst = dbscan.fit_predict(D)

plot_cluster(coordinates_vec, cluster_lst)

# Number of clusters in labels, ignoring noise if present.
labels = dbscan.labels_
# print(labels,len(labels))

core_samples = np.zeros_like(labels, dtype=bool)
core_samples[dbscan.core_sample_indices_] = True

n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
n_noise_ = list(labels).count(-1)

print('- Number of clusters: \n', n_clusters_)
print('- Number of noise points: \n', n_noise_)
print('- Silhouette Score: %0.3f' % metrics.silhouette_score(D,labels))


print('[9] All completed.\n')


plt.xlabel('Longitude (scaled)')
plt.ylabel('Latitude (scaled)')
plt.show()


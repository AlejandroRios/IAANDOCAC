########################################################################################
"""Importing Modules"""
########################################################################################

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
from geopy.distance import distance

########################################################################################
"""Importing Data"""
########################################################################################
print('[0] Load dataset.\n')

df = pd.read_csv('Centroids01.csv', header=0, delimiter=',')
df_head = df.head()

# 1.159759540154151	51.6762861168459
# 7.077291370268191	50.0817658998624

# Frankfurt airport coordinates
# lat_AIRP1 = 50.0817658998624
# lon_AIRP1 = 7.077291370268191
# coor_AIRP1 = (lat_AIRP1,lon_AIRP1)

# # Rome airport coordinates
# lon_AIRP2 = 1.159759540154151
# lat_AIRP2 = 51.6762861168459  

lat_AIRP1 = 50.110924
lon_AIRP1 = 8.682127
coor_AIRP1 = (lat_AIRP1,lon_AIRP1)

# Rome airport coordinates
# lon_AIRP2 = -0.461389
# lat_AIRP2 = 51.4775  


lon_AIRP2 = 12.2461111111
lat_AIRP2 = 41.7997222222
coor_AIRP2 = (lat_AIRP2,lon_AIRP2)

########################################################################################
"""Re-sizing flight vectors"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[1] Re-sizing flight vectors (same size).\n')

CHUNK_SIZE = 200

lat = df['lat_clus3']
xlat = np.arange(lat.size)
new_xlat = np.linspace(xlat.min(), xlat.max(), CHUNK_SIZE)
lat_rz = sp.interpolate.interp1d(xlat, lat, kind='slinear')(new_xlat)

lon = df['lon_clus3']
xlon = np.arange(lon.size)
new_xlon = np.linspace(xlon.min(), xlon.max(), CHUNK_SIZE)
lon_rz = sp.interpolate.interp1d(xlon, lon, kind='slinear')(new_xlon)

lat_ff = []
lon_ff = []
alt_ff = []
Fly_mtx = np.array([])

for j in range(len(lon_rz)):
    lon_f = [lon_rz[j]]
    lat_f = [lat_rz[j]]

    # Storing usable filtered coordinates
    lat_ff.append(lat_f)
    lon_ff.append(lon_f)

    distances_pp = []
    distances_pp_f = []

for j in range(len(lon_rz)-1):

    # Defining cordinates of two points to messure distance      
    coordinates0 = (lon_rz[j],lat_rz[j])
    coordinates1 = (lon_rz[j+1],lat_rz[j+1])

    # Calculating haversine distance between two points in nautical miles
    distance_pp = float(distance(coordinates0,coordinates1).nm)

    # Storing calculated point to point distances into a vector
    distances_pp.append(distance_pp)

    # Sum of point to point distances to obtain total distance of a flight
    distance_real = sum(distances_pp)


plt.plot(df.lat_clus1,df.lon_clus1,'b')
# plt.plot(df.lat_clus2,df.lon_clus2,'r')
# plt.plot(df.lat_clus3,df.lon_clus3,'y')

########################################################################################
"""Evaluating horizontal inefficiency"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[2] Evaluating horizontal ineff..\n')

distance_real = distance_real
GCD_AIRP1AIRP2 = (great_circle(coor_AIRP1,coor_AIRP2).nm)-120
print('Great Circle: ',GCD_AIRP1AIRP2)
print('Real distance : ', distance_real)

Heff = (((distance_real)-GCD_AIRP1AIRP2)/GCD_AIRP1AIRP2)*100
print('HFE:', Heff)


plt.show()
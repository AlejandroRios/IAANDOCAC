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

df = pd.read_csv('Centroids02.csv', header=0, delimiter=',')
df_head = df.head()


# Frankfurt airport coordinates
lat_AIRP1 = 50.110924
lon_AIRP1 = 8.682127
coor_AIRP1 = (lat_AIRP1,lon_AIRP1)

# Rome airport coordinates
lon_AIRP2 = -0.461389
lat_AIRP2 = 51.4775  
coor_AIRP2 = (lat_AIRP2,lon_AIRP2)


########################################################################################
"""Base map plot definition"""
########################################################################################
fig, ax = plt.subplots()
# m = Basemap(resolution='i', projection='merc', llcrnrlat=40, urcrnrlat=54, llcrnrlon=-5, urcrnrlon=14)
# m.drawmapboundary(fill_color='aqua')
# m.fillcontinents(color='1.0',lake_color='aqua')
# m.drawcoastlines()
# m.drawcountries()
# parallels = np.arange(0.,81,5.)
# m.drawparallels(parallels,labels=[False,True,True,False])
# meridians = np.arange(-10.,351.,5.)
# m.drawmeridians(meridians,labels=[True,False,False,True])

########################################################################################
"""Re-sizing flight vectors"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[1] Re-sizing flight vectors (same size).\n')

CHUNK_SIZE = 50

lat = df['lat_clus1']
xlat = np.arange(lat.size)
new_xlat = np.linspace(xlat.min(), xlat.max(), CHUNK_SIZE)
lat_rz = sp.interpolate.interp1d(xlat, lat, kind='slinear')(new_xlat)

lon = df['lon_clus1']
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
    coordinates0 = (lat_rz[j],lon_rz[j])
    coordinates1 = (lat_rz[j+1],lon_rz[j+1])

    # Calculating haversine distance between two points in nautical miles
    distance_pp = float(distance(coordinates0,coordinates1).nm)

    # Storing calculated point to point distances into a vector
    distances_pp.append(distance_pp)

    # Sum of point to point distances to obtain total distance of a flight
    distance_real = sum(distances_pp)


plt.plot(df.lat_clus1,df.lon_clus1,'b')
# p1 = m.plot(*(df.lat_clus1,df.lon_clus1,), c=color_lst[cluster % len(color_lst)],linewidth=0.5,alpha=0.5)
########################################################################################
"""Evaluating horizontal inefficiency"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[2] Evaluating horizontal ineff..\n')

distance_real = distance_real
GCD_AIRP1AIRP2 = (great_circle(coor_AIRP1,coor_AIRP2).nm)
print('GCD: ',GCD_AIRP1AIRP2)
print('Route distace: ', distance_real)

Heff = (((distance_real)-GCD_AIRP1AIRP2)/GCD_AIRP1AIRP2)*100
print('HFE:', Heff)


plt.show()
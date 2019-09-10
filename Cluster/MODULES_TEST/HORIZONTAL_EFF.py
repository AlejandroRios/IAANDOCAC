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

lon_CDG = 49.0096906
lat_CDG = 2.54792450

coor_CDG = (lon_CDG,lat_CDG)

lon_LHR = 51.470020
lat_LHR = -0.454295

coor_LHR = (lon_LHR,lat_LHR)



###############################################################################################
###############################################################################################
from functools import partial
import pyproj
from shapely.ops import transform
from shapely.geometry import Point

proj_wgs84 = pyproj.Proj(init='epsg:4326')


def geodesic_point_buffer(lat, lon, nm):
    # Azimuthal equidistant projection
    aeqd_proj = '+proj=aeqd +lat_0={lat} +lon_0={lon} +x_0=0 +y_0=0'
    project = partial(
        pyproj.transform,
        pyproj.Proj(aeqd_proj.format(lat=lat, lon=lon)),
        proj_wgs84)
    buf = Point(0, 0).buffer(nm * 1000)  # distance in metres
    return transform(project, buf).exterior.coords[:]

# Example
b = geodesic_point_buffer(45.4, -75.7, 100.0)

###############################################################################################
###############################################################################################

# for i in range(1): 
for i in range(0,90): 

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
    



    for j in range(len(lon_rz)):
        lon_f = [lon_rz[j]]
        lat_f = [lat_rz[j]]
        alt_f = [alt_rz[j]]

        # Storing usable filtered coordinates
        lat_ff.append(lat_f)
        lon_ff.append(lon_f)
        alt_ff.append(alt_f)

        distances_pp = []
        distances_pp_f = []

    for j in range(len(lon_rz)-1):

        # Defining cordinates of two points to messure distance      
        coordinates0 = (lat_rz[j],lon_rz[j])
        coordinates1 = (lat_rz[j+1],lon_rz[j+1])

        # Calculating haversine distance between two points in nautical miles
        distance_pp = float(haversine(coordinates0,coordinates1,unit='nmi'))

        # Storing calculated point to point distances into a vector
        distances_pp.append(distance_pp)

        # Sum of point to point distances to obtain total distance of a flight
        distances = sum(distances_pp)

        # Next step perform a filter taking out first 6 nm of the flight
        distances2 = np.asarray(distances)

        GCD_CDGLHR = great_circle(coor_CDG,coor_LHR).nm

        altitude = alt_rz[j]    
    Heff = ((distances-GCD_CDGLHR)/distances)*100
    print(distances)
    # fig = plt.plot(i,distances, '*', markeredgecolor='k', markersize=2)
    # fig = plt.plot(i,GCD_CDGLHR, '*', markeredgecolor='b', markersize=2)
    fig = plt.plot(i,Heff, '*', markeredgecolor='k', markersize=2)

    plt.show()
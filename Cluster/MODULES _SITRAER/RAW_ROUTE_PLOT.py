# Importing Modules
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import scipy as sp
import sklearn
import haversine

from mpl_toolkits.basemap import Basemap
from sklearn.cluster import DBSCAN
from sklearn.decomposition import PCA
from mpl_toolkits.mplot3d import Axes3D

from sklearn.preprocessing import StandardScaler
from haversine import haversine, Unit

from sklearn import metrics
from sklearn import preprocessing
from collections import Counter
from collections import OrderedDict
from scipy import interpolate
from itertools import cycle
from itertools import islice
from datetime import datetime

from geopy.distance import distance

# Import data
# df = pd.read_csv('AIRP1AIRP2_5day.csv', header=0, delimiter=',')
df = pd.read_csv('FRAFCO_6months18.csv', header=0, delimiter=',')
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

x1 = 5.
x2 = 14.
y1 = 40.
y2 = 51.

lat_ff = []
lon_ff = []
alt_ff = []
lat_teste_ff = []
lon_teste_ff = []

lon_AIRP1 = 8.682127
lat_AIRP1 = 50.110924
coor_AIRP1 = (lat_AIRP1,lon_AIRP1)

# lon_AIRP2 = 12.2461111111
# lat_AIRP2 = 41.7997222222
# coor_AIRP2 = (lat_AIRP2,lon_AIRP2)

lon_AIRP2 = -0.461389
lat_AIRP2 = 51.4775 

# Rome airport coordinates
# lon_AIRP2 = -3.560833
# lat_AIRP2 = 40.472222
coor_AIRP2 = (lat_AIRP2,lon_AIRP2)


fig, ax = plt.subplots()
m = Basemap(resolution='i', projection='cyl', llcrnrlat=40, urcrnrlat=54, llcrnrlon=-5, urcrnrlon=14)
m.drawmapboundary(fill_color='aqua')
m.fillcontinents(color='1.0',lake_color='aqua')
m.drawcoastlines()
m.drawcountries()
parallels = np.arange(0.,81,5.)
# labels = [left,right,top,bottom]
m.drawparallels(parallels,labels=[False,True,True,False])
meridians = np.arange(-10.,351.,5.)
m.drawmeridians(meridians,labels=[True,False,False,True])

list = [500]

# for i in range(1): 
for i in list: 
# for i in range(len(Nflights)-1): 

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
    
    x,y = m(lon_rz,lat_rz)
    m.plot(*(x, y), color = 'b', linewidth=0.1)


    

    for j in range(len(lon_rz)-1):

        # Defining cordinates of two points to messure distance      
        coordinates0 = (lat_rz[j],lon_rz[j])
        # Calculating haversine distance between two points in nautical miles
        distance_to_AIRP1 = float(haversine(coor_AIRP1,coordinates0,unit='nmi'))
        distance_to_AIRP2 = float(haversine(coor_AIRP2,coordinates0,unit='nmi'))
        
        if distance_to_AIRP1 > 60 and distance_to_AIRP2 > 60:

            lon_f = [lon_rz[j]]
            lat_f = [lat_rz[j]]
            alt_f = [alt_rz[j]]

            # lat_teste_f = [lat_teste[j]]
            # lon_teste_f = [lon_teste[j]]
            
            lat_ff.append(lat_f)
            lon_ff.append(lon_f)
            alt_ff.append(alt_f)

            # lat_teste_ff.append(lat_teste_f)
            # lon_teste_ff.append(lon_teste_f)

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

print(distance_real) 

lat_ff = np.asarray(lat_ff)
lon_ff = np.asarray(lon_ff)



#PLOT JFK INTL AIRPORT
# Plot station positions and names into the map
# again we have to compute the projection of our lon/lat values
lats = [lon_AIRP1, lon_AIRP2]
lons = [lat_AIRP1, lat_AIRP2]
names = ["FRA", "LHR"]
x, y = m(lats, lons)
m.scatter(x, y, 200, color="r", marker="v", edgecolor="k", zorder=3)
for i in range(len(names)):
    plt.text(x[i], y[i], names[i], va="top", family="monospace", weight="bold")



############################################
plt.show()








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
from mpl_toolkits.basemap import Basemap
from sklearn.preprocessing import StandardScaler
from haversine import haversine, Unit
from mpl_toolkits.mplot3d import Axes3D

from sklearn import metrics
from sklearn import preprocessing
from collections import Counter
from collections import OrderedDict
from scipy import interpolate
from itertools import cycle
from itertools import islice
from datetime import datetime



# Import data
# df = pd.read_csv('FRAITA_5day.csv', header=0, delimiter=',')
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

x1 = 5.
x2 = 14.
y1 = 40.
y2 = 51.

lat_ff = []
lon_ff = []
alt_ff = []
lat_teste_ff = []
lon_teste_ff = []

lon_FRA = 8.682127
lat_FRA = 50.110924

coor_FRA = (lat_FRA,lon_FRA)

lon_ITA = 12.2461111111
lat_ITA = 41.7997222222

coor_ITA = (lat_ITA,lon_ITA)

# fig, ax = plt.subplots()
# map = Basemap(resolution='i', projection='merc', llcrnrlat=y1, urcrnrlat=y2, llcrnrlon=x1, urcrnrlon=x2)
# map.drawmapboundary(fill_color='aqua')
# map.fillcontinents(color='0.8',lake_color='aqua')
# map.drawcoastlines()
# map.drawcountries()

# for i in range(1): 
# for i in range(1): 
# for i in range(2): 

#     # Define some parametres
#     CHUNK_SIZE = 500 # Size of flight vector

#     # Separate vector by flights
#     flights = df.iloc[Nflights.index[i]:Nflights.index[i+1]]
    
#     # Resizing vector of flights lat and lon
#     lat = flights['lat']
#     xlat = np.arange(lat.size)
#     new_xlat = np.linspace(xlat.min(), xlat.max(), CHUNK_SIZE)
#     lat_rz = sp.interpolate.interp1d(xlat, lat, kind='slinear')(new_xlat)

#     lon = flights['lon']
#     xlon = np.arange(lon.size)
#     new_xlon = np.linspace(xlon.min(), xlon.max(), CHUNK_SIZE)
#     lon_rz = sp.interpolate.interp1d(xlon, lon, kind='slinear')(new_xlon)

#     alt = flights['alt']
#     xalt = np.arange(alt.size)
#     new_xalt = np.linspace(xalt.min(), xalt.max(), CHUNK_SIZE)
#     alt_rz = sp.interpolate.interp1d(xalt, alt, kind='slinear')(new_xalt)
    
#     x,y = map(lon_rz,lat_rz)
#     plt.plot(*(x, y), color = 'b', linewidth=0.1)


    

#     for j in range(len(lon_rz)-1):

#         # Defining cordinates of two points to messure distance      
#         coordinates0 = (lat_rz[j],lon_rz[j])
#         # Calculating haversine distance between two points in nautical miles
#         distance_to_FRA = float(haversine(coor_FRA,coordinates0,unit='nmi'))
#         distance_to_ITA = float(haversine(coor_ITA,coordinates0,unit='nmi'))
        
#         if distance_to_FRA > 60 and distance_to_ITA > 60:

#             lon_f = [lon_rz[j]]
#             lat_f = [lat_rz[j]]
#             alt_f = [alt_rz[j]]

#             # lat_teste_f = [lat_teste[j]]
#             # lon_teste_f = [lon_teste[j]]
            
#             lat_ff.append(lat_f)
#             lon_ff.append(lon_f)
#             alt_ff.append(alt_f)

#             # lat_teste_ff.append(lat_teste_f)
#             # lon_teste_ff.append(lon_teste_f)

    

# lat_ff = np.asarray(lat_ff)
# lon_ff = np.asarray(lon_ff)

fig = plt.figure()
ax = fig.gca(projection='3d')

for i in range(100): 
# for i in range(len(Nflights)-1): 
    # Define some parametres
    CHUNK_SIZE = 50 # Size of flight vector

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


    lat_teste = lat_rz
    lon_teste = lon_rz

    # x,y = map(lon_teste,lat_teste)
    # plt.plot(lon_rz, lat_rz, color = 'r', linewidth=2)

    ax.plot(lon_rz, lat_rz, alt_rz)
    ax.legend()
    ax.set_xlabel('Lat [deg]')
    ax.set_ylabel('Lon [deg]')
    ax.set_zlabel('Alt [m]')

    for j in range(len(lon_rz)-1):

            # Defining cordinates of two points to messure distance      
            coordinates0 = (lat_rz[j],lon_rz[j])
            # Calculating haversine distance between two points in nautical miles
            distance_to_FRA = float(haversine(coor_FRA,coordinates0,unit='nmi'))
            distance_to_ITA = float(haversine(coor_ITA,coordinates0,unit='nmi'))
            
            if distance_to_FRA > 60 and distance_to_ITA > 60:


                lat_teste_f = [lat_teste[j]]
                lon_teste_f = [lon_teste[j]]


                lat_teste_ff.append(lat_teste_f)
                lon_teste_ff.append(lon_teste_f)




#DEFINE FIGURE


#SET AXES FOR PLOTTING AREA
# ax=plt.axes(projection=ccrs.PlateCarree())
# ax.set_ylim(40.6051,40.6825)
# ax.set_xlim(-73.8288,-73.7258)

#ADD OSM BASEMAP
# osm_tiles=OSM()
# ax.add_image(osm_tiles,13) #Zoom level 13

#PLOT JFK INTL AIRPORT
# Plot station positions and names into the map
# again we have to compute the projection of our lon/lat values
# lats = [lon_FRA, lon_ITA]
# lons = [lat_FRA, lat_ITA]
# names = ["FRA", "FCO"]
# x, y = map(lats, lons)
# map.scatter(x, y, 200, color="r", marker="v", edgecolor="k", zorder=3)
# for i in range(len(names)):
#     plt.text(x[i], y[i], names[i], va="top", family="monospace", weight="bold")


##############################################################

lon_ITA = 12.2461111111
lat_ITA = 41.7997222222
def radius_for_tissot(dist_km):
    return np.rad2deg(dist_km/6367.)


# x,y=map(lon_ITA,lat_ITA)
# x2,y2 = map(lon_ITA,lat_ITA+1) 
# circle1 = plt.Circle((x, y), 150000, color='black',fill=False)
# ax.add_patch(circle1)

# print(y2-y)

# x,y=map(lon_FRA,lat_FRA)
# x2,y2 = map(lon_FRA,lat_FRA+1) 
# circle1 = plt.Circle((x, y), 170000, color='black',fill=False)
# ax.add_patch(circle1)


############################################
plt.show()









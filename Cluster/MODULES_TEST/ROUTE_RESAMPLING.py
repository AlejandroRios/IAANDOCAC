# Importing Modules
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import scipy as sp
import sklearn

from mpl_toolkits.basemap import Basemap
from sklearn.cluster import DBSCAN
from sklearn.decomposition import PCA
from mpl_toolkits.basemap import Basemap
from sklearn.preprocessing import StandardScaler

from sklearn import metrics
from sklearn import preprocessing
from collections import Counter
from collections import OrderedDict
from scipy import interpolate
from itertools import cycle

CHUNK_SIZE = 95 # number of icaos to be processed in chunks

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

df = df.rename(columns = mapa)

print("[1] %d Imported data:" "\n",  df.head())

lat = df['lat']
lon = df['lon']
alt = df['alt']
time = df['time']

# Find all ICAO IDs in the dataset
dfcount = df.groupby('icao').size().reset_index(name='counts')
icaos = dfcount[dfcount.counts>100].icao.tolist()
print("[2] %d number of valid ICAOs." % len(icaos))

# Sort values - organize flights
# query - takes all index with hit = 0 of sorted data
Nflights = df.sort_index().query('hit == 0')

# Number of flights
Numflights = len(Nflights)
print('[1] Number of flights: ', Numflights )

# Resizing vector length working
for i in range(2): 
# for i in range(len(Nflights)-1): 

    # Define some parametres
    CHUNK_SIZE = 10 # Size of flight vector

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

plt.figure()
plt.subplot(2,1,1)
plt.plot(lon, lat, 'bo-',markersize=2,linewidth=1)
plt.xlabel('Longitude')
plt.ylabel('Latitude')
plt.legend('Raw', loc='lower left', shadow=True)
plt.title('Last Flight')

plt.subplot(2,1,2)
plt.plot(lon_rz , lat_rz, 'ro-',markersize=2,linewidth=1)
plt.xlabel('Longitude')
plt.ylabel('Latitude')
plt.legend(('Interp.'), loc='lower left', shadow=True)

plt.show()

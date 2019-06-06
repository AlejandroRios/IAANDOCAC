0# Importing Modules
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



# Resizing vector length working

y = lat[0:476]
x = np.arange(y.size)

# Interpolate the data using a cubic spline to "new_length" samples
new_length = 50
new_x = np.linspace(x.min(), x.max(), new_length)
new_y = sp.interpolate.interp1d(x, y, kind='cubic')(new_x)

# # Plot the results
plt.figure()
plt.subplot(2,1,1)
plt.plot(x, y, 'bo-')
plt.title('Using 1D Cubic Spline Interpolation')

plt.subplot(2,1,2)
plt.plot(new_x, new_y, 'ro-')

plt.show()

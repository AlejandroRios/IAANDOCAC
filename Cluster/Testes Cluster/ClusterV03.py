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
from itertools import islice
from datetime import datetime


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

# print("[1] %d Imported data:" "\n",  df.head())

t = int(df.time)

lat = df['lat']
lon = df['lon']
alt = df['alt']
time = df['time']



gb = df.groupby("icao")

gb.get_group("3991ea").head()
print(gb.get_group("3991ea"))
# lat_new = []
# for i in range(len(icaos)):
#
#     y = counts[i]
#     print(y)
#     for j in range(len(counts)):
#         lat_new.append(lat[j])
#         lat_new = lat_new
#
#         print(y)
#         # x = np.arange(y.size)
#         #
#         # # Interpolate the data using a cubic spline to "new_length" samples
#         # new_length = 50
#         # new_x = np.linspace(x.min(), x.max(), new_length)
#         # new_y = sp.interpolate.interp1d(x, y, kind='cubic')(new_x)
#
#
# lat_new = np.asarray(lat_new)
# print(lat_new[1])
#
#
# # # using sorted() + groupby()
# # # Categorize by string size
# # util_func = lambda x: len(x)
# # temp = sorted(df, key = icaos)
# # res = [list(ele) for i, ele in groupby(temp, util_func)]

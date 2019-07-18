########################################################################################
"""Importing Modules"""
########################################################################################
import pandas as pd
import numpy as np
import sklearn
import haversine

from haversine import haversine, Unit

from geopy.distance import distance

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
"""Saving processed data into new .csv"""
########################################################################################

print('[5] Saving processed data into new .csv.\n')

df.to_csv('Data4Clustering.csv') 

print('[6] All completed.\n')


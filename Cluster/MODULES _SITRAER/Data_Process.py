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
    
# df = pd.read_csv('AIRP1AIRP2_5day.csv', header=0, delimiter=',')
df = pd.read_csv('FRALHR_6months18.csv', header=0, delimiter=',')

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
print('Data containing NAN: \n',df.isnull().sum())

# Sort values - organize flights
# query - takes all index with hit = 0 of sorted data
flights = df.sort_index().query('hit == 0')

# # Number of flights
Numflights = len(flights)
print('[1] Number of flights: ', Numflights )

# Size data without filter
print('- Sample size without filters: \n', len(df))


########################################################################################
"""Creating new feature meassuring distance of samples to airports"""
########################################################################################

print('[2] Meassuring distance between samples and airpots.\n')

########################################################################################
"""Airport coordinates"""
# FRA: lat: 50.110924 | lon: 8.682127
# FCO: lat: 41.7997222222 | lon: 12.2461111111
# CDG: lat: 49.009722 | lon: 2.547778
# LHR: lat: 51.4775 | lon: -0.461389
########################################################################################


# AIRP1nkfurt airport coordinates
lat_AIRP1 = 50.110924
lon_AIRP1 = 8.682127
coor_AIRP1 = (lat_AIRP1,lon_AIRP1)

# Rome airport coordinates
lon_AIRP2 = -0.461389
lat_AIRP2 = 51.4775
coor_AIRP2 = (lat_AIRP2,lon_AIRP2)

lat = np.asarray(df['lat'])
lat = lat[:,None]

lon = np.asarray(df['lon'])
lon = lon[:,None]

Hdist_AIRP1 = []
Hdist_AIRP2 = []

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

    Airport_AIRP1 = coor_AIRP1
    Airport_AIRP2 = coor_AIRP2

    coord = (lat[idx],lon[idx])
    
    Hdist_AIRP1.append(distance(coord, Airport_AIRP1).nm)
    Hdist_AIRP2.append(distance(coord, Airport_AIRP2).nm)

    # Hdist_AIRP1.append(haversine(coord, Airport_AIRP1, unit='nmi'))
    # Hdist_AIRP2.append(haversine(coord, Airport_AIRP2, unit='nmi'))


Hdist_AIRP1 = np.asarray(Hdist_AIRP1)
Hdist_AIRP2 = np.asarray(Hdist_AIRP2)
df['Hdist_AIRP1'] = Hdist_AIRP1
df['Hdist_AIRP2'] = Hdist_AIRP2


########################################################################################
"""Filtering dataset"""
########################################################################################

print('[3] Second data filter avoiding terminal area (60 mn).\n')


# Drop outliers out of lat scale lat < -180, lat > 180
df = df.drop(df[df.lat > 55].index)
df = df.drop(df[df.lat < 40].index)
# Drop outliers out of lon scale lon < -90, lon > 90
df = df.drop(df[df.lon > 10].index)
df = df.drop(df[df.lon < -3].index)

# Identifing and saving data that is out of the terminal area
df = df[df.Hdist_AIRP1 > 60.0]
df = df[df.Hdist_AIRP2 > 60.0]

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

df.to_csv('Data4Clustering02.csv') 

print('[6] All completed.\n')


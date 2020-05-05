"""" 
Function  : raw_flights
Title     : Raw route plot
Written by: Alejandro Rios
Date      : March/2020
Language  : Python
Aeronautical Institute of Technology
"""
########################################################################################
"""Importing Modules"""
########################################################################################
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from sklearn.cluster import DBSCAN
from sklearn import metrics
from sklearn import preprocessing
from mpl_toolkits.mplot3d import Axes3D


# In-House functions
# from resize_flights import resize
# from resize_flights import resize_norm
# from distances_matrix import distances

"""Inputs"""
########################################################################################

########################################################################################
"""Importing Data"""
########################################################################################

print('[0] Load dataset.\n')
    
# df = pd.read_csv('AIRP1AIRP2_5day.csv', header=0, delimiter=',')
df = pd.read_csv('allFlights.csv',  header=None, delimiter=',')
# df.dropna(axis=1, how='all', inplace=True)
# df.drop(df.columns[[0, 4, 7,8]], axis=1) 


df.columns=["acasRAR","aircraftReg","aircraftType","airlineId","airsenseMissionId",
"alt","altGps","altSelected","altSource","autoFlags","bvr","category",
"destination","diffCorr","errorId","eta","flightNumber","fusionalt","fusionlat",
"fusionlon","fusionspeed","fusiontrack","gva","gvr","heading","ias","inTime",
"isoutlier","lat","lon","mach","magneticHeading","messageID","mil","missionId",
"mode3A","nacP","nacV","nic","nicBaro","onGround","origin","pic","posTime","qnh",
"receiverId","receiverType","sda","sil","silSupp","source","unk1","unk2","icao","unk5","unk6","unk7","unk8","unk1","unk1","unk1","unk1","unk1","unk1"]
# df_head = df.head()
# print(df_head)

df = df.drop(["acasRAR","aircraftReg",
"altSelected","airsenseMissionId","altSource","autoFlags","diffCorr","errorId","fusionalt",
"fusionspeed","fusiontrack","gva","gvr","heading","ias","mach","magneticHeading","messageID","mil","nacP","nacV",
"nicBaro","pic","qnh","sda","sil","silSupp",
"unk5","unk6","unk7","unk8","unk1","unk1","unk1","unk1","unk1","unk1"], axis=1)
df_head = df.head()

########################################################################################
"""Data manipulation and checks"""
########################################################################################

# print('[1] Data manipulation and checks.\n')

# mapa = {"hit" : "hit",
#     "icao24" : "icao",
#     "callsign" : "call",
#     "time" : "time",
#     "lat" : "lat",
#     "lon" : "lon",
#     "heading" : "hdg",
#     "alt" : "alt",
#     "estdepartureairport" : "dptair",
#     "estarrivalairport" : "arrair",
#     "onground" : "ongrnd"}



# # Rename data
# df = df.rename(columns = mapa)

# Check if data contains null values
print('Data containing NAN: \n',df.isnull().sum())

# # Sort values - organize flights
# # query - takes all index with hit = 0 of sorted data
# flights = df.sort_index().query('hit == 0')

# # # Number of flights
# Numflights = len(flights)
# print('[1] Number of flights: ', Numflights )

# # Size data without filter
# print('- Sample size without filters: \n', len(df))

# chunk_size = 50 # Size of flight vector


# print('[4] Accounting number of flights by icao and call filters.\n')

# df['count'] = df.groupby(((df['icao'] != df['icao'].shift(1)) |  (df['call'] != df['call'].shift(1))).cumsum()).cumcount()
# df = df.reset_index(drop=True)

# Nflights = df.sort_index().query('count == 0')

# # Number of flights
# Numflights = len(Nflights)

# print('- Number of flights: \n', Numflights )


# coordinates_vec = resize(df,Nflights,chunk_size,cluster_type)

# for i in range(1,50): 
#     plt.plot(coordinates_vec[i])
#     # plt.plot(coordinates_vec[i],'bs')
    



# # fig = plt.figure()
# # ax = fig.gca(projection='3d')

# # ax.scatter(df.lat,df.lon,df.alt,s=0.1)
# # plt.scatter(df.lat,df.alt,s=0.1)
plt.show()
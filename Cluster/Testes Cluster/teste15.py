# Importing Modules
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.cluster import DBSCAN
from sklearn.decomposition import PCA

dados = pd.read_csv('ENGFRA_week.csv', header=0, delimiter=',')
dados_head = dados.head()

mapa = {"hit" : "hit",
    "icao24'" : "icao",
    "callsign" : "call",
    "time" : "time",
    "lat" : "lat",
    "lon" : "lon",
    "heding" : "hdg",
    "alt" : "alt",
    "estdepartureairport" : "dptair",
    "estarrivalairport" : "arrair",
    "onground" : "ongrnd"}

dados = dados.rename(columns = mapa)
print(dados)

# # Define colummns names
# df.columns =['hit','icao24','callsign','time',
# 'lat','lon','heading','alt','estdepartureairport','estarrivalairport','onground'
# ]

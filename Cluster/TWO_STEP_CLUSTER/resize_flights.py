"""" 
Function  : spline_resize
Title     : Spline rezise function
Written by: Alejandro Rios
Date      : March/2020
Language  : Python
Aeronautical Institute of Technology
"""
########################################################################################
"""Importing Modules"""
########################################################################################
import numpy as np
import scipy as sp

from scipy import interpolate
from scipy.interpolate import make_lsq_spline, BSpline
from scipy import signal
########################################################################################
"""Re-sizing flight vectors"""
########################################################################################
print('--------------------------------------------------------------------------------\n')
print('[2] Re-sizing flight vectors (same size).\n')

def resize(df,Nflights,chunk_size,cluster_type):
    
    coordinates_vec = []
    # for i in range(6): 
    for i in range(len(Nflights)-1): 
    # for i in range(1000):
        print(len(Nflights)-1)
        # Separate vector by flights
        flights = df.iloc[Nflights.index[i]:Nflights.index[i+1]]
        print(flights)
        # Resizing vector of flights lat and lon
        lat = flights['lat']
        xlat = np.arange(lat.size)
        new_xlat = np.linspace(xlat.min(), xlat.max(), chunk_size)
        lat_rz = sp.interpolate.interp1d(xlat, lat, kind='slinear')(new_xlat)

        lon = flights['lon']
        xlon = np.arange(lon.size)
        new_xlon = np.linspace(xlon.min(), xlon.max(), chunk_size)
        lon_rz = sp.interpolate.interp1d(xlon, lon, kind='slinear')(new_xlon)

        # alt = flights['alt']
        # xalt = np.arange(alt.size)
        # new_xalt = np.linspace(xalt.min(), xalt.max(), chunk_size)
        # alt_rz = sp.interpolate.interp1d(xalt, alt, kind='slinear')(new_xalt)

        alt = flights['alt']
        xalt = np.arange(alt.size)
        new_xalt = np.linspace(xalt.min(), xalt.max(), chunk_size)
        alt_rz = sp.interpolate.interp1d(xalt, alt, kind='slinear')(new_xalt)
        alt_rz = sp.signal.medfilt(alt_rz,51)

        

        # coordinates = np.concatenate((lon_rz[:,None],lat_rz[:,None],alt_rz[:,None]),axis=1)
        if cluster_type == 0:
            coordinates = np.concatenate((lon_rz[:,None],lat_rz[:,None]),axis=1)
        elif cluster_type == 1:
            # coordinates = alt_rz[:,None]
            coordinates = np.concatenate((lat_rz[:,None],alt_rz[:,None]),axis=1)

        coordinates = tuple(map(tuple, coordinates))
        coordinates_vec.append(np.vstack(coordinates))

    return(coordinates_vec)
    

def resize_norm(df,Nflights,chunk_size,cluster_type):
    
    coordinates_vec = []
    # for i in range(6): 
    for i in range(len(Nflights)-1): 
    # for i in range(1000):

        # Separate vector by flights
        flights = df.iloc[Nflights.index[i]:Nflights.index[i+1]]

        # Resizing vector of flights lat and lon
        lat = flights['lat_norm']
        xlat = np.arange(lat.size)
        new_xlat = np.linspace(xlat.min(), xlat.max(), chunk_size)
        lat_rz = sp.interpolate.interp1d(xlat, lat, kind='slinear')(new_xlat)

        lon = flights['lon_norm']
        xlon = np.arange(lon.size)
        new_xlon = np.linspace(xlon.min(), xlon.max(), chunk_size)
        lon_rz = sp.interpolate.interp1d(xlon, lon, kind='slinear')(new_xlon)

        alt = flights['alt_norm']
        xalt = np.arange(alt.size)
        new_xalt = np.linspace(xalt.min(), xalt.max(), chunk_size)
        alt_rz = sp.interpolate.interp1d(xalt, alt, kind='slinear')(new_xalt)

        time = flights['times_norm']
        xtime = np.arange(time.size)
        new_xtime = np.linspace(xtime.min(), xtime.max(), chunk_size)
        time_rz = sp.interpolate.interp1d(xtime, time, kind='slinear')(new_xtime)

        # coordinates = np.concatenate((lon_rz[:,None],lat_rz[:,None],alt_rz[:,None]),axis=1)
        if cluster_type == 0:
            coordinates = np.concatenate((lon_rz[:,None],lat_rz[:,None]),axis=1)
        elif cluster_type == 1:
            # coordinates = alt_rz[:,None]
            coordinates = np.concatenate((lat_rz[:,None],alt_rz[:,None]),axis=1)

        coordinates = tuple(map(tuple, coordinates))
        coordinates_vec.append(np.vstack(coordinates))

    return(coordinates_vec)


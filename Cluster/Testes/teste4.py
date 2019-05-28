
import time
import datetime
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.collections import PatchCollection
from IPython.display import Image
import fiona
from shapely.prepared import prep
from descartes import PolygonPatch
from mpl_toolkits.basemap import Basemap
from shapely.geometry import Point, Polygon, MultiPoint, MultiPolygon
import warnings
warnings.filterwarnings('ignore')
################################################################################
def dist_sphere(lat1, long1, lat2, long2):

    # Convert latitude and longitude to spherical coordinates in radians.
    deg2rad = np.pi/180.0
    # phi = 90 - latitude
    phi1 = (90.0 - lat1)*deg2rad
    phi2 = (90.0 - lat2)*deg2rad
    # theta = longitude
    theta1 = long1*deg2rad
    theta2 = long2*deg2rad

    # Compute spherical distance from spherical coordinates.
    # For two locations in spherical coordinates
    # (1, theta, phi) and (1, theta, phi)
    # cosine( arc length ) =
    #    sin phi sin phi' cos(theta-theta') + cos phi cos phi'
    # distance = rho * arc length

    cos = (np.sin(phi1)*np.sin(phi2)*np.cos(theta1 - theta2) +
           np.cos(phi1)*np.cos(phi2))
    arc = np.arccos( cos )

    # Remember to multiply arc by the radius of the earth
    # in your favorite set of units to get length.
    return arc
###############################################################################

###############################################################################
# Importing data
loc_data = pd.read_csv('ENGFRA_30day.csv', header=None, delimiter=',')
loc_data_head = loc_data.head()
loc_data = loc_data.drop(0, axis=0)

# Selecting data for lat, lon and alt
loc_data['time'] = loc_data.iloc[0:,3]
loc_data['lat'] = loc_data.iloc[0:,4]
loc_data['lon'] = loc_data.iloc[0:,5]
loc_data['alt'] = loc_data.iloc[0:,6]


# Convert data to float
loc_data.time = pd.to_numeric(loc_data.time, errors='coerce')
loc_data.lat = pd.to_numeric(loc_data.lat, errors='coerce')
loc_data.lon = pd.to_numeric(loc_data.lon, errors='coerce')
loc_data.alt = pd.to_numeric(loc_data.alt, errors='coerce')

deg2rad = np.pi/180.0
loc_data['phi'] = (90.0 - loc_data.lat) * deg2rad
loc_data['theta'] = loc_data.lon * deg2rad

# Compute dist between two GPS points on a unit sphere
loc_data['dist'] = np.arccos(
    np.sin(loc_data.phi)*np.sin(loc_data.phi.shift(-1)) * np.cos(loc_data.theta - loc_data.theta.shift(-1)) +
    np.cos(loc_data.phi)*np.cos(loc_data.phi.shift(-1))) * 6378.100 # radius of earth in km

loc_data['speed'] = loc_data.dist/(loc_data.time - loc_data.time.shift(-1))*3600 #km/hr


flight_data = pd.DataFrame(data={'end_lat':loc_data.lat,
                             'end_lon':loc_data.lon,
                             'end_datetime':loc_data.time,
                             'dist':loc_data.dist,
                             'speed':loc_data.speed,
                             'start_lat':loc_data.shift(-1).lat,
                             'start_lon':loc_data.shift(-1).lon,
                             'start_datetime':loc_data.shift(-1).time,
                             }).reset_index(drop=True)



flights = flight_data[(flight_data.speed > 40)].reset_index()
_f = flights[flights['index'].diff() == 1]
adjacent_flight_groups = np.split(_f, (_f['index'].diff() > 1).nonzero()[0])

for flight_group in adjacent_flight_groups:
    idx = flight_group.index[0] - 1 #the index of flight termination
    flights.loc[idx, ['start_lat', 'start_lon', 'start_datetime']] = [flight_group.iloc[-1].start_lat,
                                                         flight_group.iloc[-1].start_lon,
                                                         flight_group.iloc[-1].start_datetime]

    # Recompute total distance of flight
    flights.loc[idx, 'distance'] = dist_sphere(flights.loc[idx].start_lat,
                                                           flights.loc[idx].start_lon,
                                                           flights.loc[idx].end_lat,
                                                           flights.loc[idx].end_lon)*6378.1

# Now remove the "flight" entries we don't need anymore.
flights = flights.drop(_f.index).reset_index(drop=True)

fig = plt.figure(figsize=(18,12))


# Plotting across the international dateline is tough. One option is to break up flights
# by hemisphere. Otherwise, you'd need to plot using a different projection like 'robin'
# and potentially center on the Int'l Dateline (lon_0=-180)
# flights = flights[(flights.start_lon < 0) & (flights.end_lon < 0)]# Western Hemisphere Flights
# flights = flights[(flights.start_lon > 0) & (flights.end_lon > 0)] # Eastern Hemisphere Flights

xbuf = 0.2
ybuf = 0.35
min_lat = np.min([flights.end_lat.min(), flights.start_lat.min()])
min_lon = np.min([flights.end_lon.min(), flights.start_lon.min()])
max_lat = np.max([flights.end_lat.max(), flights.start_lat.max()])
max_lon = np.max([flights.end_lon.max(), flights.start_lon.max()])
width = max_lon - min_lon
height = max_lat - min_lat


m = Basemap(llcrnrlon=min_lon - width* xbuf,
            llcrnrlat=min_lat - height*ybuf,
            urcrnrlon=max_lon + width* xbuf,
            urcrnrlat=max_lat + height*ybuf,
            resolution='l',
            lat_0=min_lat + height/2,
            lon_0=min_lon + width/2,)
# m = Basemap()


m.drawmapboundary(fill_color='#EBF4FA')
m.drawcoastlines()
m.drawstates()
m.drawcountries()
m.fillcontinents()

current_date = time.strftime("printed: %a, %d %b %Y", time.localtime())

for idx, f in flights.iterrows():
    m.plot(loc_data.lon, loc_data.lat, linewidth=0.1, alpha=0.4, color='b' )
    m.plot(*m(f.start_lon, f.start_lat), color='g', alpha=0.1, marker='o')
    m.plot(*m(f.end_lon, f.end_lat), color='r', alpha=0.1, marker='o' )



fig.text(0.125, 0.15, "Alejandro Rios - ITA", color='#555555', fontsize=16, ha='left')
plt.savefig('flights.pdf', dpi=150, frameon=False, transparent=False, bbox_inches='tight', pad_inches=0.2)

# print(__doc__)

import numpy as np
import pandas as pd
import seaborn as sb
import matplotlib.pyplot as plt
import sklearn

from itertools import cycle
from mpl_toolkits import mplot3d
from sklearn.cluster import DBSCAN
from sklearn import metrics
from sklearn import preprocessing
from collections import Counter
from collections import OrderedDict
from sklearn.preprocessing import StandardScaler
# from sklearn.cluster import OPTICS, cluster_optics_dbscan
# Constants
MIN_DATA_SIZA = 100  # minimal number of data in a flight
CHUNK_SIZE = 150     # number of icaos to be processed in chunks
TEST_FLAG = True     # if this is a test run
# #############################################################################
# Generate sample data
# making data frame from csv file
df = pd.read_csv('ENGFRA_week.csv', header=0, delimiter=',')

# Define colummns names
df.columns =['hit','icao24','callsign','time',
'lat','lon','heading','alt','estdepartureairport','estarrivalairport','onground'
]

# dropping ALL duplicte values
df.drop_duplicates(subset=['time'], inplace=True)

ids = df['icao24']
lats = df['lat']
lons = df['lon']
alts = df['alt']
hdgs = df['heading']
times = df['time']

le = preprocessing.LabelEncoder()
encoded_ids = le.fit_transform(ids)

# Find all ICAO IDs in the dataset
dfcount = df.groupby('icao24').size().reset_index(name='counts')
icaos = dfcount[dfcount.counts>100].icao24.tolist()

mms = preprocessing.MinMaxScaler(feature_range=(0, 1000))
times_norm = mms.fit_transform(times.values.reshape(-1,1))
dt = mms.scale_ * 0.5 * 60 * 60   # time interval of 30 mins

mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
alts_norm = mms.fit_transform(alts.values.reshape(-1,1))
acs = {}



times_norm = times_norm.reshape(-1)
alts_norm = times_norm.reshape(-1)
acs = [[times_norm], [alts_norm], [times],
                        [lats], [lons], [alts],[hdgs]]


cluster = DBSCAN(eps=dt, min_samples=MIN_DATA_SIZA)
# acsegs = {}

# print(acs)
data = acs
data = np.asarray(acs)
tdata = np.copy(data)
tdata = np.squeeze(tdata).shape
tdata = tdata[2,:]
print(tdata)


cluster.fit(tdata)
# labels = cluster.labels_
# n_clusters = np.unique(labels).size
# print("n_clusters : %d" % n_clusters)
#
# if not TEST_FLAG:
#     for i in range(n_clusters):
#         mask = labels == i
#         c = data[mask, 2:]
#         c = c[c[:, 0].argsort()]   # sort by ts
#
#         if len(c) > MIN_DATA_SIZA:
#             mcollflights.insert_one(
#                 OrderedDict([
#                     ('icao', k),
#                     ('ts',   c[:, 0].tolist()),
#                     ('lat',  c[:, 1].tolist()),
#                     ('lon',  c[:, 2].tolist()),
#                     ('alt',  c[:, 3].tolist()),
#                     ('spd',  c[:, 4].tolist()),
#                     ('hdg',  c[:, 5].tolist()),
#                     ('roc',  c[:, 6].tolist()),
#                 ])
#             )
#
# # Plot result
# if TEST_FLAG:
#     colorset = cycle(['purple', 'green', 'red', 'blue', 'orange'])
#     for i, c in zip(list(range(n_clusters)), colorset):
#         mask = labels == i
#         ts = data[mask, 0].tolist()
#         alts = data[mask, 5].tolist()
#         lons = data[mask, 4].tolist()
#         lats = data[mask, 3].tolist()
#         if len(alts) > MIN_DATA_SIZA:
#             plt.plot(lons, lats, 'w', color=c, marker='.', alpha=1.0)
#
#     # plt.xlim([0, 1000])
#     plt.draw()
#     plt.waitforbuttonpress(-1)
#     plt.clf()
# print('')

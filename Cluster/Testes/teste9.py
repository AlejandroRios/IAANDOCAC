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
# df = pd.read_csv('ENGFRA_30day.csv', header=0, delimiter=',')
df = pd.read_csv('ENGFRA_GERNED.csv', header=0, delimiter=',')

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


# le = preprocessing.LabelEncoder()
# encoded_ids = le.fit_transform(ids)

# Find all ICAO IDs in the dataset
dfcount = df.groupby('icao24').size().reset_index(name='counts')
icaos = dfcount[dfcount.counts>100].icao24.tolist()

print("[2] %d number of valid ICAOs." % len(icaos))

for i in range(0, len(icaos), CHUNK_SIZE):

    print('[3][%d-%d of %d] ICAOs beening processed.' \
% (i, i+CHUNK_SIZE, len(icaos)))



# Scaling parameters 0 to 100
mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
lats_norm = mms.fit_transform(lats.values.reshape(-1,1))


mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
lons_norm = mms.fit_transform(lons.values.reshape(-1,1))


mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
alts_norm = mms.fit_transform(alts.values.reshape(-1,1))


mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
hdgs_norm = mms.fit_transform(hdgs.values.reshape(-1,1))


mms = preprocessing.MinMaxScaler(feature_range=(0, 100))
times_norm = mms.fit_transform(times.values.reshape(-1,1))
dt = mms.scale_ * 0.5 * 60 * 60   # time interval of 30 mins

# print('lats norm : ', lats_norm)
# print(lats_norm.max())
# print('lons norm : ', lons_norm)
# print(lons_norm.max())
# print('alts norm : ', alts_norm)
# print(alts_norm.max())
# print('hdgs norm : ', hdgs_norm)
# print(hdgs_norm.max())
# print('times norm : ', times_norm)
# print(times_norm.max())

# Reshape of scaled parametres
lats_norm = times_norm.reshape(-1)
lons_norm = times_norm.reshape(-1)
alts_norm = times_norm.reshape(-1)
hdgs_norm = times_norm.reshape(-1)
times_norm = times_norm.reshape(-1)

acs = [[times_norm], [alts_norm], [lats_norm], [lons_norm], [hdgs_norm]]

data = acs
data = np.asarray(acs)
tdata = np.copy(data)

# tdata0 = tdata[0] # times norm
# tdata1 = tdata[1] # alts norm
tdata2 = tdata[2] # lats norm
tdata3 = tdata[3] # lons norm
# tdata4 = tdata[4] # hdgs norm
# tdata5 = tdata[5] # alts
# tdata6 = tdata[6] # heading

# Clustering
cluster = DBSCAN(eps=70, min_samples=8).fit(tdata3)


labels = cluster.labels_
n_clusters = np.unique(labels).size
print("n_clusters : %d" % n_clusters)


colorset = cycle(['purple', 'green', 'red', 'blue', 'orange'])
for i, c in zip(list(range(n_clusters)), colorset):
    mask = labels == i
    ts = data[0].tolist()
    alts = data[1].tolist()
    lons = data[3].tolist()
    lats = data[2].tolist()
    if len(alts) > MIN_DATA_SIZA:
        plt.plot(lons, lats, 'w', color=c, marker='.', alpha=-1.0)

# plt.xlim([0, 1000])
# plt.draw()
# plt.waitforbuttonpress(-1)
# plt.clf()
print('')

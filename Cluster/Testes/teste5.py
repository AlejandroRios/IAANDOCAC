# print(__doc__)

import numpy as np
import pandas as pd
import seaborn as sb
import matplotlib.pyplot as plt
import sklearn

from mpl_toolkits import mplot3d
from sklearn.cluster import DBSCAN
from sklearn import metrics
from collections import Counter
from sklearn.preprocessing import StandardScaler
# from sklearn.cluster import OPTICS, cluster_optics_dbscan

# #############################################################################
# Generate sample data
df = pd.read_csv('ENGFRA_day.csv', header=0, delimiter=',')

# Define colummns names
df.columns =['hit','icao24','callsign','time',
'lat','lon','alt','estdepartureairport','estarrivalairport','onground'
]

# Select data for clustering
datam= df.iloc[0:50000,[4,5]]
data= df.iloc[0:50000,[4,5,7]]
print(len(data))
print(data.head())
# ##############################################################################
# Define model
model = DBSCAN(eps = 53, min_samples = 8).fit(datam)
# print(model)


core_samples_mask = np.zeros_like(model.labels_, dtype=bool)
core_samples_mask[model.core_sample_indices_] = True
labels = model.labels_

# Number of clusters in labels, ignoring noise if present.
n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)
n_noise_ = list(labels).count(-1)

print('Estimated number of clusters: %d' % n_clusters_)
print('Estimated number of noise points: %d' % n_noise_)
# print("Homogeneity: %0.3f" % metrics.homogeneity_score(labels_true, labels))
# print("Completeness: %0.3f" % metrics.completeness_score(labels_true, labels))
# print("V-measure: %0.3f" % metrics.v_measure_score(labels_true, labels))
# print("Adjusted Rand Index: %0.3f"
#       % metrics.adjusted_rand_score(labels_true, labels))
# print("Adjusted Mutual Information: %0.3f"
#       % metrics.adjusted_mutual_info_score(labels_true, labels))
# print("Silhouette Coefficient: %0.3f"
#       % metrics.silhouette_score(X, labels))


outliers_df = pd.DataFrame(data)

# Count outliers
print(Counter(model.labels_))
print(outliers_df[model.labels_==-1])


data = np.array(data)

#############################################################################
# Outliers figure
fig = plt.figure()
ax = fig.add_axes([.1,.1, 1,1, 1,1])
colors = model.labels_

ax.scatter(data[:,0],data[:,1], c=colors, s =10)
ax.set_xlabel('lat')
ax.set_ylabel('lon')

fig = plt.figure()
ax = plt.axes(projection='3d')
colors = model.labels_
ax.scatter(data[:,0],data[:,1],data[:,2], c=colors, cmap='viridis', marker ='o', linewidth=0.5);
ax.set_xlabel('lat')
ax.set_ylabel('lon')
ax.set_zlabel('alt')









plt.title('DBSCAN for Outliers')
#
plt.show()

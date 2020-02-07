import numpy as np
from hausdorff import hausdorff_distance


n = 4
# # two random 2D arrays (second dimension must match)
# 'Curve 1'
# t = np.linspace((3/4)*np.pi, (5/4)*np.pi, n)
# x1 = np.cos(t)
# y1 = np.sin(t)
# z1 = t

# 'Curve 2'
# u = np.linspace((1/2)*np.pi, (3/2)*np.pi, n)
# x2 = 2*np.cos(u)
# y2 = np.sin(u)
# z2 = 2*u



# 'Euclidean distance'


# X = np.array([x1,y1])
# Y = np.array([x2,y2])

# # Test computation of Hausdorff distance with different base distances
# print("Hausdorff distance test: {0}".format( hausdorff_distance(X, Y, distance="manhattan") ))
# print("Hausdorff distance test: {0}".format( hausdorff_distance(X, Y, distance="euclidean") ))
# print("Hausdorff distance test: {0}".format( hausdorff_distance(X, Y, distance="chebyshev") ))
# print("Hausdorff distance test: {0}".format( hausdorff_distance(X, Y, distance="cosine") ))

# # For haversine, use 2D lat, lng coordinates
# def rand_lat_lng(N):
#     lats = np.random.uniform(-90, 90, N)
#     lngs = np.random.uniform(-180, 180, N)
#     return np.stack([lats, lngs], axis=-1)
        
# X = rand_lat_lng(100)
# Y = rand_lat_lng(250)
# print("Hausdorff haversine test: {0}".format( hausdorff_distance(X, Y, distance="haversine") ))




n = 4
# # two random 2D arrays (second dimension must match)
# 'Curve 1'
# t = np.linspace((3/4)*np.pi, (5/4)*np.pi, n)
# x1 = np.cos(t)
# y1 = np.sin(t)
# z1 = t

# 'Curve 2'
# u = np.linspace((1/2)*np.pi, (3/2)*np.pi, n)
# x2 = 2*np.cos(u)
# y2 = np.sin(u)
# z2 = 2*u


# # two random 2D arrays (second dimension must match)
# 'Curve 1'
# t = np.linspace((3/4)*np.pi, (5/4)*np.pi, n)
# x1 = np.cos(t)
# y1 = np.sin(t)
# z1 = t

# 'Curve 2'
# u = np.linspace((1/2)*np.pi, (3/2)*np.pi, n)
# x2 = 2*np.cos(u)
# y2 = np.sin(u)
# z2 = 2*u



'Euclidean distance'


X = np.array([x1,y1])
Y = np.array([x2,y2])



def distance_function(X,Y):
    n = X.shape[0]
    ret = 0.0
    for i in range(n):
        print(X[i],Y[i])
        ret += (X[i]-Y[i])**2
        
    distances = (np.sqrt(ret))
    return(distances)



nA = X.shape[0]
nB = Y.shape[0]
cmax = 0.
for i in range(nA):
    cmin = np.inf
    for j in range(nB):
        d = distance_function(X[i,:], Y[j,:])
        if d<cmin:
            cmin = d
        if cmin<cmax:
            break
    if cmin>cmax and np.inf>cmin:
        cmax = cmin
for j in range(nB):
    cmin = np.inf
    for i in range(nA):
        d = distance_function(X[i,:], Y[j,:])
        if d<cmin:
            cmin = d
        if cmin<cmax:
            break
    if cmin>cmax and np.inf>cmin:
        cmax = cmin

print(cmax)

# n = array_x.shape[0]
# 	ret = 0.
# 	for i in range(n):
# 		ret += (array_x[i]-array_y[i])**2
"""" 
Function  : Case 1
Title     : Case_1
Written by: Alejandro Rios
Date      : March/2020
Language  : Python
Aeronautical Institute of Technology
"""
import numpy as np  
import math
from docplex.mp.model import Model
#######################################################################################
# Cargo capacity of aircraft type
C = [5000, 72210, 202100]
# Range capacity of aircraft type
R = [1063, 3000, 3950]
# Cruise velocity of aircraft type
Vc = [252, 465, 526]
# Fixed cost $ per day of aircraft type
f = [1481, 10616, 26129]
# Linear cost $ per hour of aircraft type
m = [758, 3116, 7194]

mdl = Model('Transport')

# Total number of cities in the network
N_cities = 7
N = [i for i in range(1,N_cities+1)]
Arcs = [(i,k) for i in N for k in N]

Num_Airplane_Types = 3
Airplanes = [A for A in range(1,Num_Airplane_Types+1)]
n = mdl.integer_var_dict(Airplanes, ub = 10, name = 'n')
x = mdl.continuous_var_dict(Arcs, name = 'x')

# Package demand
P = {0:0, 1:14045, 2:31313, 3:19984, 4:34506, 5:57949, 6:37318}


mdl.add_constraints(mdl.sum(x[i, j] for j in V if j != i) == 1 for i in N)

# mdl.minimize(mdl.sum(c[i]*n[i] for i in Arcs))
# mdl.add_constraints(mdl.sum(x[i,j,k] for k in N)==P[i,j] for i,j in N)
# mdl.add_constraints(mdl.sum(x[i,j,k] for j in N)<= G[i,k] for i,k in N)
# mdl.add_constraints(mdl.sum(x[i,j,k] for i in N)<= G[j,k] for j,k in N)






















# # Distances
# dik = [[0, 934, 622, 688, 1921, 756, 2179],
#         [934, 0, 882, 1538, 0, 2629, 183, 2729],
#         [622, 882, 0, 806, 1767, 713, 1866],
#         [688, 1538, 806, 0, 1257, 1360, 1518],
#         [1921, 2629, 1767, 1257, 0, 2454, 330],
#         [756, 183, 713, 1360, 2454, 0, 2560],
#         [2179, 2729, 1866, 1518, 330, 2560, 0]]

# # print(dik)

# # Demand
# Pik = [[0, 14045, 31313, 19984, 34506, 57949, 37318],
#         [14045, 0, 27261, 17398, 30041, 50451, 32489],
#         [31313, 27261, 0, 38788, 66975, 112479, 72438],
#         [19984, 17398, 38788, 0 , 42743, 71784, 46227],
#         [34506, 30041, 66975, 42743,0,123948, 79820],
#         [57949, 50451, 112479, 71784, 123948, 0, 134050],
#         [37318, 32489, 72434, 46227, 79820, 134050, 0]]
































# Airports = [k for k in range(N)]

# Arcs = [(i,k) for i in Airports for k in Airports]

# print(Arcs)
# r = R
# # Cost of te aircraft (A, B or C) traveling on rote (i,k)
# if r[0] >= dik[0][0]:
#     cik = f[0] + m[0]*(2*dik[0][0]/Vc[0])
# elif r[0] < dik[[0][0]]:
#     cik = math.inf
# else:
#     cik = 0

# C = [5000, 72210, 202100]
# capacity = {0:5000, 1:72210, 2:202100}
# demand = {0:0, 1:14045, 2:31313, 3:19984, 4:34506, 5:57949, 6:37318}

# mdl = Model('Transport')

# x = mdl.integer_var_dic(Arcs,name='x')




# mdl.minimize(mdl.sum(x[i])*cik[i] for i in Arcs)

# # Capacidad 
# for k in Air




"""" 
Function  : Case 1
Title     : Case_1
Written by: Alejandro Rios
Date      : March/2020
Language  : Python
Aeronautical Institute of Technology
"""
import numpy as np  

#######################################################################################

# C = [5000, 72210, 202100]
# R = [1063, 3000, 3950]
# V = [252, 465, 526]
# f = [1481, 10616, 26129]
# m = [758, 3116, 7194]

# distances = []


rnd = np.random
rnd.seed(5)

#clients
n = 10
# vehic capacity
Q = 20
# set of node
N = [i for i in range(1,n+1)]
# vertices or nodes
V = [0] + N
# amount that has to be delivered
q = {i: rnd.randint(1, 10) for i in N}

loc_x = rnd.rand(len(V))*200
loc_y = rnd.rand(len(V))*100

import matplotlib.pyplot as plt 

plt.scatter(loc_x[1:], loc_y[1:], c='b')
for i in N:
    plt.annotate('$q_%d=%d$' % (i, q[i]), (loc_x[i]+2, loc_y[i]))
plt.plot(loc_x[0], loc_y[0], c='r', marker='s')
plt.axis('equal')
# plt.show()


A = [(i, j) for i in V for j in V if i != j]
c = {(i, j): np.hypot(loc_x[i]-loc_x[j], loc_y[i]-loc_y[j]) for i, j in A}

from docplex.mp.model import Model
mdl = Model('CVRP')
x = mdl.binary_var_dict(A, name='x')
u = mdl.continuous_var_dict(N, ub=Q, name='u')



mdl.minimize(mdl.sum(c[i, j]*x[i, j] for i, j in A))
mdl.add_constraints(mdl.sum(x[i, j] for j in V if j != i) == 1 for i in N)
mdl.add_constraints(mdl.sum(x[i, j] for i in V if i != j) == 1 for j in N)
mdl.add_indicator_constraints(mdl.indicator_constraint(x[i, j], u[i]+q[j] == u[j]) for i, j in A if i != 0 and j != 0)
mdl.add_constraints(u[i] >= q[i] for i in N)
mdl.parameters.timelimit = 15

solution = mdl.solve(log_output=True)

print(solution)


print(solution.solve_status)

active_arcs = [a for a in A if x[a].solution_value>0.9]

plt.scatter(loc_x[1:], loc_y[1:], c='b')
for i in N:
    plt.annotate('$q_%d=%d$' % (i, q[i]), (loc_x[i]+2, loc_y[i]))

for i,j in active_arcs:
    plt.plot([loc_x[i],loc_x[j]],[loc_y[i],loc_y[j]],c='g',alpha =0.3)
plt.plot(loc_x[0], loc_y[0], c='r', marker='s')
plt.axis('equal')
plt.show()
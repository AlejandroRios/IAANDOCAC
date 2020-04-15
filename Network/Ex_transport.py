"""" 
Function  : Transportation Problem
Title     : Ex_trasportation
Written by: Alejandro Rios
Date      : February/2020
Language  : Python
Aeronautical Institute of Technology
"""

from pulp import *


# SETS

CITY_i = ["A","B","C","D","E","F","G"]
CITY_j = ["1","2","3","4","5","6","7"]

# Dictionary of max amount that can be shipped to each plant


# Dictionary of amount each grove will suply


# Disctionary of distances between cities

D = {"A":{"1":0, "2":}


}


0	1407	2225	1641	1335	1391	1603
1407	0	1075	240	716	460	712
2225	1075	0	841	1015	869	648
1641	240	841	0	785	487	516
1335	716	1015	785	0	299	355
1391	460	869	487	299	0	252
1603	712	648	516	355	252	0


bush = {"A":{"1":21, "2":50, "3":40},
       "B":{"1":35, "2": 30, "3":22},
       "C":{"1":55, "2": 20, "3":25}}


# Set Problem Variable
prob = LpProblem("Transportation", LpMinimize)

routes = [(i,j) for i in GROVES for j in PLANTS]

# Decision Variable
amount_vars = LpVariable.dicts('ShipAmount',(GROVES,PLANTS),0)

# Objective Function
prob += lpSum(amount_vars[i][j]*bush[i][j] for (i,j) in routes)

# Constraints:

for j in PLANTS:
    prob += lpSum(amount_vars[i][j] for i in GROVES) <= mship[j]

for i in GROVES:
    prob += lpSum(amount_vars[i][j] for j in PLANTS) == supply[i]

prob.solve() 

print("Status:", LpStatus[prob.status])

for v in prob.variables():
    if v.varValue > 0:
        print(v.name, '=', v.varValue)

print("Total bushel-miles = ", value(prob.objective))
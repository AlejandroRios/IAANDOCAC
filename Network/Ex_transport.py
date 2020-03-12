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

GROVES = ["A","B","C"]
PLANTS = ["1","2","3"]

# Dictionary of max amount that can be shipped to each plant
mship = {"1" : 200000,
        "2" : 600000,
        "3" : 225000}

# Dictionary of amount each grove will suply
supply = {"A" : 275000,
        "B" : 400000,
        "C" : 300000}

# Disctionary of bushel miles for all groves and plants
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
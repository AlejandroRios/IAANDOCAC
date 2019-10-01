"""" 
Function  : @ingroup Methods-Geometry-Two_Dimensonal-Cross_Section-Airfoil
Title     : Airfoil Sobieski coefficients
Written by: Alejandro Rios
Date      : Sep/2019
Language  : Python
Aeronautical Institute of Technology
"""
# ----------------------------------------------------------------------
#  Imports
# ----------------------------------------------------------------------
import numpy as np 
import matplotlib.pyplot as plt
import pandas as pd
from scipy import interpolate
from scipy.optimize import differential_evolution

# ----------------------------------------------------------------------
#  Compute Airfoil Sobieski coefficients
# ----------------------------------------------------------------------
## @ingroup Methods-Costs-Industrial_Costs
# def airfoil_sobieski_coefficients(airfoil_name):
"""Compute Sobieski coefficients

Assumptions:
No assumptions

Source:
"", Sobieski

Inputs:
airfoil dime (.dat)     [-]     Airfoil .dat coordinates


Outputs:
Sobieski coefficientes:
r0          [-] 
t_c         [-]     thick to chord ratio
X_tcmax     [m]     X position of tcmax  
theta       [-]
epsilon     [-]
Ycmax       [-]
YCtcmax     [-]
X_Ycmax     [-]
xp          [-]
yu          [-]
yl          [-]

Properties Used:
N/A
"""

########################################################################################
"""Importing Data"""
########################################################################################

print('[0] Load airfoil coordinates.\n')
df = pd.read_csv('PR1.dat',sep=',', delimiter=None,header=None)
df.columns = ['x','y']
df_head = df.head()
n_coordinates = len(df)

print('[1] Compute distance between consecutive points.\n')
dx = []
dy = []
ds = []
ds_vector = []
ds=np.zeros((n_coordinates,1))
ds[0] = 0 

for i in range(1,n_coordinates):
    dx = df.x[i] - df.x[i-1]
    dy = df.y[i] - df.y[i-1]
    ds[i] = ds[i-1]  + np.sqrt(dx*dx+dy*dy)

xa = df.x[0]
xb = df.x[1]
ind = 0

print('[2] Find leading edge index.\n')
while xb < xa:
    ind = ind + 1
    xa = df.x[ind]
    xb = df.x[ind+1]

print('[3] Generate chord-wise positions using cosine spacing.\n')
n_panels_x = 60
xp = np.linspace(0,1,n_panels_x)
xp = np.flip((np.cos(xp*np.pi)/2+0.5))

print('[4] Interpolate upper skin.\n')
dsaux = ds[0:ind+1]
xaux = df.x[0:ind+1]

dsaux = np.reshape(dsaux,-1)
ds = np.reshape(ds,-1)

dsinterp = interpolate.interp1d(xaux,dsaux, kind='slinear')(xp)
yupp = interpolate.interp1d(ds,df.y, kind='slinear')(dsinterp)

# plt.plot(dsinterp, yupp)

print('[5] Interpolate lower skin.\n')

dsaux = []
dsaux = ds[ind:n_coordinates]
dsinterp = []
xaux = df.x[ind:n_coordinates]

dsinterp = interpolate.interp1d(xaux,dsaux, kind='slinear')(xp)
ylow= interpolate.interp1d(ds,df.y, kind='slinear')(dsinterp)


bounds = [(0.015, 0.20), (0.08, 0.16), (-0.24, 0.1), (0.2, 0.46), (-0.2, 0.1), (-0.3, -0.005), (-0.05, 0.03), (-0.05, 0.025), (0.5, 0.8), (0.025, 0.025), (0.0, 0.0)]


# These airfoil parameters are constant
Hte = 0.0 # x(10);
EspBF = 0.0025; # x(11);


airfoil_params=fmincon(@(airfoil_params) resolvecoef(airfoil_params,xp,ysup,yinf,Hte,EspBF), airfoil_params0,[],[],[],[],LB,UB,[],options);

airfoil_paramsr= differential_evolution(airfoil_params, bounds,maxiter=100000,polish=False)
# plt.plot(dsinterp, ylow)


# plt.show()





    
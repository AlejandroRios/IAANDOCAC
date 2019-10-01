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
import scipy as sp
# ----------------------------------------------------------------------
#  Compute Airfoil Parametres
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
n_panels_x = 200
xp = np.linspace(0,1,n_panels_x)
xp = np.flip((np.cos(xp*np.pi)/2+0.5))

print('[4] Interpolate upper skin.\n')
dsaux = ds[0:ind+1]
xaux = df.x[0:ind+1]

dsaux = np.reshape(dsaux,-1)
ds = np.reshape(ds,-1)

dsinterp = interpolate.interp1d(xaux,dsaux, kind='slinear')(xp)
yupp = interpolate.interp1d(ds,df.y, kind='slinear')(dsinterp)


print('[5] Interpolate lower skin.\n')

dsaux = []
dsaux = ds[ind:n_coordinates]
dsinterp = []
xaux = df.x[ind:n_coordinates]

dsinterp = interpolate.interp1d(xaux,dsaux, kind='slinear')(xp)
ylow= interpolate.interp1d(ds,df.y, kind='slinear')(dsinterp)

local_thickness = []
mean_thickness= []
for i in range(len(xp)):
    thickness = np.abs(yupp[i]) + np.abs(ylow[i])
    m_thickness = yupp[i] + ylow[i]
    local_thickness.append(thickness)
    mean_thickness.append(m_thickness)

dataframe = pd.DataFrame()
dataframe['x_coordinates'] = xp
dataframe['y_low_coordinates'] = ylow
dataframe['y_upp_coordinates'] = yupp
dataframe['local_thickness'] = local_thickness
dataframe_head = dataframe.head()

print(dataframe_head)

max_index = dataframe.local_thickness.idxmax()
max_thickness = dataframe.loc[dataframe.local_thickness.idxmax()]

print(max_thickness )


# plt.plot(df.x,df.y,'o')
plt.plot(xp,yupp)
plt.plot(xp,ylow)
plt.plot(xp,local_thickness)
plt.show()
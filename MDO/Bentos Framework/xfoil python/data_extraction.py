import numpy as np
from rxfoil import rxfoil

Re_min = 1200000
Re_max = 22000000
N = 5

aoa_ini   = '0'
aoa_fin   = '2'
delta_aoa = '1'

Reynolds = np.linspace(Re_min, Re_max, N)
Mach = 0.15

PRoot = ['PR1','PR2','PR3','PR4']


Clmax = np.zeros((N,(len(PRoot))))
Rey = np.zeros((N))
Name = np.zeros((N))
Re = []
AirfoilN = []
for i in range(N):
    Re =  Reynolds[i]
    Rey[i] = Re

    for j in range(len(PRoot)):
        print(Re)
        Airfoil = PRoot[j]
        
        Re = str(Re)
        [Cl,_,_,_,_,_] = rxfoil(Airfoil,Re,aoa_ini,aoa_fin,delta_aoa)
    
        Clmax[i,j] = Cl
        

print(Name,Rey,Clmax)
# np.savetxt("Clmax.csv", Clmax, delimiter=",")

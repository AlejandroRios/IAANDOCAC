import numpy as np 
from breguet import breguet
from missionfuelburn import missionfuelburn
from fuelfractionsizing import fuelfractionsizing


rho = 0.002378  # [lb/m3]
g   = 32.174    # [ft/s2]
CL  = 2       


SFC = 0.6   # [l/s]
PSFC = SFC
LD  = 17    
t   = 0.5    # [hr]

# Capacity | Range | Velocity | Fixed cost | linear cost |
#             w[lb]    r[nmi]  v[kt]  f[$/d]  m[$/h]
airplane_A = [5000     ,1063   ,252   ,1481   ,758]
airplane_B = [77210    ,3000   ,465   ,10616  ,3116]
airplane_C = [202100   ,3950   ,526   ,26129  ,7194]


airplanes = [airplane_A, airplane_B, airplane_C]



R   = 1063    # [nmi]
C   = 5000    # [lb]
V   = 252     # [kt]
S   = 277.5   # [ft2]
W_S = 95      # [lb/ft2]
T_W = 0.3     
Neng_A  = 2
n_ik    = 5


d_TO = (1.21*W_S)/(g*rho*CL*T_W)
print(d_TO)

fixedW = 6314      # [lb]
         

eta  = 0.8      

segments = [0.97,
            0.985,
            breguet('jet','cruise',R,LD,PSFC,V,'False','False'),
            breguet('jet','loiter',R,LD,PSFC,'False','False',t),
            0.995]
print(segments)


fuel_safety_margin = 0.06
FF = (1+fuel_safety_margin)*missionfuelburn(segments)

# sf= lambda w0: 3.03*w0**-0.235
sf= lambda w0: 1.02*w0**-0.06
W0 = fuelfractionsizing(sf,fixedW,FF,'false','false')



d_TO = (1.21*W0/S)/(g*rho*CL*T_W)

print(W0)
print(W0/S)
print(d_TO)
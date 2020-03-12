import numpy as np 
from breguet import breguet
from missionfuelburn import missionfuelburn
from fuelfractionsizing import fuelfractionsizing



rho = 0.002378
g = 32.174
CL = 1

Wt = 20000

W_Wtakeoff = Wt*0.97
W_Wclimb  = Wt* 0.985
W_Wland = Wt*0.995


SFC = 0.6
LD = 17
t = 30

# Capacity | Range | Velocity | Fixed cost | linear cost |
airplane_A = [5000, 1063, 252, 1481, 758]
airplane_B = [77210, 3000, 465, 10616, 3116]
airplane_C = [202100, 3950, 526, 26129, 7194]


airplanes = [airplane_A, airplane_B, airplane_C]



R = 5000
C = 1063
V = 252
W_S = 95
T_W = 0.3
Neng_A = 2
n_ik = 5

# result = minimize(objfun, A0, jac=objfungrad,
#                   constraints=[con1],
#                   bounds=bounds,
#                   method='slsqp')



d_TO = (1.21*W_S)/(g*rho*CL*T_W)


fixedW = 600
R = R
V = V
PSFC = SFC
eta = 0.8

segments = [0.98,
            0.99,
            breguet('jet','cruise',R,LD,PSFC,V,eta),
            0.99]

fuel_safety_margin = 0.06
FF = (1+fuel_safety_margin)*missionfuelburn(segments)

EWfunc = lambda w0: 3.03*w0**-0.235
tol = 1.5e-5
W0 = fuelfractionsizing(EWfunc,fixedW,FF,'false','false')

sf = 1.02*W0**-0.06
print(W0)
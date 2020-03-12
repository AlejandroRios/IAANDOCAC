from breguet import breguet
from missionfuelburn import missionfuelburn
from fuelfractionsizing import fuelfractionsizing
fixedW = 600
R = 200*1852
LD = 12
PSFC = 0.4*1.657e-6
eta = 0.6

segments = [0.98,
            0.99,
            breguet('prop','cruise',R,LD,PSFC,'false',eta),
            0.99]

fuel_safety_margin = 0.06
FF = (1+fuel_safety_margin)*missionfuelburn(segments)

EWfunc = lambda w0: 3.03*w0**-0.235
tol = 1.5e-5
W0 = fuelfractionsizing(EWfunc,fixedW,FF,'false','false')

print(W0)
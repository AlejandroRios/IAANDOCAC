import inspect
import numpy as np
import scipy as sp



from inspect import isfunction
from missionfuelburn import missionfuelburn
from scipy.optimize import fsolve
# fn = lambda x: x**2 + 3*x - 4

# fn = np.array([1,2,3])
# print(type(fn))
# if isinstance(fn, (np.ndarray)) == True:
#     print('yesss')
# else:   
#     print('nooo')


def fuelfractionsizing(EWfunc,fixedW,FF,tol,maxW):

    if isfunction(EWfunc) != True:
        if len(EWfunc) == 1:
            W0 = fixedW/(1-FF-EWfunc[0])
            return
        elif len(EWfunc) == 2:
            EWfunc = lambda w0: EWfunc[0]*w0**(EWfunc[1])
        elif len(EWfunc) == 3:
            EWfunc = lambda w0: EWfunc[2]*EWfunc[0]*w0**(EWfunc[1])
        else:
            print('invalid empty weight function EWfunc')
        
    

    if isinstance(EWfunc, (np.ndarray)) == True:
         FF = missionfuelburn(FF)
    
    minW = fixedW/(1-FF)

    # # default maxW represents an aircraft with a terrible fixedW fraction
    # if (*args < 5) || isempty(maxW)
    maxW = minW*1e6
    
    tol = 1e-5*minW
    # if (nargin < 4) || isempty(tol)
    #     tol = 1e-5*minW

    f = lambda W: 1 - EWfunc(W) - FF -fixedW/W

    bounds = np.array([minW,maxW])
    bounds = minW
    W0 = fsolve(f,bounds,xtol=tol)

    return(W0)
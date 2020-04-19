import numpy as np

Rcr = 1063
V = 252
C = 0.6
LD = 17

W5_W4 = 1/np.exp(Rcr/((V/C)*LD))
print(W5_W4)


t = 1
W6_W5 = 1/np.exp(t/((1/C)*LD))
print(W6_W5)
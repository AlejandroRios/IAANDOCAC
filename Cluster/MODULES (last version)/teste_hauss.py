import numpy as np
import matplotlib as mpl
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import matplotlib.pyplot as plt
from hausdorff import hausdorff_distance

n = 10

'Ex 1'
'Curve 1'
t = np.linspace(0, 1, n)
x1 = t
y1 = t + 1
z1 = t

'Curve 2'
u = np.linspace(-0.5,0.5, n)
x2 = u
y2 = u+2
z2 = 2*u

'Ex 2'
'Curve 1'
t = np.linspace(0, 1, n)
x1 = t
y1 = t + 1
z1 = t

'Curve 2'
u = np.linspace(0,1, n)
x2 = u
y2 = u+2
z2 = 2*u

'Ex3'
'Curve 1'
t = np.linspace(-1.5, 1, n)
x1 = t
y1 = (t**2) + (t-1)
z1 = t

'Curve 2'
u = np.linspace(-1.5,1, n)
x2 = u
y2 = 2 - u**2
z2 = 2*u


'Ex4'
'Curve 1'
t = np.linspace(-1.5, 1, n)
x1 = t
y1 = (t**2) + (t-1)
z1 = t

'Curve 2'
u = np.linspace(-1.5,1, n)
x2 = u
y2 = 2 - u**2
z2 = 2*u


'Ex 5'
'Curve 1'
t = np.linspace((2/3)*np.pi, (3/2)*np.pi, n)
x1 = np.cos(t)
y1 = np.sin(t)
z1 = t

'Curve 2'
u = np.linspace((1/2)*np.pi, (3/2)*np.pi, n)
x2 = 2*np.cos(u)
y2 = np.sin(u)
z2 = 2*u



'Ex 7'
'Curve 1'
t = np.linspace((3/4)*np.pi, (5/4)*np.pi, n)
x1 = np.cos(t)
y1 = np.sin(t)
z1 = t

'Curve 2'
u = np.linspace((1/2)*np.pi, (3/2)*np.pi, n)
x2 = 2*np.cos(u)
y2 = np.sin(u)
z2 = 2*u


#########################################################################################################################################



# x1 = [1, 0,-1,0]
# y1 = [0,1,0,-1]

# x2 = [2,0,-2,0]
# y2 = [0,2,0,-4]

# A = [x1,y1]
# B = [x2,y2]
# np.random.seed(0)
# A = np.random.random((n,3))
# B = np.random.random((n,3))

A = [x1,y1]
B = [x2,y2]


def cmax(B,A,n):

    x1 = A[0]
    y1 = A[1]
    # z1 = A[2]
    x2 = B[0]
    y2 = B[1]
    # z2 = B[2]


    cmax = 0
    for i in range(n):
        cmin = np.inf
        for j in range(n):
            # print(x2[j],x1[i],y2[j],y1[i])
            d = np.sqrt((x2[j]-x1[i])**2 + (y2[j]-y1[i])**2)
            # d = np.sqrt((x2[j]-x1[i])**2 + (y2[j]-y1[i])**2 +  (z2[j]-z1[i])**2)
            # print(d)
            if d < cmax:
                cmin = 0
            cmin = min(cmin,d)
        
        cmax = max(cmax,cmin)


    return(cmax)


print(cmax(A,B,n))
print(cmax(B,A,n))

# print(max(cmax(A,B,n),cmax(B,A,n)))


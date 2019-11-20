"""" 
Title     : Xfoil Python function
Written by: Alejandro Rios
Date      : 22/08/19
Language  : Python
Aeronautical Institute of Technology


Inputs:
airfoil name
Reynolds number
AoA initial
AoA final
Delta AoA

Outputs:
Cl max.
Cd@Cl max.
Cl@Cd min.
Cd min.
Cl min.
Cd@Cl min.
"""
########################################################################################
"""Importing Modules"""
########################################################################################
import numpy as np
import os
import matplotlib.pyplot as plt
import pandas as pd
import matplotlib.pyplot as plt
########################################################################################
"""Constants declaration"""
########################################################################################
# cmd = '/home/alejandro/Documents/Github/IAANDOCAC/MDO/fpwb'
import subprocess
# subprocess.Popen([r"/home/alejandro/Documents/Github/IAANDOCAC/MDO/TestesBLWF/fpwb.exe"])

# os.system(r'"/home/alejandro/Documents/Github/IAANDOCAC/MDO/TestesBLWF/fpwb.exe"')

# subprocess.call(["/home/alejandro/Documents/Github/IAANDOCAC/MDO/TestesBLWF/fpwb.exe"])

import os
path = "/home/alejandro/Documents/Github/IAANDOCAC/MDO/TestesBLWF/"
os.chdir(path)
# os.system("fpwb.exe")

os.system("fpwb.exe < fpwbclm1.inp > NUL.dat")

# print(os)
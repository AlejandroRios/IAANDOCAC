"""" 
Title     : Wetted area wing
Written by: Alejandro Rios
Date      : 13/11/19
Language  : Python
Aeronautical Institute of Technology


Inputs:
MTOW

Outputs:
Cap_Sal
FO_Sal
"""

########################################################################################
"""Importing Modules"""
########################################################################################
import numpy as np
import pandas as pd
import os
from scipy import interpolate
from area_triangle_3d import area_triangle_3d
from airfoil_preprocessing import airfoil_preprocessing
import matplotlib.pyplot as plt
import mmap
import sys
from itertools import islice
########################################################################################
"""Constants declaration"""
########################################################################################
# def find(substr, infile):
#   with open(infile) as a:
#    for line in a:
#     if substr in line:
#         print(line)
def find(substr, infile):
    with open(infile) as a:
        num_line = []       
        for num, line in enumerate(a, 1):
            if substr in line:               
                num_line = num
    return(num_line)

def read(line_num, infile):
    with open(arq_output) as lines:
        for line in islice(lines, line_num, line_num+1):
            line_saida = line
    return(line_saida)


arq_output = 'fpwbclm1.out'

to_find = 'MACH'


line_num = find(to_find, arq_output)
line_saida = read(line_num, arq_output)


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
        
        for num, line in enumerate(a, 1):
            if substr in line:
                num = num
            # if substr in line:
            #     print(line,num)
    return(num)


def daaa(error):
    #   Leitura do CD, Momento Fletor e Calculo do CLMAX
    #clc
    CLMAX      = 0
    CLALFA_rad = 0
    nstat      = 21
    K_IND      = 1000
    CD0        = 1E06
    estaestol = 1 # estacao da envergadura onde ocorre o inicio do estol (fracao da enverghadura)
    #
    #ybreaksta = dist_quebra/(meia_env)
    # estacao da ponta
    #yetaponta=(env/2)/(env/2+envergadurarake) # with raked wingtip
    yetaponta=1 # with no raked wingtip
    #
    #  calcula clmax da asa-fuselagem
    # Inicialmente faz leitura da saida do BLWF para a primeira condicao
    #
    error1 = 1
    error2 = 1
    #
    arq_output = 'fpwbclm1.out'

    # with open(arq_output, 'rb', 0) as file:
    #     mmap.mmap(file.fileno(), 0, access=mmap.ACCESS_READ) as file:
    end_file = find('The end', arq_output) 

    print(end_file)
    if end_file >= 0:
        error1 = 0
    # file.close()

    if error1 == 1:
        return
    else:
        line_number = find('     MACH ', arq_output) 

        print(line_number)



    






        # while (isempty(findstr('MACH',linha)))
        #         linha = fgetl(fid)
        # end
        # linhamach = fgetl(fid)
        # READ = strread(linhamach)
        # ALFA1=READ(2)
        # while (isempty(findstr('CHORD',linha)))
        #         linha = fgetl(fid)
        # end

        # for k=1:nstat
        #     linha = fgetl(fid)
        #     READ = strread(linha)
        #     Zestacao1(k) = READ(2)
        #     CLestacao1(k) = READ(3)
        #     Chordestacao1(k) =READ(12)
        # end
        # #
        # while (isempty(findstr('CDIND',linha)))
        #         linha = fgetl(fid)
        # end
        # #
        # linha = fgetl(fid)
        # READ = strread(linha)
        # CL1  = READ(1)
        # CD1 = READ(2) + READ(3) + READ(6)
        # end
    


# with open(arq_output) as fp:
#     line = fp.readline()
#     cnt = 1
#     while line:
#     #    print("Line {}: {}".format(cnt, line.strip()))
#        line = fp.readline()
#        cnt += 1
    # print(line[0].find("The end"))
error = 1
daaa(error)

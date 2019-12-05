"""" 
Title     : Section Clmax
Written by: Alejandro Rios
Date      : 05/11/19
Language  : Python
Aeronautical Institute of Technology


Inputs:
Mach
AirportElevation
PROOT
Craiz
PKINK
Cquebra
PTIP
Cponta

Outputs:
clmax_airfoil
flagsuc
"""
########################################################################################
import numpy as np
import os
from atmosphere import atmosphere
from cf_flat_plate import cf_flat_plate
########################################################################################
"""Constants declaration"""
########################################################################################
# Esta rotina computa 0 volume do tanque externo (entre a quebra e
# a raiz do aileron


    yinterno=ymed1
    yexterno=ymed2
    #acha perfil externo
    deltay=wingb/2-yinterno


    xuperfilext=xutip
    yuperfilext=yukink + ((yexterno-yinterno)/deltay)*(yutip-yukink)
    ylperfilext=ylkink + ((yexterno-yinterno)/deltay)*(yltip-ylkink)
    Cext = Cquebra + ((yexterno-yinterno)/deltay)*(Cponta-Cquebra)
    heighte = ymed2-ymed1
    icount=0


    xlkink
    for i in range(0,nukink,1):
        if xuperfilext(i) < limitepe and xuperfilext(i) >= limited:
            icount=icount+1
            xpolye[icount]=xuperfilext[i]
            ypolye[icount]=yuperfilext[i]
            xpolyi[icount]=xukink[i]
            ypolyi[icount]=yukink[i]

    for i in range(nukink,0,-1):
        if xuperfilext[i] < limitepe and xuperfilext[i] >= limited:
            icount=icount+1
            xpolye[icount]=xuperfilext[i]
            ypolye[icount]=ylperfilext[i]
            xpolyi[icount]=xlkink[i]
            ypolyi[icount]=ylkink[i]

    #xistosxlkink=xlkink
    #xistosylkink=ylkink
    # a percentagem da corda na secao da raiz nao eh a memsma da long traseira
    yinterno=yfusjunc
    yexterno=ymed3
    #xistosquebra=yquebra
    #acha perfil externo
    deltay=yquebra-yinterno

    gradaux= (yexterno-yinterno)/deltay

    xuperfilint=xuroot
    


    for j in range(len(xuroot)):
        yuperfilint[j] = yuroot[j] + gradaux*(yukink[j]-yuroot[j])
        ylperfilint[j] = ylroot[j] + gradaux*(ylkink[j]-ylroot[j])
    
    Csupint = Cinter + ((yexterno-yinterno)/deltay)*(Cquebra-Cinter)


    limitedr = limited

    icount=0

    for i in range(0,len(xuroot),1):
        if xuperfilint[i] <= limitepi1 and xuperfilint[i] >= limitedr:
            icount=icount+1
            xpolyroot[icount]=xuroot[i]
            ypolyroot[icount]=yuperfilint[i]

    #xistosxlroot=xlroot
    #xistosylroot=ylroot
    for i in range(len(xuroot,1,-1)):

        if xuperfilint[i] <= limitepi1 and xuperfilint[i] >= limitedr:
            icount=icount+1
            xpolyroot[icount]=xuroot[i]
            ypolyroot[icount]=ylperfilint[i]

    #
    # Area molhada no perfil da interseccao asa-fuselagem
    icount=0


    for i in range(0,len(xuroot),1):
        if xuroot[i] <= limitepi2 and xuroot[i] >= limitedr:
            icount=icount+1
            xpolyroot1[icount]=xuroot[i]
            ypolyroot1[icount]=yuroot[i]

    #xistosxlroot=xlroot
    #xistosylroot=ylroot

    for i in range(len(xuroot),0,-1):
        if xuroot[i] <= limitepi2 and xuroot[i] >= limitedr:
            icount=icount+1
            xpolyroot1[icount]=xuroot[i]
            ypolyroot1[icount]=ylroot[i]

    def PolyArea(x,y):
        return 0.5*np.abs(np.dot(x,np.roll(y,1))-np.dot(y,np.roll(x,1)))


    areae=PolyArea(xpolye,ypolye)*Cext*Cext
    areai=PolyArea(xpolyi,ypolyi)*Cquebra*Cquebra
    arearootsup=PolyArea(xpolyroot,ypolyroot)*Csupint*Csupint
    arearootinf=PolyArea(xpolyroot1,ypolyroot1)*Cinter*Cinter
    # Calculo dos volumes
    voltanqueext=0.98*(heighte/3)*(areai + areae + np.sqrt(areai*areae)) # 2# de perdas devido a nervuras, revestimento e outros equip
    voltanqueint=0.98*(deltay/3)*(arearootinf + arearootsup + np.sqrt(arearootinf*arearootsup)) # 2# de perdas devido a nervuras, revestimento e outros equip
#
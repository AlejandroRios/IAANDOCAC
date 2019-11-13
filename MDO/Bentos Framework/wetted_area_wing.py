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
import os
from area_triangle_3d import area_triangle_3d
########################################################################################
"""Constants declaration"""
########################################################################################

def wetted_area_wing(ediam,wingloc,FusDiam,Ccentro,Craiz,Cquebra,
                    Cponta,semispan,sweepLE,iroot,ikink,itip,xle,yposeng,wingdi,wtaper,
                    fileToRead1,fileToRead2,fileToRead3):
    # Calcula area exposta ada asa
    rad  = np.pi/180
    #
    raio = FusDiam/2
    df   = FusDiam
    tanaux=np.tan(rad*sweepLE)

    ##------------------ WING  ----------------------------------
    # Read root airfoil geometry
    #  cd ..
    fileReadaux=''
    filereadpath=[fileReadaux fileToRead1 '.dat']
    arq_input = (filereadpath)
    fid = fopen(arq_input)
    fgetl(fid)
    #fprintf(' \n #s \n',linhai)
    icount=0
    while (~feof(fid))
        linha = fgetl(fid)
        READ=strread(linha)
        icount=icount+1
        xp=READ(1)
        #
        yp=READ(2)
        xperraiz(icount)=xp
        yperraiz(icount)=yp
    end
    npraiz=icount
    fclose(fid)

    # reinterpola perfil da raiz
    npontos = 50
    xspline = (cos(pi:-pi/npontos:0)+1)/2.
    ds(1) = 0
    for i=1:1:(npraiz-1)
    ds(i+1) = ds(i)+sqrt((xperraiz(i+1)-xperraiz(i))^2 + (yperraiz(i+1)-yperraiz(i))^2)
    end


    [~, indp]=min(xperraiz)
    xaux   = xperraiz(1:1:indp)
    dsaux  = ds(1:1:indp)
    dsplin = spline(xaux,dsaux,xspline)

    xuraiz  = xspline
    yuraiz = spline(ds,yperraiz,dsplin)
    #

    xaux1   = xperraiz(indp:1:npraiz)
    dsaux1  = ds(indp:1:npraiz)
    dsplin1 = spline(xaux1,dsaux1,xspline)
    xlraiz   = xspline
    ylraiz   = spline(ds,yperraiz,dsplin1)

    xperroot=[xuraiz(npontos+1:-1:2), xlraiz]
    yperroot=[yuraiz(npontos+1:-1:2), ylraiz]
    esspraiz=max(yuraiz)-min(ylraiz)

    ########################### Read kink station airfoil
    filereadpath=[fileReadaux fileToRead2 '.dat']
    arq_input = (filereadpath)

    fid = fopen(arq_input)
    linhatit=fgetl(fid)
    #fprintf(' \n #s \n',linhai)
    icount=0
    while (~feof(fid))
        linha = fgetl(fid)
        READ=strread(linha)
        icount=icount+1
        xp=READ(1)
        #
        yp=READ(2)
        xperbreak(icount)=xp
        yperbreak(icount)=yp
    end
    npbreak=icount
    fclose(fid)
    # reinterpola perfil da ponta
    npontos = 50
    xspline = (cos(pi:-pi/npontos:0)+1)/2.
    ds=[]
    ds(1) = 0
    for i=1:1:(npbreak-1)
    ds(i+1) = ds(i)+sqrt((xperbreak(i+1)-xperbreak(i))^2 + (yperbreak(i+1)-yperbreak(i))^2)
    end


    [~, indp]=min(xperbreak)
    xaux      = xperbreak(1:1:indp)
    dsaux     = ds(1:1:indp)
    dsplin    = spline(xaux,dsaux,xspline)
    #nutip  = npontos+1
    xubreak   = xspline
    yubreak   = spline(ds,yperbreak,dsplin)
    #
    #nltip   = npontos+1
    xaux1     = xperbreak(indp:1:npbreak)
    dsaux1    = ds(indp:1:npbreak)
    dsplin1   = spline(xaux1,dsaux1,xspline)
    xlbreak   = xspline
    ylbreak   = spline(ds,yperbreak,dsplin1)

    xperbreak = [xubreak(npontos+1:-1:2), xlbreak]
    yperbreak = [yubreak(npontos+1:-1:2), ylbreak]
    ########################### read tip airfoil
    filereadpath=[fileReadaux fileToRead3 '.dat']
    arq_input = (filereadpath)

    fid = fopen(arq_input)
    fgetl(fid)
    #fprintf(' \n #s \n',linhai)
    icount=0
    while (~feof(fid))
        linha = fgetl(fid)
        READ=strread(linha)
        icount=icount+1
        xp=READ(1)
        #
        yp=READ(2)
        xpertip(icount)=xp
        ypertip(icount)=yp
    end
    nptip=icount
    fclose(fid)
    # reinterpola perfil da ponta
    npontos = 50
    xspline = (cos(pi:-pi/npontos:0)+1)/2.
    ds=[]
    ds(1) = 0
    for i=1:1:(nptip-1)
    ds(i+1) = ds(i)+sqrt((xpertip(i+1)-xpertip(i))^2 + (ypertip(i+1)-ypertip(i))^2)
    end


    [~, indp]=min(xpertip)
    xaux   = xpertip(1:1:indp)
    dsaux  = ds(1:1:indp)
    dsplin = spline(xaux,dsaux,xspline)
    #nutip  = npontos+1
    xutip  = xspline
    yutip  = spline(ds,ypertip,dsplin)
    #
    #nltip   = npontos+1
    xaux1   = xpertip(indp:1:nptip)
    dsaux1  = ds(indp:1:nptip)
    dsplin1 = spline(xaux1,dsaux1,xspline)
    xltip   = xspline
    yltip   = spline(ds,ypertip,dsplin1)

    xpertip=[xutip(npontos+1:-1:2), xltip]
    ypertip=[yutip(npontos+1:-1:2), yltip]

    #=====> Wing
    if wingloc ==1
        wingpos=-0.48*raio
        engzpos=-0.485*raio
    else
        wingpos=raio-Ccentro*1.15*0.12/2
        engzpos=wingpos-0.10*ediam/2
    end
    # Rotate root section according to given incidence
    teta=-iroot # - points sky + points ground
    tetar=teta*rad
    xperroot_rota=xperroot*cos(tetar)-yperroot*sin(tetar)
    yperroot_rota=xperroot*sin(tetar)+yperroot*cos(tetar)

    # Rotates kink station airfoil
    teta  =-ikink
    tetar =teta*rad
    xperbreak=xperbreak*cos(tetar)-yperbreak*sin(tetar)
    yperbreak=xperbreak*sin(tetar)+yperbreak*cos(tetar)

    # Rotates tip airfoil
    teta  =-itip
    tetar =teta*rad
    xperponta=xpertip*cos(tetar)-ypertip*sin(tetar)
    yperponta=xpertip*sin(tetar)+ypertip*cos(tetar)
    deltax=semispan*tanaux

    maxcota=-0.48*(df/2)+1.15*Ccentro*esspraiz
    yraiz=sqrt((df/2)^2-maxcota^2)
    xleraiz=xle+yraiz*tanaux
    xlequebra=xle+semispan*yposeng*tanaux

    xistosxper=[xle+Ccentro*xperroot_rota xleraiz+Craiz*xperroot_rota xlequebra+Cquebra*xperbreak xle+deltax+Cponta*xperponta]
    #
    xistoszper=[(wingpos+Ccentro*yperroot_rota)wingpos+Craiz*yperroot_rota(wingpos+(yposeng*semispan*tan(rad*wingdi))+ Cquebra*yperbreak)(semispan*tan(rad*wingdi)+wingpos+Ccentro*wtaper*yperponta)]

    sizex=size(xperroot)
    yper1(1:sizex(2))=0
    yper2(1:sizex(2))=yraiz
    yper3(1:sizex(2))=semispan*yposeng
    #yper3(1:sizex(2))=semispan-df/2
    yper4(1:sizex(2))=semispan
    xistosyper=[yper1yper2 yper3 yper4]

    # C
    #surface(xistosxper,xistosyper,xistoszper,'FaceLighting','gouraud','EdgeColor','none','FaceColor','blue')
    #surface(xistosxper,-xistosyper,xistoszper,'FaceLighting','gouraud','EdgeColor','none','FaceColor','blue')
    #
    ##=== End wing
    #axis equal

    areawingwet= calcareawet(xistosxper,xistosyper,xistoszper)

    return(areawingwet, xutip, yutip, xltip, yltip, xubreak,yubreak,xlbreak,ylbreak, xuraiz,yuraiz,xlraiz,ylraiz)


# def calcareawet(xistosXper,xistosYper,xistosZper):
#     # Calcula área exposta da asa (m2)
#     [m, n]=size(xistosXper)

#     areawet =0

#     for  j=2:(m-1)
#         for i=1:(n-1)
#             x1=xistosXper(j,i)
#             y1=xistosYper(j,i)
#             z1=xistosZper(j,i)
            
#             x2=xistosXper(j,i+1)
#             y2=xistosYper(j,i+1)
#             z2=xistosZper(j,i+1)
            
#             x3=xistosXper(j+1,i+1)
#             y3=xistosYper(j+1,i+1)
#             z3=xistosZper(j+1,i+1)
            
#             Stri=tri3darea(x1,y1,z1,x2,y2,z2,x3,y3,z3)
        
#             areawet = areawet + abs(Stri)
            
#             x1=xistosXper(j,i+1)
#             y1=xistosYper(j,i+1)
#             z1=xistosZper(j,i+1)
            
#             x2=xistosXper(j+1,i)
#             y2=xistosYper(j+1,i)
#             z2=xistosZper(j+1,i)
            
#             x3=xistosXper(j+1,i+1)
#             y3=xistosYper(j+1,i+1)
#             z3=xistosZper(j+1,i+1) 
            
#             Stri=tri3darea(x1,y1,z1,x2,y2,z2,x3,y3,z3)
        
#             areawet = areawet + abs(Stri)

#     areawet=2*areawet
#     return(areawet)


# def tri3darea(x1,y1,z1,x2,y2,z2,x3,y3,z3):
#     # Calcula area de um triangulo a partir das coordendas dos vertices

#     a1=x1-x2
#     a2=y1-y2
#     a3=z1-z2

#     b1=x3-x2
#     b2=y3-y2
#     b3=z3-z2

#     axb1=(a2*b3-a3*b2)
#     axb2=(a3*b1-a1*b3)
#     axb3=(a1*b2-a2*b1)

#     Stri=0.50*sqrt(axb1^2 +axb2^2 + axb3^2)
#     return(Stri)

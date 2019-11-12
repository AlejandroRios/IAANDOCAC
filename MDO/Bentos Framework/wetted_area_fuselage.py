"""" 
Title     : Wetted area fuselage
Written by: Alejandro Rios
Date      : 08/11/19
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

def wetted_area_forward_fuselage(fus_h,fus_w,lco):

    from stl import mesh

    mesh = mesh.Mesh.from_file('forwardfus_short.stl')

    xmin = mesh.min_[0]
    xmax = mesh.max_[0]
    ymin = mesh.min_[1]
    ymax = mesh.max_[1]
    zmin = mesh.min_[2]
    zmax = mesh.max_[2]

    # Proceed to scale the mesh to fit into the current airplane configuration
    #xmed = 0.50*(xmin+xmax)
    ymed = 0.50*(ymin+ymax)
    zmed = 0.50*(zmin+zmax)

    dx = xmax-xmin
    dy = ymax-ymin
    dz = zmax-zmin

    scalex = lco/dx
    scaley = fus_w/dz
    scalez = fus_h/dy


    vertx = mesh.x - xmin
    vertx = vertx * scalex

    verty = mesh.y - ymed
    verty = verty * scalez

    vertz = mesh.z - zmed
    vertz = vertz * scaley

    # verts = np.column_stack((vertx,vertz,verty))
    nfac = len(mesh.vectors)
    areas = []
    for i in range(nfac):
        x = vertx[i]
        y = vertz[i]

        z = verty[i]

        area = area_triangle_3d(x,y,z)
        areas.append(area)
        # print(areas)
    total_area = np.sum(areas)


    return(total_area)

def wetted_area_tailcone_fuselage(fus_h,fus_w,lf,ltail):
    ai=fus_w/2
    bi=0.90*fus_h/2
    # Ellipse do final da fuselagem
    af=0.250 # m
    bf=0.30 # m
    z0f=bi-bf
    #
    n_points=20
    teta=(0:1/n_points:1)*pi
    #
    xi(1:n_points)=lf-ltail
    zi=bi*np.cos(teta)
    yi=ai*np.sin(teta)
    #
    xf(1:n_points)=lf
    zf=z0f + bf*np.cos(teta)
    yf= af*np.sin(teta)
    SWET_TC = 0

    for ie in range(n_points-1)
        xe(0)=xi(ie)
        ye(0)=yi(ie)
        ze(0)=zi(ie)
        xe(1)=xf(ie)
        ye(1)=yf(ie)
        ze(1)=zf(ie)
        xe(2)=xf(ie+1)
        ye(2)=yf(ie+1)
        ze(2)=zf(ie+1)
        xe(3)=xi(ie+1)
        ye(3)=yi(ie+1)
        ze(3)=zi(ie+1)
        xe(4)=xe(0)
        ye(4)=ye(0)
        ze(4)=ze(0)
        # Triangle # 1
        xt(0)=xe(0)
        xt(1)=xe(1)
        xt(2)=xe(3)
        yt(0)=ye(0)
        yt(1)=ye(1)
        yt(2)=ye(3)
        zt(0)=ze(0)
        zt(1)=ze(1)
        zt(2)=ze(3)
        A1=area_triangle_3d(x,y,z)
        #  plot3(xt,yt,zt)
        #  hold on
        # Triangle # 2
        xt(0)=xe(1)
        xt(1)=xe(2)
        xt(2)=xe(3)
        yt(0)=ye(1)
        yt(1)=ye(2)
        yt(2)=ye(3)
        zt(0)=ze(1)
        zt(1)=ze(2)
        zt(2)=ze(3)
        A2=area_triangle_3d(x,y,z)
        #  plot3(xt,yt,zt)
        #  hold on
        SWET_TC = SWET_TC + A1 + A2

    #  axis equal
    #  xlabel('x')
    #  ylabel('y')
    #  zlabel('z')
    SWET_TC = 2*SWET_TC

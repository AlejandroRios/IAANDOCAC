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

    # check this point
    for i in range(nfac-1):
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
    teta = np.linspace(0,1,n_points+1)*np.pi

    # #
    xi = np.ones(n_points)*(lf-ltail)
    zi=bi*np.cos(teta)
    yi=ai*np.sin(teta)
    #
    xf =  np.ones(n_points)*lf
    zf=z0f + bf*np.cos(teta)
    yf= af*np.sin(teta)
    SWET_TC = 0

    xe = []
    ye = []
    ze = []
    xt1 = []
    yt1 = []
    zt1 = []

    xt2 = []
    yt2 = []
    zt2 = []

    areas = []
    for ie in range(n_points-1):
        xe.insert(0,xi[ie])
        xe.insert(1,xf[ie])
        xe.insert(2,xf[ie+1])
        xe.insert(3,xi[ie+1])
        xe.insert(4,xe[0])

        ye.insert(0,yi[ie])
        ye.insert(1,yf[ie])
        ye.insert(2,yf[ie+1])
        ye.insert(3,yi[ie+1])
        ye.insert(4,ye[0])

        ze.insert(0,zi[ie])
        ze.insert(1,zf[ie])
        ze.insert(2,zf[ie+1])
        ze.insert(3,zi[ie+1])
        ze.insert(4,ze[0])
        
        xt1.insert(0,xe[0])
        xt1.insert(1,xe[1])
        xt1.insert(2,xe[3])

        yt1.insert(0,ye[0])
        yt1.insert(1,ye[1])
        yt1.insert(2,ye[3])

        zt1.insert(0,ze[0])
        zt1.insert(1,ze[1])
        zt1.insert(2,ze[3])

        A1 = area_triangle_3d(xt1,yt1,zt1)

        xt2.insert(0,xe[1])
        xt2.insert(1,xe[2])
        xt2.insert(2,xe[3])

        yt2.insert(0,ye[1])
        yt2.insert(1,ye[2])
        yt2.insert(2,ye[3])

        zt2.insert(0,ze[1])
        zt2.insert(1,ze[2])
        zt2.insert(2,ze[3])

        A2 = area_triangle_3d(xt2,yt2,zt2)

        areas.append(A1+A2)

    total_area = 2*(sum(areas))
    return(total_area)
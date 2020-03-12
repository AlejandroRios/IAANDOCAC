"""" 
Function  : Distances matrix
Title     : distances_matrix
Written by: Alejandro Rios
Date      : February/2020
Language  : Python
Aeronautical Institute of Technology
"""
########################################################################################
"""Importing Modules"""
########################################################################################
import numpy as np
from hausdurff_distance import cmax
########################################################################################
""" Meassuring Hausdorff distance between trajectories  2"""
#######################################################################################


def hausdorff(A,B):
    H_distance = max(cmax(A, B),cmax(B,A))
    return(H_distance)

def distances(coordinates_vec,d_matrix_exist):

    traj_count = len(coordinates_vec)
    D = np.zeros((traj_count, traj_count))

    # This may take a while
    for i in range(traj_count):
        for j in range(i + 1, traj_count):
            # distance = hausdorff(coordinates_vec[i], coordinates_vec[j])
            distance = hausdorff(coordinates_vec[i], coordinates_vec[j])
            D[i, j] = distance
            D[j, i] = distance



    if d_matrix_exist == 0:
        np.save('d_mat_FRAFCO.npy', D)

    return(D)


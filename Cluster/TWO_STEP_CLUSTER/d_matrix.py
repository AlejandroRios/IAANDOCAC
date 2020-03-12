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

print('--------------------------------------------------------------------------------\n')
print('[3] Meassuring Hausdorff distance between trajectories.\n')


def hausdorff(A,B):
    H_distance = max(cmax(coordinates_vec[i], coordinates_vec[j]),cmax(coordinates_vec[i], coordinates_vec[j]))
    return(H_distance)

def distances(coordinates_vec,save_matrix):

    traj_count = len(coordinates_vec)
    D = np.zeros((traj_count, traj_count))

    # This may take a while
    for i in range(traj_count):
        for j in range(i + 1, traj_count):
            # distance = hausdorff(coordinates_vec[i], coordinates_vec[j])
            distance = hausdorff(coordinates_vec[i], coordinates_vec[j])
            D[i, j] = distance
            D[j, i] = distance



    if save_matrix == 1:
        np.save('distances_n_norm.npy', D)

    return(D)


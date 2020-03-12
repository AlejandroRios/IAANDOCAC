"""" 
Function  : plot_cluster
Title     : Plot cluster
Written by: Alejandro Rios
Date      : March/2020
Language  : Python
Aeronautical Institute of Technology
"""
########################################################################################
"""Importing Modules"""
########################################################################################
import matplotlib.pyplot as plt
import numpy as np
########################################################################################
color_lst = plt.rcParams['axes.prop_cycle'].by_key()['color']
color_lst.extend(['b', 'dimgray', 'indigo', 'khaki', 'teal', 'saddlebrown', 
                 'skyblue', 'coral', 'darkorange', 'lime', 'darkorchid', 'olive'])


color_lst = plt.rcParams['axes.prop_cycle'].by_key()['color']
color_lst.extend(['b', 'dimgray', 'indigo', 'khaki', 'teal', 'saddlebrown', 
                 'skyblue', 'coral', 'darkorange', 'lime', 'darkorchid', 'olive'])

def plot_cluster(traj_lst, cluster_lst):
    cluster_count = np.max(cluster_lst) + 1
    
    for traj, cluster in zip(traj_lst, cluster_lst):
        
        if cluster == -1:
            x1, y1 = m(traj[:, 0], traj[:, 1])
            # m.plot(*(x1, y1), c='b', linestyle='dashed',linewidth=2)
            p0 = m.plot(*(x1, y1), c='k', linestyle='dashed',linewidth=0.1,alpha=0.5)
        elif cluster == 0:
            x2, y2 = m(traj[:, 0], traj[:, 1])
            p1 = m.plot(*(x2, y2), c=color_lst[cluster % len(color_lst)],linewidth=0.5,alpha=0.5)
        elif cluster == 1:
            x3, y3 = m(traj[:, 0], traj[:, 1])
            p2 = m.plot(*(x3, y3), c=color_lst[cluster % len(color_lst)],linewidth=0.5,alpha=0.5)        
        elif cluster == 2:
            x4, y4 = m(traj[:, 0], traj[:, 1])
            p3 = m.plot(*(x4, y4), c=color_lst[cluster % len(color_lst)],linewidth=0.5,alpha=0.5)
    
    plt.legend((p0[0],p1[0],p2[0],p3[0]),('Outliers','R1 Clust. 0','R1 Clust. 1','R1 Clust. 2'))
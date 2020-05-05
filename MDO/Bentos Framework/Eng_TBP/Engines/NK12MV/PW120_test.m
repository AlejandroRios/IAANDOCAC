clear all
close all
clc

M0 = linspace(0.1,0.8,10);
altitude = linspace(0,30000,10);
Tt4 = 3200;  

%% Input data
% Engine Limits 
pi_c_lim = 30;
Tt3_lim = 1600;
Tt4_init = 3200;

M0 = 0.2;
altitude = 0;

[F_m0_dot,F,S,pi_c] = turboprop_func(Tt4_init,Tt3_lim,pi_c_lim, M0,altitude);
clear all
close all
clc
%%
K2R = 1.8;

%% Input data
% Engine Limits 
% pi_c_lim = 30;
% Tt3_lim = 1600;
% Tt4_init = 3200;
% 
% M0 = 0.2;
% altitude = 0;

% Engine Limits 
pi_c_lim = 7.2;
Tt3_lim = 1600;
Tt4_init = 2500;

M0 = 0.5;
altitude = 25000;


[F_m0_dot,F,S,pi_c] = turboprop_func(Tt4_init,Tt3_lim,pi_c_lim, M0,altitude);
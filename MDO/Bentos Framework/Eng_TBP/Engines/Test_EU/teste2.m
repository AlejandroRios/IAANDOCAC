
clear all
close all
clc
%-------------- Conversion factors ----------------------------------------
K2R = 1.8;
lb2kg    = 0.454;
kg2lb    = 1/lb2kg;
kW2hp    = 1.341;
%--------------Atmosphere------------------------- 
M0 = 0;
altitude = 0;
%--------------Engine Data------------------------ 
Tt4     = 1295;  % Turbine Inlet total temperature [K]

%% Input data
% Engine Limits 
pi_c_lim = 30;
Tt3_lim = 1600;
Tt4_init = 3200;

% Engine data -------------------------------------------------------------
Tt4_init = Tt4*K2R;5;  % Turbine Inlet total temperature [K]




[F_m0_dot,F,S,pi_c] = turboprop_func(Tt4_init,Tt3_lim,pi_c_lim, M0,altitude);

clear all
close all
clc
%% Turboprop Engine Parametric Cycle Analysis
% Inputs:
% Flight parameters: M0, T0, P0
% Aircraft system parameters: Beta, CTOL, CTOH
% Design limitations:
% Fuel heating value: hPR
% Component figures of metir: pi_b, pi_dmax, pi_n,
%                             e_c, e_tH, e_tL
%                             eta_b, eta_mL, eta_mH, eta_mPL, eta_mPH,
%                             eta_prop
% Design choices: pi_c, tau_t, Tt4

% Outputs:
% Overall performance: F/m_dot_0, S, P/m_dot_0, S_P, f0, C_C, C_prop,
% eta_P, eta_TH, V9/a0
% Component behavior: pi_tH, pi_tL, tau_c, tau_tH, tau_tL, tau_lambda,f,
% eta_c, eta_tH, eta_tL, M9, Pt9/P9, P9/P0,, T9/T0
%% Convertion factors
m2ft = 3.28084;
kgsecW2lbhrhp = 5918384.527;
kW2hp = 1.341;
N2lb = 0.2248;
%% Inputs

% Mode 0 design point | Mode 1 off design
h = 5000;
h = h*m2ft;             % [ft]
ISADEV = 0;

% Atmospheric parameters
atm=atmosphere(h,ISADEV);

% Flight parametres
P0 = atm(5);            % [KPa]
T0 = atm(1);            % [K]
rho0 = atm(6);          % [kg/m3]
R_air = 287;            % [J/kg·K]
M0 = 0.2;

%% Execution
[~, h0, Pr0, phi0, Cp0, R0, gamma0, a0] = FAIR(1,0,T0);
V0 = M0*a0;             % [m/s]

ht0 = h0 + V0^2/2*g_c
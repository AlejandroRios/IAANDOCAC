%% Inputs
clear all
clc
%% TURBOPROP ENGINE

%% Inputs
%--------------Flight parameters-------------------------

M0 = 1.6;
T0 = 394.10;
P0 = 5.4605;

%--------------Aircraft system parameters----------------

beta = 0;
C_TOL = 0;
C_TOH = 0;

%--------------Design limitations------------------------

% Fuel heating value
h_PR = 3200;

% Components figures of merit
epsilon1 = 0;
epsilon2 = 0;

pi_b = 0.96;
pi_d_max = 0.97;
pi_n = 0.99;

e_c = 0.9;
e_tH = 0.89;
e_tL = 0.91;

eta_b = 0.995;
eta_mL = 0.99;
eta_mH = 0.98;
eta_mPL = 1;
eta_mPH = 1;
eta_prop = 0.82;
%--------------Design choices----------------------------

pi_c = 30;
tau_t = 0.45;
Tt4 = 3200;

%--------------Other-------------------------------------
%         BE(32.17,32.17),
%         SI(9.8067, 1)
g_c = 32.174;     % Newtons gravitational constant
g_0 = 32.17;     % Aceleration of gravity

%% Equations
[~, h0, Pr0, phi0, Cp0, R0, gamma0, a0] = FAIR(1,0,T0);
V0 = M0*a0;
ht0 = (h0*782) + ((V0^2)/(2*g_c));

[Tt0, ~, Prt0, ~, ~, ~, ~, ~] = FAIR(2,0,[],ht0);

tau_r = ht0/782/h0




































clear all
clc
%% TURBOPROP ENGINE

%% Inputs

%--------------Performance Choices----------------

% Flight parameters:
M0 = 0.8;
% T0 = 288.2;             % [K]
T0 = 429.62;
% P0 = 101.3;             % [KPa]
P0 = 5.461;             % [psia]
% Throttle setting:
% Tt4 = 1777;             % [K] 
Tt4 = 3200;             % [R]
%--------------Design Constants----------------

% Compressor pressure ratio pi's:
pi_d_max = 0.97;
pi_b = 0.96;
pi_n = 0.99;

% Efficiencies eta's:
eta_c = 0.8755; 
eta_tH = 0.8950;
eta_tL = 0.9212;
eta_b = 0.995;
eta_mL = 0.99;
eta_mH = 0.98;
eta_mPL = 1; 
eta_mPH = 1;
eta_prop_max = 0.82;
eta_g = 0.99;
eta_cH = 1;
% A's:

A4 = 3.587;
A4_5 = 3.455;
A8 = 6.98;

% Others:
beta = 0;
epsilon1 = 0.05;
epsilon2 = epsilon1;
% h_PR = 42.800;          % [kJ/Kg]
h_PR = 18400;           % [Btu/lbm]
% P_TOL
% P_TOH
g_c = 32.17405;             % [ft/s]
C_TOL = 0;
C_TOH = 0;
%--------------Reference Condition----------------

% Flight parameters:
M0_R = M0;
T0_R = T0;
P0_R = P0;

% Component behavior:
pi_c_R = 5;
pi_r_R = 1.524;
pi_d_R = 0.97;
pi_tH_R = 0.6945;
pi_tL_R = 0.3687;
tau_c_R = 1.6668;
tau_r_R = 1.128;
tau_tH_R = 0.9115;
tau_tL_R = 0.7715;
tau_cH = 1;
% Others:
Tt4_R = Tt4;
tau_m1_R = 0.9597;
tau_m2_R = 0.9631;
f_R = 0.04083;
% M0_R
M8_R = 0.9559;
C_TOL_R = 0;
C_TOH_R = 0;
% F_R
m0_dot_R = 100;
% S_R



%--------------Engine Control Limits----------------
% pi_c_max
% Tt3_max
% Pt3_max
% N_L_percent
% N_H_percent

gamma_c = 1.4;
gamma_t = 1.4;

Cp_c = 0.240;           % [Btu/lbm-R]
Cp_t = 0.295; 


%% Preliminary Computations
% case 1 - T is known
[~, h0, Pr0, phi0, Cp0, R0, gamma0, a0] = FAIR(1,0,T0);

h0_R = h0;
MFP4_R = M0_R*sqrt((gamma0*g_c)/R0)*(1 + ((gamma0-1)/2)*M0^2)^((gamma0+1)/(2*(1-gamma0)));

V0 = M0*a0;             % [ft/s]

ht0 = h0 + (V0^2)/(2*g_c);          % [Btu/lbm]
%case 2 - h is known
[Tt0, ht0, Prt0, phit0, Cpt0, Rt0, gammat0, at0] = FAIR(2,0,[],ht0);

tau_r = ht0/h0;
pi_r = Prt0/Pr0;

if M0 <= 1
    pi_d = pi_d_max;
end

if M0 <= 0.1
    eta_prop = 10*M0*eta_prop_max;
elseif M0 > 0.1 && M0 <= 0.7
    eta_prop = eta_prop_max;
elseif M0 > 0.7 && M0 <= 0.85
    eta_prop = (1 - (M0-0.7)/3)*eta_prop_max;
end

ht2 = ht0;
Prt2 = Prt0;

%% Set initial values

pi_tH = pi_tH_R;
pi_tL = pi_tL_R;
tau_tH = tau_tH_R;
tau_tL = tau_tL_R;

pi_c = pi_c_R;
tau_c = tau_c_R;
m0_dot = m0_dot_R;
tau_m1 = tau_m1_R;
tau_m2 = tau_m2_R;
f = f_R;
M4 = 1;
M4_5 = 1;
M8 = M8_R;
M9 = M8;

%% Hig-pressure and low-pressure turbines:
% case 1 - T is known
[~, ht4, Prt4, phit4, Cpt4, Rt4, gammat4, at4] = FAIR(1,f,Tt4);

ht4_5 = ht4*tau_m1*tau_tH*tau_m2;
f4_5 = f*(1 - beta - epsilon1 - epsilon2)/(1 - beta);
% case 2 - h is known
[Tt4_5i, ~, Prt4_5, phit4_5, Cpt4_5, Rt4_5, gammat4_5, at4_5] = FAIR(2,f4_5,[],ht4_5);

ht5 = ht4_5*tau_tL;
% case 2 - h is known
[Tt5i, ~, Prt5, phit5, Cpt5, Rt5, gammat5, at5] = FAIR(2,f4_5,[],ht5);

ht3 = ht2*tau_c;
% case 2 - h is known
[Tt3, ~, Prt3, phit3, Cpt3, Rt3, gammat3, at3] = FAIR(2,0,[],ht3);

% case 1 - T is known
[~, ht4, Prt4, phit4, Cpt4, Rt4, gammat4, at4] = FAIR(1,f,Tt4);
f4_5 = f*(1 - beta - epsilon1 - epsilon2)/(1 - beta);


[pi_tH, tau_tH, Tt4_5] = TURBC(Tt4, f, A4/A4_5, M4, M4_5, eta_tH, Tt4_5i, Tt3, beta, epsilon1, epsilon2);

[pi_tL, tau_tL, Tt5] = TURB(Tt4_5, f4_5, A4_5/A8, M4_5, M8, eta_tL, Tt5i);

tau_lambda = ht4/h0;

%% Compressor and engine mass flow:

tau_c = 1 + eta_mH*((1 - beta - epsilon1 - epsilon2)*(1+f) + epsilon1)*((tau_lambda*tau_m1*(1-tau_tH))/(tau_r)) - (C_TOH/eta_mPH);

ht3 = ht2*tau_c;
ht3i = ht2*(1 + eta_cH*(tau_cH - 1));

% case 2 - h is known
[Tt3, ~, Prt3, phit3, Cpt3, Rt3, gammat3, at3] = FAIR(2,0,[],ht3);
% case 2 - h is known
[Tt3i, ~, Prt3i, phit3i, Cpt3i, Rt3i, gammat3i, at3i] = FAIR(2,0,[],ht3i);

pi_c = Prt3i/Prt2;

ftemp = f;
% case 1 - T is known
[~, ht4, Prt4, phit4, Cpt4, Rt4, gammat4, at4] = FAIR(1,f,Tt4);
f = (ht4 - ht3)/(h_PR*eta_b - ht4);

while abs(f-ftemp) > 0.0001
    ftemp = f;
    [Tt4, ht4, Prt4, phit4, Cpt4, Rt4, gammat4, at4] = FAIR(1,f,Tt4);
    f = (ht4 - ht3)/(h_PR*eta_b - ht4);
end

Pt9_P0 = pi_r*pi_d*pi_c*pi_b*pi_tH*pi_tL*pi_n;

[M9_new, Tt_T9, ~, MFP9] = RGCOMPR (3, Tt5, [], f4_5, [], Pt9_P0, []);

M9_error = abs(M9-M9_new);

while M9_error > 0.01
    [M9_new, Tt_T9, ~, MFP9] = RGCOMPR (3, Tt5, [], f4_5, [], Pt9_P0, []);
    M9 = M9_new;
    M9_error = abs(M9-M9_new);
end

if M9 > 1
    M8 = 1;
else
    M8 = M9;
end

[~, Tt_T, Pt_P, MFP4] = RGCOMPR (1, Tt4, M4, f, [], [], []);


m0_dot_new = m0_dot_R *((1+f_R)/(1+f))*((P0*pi_r*pi_d*pi_c)/(P0_R*pi_r_R*pi_d_R*pi_c_R))*(MFP4/MFP4_R)*sqrt(Tt4_R/Tt4);

m0_dot_error = abs((m0_dot_new - m0_dot)/m0_dot_R);


while m0_dot_error > 0.001
    m0_dot = m0_dot_new;
    
    ht3 = ht2*tau_c;
    ht3i = ht2*(1 + eta_cH*(tau_cH - 1));

    [Tt3, ht3, Prt3, phit3, Cpt3, Rt3, gammat3, at3] = FAIR(2,0,[],ht3);
    [Tt3i, ht3i, Prt3i, phit3i, Cpt3i, Rt3i, gammat3i, at3i] = FAIR(2,0,[],ht3i);

    pi_c = Prt3i/Prt2;

    ftemp = f;

    [Tt4, ht4, Prt4, phit4, Cpt4, Rt4, gammat4, at4] = FAIR(1,f,Tt4);
    f = (ht4 - ht3)/(h_PR*eta_b - ht4);

    while abs(f-ftemp) > 0.0001
        ftemp = f;
        [Tt4, ht4, Prt4, phit4, Cpt4, Rt4, gammat4, at4] = FAIR(1,f,Tt4);
        f = (ht4 - ht3)/(h_PR*eta_b - ht4);
    end

    Pt9_P0 = pi_r*pi_d*pi_c*pi_b*pi_tH*pi_tL*pi_n;

    [M9_new, Tt_T9, ~, MFP9] = RGCOMPR (3, Tt5, [], f4_5, [], Pt9_P0, []);

    M9_error = abs(M9-M9_new);

    while M9_error > 0.01
        [M9_new, Tt_T9, ~, MFP9] = RGCOMPR (3, Tt5, [], f4_5, [], Pt9_P0, []);
        M9 = M9_new;
        M9_error = abs(M9-M9_new);
    end

    if M9 > 1
        M8 = 1;
    else
        M8 = M9;
    end

    [~, Tt_T, Pt_P, MFP4] = RGCOMPR (1, Tt4, M4, f, [], [], []);

    m0_dot_new = m0_dot_R *((1+f_R)/(1+f))*((P0*pi_r*pi_d*pi_c)/(P0_R*pi_r_R*pi_d_R*pi_c_R))*(MFP4/MFP4_R)*sqrt(Tt4_R/Tt4);
    
    m0_dot_error = abs((m0_dot_new - m0_dot)/m0_dot_R);
end

Tt9 = Tt5;

[~, Tt_T, Pt9_P9, MFP9] = RGCOMPR (1, Tt9, M9, f4_5, [], [], []);
P0_P9 = (Pt9_P9)/(Pt9_P0);
T9 = Tt9/Tt_T9;

[~, h9, Pr9, phi9, Cp9, R9, gamma9, a9] = FAIR(1,f4_5,T9);

V9 = M9*a9;

f0  = f*(1-beta-epsilon1-epsilon2);

C_TOL = C_TOL_R*(m0_dot_R/m0_dot)*(h0_R/h0);
C_TOH = C_TOL_R*(m0_dot_R/m0_dot)*(h0_R/h0);

C_c = (gamma0-1)*M0*((1+f0-beta)*(V0/a0) - M0 + (1+f0-beta)*((R9/R0)*(T9/T0/V9/a0)*((1-P0_P9)/gamma0)));
C_prop = eta_prop*eta_g*(eta_mL*(1+f0-beta)*tau_lambda*tau_m1*tau_tH*tau_m2*(1-tau_tL)-(C_TOL/eta_mPL));

C_TOTAL = C_prop+C_c;
P_m0_dot = C_TOTAL*h0;
P = m0_dot*C_TOTAL*h0;
S_P = f0/(C_TOTAL*h0);
F_m0_dot = (C_TOTAL*h0)/V0;
F = m0_dot*C_TOTAL*h0*V0;
S = f0/(F_m0_dot);

eta_P = C_TOTAL/(  (C_prop/eta_prop)  +  ((gamma0-1)/2)  *  ((1+f0-beta)*((V9/a0)^2)-M0^2));

eta_TH = (C_TOTAL + C_TOL + C_TOH)/(f0*h_PR/h0);

eta_O = eta_TH*eta_P;

[~, Tt_T, PtP, MFP0] = RGCOMPR (1, Tt0, M0, 0, [], [], []);

A0 = (m0_dot*sqrt(Tt0))/(P0*MFP0);

[~, ht4_5, Prt4_5, phit4_5, Cpt4_5, Rt4_5, gammat4_5, at4_5] = FAIR(1,f4_5,Tt4_5);

f4_5_R = f_R*(1-beta-epsilon1-epsilon2)/(1-beta);

[~, ht4_R, Prt4_R, phit4_R, Cpt4_R, Rt4_R, gammat4_R, at4_R] = FAIR(1,f_R,Tt4_R);

ht4_5_R = ht4_R*tau_m1_R*tau_tH_R*tau_m2_R

percent_N_L = 100*sqrt((ht4_5*(1-tau_tL))/(ht4_5_R*(1-tau_tL)))
percent_N_H = 100*sqrt((h0*tau_r*(tau_c-1))/(h0_R*tau_r_R*(tau_c_R-1)))
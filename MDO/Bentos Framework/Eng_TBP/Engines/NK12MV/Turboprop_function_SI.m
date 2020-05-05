
function [P_m0_dot,P,F_m0_dot,F,S,pi_c,f0,S_P,eta_P,eta_TH,eta_O,m0_dot] = Turboprop_function_SI(Tt4,Tt3_lim,pi_c_lim, M0,h)

%% Turboprop Engine Parametric Cycle Analysis
% Inputs:
% Flight parameters: M0, T0, P0
% Aircraft system parameters: Beta, CTOL, CTOH
% Design limitations:
% Fuel heating value: hPR
% Component figures of merit: pi_b, pi_dmax, pi_n,
%                             e_c, e_tH, e_tL
%                             eta_b, eta_mL, eta_mH, eta_mPL, eta_mPH,
%                             eta_prop
% Design choices: pi_c, tau_t, Tt4

% Outputs:
% Overall performance: F/m_dot_0, S, P/m_dot_0, S_P, f0, C_C, C_prop,
% eta_P, eta_TH, V9/a0
% Component behavior: pi_tH, pi_tL, tau_c, tau_tH, tau_tL, tau_lambda,f,
% eta_c, eta_tH, eta_tL, M9, Pt9/P9, P9/P0,, T9/T0
% Convertion factors
m2ft = 3.28084;
kgsecW2lbhrhp = 5918384.527;
kW2hp = 1.341;
N2lb = 0.2248;
% Inputs
%--------------Flight and Atmosphere-------------------------
% h = 25000;
% h = h;             % [ft]
ISADEV = 0;
atm=atmosphere(h,ISADEV);

% Flight parametres
P0 = atm(5);            % [KPa]
T0 = atm(1);            % [K]
% M0 = 0.8;

rho0 = atm(6);          % [kg/m3]
R_air = 287;            % [J/kg·K]


g_c = 1;                                     % [lbm*ft/lbf*s2]
g_0 = 9.81;

%--------------Aircraft system parameters-------------------------
beta = 0;
C_TOL = 0;
C_TOH = C_TOL;

%--------------Component figures of merit-------------------------
epsilon1 = 0.0; 
epsilon2 = 0.0;

pi_b = 0.94;
pi_d_max = 0.95;
pi_n = 0.99;

e_c = 0.9;
e_tH = 0.89;
e_tL = 0.91;

eta_b = 0.98;
eta_mL = 0.98;
eta_mH = 0.99;
eta_mPL = 0.95;
eta_mPH = 0.95;

eta_prop = 0.80;
eta_g = 0.95;

% h_PR = 42.8e6;       % Fuel heating value Kerosene
h_PR = 18400*2326;   % [J/kg]
%--------------Design Choices-------------------------
pi_c = 11;
tau_t = 0.65;
% Tt4 = 1778.778;      % [K]

%--------------Others-------------------------
m0_dot = 100*0.4536; % [kg/s]
% Execution
% in: T0 [K] | out: h0 [J/kg]; Pr0 [Pa]; R0 [J/KgK] ;  
[~, h0, Pr0,~,~,R0,gamma0,a0] = FAIR(1,0,T0); 
V0 = M0*a0;             % [m/s]
ht0 = h0 + (V0^2)/(2);  % [J/kg]

% in: ht0 [J/kg] | out: Prt0 [Pa]
[~, ~, Prt0, ~, ~, ~, ~, ~] = FAIR(2,0,[],ht0);
tau_r = ht0/h0;
pi_r = Prt0/Pr0;
pi_d = pi_d_max;
ht2 = ht0;                  % [J/kg]
Prt2 = Prt0;                % [Pa]
Prt3 = Prt2*pi_c^(1/e_c);   % [Pa]

% in: Prt3 [Pa]  | out: ht3 [J/kg]
[~, ht3, ~, ~, ~, ~, ~, ~] = FAIR(3,0,[],[],Prt3); 
tau_cL = ht3/ht2;
Prt3i = Prt2*pi_c;          % [psi]

% in: Prt3i [Pa]  | out: ht3i [J/kg]
[~, ht3i, ~, ~, ~, ~, ~, ~] = FAIR(3,0,[],[],Prt3i);
eta_c = (ht3i - ht2)/(ht3 - ht2);

% Set initial value of fuel/air ratio at station 4
f4i = 0.0676;
while true
% in: T4 [K]; f4i | out: ht4 [J/kg]
[~, ht4,~,~,~,~,~,~] = FAIR(1,f4i,Tt4);
f = (ht4 - ht3)/(eta_b*h_PR - ht4);  
    if abs(f-f4i) > 0.0001
        f4i = f;
    continue;
    end
break
end

M4 = 1;
[~,~,~,MFP4] = RGCOMPR(1, Tt4, M4, f, [], [], []);


tau_lambda = ht4/h0;
tau_m1 = ((1-beta - epsilon1 - epsilon2)*(1+f) + (epsilon1*tau_r*tau_cL/tau_lambda))/((1-beta - epsilon1 - epsilon2)*(1+f) + epsilon1);
tau_tH = 1 - ((tau_r*(tau_cL-1) + (C_TOL/(eta_mPH)))/(eta_mH*tau_lambda*((1-beta - epsilon1 - epsilon2)*(1+f) + (epsilon1*tau_r*tau_cL/tau_lambda))));
ht4_1 = ht4*tau_m1;         % [J/kg]
f4_1 = f/((1+f+epsilon1)/(1-beta-epsilon1-epsilon2));

% in: ht4_1 [J/kg]; f4_1 | out: Prt4_1 [Pa]
[~, ~, Prt4_1, ~, ~, ~, ~, ~] = FAIR(2,f4_1,[],ht4_1);
ht4_4 = ht4_1*tau_tH;       % [J/kg] 

% in: ht4_4 [J/kg]; f4_1 | out: Prt4_4 [Pa]
[~, ~, Prt4_4, ~, ~, ~, ~, ~] = FAIR(2,f4_1,[],ht4_4);
pi_tH = (Prt4_4/Prt4_1)^(1/e_tH);
Prt4_4i = pi_tH*Prt4_1; % [Pa]

% in: Prt4_4i [Pa]; f4_1 | out: ht4_4i [J/kg]
[~, ht4_4i, ~, ~, ~, ~, ~, ~] = FAIR(3,f4_1,[],[],Prt4_4i);
eta_tH = (ht4_1 - ht4_4)/(ht4_1 - ht4_4i);

tau_m2 = ((1-beta - epsilon1 - epsilon2)*(1+f) + epsilon1 +(epsilon2*((tau_r*tau_cL)/(tau_lambda*tau_m1*tau_tH))))/((1-beta - epsilon1 - epsilon2)*(1+f) + epsilon1 + epsilon2);

ht4_5 = ht4_4*tau_m2;       % [J/kg] 

f4_5 = f/(1+f+((epsilon1+epsilon2)/(1-beta-epsilon1-epsilon2)));

% in: ht4_5 [J/kg]; f4_5 | out: Prt4_5 [Pa]
[~, ~, Prt4_5, ~, ~, ~, ~, ~] = FAIR(2,f4_5,[],ht4_5);
tau_tL = tau_t/(tau_m1*tau_tH*tau_m2);
ht5 = ht4_5*tau_tL;       % [J/kg] 

% in: ht5 [J/kg]; f4_5 | out: Prt5 [Pa]; Tt5 [K]
[Tt5, ~, Prt5, ~, ~, ~, ~, ~] = FAIR(2,f4_5,[],ht5);
pi_tL = (Prt5/Prt4_5)^(1/e_tL);
Prt5i = pi_tL*Prt4_5;       % [Pa]

% in: Prt5i [Pa]; f4_5 | out: ht5i [J/kg]
[~, ht5i, ~, ~, ~, ~, ~, ~] = FAIR(3,f4_5,[],[],Prt5i);
eta_tL = (ht4_5 - ht5)/(ht4_5 - ht5i);

ht9 = ht5;       % [J/kg]
Tt9 = Tt5;       % [K]
Prt9 = Prt5;     % [Pa]
f9 = f4_5;

M9 = 1;

% in: Tt0 [K]; M; f9 | Tt_T9; Pt_P9 
[~,Tt_T9, Pt_P9,~] = RGCOMPR(1, Tt9, M9, f9, [], [], []);

Pt9_P0 = pi_r*pi_d*pi_c*pi_b*pi_tH*pi_tL*pi_n;


if Pt9_P0 >= Pt_P9
    T9 = Tt9/(Tt_T9);  %[K]
    % in: T9 [K]; f9 | out: h9 [J/kg]; Pr9 [Pa]; R9 [J/KgK]; a9 [m/s];
    [~, h9, Pr9, ~, ~, R9, ~, a9] = FAIR(1,f9,T9);
    P0_P9 = Pt_P9/Pt9_P0;
else
    Pr9 = Prt9/Pt9_P0;
    [T9, h9, ~, ~, ~, R9, ~, a9] = FAIR(3,f9,[],[],Pr9);
    P0_P9 = 1;
end
 
V9 = sqrt(2*g_c*(ht9-h9)); % [m/s]
M9 = V9/a9; 
f0 = f*(1-beta-epsilon1-epsilon2);
C_c = (gamma0-1) * M0 * ((1+f0-beta)*(V9/a0) - M0 + (1+f0-beta)*((R9/R0)*((T9/T0)/(V9/a0))*((1-P0_P9)/gamma0))); % dimensionless

% Propeller work interaction coefficient:
C_prop = eta_prop*eta_g*(eta_mL*(1+f0-beta)*tau_lambda*tau_m1*tau_tH*tau_m2*(1-tau_tL) - (C_TOL/eta_mPL)); % dimensionless

C_TOTAL = C_prop+C_c; % dimensionless

% Uninstalled specific power of the engine:
P_m0_dot = C_TOTAL*h0; % [J/Kg]

% Uninstalled power specific fuel consumption:
S_P = f0/(C_TOTAL*h0); % [1/J/Kg]
S_P = 1e6*(S_P); % [mg/W.s]
% Uninstalled equivalent specific thrust:
F_m0_dot = (C_TOTAL*h0)/V0; % [J.s/Kg.m]

% Uninstalled thrust specific fuel consumption:
% S = f0*V0/(C_TOTAL*h0); % [Kg.m/J.s]
S = (f0/(F_m0_dot));  % [Kg.m/J.s]
S_mg = S*1e6;  % [mg/N-s]

% Propulsive efficiency:
eta_P = C_TOTAL/(  (C_prop/eta_prop)  +  ((gamma0-1)/2)*  ((1+f0-beta)*((V9/a0)^2) - M0^2));

% Thermanl efficiency:
eta_TH = (C_TOTAL + C_TOL + C_TOH)/((f0*h_PR)/h0);



%% Turboprop Engine Performance Cycle Analysis

while true
%% Inputs
eta_cH = eta_c;
eta_prop_max = eta_prop;
% A's:
% A4 = 3;                                             % [ft2]
% A4_5 = 3;                                         % [ft2]
% A8 = 3;                                              % [ft2]

% A4_A4_5 = A4/A4_5;
% A4_5_A8 = A4/A8;
A4_A4_5 = 0.99;
A4_5_A8 = 0.4;


%--------------Reference Condition----------------

% Flight parameters:
M0_R = M0;
T0_R = T0;                                          % [R]
P0_R = P0;                                          % [psia]
h0_R = h0;
% Component behavior:
pi_c_R = pi_c;
pi_tH_R = pi_tH;
pi_tL_R = pi_tL;

pi_r_R = pi_r;
pi_d_R = pi_d;


tau_c_R = tau_cL;
tau_tH_R = tau_tH;
tau_tL_R = tau_tL;

tau_r_R = tau_r;
tau_cH = tau_cL;

MFP4_R = MFP4;

% Others:
Tt4_R = Tt4;                                        % [R]                                           
tau_m1_R = tau_m1;
tau_m2_R = tau_m2;
f_R = f;
M0_R = M0;
M8_R = M9;
C_TOL_R = C_TOL;
C_TOH_R = C_TOH;                                      % [lbf]
m0_dot_R = m0_dot;                                     % [lbm/sec]
S_R = S;                                       % [(lbm/hr)/lbf]

%--------------Engine Control Limits----------------
% pi_c_max = 30; 
% Tt3_max = 1600;                                     % [R]
% Pt3_max = 0;
% N_L_percent = 100;                                  % [%]
% N_H_percent = 100;                                  % [%]

% Others
Cp_c = 0.235;                                       % [Btu/lbm-R]
Cp_t = 0.295;                                       % [Btu/lbm-R]
g_c = 1;                                     % [lbm*ft/lbf*s2]
g_0 = 9.82;
% Preliminary Computations
% in: T0 [K] | out: h0 [J/kg]; Pr0 [Pa]; R0 [J/KgK] ;  
[~, h0, Pr0,~,~,R0,gamma0,a0] = FAIR(1,0,T0); 
% MFP4_R = M0_R*sqrt((gamma0)/R0)*(1 + ((gamma0-1)/2)*M0^2)^((gamma0+1)/(2*(1-gamma0))); % [(s*sqrt(R))/ft]




V0 = M0*a0;             % [m/s]
ht0 = h0 + (V0^2)/(2);  % [J/kg]

% in: ht0 [J/kg] | out: Prt0 [Pa]; Tt0 [K]
[Tt0, ~, Prt0, ~, ~, ~, ~, ~] = FAIR(2,0,[],ht0);
tau_r = ht0/h0;
pi_r = Prt0/Pr0;
if M0 <= 1
    pi_d = pi_d_max;
end

% eta_prop as function of Mach
if M0 <= 0.1
    eta_prop = 10*M0*eta_prop_max;
elseif M0 > 0.1 && M0 <= 0.7
    eta_prop = eta_prop_max;
elseif M0 > 0.7 && M0 <= 0.85
    eta_prop = (1 - (M0-0.7)/3)*eta_prop_max;
end

ht2 = ht0;      % [J/kg]
Prt2 = Prt0;    % [Pa]

% Set initial values

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

% Hig-pressure and low-pressure turbines:
% in: Tt4 [K]; f | out: ht4 [J/kg]
[~, ht4, ~, ~, ~, ~, ~, ~] = FAIR(1,f,Tt4);
ht4_5 = ht4*tau_m1*tau_tH*tau_m2;                                           
f4_5 = f*(1 - beta - epsilon1 - epsilon2)/(1 - beta);

% in: ht4_5 [J/kg]; f4_5 | out: Tt4_5i [K]
[Tt4_5i, ~, ~, ~, ~, ~, ~, ~] = FAIR(2,f4_5,[],ht4_5);
ht5 = ht4_5*tau_tL;      % [J/kg]

% in: ht5 [J/kg]; f4_5 | out: Tt5i [K]
[Tt5i, ~, ~, ~, ~,~,~,~] = FAIR(2,f4_5,[],ht5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loop 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
iterm0dot = 0;
m0_dot_error = 1;
m0_dot_new = 0;

while true

iterm0dot = iterm0dot+1;
    iterM = 0;
    M9_error = 1;
    M9_new = M8_R;
    while true
    iterM = iterM+1;    
    
    
    ht3 = ht2*tau_c;      % [J/kg]
    
    % in: ht3 [J/kg] | out: Tt3 [K]
    [Tt3, ~, ~, ~, ~, ~, ~, ~] = FAIR(2,0,[],ht3);
    % in: Tt4 [K]; f | out: ht4 [J/kg]
    [~, ht4, ~, ~, ~, ~, ~, ~] = FAIR(1,f,Tt4);
    
    f4_5 = f*(1 - beta - epsilon1 - epsilon2)/(1 - beta);
    
    % High pressure cooled turbine
    % in: Tt4 [K], f, A4_A4_5, M4, M4_5, eta_tH, Tt4_5i [K], Tt3 [K], beta, epsilon1, epsilon2 | out: Tt4_5 [J/kg]
    [pi_tH,tau_tH,Tt4_5] = TURBC(Tt4, f, A4_A4_5, M4, M4_5, eta_tH, Tt4_5i, Tt3, beta, epsilon1, epsilon2);
    % Low pressure turbine
    % in: Tti, f, (Ai /Ae), Mi, Me, Eta_t, TteR | out: pi_t, tau_t, Tte
    [pi_tL,tau_tL,Tt5] = TURB(Tt4_5, f4_5, A4_5_A8, M4_5, M8, eta_tL, Tt5i);

    tau_lambda = ht4/h0;

    % Compressor and engine mass flow:

    tau_c = 1 + (eta_mH*(((1 - beta - epsilon1 - epsilon2)*(1+f)) + epsilon1)*((tau_lambda*tau_m1*(1-tau_tH))/(tau_r))) - (C_TOH/eta_mPH);

    ht3 = ht2*tau_c;                          % [J/kg]
    ht3i = ht2*(1 + eta_cH*(tau_c - 1));      % [J/kg]

    % in: ht3 [J/kg] | out: Tt3 [K]
    [Tt3, ~, ~,~, ~, ~, ~, ~] = FAIR(2,0,[],ht3);
    % in: ht3i [J/kg] | out: Prt3i [Pa]
    [~, ~, Prt3i, ~, ~,~,~,~] = FAIR(2,0,[],ht3i);

    pi_c = Prt3i/Prt2;

    ftemp = f;
    
    % in: Tt4 [K]; f | out: ht4 [J/kg]
    [~, ht4,~, ~,~,~,~,~] = FAIR(1,f,Tt4);
    f = (ht4 - ht3)/(h_PR*eta_b - ht4);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    iterf = 0;
    while true
        iterf = iterf+1;
        % in: Tt4 [K]; f | out: ht4 [J/kg]
        [~, ht4,~, ~,~,~,~,~] = FAIR(1,f,Tt4);
        f = (ht4 - ht3)/(h_PR*eta_b - ht4);
        if abs(f-ftemp) > 0.0001
            ftemp = f;
            continue;
        end
        break;

    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Pt9_P0 = pi_r*pi_d*pi_c*pi_b*pi_tH*pi_tL*pi_n;
    % in: Tt5 [K]; f4_5; Pt9_P0 | M9_new; Tt_T9 
    [M9_new,Tt_T9,~,~] = RGCOMPR(3, Tt5, [], f4_5, [], Pt9_P0, []);
    

    M9_error = abs(M9-M9_new);
    if M9_error > 0.01
        M9 = M9_new;
        continue;
    end
    break
    end

  
if M9 > 1
    M8 = 1;
else
    M8 = M9;
end

% in: Tt4 [K]; M4; f | MFP4
[~,~,~,MFP4] = RGCOMPR(1, Tt4, M4, f, [], [], []);

m0_dot_new = m0_dot_R *((1+f_R)/(1+f))*((P0*pi_r*pi_d*pi_c)/(P0_R*pi_r_R*pi_d_R*pi_c_R))*...
    (MFP4/MFP4_R)*sqrt(Tt4_R/Tt4);                  % [kg/s]

m0_dot_error = abs((m0_dot_new - m0_dot)/m0_dot_R);                                     
if m0_dot_error > 0.001
    m0_dot = m0_dot_new; % [kg/s]
    continue;
end
break    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tt9 = Tt5; % [K]

% in: Tt9 [K]; M9; f4_5 | MFP4
[~, ~, Pt9_P9, MFP9] = RGCOMPR (1, Tt9, M9, f4_5, [], [], []);
P0_P9 = (Pt9_P9)/(Pt9_P0);
T9 = Tt9/Tt_T9;  % [K] 

% in: T9 [K]; f4_5 | out: R0 [J/KgK]; a9 [m/s]; 
[~,~, ~, ~, ~, R9, ~, a9] = FAIR(1,f4_5,T9);

V9 = M9*a9; % [m/s]

f0  = f*(1-beta-epsilon1-epsilon2);

C_TOL = C_TOL_R*(m0_dot_R/m0_dot)*(h0_R/h0);
C_TOH = C_TOL_R*(m0_dot_R/m0_dot)*(h0_R/h0);

C_c = (gamma0-1) * M0 * ((1+f0-beta)*(V9/a0) - M0 + (1+f0-beta)*((R9/R0)*((T9/T0)/(V9/a0))*((1-P0_P9)/gamma0))); % dimensionless

% Propeller work interaction coefficient:
C_prop = eta_prop*eta_g*(eta_mL*(1+f0-beta)*tau_lambda*tau_m1*tau_tH*tau_m2*(1-tau_tL) - (C_TOL/eta_mPL)); % dimensionless

C_TOTAL = C_prop+C_c; % dimensionless

% Uninstalled specific power of the engine:
P_m0_dot = C_TOTAL*h0; % [J/Kg]
P = m0_dot*C_TOTAL*h0;                        % [N.m/sec | Watts]

% Uninstalled power specific fuel consumption:
S_P = f0/(C_TOTAL*h0); % [1/J/Kg | kg/W*s] 
% S_P = 1e6*(S_P); % [mg/W.s]
S_P = 3.6e6*(S_P); % [kg/hkW]
% S_P = 5.918e6 *(S_P); % [lb/hrehp]



% Uninstalled equivalent specific thrust:
F_m0_dot = (C_TOTAL*h0)/V0; % [J.s/Kg.m]
F = F_m0_dot*m0_dot;  % [N]


% Uninstalled thrust specific fuel consumption:
% S = f0*V0/(C_TOTAL*h0); % [Kg.m/J.s]
S = (f0/(F_m0_dot));  % [Kg.m/J.s]
% S_mg = S*1e6;  % [mg/N-s]



eta_P = C_TOTAL/(  (C_prop/eta_prop)  +  ((gamma0-1)/2)*  ((1+f0-beta)*((V9/a0)^2) - M0^2));

eta_TH = (C_TOTAL + C_TOL + C_TOH)/((f0*h_PR)/h0);

eta_O = eta_TH*eta_P;

% in: Tt0 [K]; M0; f |  out: Tt_T, PtP, MFP0
[~, Tt_T, PtP, MFP0] = RGCOMPR (1, Tt0, M0, 0, [], [], []);

A0 = ((m0_dot*g_0)*sqrt(Tt0))/((P0) * MFP0);  % [m2]


% in: Tt4_5 [K]; f4_5 | out: ht4_5 [J/kg]
[~, ht4_5,~,~,~,~,~,~] = FAIR(1,f4_5,Tt4_5);
f4_5_R = f_R*(1-beta-epsilon1-epsilon2)/(1-beta);

% in: Tt4_R [K]; f_R | out: ht4_R [J/kg] 
[~, ht4_R,~,~,~,~,~,~] = FAIR(1,f_R,Tt4_R);

ht4_5_R = ht4_R*tau_m1_R*tau_tH_R*tau_m2_R;

percent_N_L = 100*sqrt((ht4_5*(1-tau_tL))/(ht4_5_R*(1-tau_tL_R)));
percent_N_H = 100*sqrt((h0*tau_r*(tau_c-1))/(h0_R*tau_r_R*(tau_c_R-1)));


if pi_c > pi_c_lim || Tt3 > Tt3_lim 
    
    
    Tt4_new = Tt4 -10;
    Tt4 = Tt4_new;
    continue;
end
break;
end
end
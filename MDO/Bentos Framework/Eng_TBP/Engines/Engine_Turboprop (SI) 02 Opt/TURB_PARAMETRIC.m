function [F_m0_dot,S,P_m0_dot,S_P,f0,C_c,C_prop,eta_P,eta_TH,V9_a0,...
    pi_tH,pi_tL,...
    tau_cL,tau_tH,tau_tL,tau_lambda,tau_m1,tau_m2,...
    f,...
    eta_c,eta_tH,eta_tL,...
    M9,Pt9_P9,P9_P0,Prt3_Prt2,T9_T0,...
    M0,T0,P0,F,P,pi_r,MFP4,h0,tau_r] = TURB_PARAMETRIC(h, M0,...
    beta, C_TOL, C_TOH,h_PR,...
    epsilon1,epsilon2,...
    pi_b, pi_dmax, pi_n,...
    e_c, e_tH, e_tL,...
    eta_b, eta_mL, eta_mH, eta_mPL, eta_mPH,eta_prop,eta_g,...
    pi_c, tau_t, Tt4,...
    m0_dot)

%% Turboprop Engine Parametric Cycle Analysis
% =========================================================================
% Inputs:
% Flight parameters: M0, T0, P0
% Aircraft system parameters: 
% Design limitations:
% Fuel heating value: hPR
% Component figures of merit: epsilon1,epsilon2,
%                             pi_b, pi_dmax, pi_n,
%                             e_c, e_tH, e_tL
%                             eta_b, eta_mL, eta_mH, eta_mPL, eta_mPH,
%                             eta_prop
% Design choices: pi_c, tau_t, Tt4

% Outputs:
% Overall performance: F/m_dot_0, S, P/m_dot_0, S_P, f0, C_C, C_prop,
% eta_P, eta_TH, V9/a0
% Component behavior: pi_tH, pi_tL, tau_c, tau_tH, tau_tL, tau_lambda,f,
% eta_c, eta_tH, eta_tL, M9, Pt9/P9, P9/P0,, T9/T0
% =========================================================================
%% Convertion factors
m2ft = 3.28084;
kgsecW2lbhrhp = 5918384.527;
kW2hp = 1.341;
N2lb = 0.2248;
% =========================================================================
%% Inputs
%--------------Flight and Atmosphere-------------------------
ISADEV = 0;
atm=atmosphere(h,ISADEV);

% Flight parametres
P0 = atm(5)*1000;            % [Pa]
T0 = atm(1);            % [K]
M0 = M0;

rho0 = atm(6);          % [kg/m3]
R_air = 287;            % [J/kg·K]

g_c = 1;
g_0 = 9.81;

%% Execution
% in: T0 [K] | out: h0 [J/kg]; Pr0 [Pa]; R0 [J/KgK] ;  
[~, h0, Pr0,~,~,R0,gamma0,a0] = FAIR(1,0,T0); 
V0 = M0*a0;             % [m/s]
ht0 = h0 + (V0^2)/(2);  % [J/kg]

% in: ht0 [J/kg] | out: Prt0 [Pa]
[~, ~, Prt0, ~, ~, ~, ~, ~] = FAIR(2,0,[],ht0);
tau_r = ht0/h0;
pi_r = Prt0/Pr0;



pi_d = pi_dmax;
ht2 = ht0;                  % [J/kg]
Prt2 = Prt0;                % [Pa]

% ate aqui igual===========================================================

Prt3 = Prt2*pi_c^(1/e_c);   % [Pa]

% in: Prt3 [Pa]  | out: ht3 [J/kg]
[~, ht3, ~, ~, ~, ~, ~, ~] = FAIR(3,0,[],[],Prt3); 
tau_cL = ht3/ht2;
Prt3i = Prt2*pi_c;          % [Pa]

% Overall pressure ratio

Prt3_Prt2 = Prt3/Prt2;


% in: Prt3i [Pa]  | out: ht3i [J/kg]
[~, ht3i, ~, ~, ~, ~, ~, ~] = FAIR(3,0,[],[],Prt3i);
eta_c = (ht3i - ht2)/(ht3 - ht2);

% Set initial value of fuel/air ratio at station 4
f4i = 0.03;
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
% tau_lambda = 7.049


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
Prt5i = pi_tL*Prt5;       % [Pa]

% in: Prt5i [Pa]; f4_5 | out: ht5i [J/kg]
[~, ht5i, ~, ~, ~, ~, ~, ~] = FAIR(3,f4_5,[],[],Prt5i);
eta_tL = (ht4_5 - ht5)/(ht4_5 - ht5i);

ht9 = ht5;       % [J/kg]
Tt9 = Tt5;       % [K]
Prt9 = Prt5;     % [Pa]
f9 = f4_5;

M9 = 1;

% in: Tt0 [K]; M; f9 | Tt_T9; Pt_P9 
[~,Tt9_T9, Pt9_P9,~] = RGCOMPR(1, Tt9, M9, f9, [], [], []);


Pt9_P0 = pi_r*pi_d*pi_c*pi_b*pi_tH*pi_tL*pi_n;


if Pt9_P0 >= Pt9_P9
    T9 = Tt9/(Tt9_T9);  %[K]
    % in: T9 [K]; f9 | out: h9 [J/kg]; Pr9 [Pa]; R9 [J/KgK]; a9 [m/s];
    [~, h9, Pr9, ~, ~, R9, ~, a9] = FAIR(1,f9,T9);
    P0_P9 = Pt9_P9/Pt9_P0;
else
    Pr9 = Prt9/Pt9_P0;
    [T9, h9, ~, ~, ~, R9, ~, a9] = FAIR(3,f9,[],[],Pr9);
    P0_P9 = 1;
end
 
P9_P0 = 1/P0_P9;
T9_T0 = T9/T0;

V9 = sqrt(2*g_c*(ht9-h9)); % [m/s]
M9 = V9/a9; 
f0 = f*(1-beta-epsilon1-epsilon2);
C_c = (gamma0-1) * M0 * ((1+f0-beta)*(V9/a0) - M0 + (1+f0-beta)*((R9/R0)*((T9/T0)/(V9/a0))*((1-P0_P9)/gamma0))); % dimensionless

V9_a0 = V9/a0;  % dimensionless

% Propeller work interaction coefficient:
C_prop = eta_prop*eta_g*(eta_mL*(1+f0-beta)*tau_lambda*tau_m1*tau_tH*tau_m2*(1-tau_tL) - (C_TOL/eta_mPL)); % dimensionless

C_TOTAL = C_prop+C_c; % dimensionless

% Uninstalled specific power of the engine:
P_m0_dot = C_TOTAL*h0; % [J/Kg]
%Power
P = m0_dot*C_TOTAL*h0; % [W]
% Uninstalled power specific fuel consumption:
S_P = f0/(C_TOTAL*h0); % [Kg/J]
S_P_mg = 1e6*(S_P); % [mg/W.s]

% Uninstalled equivalent specific thrust:
F_m0_dot = (C_TOTAL*h0)/V0; % [J.s/Kg.m]
% Thrust
F = F_m0_dot*m0_dot;  % [N]

% Uninstalled thrust specific fuel consumption:
% S = f0*V0/(C_TOTAL*h0); % [Kg.m/J.s]
S = (f0/(F_m0_dot));  % [Kg.m/J.s]
S_mg = S*1e6;  % [mg/N-s]

% Propulsive efficiency:
eta_P = C_TOTAL/(  (C_prop/eta_prop)  +  ((gamma0-1)/2)*((1+f0-beta)*((V9/a0)^2) - M0^2));

% Thermanl efficiency:
eta_TH = (C_TOTAL + C_TOL + C_TOH)/((f0*h_PR)/h0);
end

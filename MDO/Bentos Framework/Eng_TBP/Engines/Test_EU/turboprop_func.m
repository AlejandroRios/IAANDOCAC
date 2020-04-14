function [F_m0_dot,F,S,pi_c] = turboprop_func(Tt4,Tt3_lim,pi_c_lim, M0,altitude);
%% TURBOPROP ENGINE

% Throttle setting:
% Tt4 = 3500;                                         % [R]
while true

%% Convertion factors
BTU2ftlbf = 778.16;
ftlbf2BTU = 1/778.16;
psi2lbft2 = 144;
KPa2psi = 0.145038;
K2R = 1.8;

%% Inputs

% altitude = 25000;
ISADEV = 0;
%--------------Atmosphere-------------------------
atm=atmosphere(altitude,ISADEV);
P0 = atm(5)*KPa2psi;                             %[psia]
T0 = atm(1)*K2R;                                 % [R]

%--------------Performance Choices----------------

% Flight parameters:
% M0 = 0.8;
% T0 = 429.62;                                        % [R]
% P0 = 5.461;                                         % [psia]



%--------------Design Constants-------------------

% Compressor pressure ratio pi's:
pi_d_max = 0.97;            % Diffuser or inlet total pressure ratio
pi_b = 0.96;                % Burner total pressure ratio
pi_n = 0.99;                % Exhaust nozzle total pressure ratio

% Efficiencies eta's:
eta_c = 0.8755;             % Adiabatic efficiency of compressor
eta_tH = 0.8950;            % Adiabatic efficiency of high pressure turbine
eta_tL = 0.9212;            % Adiabatic efficiency of low pressure turbine
eta_b = 0.995;              % Adiabatic efficiency of burner
eta_mL = 0.99;              % Adiabatic efficiency of mechanical low pressure spool
eta_mH = 0.98;              % Adiabatic efficiency of mechanical high pressure spool
eta_mPL = 1;                % Adiabatic efficiency of mechanical pwr takeoff shaft from low pressure spool
eta_mPH = 1;                % Adiabatic efficiency of mechanical pwr takeoff shaft from high pressure spool
eta_prop_max = 0.82;        % Adiabatic efficiency of propeller

eta_g = 0.99;               % Adiabatic efficiency of gear
eta_cH = eta_c;             % Adiabatic efficiency of high pressure compressor

% A's:
A4 = 3;                                             % [ft2]
A4_5 = 3.5;                                         % [ft2]
A8 =6;                                              % [ft2]

A4_A4_5 = A4/A4_5;
A4_5_A8 = A4/A8;

% Others:
beta = 0;                                           % [degree]
epsilon1 = 0.05;                                    % Cooling air #1 mass flow rate
epsilon2 = epsilon1;                                % Cooling air #2 mass flow rate   
h_PR = 18400;                                       % [Btu/lbm]
P_TOL = 0;                                          % [kW]
P_TOH = 0;                                          % [kW]

C_TOL = 0;                                          % 
C_TOH = 0;
%--------------Reference Condition----------------

% Flight parameters:
M0_R = M0;
T0_R = T0;                                          % [R]
P0_R = P0;                                          % [psia]

% Component behavior:
pi_c_R = 30;                % Total pressure ratio accros the compressor
pi_tH_R = 0.3041;           % Total pressure ratio accros high pressure turbine
pi_tL_R = 0.1856;           % Total pressure ratio accros low pressure turbine
pi_r_R = 1.524;             % 
pi_d_R = 0.97;


tau_c_R = 2.9439;           % Total enthalpy ratio accros the compressor 
tau_tH_R = 0.7388;          % Total enthalpy ratio accros high pressure turbine
tau_tL_R = 0.6454;          % Total enthalpy ratio accros low pressure turbine

tau_r_R = 1.128;            % Adiatatic freestrem recovery
% tau_cH = tau_c_R;           % Total enthalpy ratio accros the compressor 


% Others:
Tt4_R = Tt4;                                        % [R]                                           
tau_m1_R = 0.9671;          % Total enthalpy ratio accros cooling air mixing process 1
tau_m2_R = 0.9758;          % Total enthalpy ratio accros cooling air mixing process 2
f_R = 0.03110;
M0_R = M0;
M8_R = 1;
C_TOL_R = 0;
C_TOH_R = 0;    
F_R = 21965;                                        % [lbf]
m0_dot_R = 100;                                     % [lbm/sec]
S_R = 0.4537;                                       % [(lbm/hr)/lbf]

%--------------Engine Control Limits----------------
pi_c_max = 30;              % Max total pressure ratio accros the compressor
Tt3_max = 1600;                                     % [R]
Pt3_max = 0;
N_L_percent = 100;                                  % [%]
N_H_percent = 100;                                  % [%]

% Others

gamma_c = 1.4;
gamma_t = 1.4;
Cp_c = 0.240;                                       % [Btu/lbm-R]
Cp_t = 0.295;                                       % [Btu/lbm-R]
g_c = 32.17405;                                     % [lbm*ft/lbf*s2]
g_0 = 32.17;
%% Preliminary Computations
% case 1 - T is known
[~, h0, Pr0, phi0, Cp0, R0, gamma0, a0] = FAIR(1,0,T0);
MFP4_R = M0_R*sqrt((gamma0*g_c)/R0)*(1 + ((gamma0-1)/2)*M0^2)^((gamma0+1)/(2*(1-gamma0))); % [(s*sqrt(R))/ft]
h0_R = h0;

V0 = M0*a0;                                         % [ft/s]

ht0 = (h0*BTU2ftlbf) + ((V0^2)/(2*g_c));         % [ft*lbf/lbm]
ht0 = ht0*ftlbf2BTU;                             % [BTU/lbm]

%case 2 - h is known
[Tt0, ~, Prt0, ~, ~, ~, ~, ~] = FAIR(2,0,[],ht0); % T [R]; 

tau_r = ht0/h0; % Adiatatic freestrem recovery
pi_r = Prt0/Pr0; % isentropic freestream recovery
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

ht2 = ht0;                                          % [BTU/lbm]
Prt2 = Prt0;                                        % [psia]

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
[~, ht4, ~, ~, ~, ~, ~, ~] = FAIR(1,f,Tt4);
ht4_5 = ht4*tau_m1*tau_tH*tau_m2;                   % [BTU/lbm]                                           
f4_5 = f*(1 - beta - epsilon1 - epsilon2)/(1 - beta);

% case 2 - h is known
[Tt4_5i, ~, ~, ~, ~, ~, ~, ~] = FAIR(2,f4_5,[],ht4_5);
ht5 = ht4_5*tau_tL;                                 % [BTU/lbm]  

% case 2 - h is known
[Tt5i, ~, ~, ~, ~,~,~,~] = FAIR(2,f4_5,[],ht5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Loop 1
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
    
    
    ht3 = ht2*tau_c;                                % [BTU/lbm]  
    
    % case 2 - h is known
    [Tt3, ~, ~, ~, ~, ~, ~, ~] = FAIR(2,0,[],ht3);
    % case 1 - T is known
    [~, ht4, ~, ~, ~, ~, ~, ~] = FAIR(1,f,Tt4);
    
    f4_5 = f*(1 - beta - epsilon1 - epsilon2)/(1 - beta);
    
    % High pressure cooled turbine
    [~, ~, Tt4_5] = TURBC(Tt4, f, A4_A4_5, M4, M4_5, eta_tH, Tt4_5i, Tt3, beta, epsilon1, epsilon2);
    % Low pressure turbine
    [~, ~, Tt5] = TURB(Tt4_5, f4_5, A4_5_A8, M4_5, M8, eta_tL, Tt5i);

    tau_lambda = ht4/h0;

    %% Compressor and engine mass flow:

    tau_c = 1 + (eta_mH*(((1 - beta - epsilon1 - epsilon2)*(1+f)) + epsilon1)*((tau_lambda*tau_m1*(1-tau_tH))/(tau_r))) - (C_TOH/eta_mPH);

    ht3 = ht2*tau_c;                                % [BTU/lbm]  
    ht3i = ht2*(1 + eta_cH*(tau_c - 1));            % [BTU/lbm]  

    % case 2 - h is known
    [Tt3, ~, ~,~, ~, ~, ~, ~] = FAIR(2,0,[],ht3);
    % case 2 - h is known
    [~, ~, Prt3i, ~, ~,~,~,~] = FAIR(2,0,[],ht3i);

    pi_c = Prt3i/Prt2;

    ftemp = f;
    
    % case 1 - T is known
    [~, ht4,~, ~,~,~,~,~] = FAIR(1,f,Tt4);
    f = (ht4 - ht3)/(h_PR*eta_b - ht4);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    iterf = 0;
    while true
        iterf = iterf+1;
        
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
    % Case 3 - Tt/t or Pt/P number known
    [M9_new,Tt_T9,~,~] = RGCOMPR (3, Tt5, [], f4_5, [], Pt9_P0, []);
    

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

% Case 1 - Mach number known
[~,~,~,MFP4] = RGCOMPR(1, Tt4, M4, f, [], [], []);

% MFP4_R = MFP4;

m0_dot_new = m0_dot_R *((1+f_R)/(1+f))*((P0*pi_r*pi_d*pi_c)/(P0_R*pi_r_R*pi_d_R*pi_c_R))*...
    (MFP4/MFP4_R)*sqrt(Tt4_R/Tt4);                  % [lbm/sec]

m0_dot_error = abs((m0_dot_new - m0_dot)/m0_dot_R);                                     
if m0_dot_error > 0.001
    m0_dot = m0_dot_new;
    continue;
    end
break    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tt9 = Tt5;

% Case 1 - Mach number known
[~, ~, Pt9_P9, MFP9] = RGCOMPR (1, Tt9, M9, f4_5, [], [], []);
P0_P9 = (Pt9_P9)/(Pt9_P0);
T9 = Tt9/Tt_T9;                                     % [R]

[~,~, ~, ~, ~, R9, ~, a9] = FAIR(1,f4_5,T9);

V9 = M9*a9;                                         % [ft/s]

f0  = f*(1-beta-epsilon1-epsilon2);

C_TOL = C_TOL_R*(m0_dot_R/m0_dot)*(h0_R/h0);
C_TOH = C_TOL_R*(m0_dot_R/m0_dot)*(h0_R/h0);

C_c = (gamma0-1) * M0 * ((1+f0-beta)*(V9/a0) - M0 + (1+f0-beta)*((R9/R0)*((T9/T0)/(V9/a0))*((1-P0_P9)/gamma0)));
C_prop = eta_prop*eta_g*(eta_mL*(1+f0-beta)*tau_lambda*tau_m1*tau_tH*tau_m2*(1-tau_tL) - (C_TOL/eta_mPL));

C_TOTAL = C_prop+C_c;
% P_m0_dot = C_TOTAL*h0*BTU_to_ftlbf/550;
P_m0_dot = C_TOTAL*h0/0.7068;
% P = m0_dot*C_TOTAL*h0;
P = P_m0_dot*m0_dot;                                                % [HP]
S_P = (f0/(C_TOTAL*h0/2544.5));
F_m0_dot = (C_TOTAL*h0*BTU2ftlbf)/V0;
F = F_m0_dot*m0_dot;                                                % [lbf]
S = (f0/(F_m0_dot))*3600;

% Propulsive efficiency
eta_P = C_TOTAL/(  (C_prop/eta_prop)  +  ((gamma0-1)/2)*  ((1+f0-beta)*((V9/a0)^2) - M0^2));

eta_TH = (C_TOTAL + C_TOL + C_TOH)/((f0*h_PR)/h0);

eta_O = eta_TH*eta_P;

[~, Tt_T, PtP, MFP0] = RGCOMPR (1, Tt0, M0, 0, [], [], []);

A0 = ((m0_dot*g_0)*sqrt(Tt0))/((P0*psi2lbft2) * MFP0);                                    % [ft2]

[~, ht4_5,~,~,~,~,~,~] = FAIR(1,f4_5,Tt4_5);

f4_5_R = f_R*(1-beta-epsilon1-epsilon2)/(1-beta);

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

% if pi_c > 30
%     fprintf('Compressor pressure ratio exceeded')
%     pi_c
%     
% end
% 
% if Tt3 > 1600
%     fprintf('Temperature at Tt3 exceeded')
%     Tt3_constraint = 0;
% else
%     Tt3_constraint = 1;
% end
% 
% 
% plot(Tt4,Tt3,'o')
% xlabel('Tt4')
% ylabel('Tt3')
% hold on
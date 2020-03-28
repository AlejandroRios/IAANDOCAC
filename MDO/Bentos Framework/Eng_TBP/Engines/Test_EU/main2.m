
clear all

%% Choices
% Flight parameters:
M0 = 0.1;
T0 = 288.2;             % [K]
P0 = 101.3;             % [KPa]
% Main burner exit temperature 
Tt4 = 1670;             % [K] 

%% Design constants

% Compressor pressure ratio pi's:
pi_d_max = 0.98;
pi_b = 0.94;
pi_tH = 0.2212;
pi_n = 0.98;
pi_c = 30;
pi_tL = 0.2537;

% Turbine temperature ratio tau's:
tau_tH = 0.7336;
tau_tL = 0.7497;
tau_c = 1;
tau_r_R = 0.55;
% Efficiencies eta's:
eta_c = 0.845;
eta_b = 0.995;
eta_tL = 0.9224;
eta_mL = 0.99;
eta_g = 0.99;
eta_p_max = 0.812;
eta_r = 1; 

% Gas properties:
gamma_c = 1.4;
gamma_t = 1.3;
Cp_c = 1.004;           % [kJ/(KgK)]
Cp_t = 1.235;           % [kJ/(KgK)]

% Fuel
h_PR = 42.800;          % [kJ/Kg]


% Outros
g_c = 1;
%% Reference conditions

% Flight parameters:
M0_R = M0;
T0_R = T0;          % [K]
P0_R = P0;          % [kPA]
tau_r = 1 + (gamma_c-1)/2 * M0^2;

tau_c = 1 + (Tt4/T0)/(Tt4/T0_R) * (tau_r_R)/tau_r * (tau_c-1);
pi_r_R = tau_r_R^(gamma_c/(gamma_c-1));

% Throttle setting:
Tt4_R = Tt4;            % [K]

% Component behavior:
pi_d_R = pi_d_max*eta_r;
pi_c_R = (1 + eta_c*(tau_c - 1))^(gamma_c/(gamma_c-1));
pi_tL_R = pi_tL;
tau_tL_R = 1 - eta_tL*(1 - pi_tL^((gamma_t-1)/gamma_t));

% Exhaust nozzle:
% M9_R

%% Equations


R_c = ((gamma_c-1)/gamma_c)*Cp_c;
R_t = ((gamma_t-1)/gamma_t)*Cp_t;

a0 = sqrt(gamma_c*(R_c*1000)*g_c*T0);           % [m/s]
V0 = a0*M0;             % [m/s]
tau_r = 1 + ((gamma_c-1)/2) * M0^2;
pi_r = tau_r^(gamma_c/(gamma_c-1));
eta_r =1;
pi_d = pi_d_max*eta_r;

tau_c = 1 + (Tt4/T0)/(Tt4/T0_R) * (tau_r_R)/tau_r * (tau_c-1);

pi_c = (1 + eta_c*(tau_c - 1))^(gamma_c/(gamma_c-1));

tau_lambda = (Cp_t*Tt4)/(Cp_c*T0);

f = (tau_lambda - (tau_r*tau_c))/((h_PR*eta_b)/(Cp_c*T0) - tau_r)
%% Outputs

% % Overall performance:
% F % [N]
% W_dot = % [kW]
% m_0_dot = % [kg/sec]
% S = % [(mg/sec])/N]
% S_p = % [(mg/sec])/N]
% f =
% eta_p
% eta_T
% eta_O
% C_c
% C_prop
% C_tot
% 
% % Component behavior
% pi_c
% tau_c
% pi_tL
% tau_tL
% f
% M9
% N_corespool
% N_powerspool



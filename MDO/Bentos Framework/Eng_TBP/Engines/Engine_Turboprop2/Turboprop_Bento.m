clear all
close all
clc
%% Global variables
global P0 T05 P05 eta_t eta_n gamma_t R_air 

%% Convertion factors
m2ft = 3.28084;
kgsecW2lbhrhp = 5918384.527;
kW2hp = 1.341;
N2lb = 0.2248;
%% Inputs

% Mode 0 design point | Mode 1 off design
mode = 1; 

% Flight altitude
if mode == 0
    h = 0;              % [m]
else
    h = 7620;           % [m]
end
h = h*m2ft;             % [ft]
ISADEV = 0;

% Atmospheric parameters
atm=atmosphere(h,ISADEV);

% Flight parametres
P0 = atm(5);            % [KPa]
T0 = atm(1);            % [K]
rho0 = atm(6);          % [kg/m3]
a0 = atm(7);            % [m/s]
R_air = 287;            % [J/kg·K]

if mode == 0
    M0 = 0.0;
else
    M0 = 0.38;
end

V0 = M0*a0;             % [m/s]
%% Design parameters

% Diffuser/Intake:
eta_d = 0.95;   % Diffuser adiabatic efficiency 
d_i = 0.328;    % Diffuser diameter at inlet [m2] 

% Compressor:
eta_c = 0.85;   % Compressor adiabatic efficiency
% pi_c = 11;    % Compression ratio
pi_c_LP = 3;    
pi_c_HP = 4.2;


% Burner
eta_b = 0.99;       % Burner adiabatic efficiency
Cp_b_exit = 1005;   % [J/Kg.K]
pi_b = 0.94;        % Turbine stagnation pressure losses

% Combustor exit stagnation temperature [K]
if mode == 0
    Tmax = 1466;
else
    Tmax = 1295;
%     Tmax = 1341; % normal cruise
%     Tmax = 1400;
%     Tmax = 1466; % max
end
q_R = 42.8e6;       % Fuel heating value

% Turbine
eta_t = 0.88;   % Turbine adiaba
eta_m = 0.98;   % Turbomachinery adiabatic efficiency
b = 0;          % bleed 
% eta_ft = 0.88;  


% Core nozzle
eta_n = 0.95;       % nozzle adiabatic efficiency
d_e = 0.32;         % core nozzle fixed exit diameter 
V_e = 170;          % Core exhaust speed
A_e = (pi*d_e^2)/4; % Nozzle exit-plane area


% Propeller
eta_pr = 0.82; % Proppeller propulsive efficiency

% Gearbox
eta_g = 0.98; % Gearbox efficiency

%% Execution
%% ---------------------------------------------------------------
% Starting from intake (diffuser):
[~,~,Prt2,~, ~,~, gamma_d, ~] = FAIR(1, 0, T0);

T02 = T0*(1 + (((gamma_d-1)/2) *M0^2));
% at diffuser outlet

P02 = P0*(1 + eta_d*((T02/T0)-1))^(gamma_d/(gamma_d-1));
% P02 = P0*(1 + eta_d*((gamma_d-1)/2)*M0^2)^((gamma_d/(gamma_d-1)));
% at diffuser outlet
%% ---------------------------------------------------------------
% Moving through compressor:
% ===================LP Compressor===================
% [~,~,~,~, Cp_c,~, gamma_c, ~] = FAIR(3, 0,[],[],P02);
[~,~,~,~, Cp_c_LP,~, gamma_c_LP, ~] = FAIR(1, 0, T02);

T03_LP = T02*(1 + (1/eta_c)*((pi_c_LP^((gamma_c_LP-1)/gamma_c_LP))-1));
% T03 = T02*(1 + (pi_c^((gamma_c-1)/gamma_c) -1)/eta_c)
% at compressor outlet

P03_LP = pi_c_LP*P02;
% at compressor outlet
% ===================HP Compressor===================
[~,~,~,~, Cp_c_HP,~, gamma_c_HP, ~] = FAIR(1, 0, T03_LP);

delta_hc = Cp_c_HP*T03_LP/eta_c*(pi_c_HP^((gamma_c_HP-1)/gamma_c_HP)-1);
delta_tc = delta_hc/Cp_c_HP;

T03_HP = T03_LP+ delta_tc;
% T03_HP = T02*(1 + (1/eta_c)*((pi_c_LP^((gamma_c_LP-1)/gamma_c_LP))-1));
% T03 = T02*(1 + (pi_c^((gamma_c-1)/gamma_c) -1)/eta_c)
% at compressor outlet

P03_HP = pi_c_HP*P03_LP;
% at compressor outlet

 % Specific work of the compressor
delta_hc =Cp_c_HP*(T03_LP-T02);

[~,~,Prt3,~, ~,~, ~, ~] = FAIR(1, 0, T03_HP);
pi_c = Prt3/Prt2;
%% ---------------------------------------------------------------
% Moving through combustor (burner):
T04 = Tmax;
[~,~,~,~, Cp_cc,~, gamma_cc, ~] = FAIR(1, 0, T04);

P04 = pi_b*P03_HP;
% at burner exit

T04_T03 = T04/T03_HP;

f = (T04_T03-(Cp_c_HP/Cp_b_exit))/(((eta_b*q_R)/(Cp_b_exit*T03_HP))-T04_T03);
% f = (Cp_cc*T04 - Cp_c*T03)/(eta_b*q_R - Cp_cc*T04)
%% ---------------------------------------------------------------
% Moving through the two turbine sections of the engine:
%% Gas generator turnine
[~,~,~,~, Cp_t,~, gamma_t, ~] = FAIR(1, f,T04);

% T05 = T04 - (1/eta_m)*(T03-T02);
T05 = T04 - (Cp_c_HP*(T03_HP-T02))/(Cp_t*eta_c*eta_m*(1+f-b));

% Cp_t = (gamma_t*R_air)/(gamma_t-1);

P05 = P04*(1 - ((1/eta_t)*(1-(T05/T04))))^(gamma_t/(gamma_t-1));
% P05 = P04*(1 - ((T04-T05)/(eta_t*T04)))^(gamma_t/(gamma_t-1));

% specific work generated by the turbine of the gas generator:
delta_t = Cp_t*(T04-T05)*(1+f-b); 

%% free turnine
[~,~,~,~, Cp_ft,~, gamma_ft, ~] = FAIR(1, f,T05);

fun = @functionT05;
T06 =  fminbnd(fun,0,1000);
P06 = P05*(1-(1/eta_t)*(1-(T06/T05)))^(gamma_t/(gamma_t-1));

delta_ft = Cp_ft*(1+f-b)*(T05-T06);
% at outlet of free turbine
%% No afterburner then:
T07 = T06;
P07 = P06;
%% Exit nozzle 
% Approaching subsonic converging nozzle, assume flow is unchoked
[~,~,~,~, Cp_n,~, gamma_n, ~] = FAIR(1, 0,T07);

P07_P0 = P07/P0;
criterion = ((gamma_n+1)/2)^(gamma_n/(gamma_n-1));

if criterion > P07_P0
  fprintf('nozzle flow is unchoked')  
else
    fprintf('CAUTION! nozzle flow is choked')  
end

T8 = T07*(P0/P07)^((gamma_n-1)/gamma_n);

if M0 > 0
V_e = V0*(eta_n/(eta_pr*eta_g*eta_m*eta_t));
end

M_e = V_e/sqrt(gamma_n*R_air*T8);

rho8 = P07*1000/(R_air*T8);
rho_e = rho8;

m_dot_e = rho_e*V_e*A_e;                            % [kg/s]

P_S_m_dot_a = Cp_t*eta_m*(T05-T06);                 % [W/(kg/s)]

m_dot_a = m_dot_e/(1 + f);                          % [kg/s]

P_S_W = m_dot_a* P_S_m_dot_a;                       % [W]
P_S_kW = P_S_W/1000;                                % [kW]
P_S_hp = P_S_kW*kW2hp;                              % [hp]

F_jet_net = (1+f-b)*m_dot_a*V_e - m_dot_a*V0;       % [N]

BSFC_shaft = f/(P_S_W/m_dot_a);                     % [kg/(sW)]

P_eq = P_S_hp + (F_jet_net*N2lb/2.5);               % [ehp]
P_eq_kW = P_eq*(1/kW2hp);                           % [kW]
P_eq_W = P_eq_kW*1000;                              % [W]

BSFC_eq = f/(P_eq_W/m_dot_a);                       % [kg/(sW)]

m_dot_f = f*m_dot_a;                                % [kg/s]


% % fprintf('\n Shaft power %i [kW]',round(P_S_kW))
% % fprintf('\n Thrust core jet exhaust  %i [N]',round(F_jet_net))
% % fprintf('\n Total effective power %i [ehp] ',round(P_eq))
% % fprintf('\n Thrust-specific fuel consumption shaft %5.3f [lb/h/ehp]  ',BSFC_shaft*kgsecW2lbhrhp)
% % fprintf('\n Thrust-specific fuel consumption %5.3f [lb/h/ehp]  ',BSFC_eq*kgsecW2lbhrhp)
% % fprintf('\n Turbine inlet total temperature %6.0f [K] ',T04)
% % fprintf('\n Mass flow rate through the LP compressor %5.2f kg/s ',m_dot_a)
% % fprintf('\n Fuel mass fraction %5.4f  ',f)
% % fprintf('\n Mach number at exit %6.3f ',M_e)
% % fprintf('\n Fuel flow rate %6.0f [kg/h]',m_dot_f*3600)
% % 
% %  %-------------------------------------------------------------------------
% %  figure(1)
% %  Tplot=[T0, T0,T02 , T03_HP, T04, T05, T06, T07, T8];
% %  staPlot=[0 1 2 3 4 5 6 7 8];
% %  plot(staPlot,Tplot,'b')
% %  text(1,T0,'LP Compressor','Rotation',90)
% %  text(2,T0,'HP Compressor','Rotation',90)
% %  text(3,T0,'Combustor','Rotation',90)
% %  text(4,T0,'HP Turbine','Rotation',90)
% %  text(5,T0,'LP Turbine','Rotation',90)
% %  text(6,T0,'Free Turbine','Rotation',90)
% %  text(7,T0,'Entering the Nozzle','Rotation',90)
% %  xlabel('Station')
% %  ylabel('Total Temperature [K]')
% %  figure (2)
% %  Pplot=[P0, P0,P03_LP, P03_HP, P04, P05, P06, P07, P07];
% %  plot(staPlot,round(Pplot),'r')
% %  text(1,P0,'LP Compressor','Rotation',90)
% %  text(2,P0,'HP Compressor','Rotation',90)
% %  text(3,P0,'Combustor','Rotation',90)
% %  text(4,P0,'HP Turbine','Rotation',90)
% %  text(5,P0,'LP Turbine','Rotation',90)
% %  text(6,P0,'Free Turbine','Rotation',90)
% %  text(7,P0,'Entering the Nozzle','Rotation',90)
% %  xlabel('Station')
% %  ylabel('Total Pressure [kPa]')
% % %--------------------------------------------------------------------------


function f = functionT05(X)

global P0 T05 P05 eta_t eta_n gamma_t R_air 

T06 = X(1);
P06 = P05 * (1 - (1/eta_t)*(1-(T06/T05))) ^ (gamma_t/(gamma_t-1));
T07 = T06;
P07 = P06;
[~,~,~,~, Cp_n,~, gamma_n, ~] = FAIR(1, 0,T07);

% Cp_n = (gamma_n*R_air)/(gamma_n-1);
% V_e = sqrt((2*eta_n*Cp_n*T07) * (1 - (P0/P07)^((gamma_n-1)/gamma_n)));
V_e = 170;

f1 = (T06*(1 - (P0/(P05 * (1 - (1/eta_t)*(1-(T06/T05)))^(gamma_t/(gamma_t-1))))^((gamma_n-1)/gamma_n)));
f2 = (V_e^2/(2*eta_n*Cp_n));

f =  f2/f1;
end


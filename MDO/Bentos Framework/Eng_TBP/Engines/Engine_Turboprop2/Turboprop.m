% clear all
% close all
% clc
%%
global P0 T04_5 eta_m Cp_t P04_5 eta_t eta_n gamma_t gamma_n R_air 

% convertion factors
m2ft = 3.28084;
%%

% atm(1)=temperatura isa [K]
% atm(2)=teta; 
% atm(3)=delta;
% atm(4)=sigma;
% atm(5)=pressure [KPa]
% atm(6)=air density [Kg/m�]
% atm(7)=sound speed [m/s]
% atm(8)= air viscosity

h = 0;
h = h*m2ft;
ISADEV = 0;
atm=atmosphere(h,ISADEV);

P0 = atm(5);
T0 = atm(1);
rho0 = atm(6);
a0 = atm(7);
M0 = 0;
V0 = M0/a0;
R_air = 287;

%% Design parameters
% Diffuser:
eta_d = 0.95;
% gamma_d = 1.4;

% Compressor:
eta_c = 0.85;
% gamma_c = 1.37;
% Cp_c = 1062;
pi_c = 12;
% pi_c = 11;

% Burner
eta_b = 0.99;
% gamma_b = 1.35;
Cp_b_exit = 1148;
pi_b = 0.94;
% Tmax = 1295;
Tmax = 1491;
q_R = 42.8e6;

% Turbine
% gamma_t = 1.33;
eta_t = 0.88;
eta_m = 0.98;

% Core nozzle
eta_n = 0.95;
% gamma_n = 1.36;

d_e = 0.3; % core nozzle fixed exit diameter 

% Core exhaust
V_e = 170;
% Nozzle exit-plane area
A_e = (pi*d_e^2)/4;

%% Execution
%---------------------------------------------------------------
% Starting from intake (diffuser):
[~,~,~,~, ~,~, gamma_d, ~] = FAIR(1, 0, T0);

T02 = T0*(1 + ((gamma_d-1)/2)*M0^2);
% at diffuser outlet

P02 = P0*(1 + eta_d*((T02/T0)-1))^(gamma_d/(gamma_d-1));
% at diffuser outlet

%---------------------------------------------------------------
% Moving through compressor:
[~,~,~,~, Cp_c,~, gamma_c, ~] = FAIR(3, 0,[],[],P02);
T03 = T02*(1 + (1/eta_c)*((pi_c^((gamma_c-1)/gamma_c))-1));
% at compressor outlet
P03 = pi_c*P02;
% at compressor outlet

%---------------------------------------------------------------
% Moving through combustor (burner):
Cp_b_exit = Cp_b_exit;

T04 = Tmax;

P04 = pi_b*P03;
% at burner exit

T04_T03 = T04/T03;

f = (T04_T03-(Cp_c/Cp_b_exit))/(((eta_b*q_R)/(Cp_b_exit*T03))-T04_T03);

%---------------------------------------------------------------
% Moving through the two turbine sections of the engine:
[~,~,~,~, Cp_t,~, gamma_t, ~] = FAIR(1, f,T04);

T04_5 = T04 - (1/eta_m)*(T03-T02);
% Cp_t = (gamma_t*R_air)/(gamma_t-1);

P04_5 = P04*(1 - ((1/eta_t)*(1-(T04_5/T04))))^(gamma_t/(gamma_t-1));
%% 

fun = @functionT05;
T05 =  fminbnd(fun,0,1000);

%%

P05 = P04_5*(1-(1/eta_t)*(1-(T05/T04_5)))^(gamma_t/(gamma_t-1));
% at outlet of free turbine

T06 = T05;
P06 = P05;

% Approaching subsonic converging nozzle, assume flow is unchoked
[~,~,~,~, Cp_n,~, gamma_n, ~] = FAIR(1, 0,T06);
T7 = T06*(P0/P06)^((gamma_n-1)/gamma_n);

M_e = V_e/sqrt(gamma_n*R_air*T7)

rho7 = P0*1000/(R_air*T7);
rho_e = rho7;
m_dot_e = rho_e*V_e*A_e;

P_S_m_dot_a = Cp_t*eta_m*(T04_5-T05);

m_dot_a = m_dot_e/(1 + f);

P_S = m_dot_a* P_S_m_dot_a;
P_S = P_S/1000;


% TP = 
F_jet_net = (1+f)*m_dot_a*V_e - m_dot_a*V0;

BSFC_shaft = f/(P_S/m_dot_a);

P_eq = P_S + (F_jet_net/2.5);

BSFC_eq = f/P_eq/m_dot_a;

m_dot_f = f*m_dot_a;


fprintf('\n Shaft power %i [kW]',round(P_S))
fprintf('\n Thrust core jet exhaust  %i [N]',round(F_jet_net))
fprintf('\n Total effective power %i [ehp] ',round(P_eq))
fprintf('\n Thrust-specific fuel consumption %5.3f [lb/h/ehp]  ',round(BSFC_eq))
fprintf('\n Turbine inlet total temperature %6.0f [K] ',T04)
% fprintf('\n Overall Pressure Ratio %6.1f ',prclp*prchp)
% fprintf('\n Mass flow rate through the LP compressor %5.2f kg/s ',ma)
fprintf('\n Fuel mass fraction %5.4f  ',f)
fprintf('\n Mach number at exit %6.3f ',M_e)

fprintf('\n Fuel flow rate %6.0f [kg/h]',m_dot_f*3600)




function f = functionT05(X)

global P0 T04_5 P04_5 eta_t eta_n gamma_t gamma_n R_air 

T05 = X(1);
P05 = P04_5 * (1 - (1/eta_t)*(1-(T05/T04_5))) ^ (gamma_t/(gamma_t-1));
T06 = T05;
P06 = P05;
[~,~,~,~, ~,~, gamma_n, ~] = FAIR(1, 0,T06);

Cp_n = (gamma_n*R_air)/(gamma_n-1);
V_e = sqrt((2*eta_n*Cp_n*T06) * (1 - (P0/P06)^((gamma_n-1)/gamma_n)));
V_e = 170;

f1 = (T05*(1 - (P0/(P04_5 * (1 - (1/eta_t)*(1-(T05/T04_5)))^(gamma_t/(gamma_t-1))))^((gamma_n-1)/gamma_n)));
f2 = (V_e^2/(2*eta_n*Cp_n));

f =  f2/f1;
end




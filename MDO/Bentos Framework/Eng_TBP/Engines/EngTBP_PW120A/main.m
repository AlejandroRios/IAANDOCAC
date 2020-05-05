clear all
close all
clc
%% Main function running turboprop
%%
% convertion factors
m2ft = 3.28084;
% kgsecW2lbhrhp = 5.918e6; 
kgsecW2lbhrhp = 5918384.527;
kW2hp = 1.341;
N2lb = 0.2248;
%%
% Input data
% M0 = 0.5;
% h = 6000; % [m]
% Tmax =1433;
% Tmax =1295; % [K]
% b = 0.06; % bleed
% 
% Mode 0 design point | Mode 1 off design
% mode = 1;
% 
% [P_S_kW,P_eq_kW,F_jet_net,BSFC_shaft,BSFC_eq,m_dot_a,m_dot_e,m_dot_f,f,M_e,TR]  = Turboprop_func(mode,b,Tmax,M0,h);

 %-------------------------------------------------------------------------
% fprintf('\n Shaft power %i [kW]',round(P_S_kW))
% fprintf('\n Thrust core jet exhaust  %i [N]',round(F_jet_net))
% fprintf('\n Total effective power %i [kW] ',round(P_eq_kW))
% fprintf('\n Thrust-specific fuel consumption shaft %5.3f [lb/h/ehp]  ',BSFC_shaft*kgsecW2lbhrhp)
% fprintf('\n Thrust-specific fuel consumption %5.3f [lb/h/ehp]  ',BSFC_eq*kgsecW2lbhrhp)
% fprintf('\n Turbine inlet total temperature %6.0f [K] ',Tmax)
% fprintf('\n Mass flow rate through the LP compressor %5.2f [kg/s] ',m_dot_a)
% fprintf('\n Fuel mass fraction %5.4f  ',f)
% fprintf('\n Mach number at exit %6.3f ',M_e)
% fprintf('\n Fuel flow rate %6.0f [kg/h]',m_dot_f*3600)
% fprintf('\n Throttle Ratio %5.4f', TR)
%%
%% Input data
M0 = linspace(0.1,0.7,10);
h = linspace(0,0,1);
Tt3_lim = 1500;
Tmax =1433;
b = 0.06;
mode = 1;
for i=1:10
    for j=1:1
%         [P_S_kW(i,j),V0(i,j),BSFC_eq(i,j),BSFC_shaft(i,j),F_jet_net(i,j),P_eq(i,j)] = Turboprop_func(mode,Tmax, M0(i),altitude(j));
        [P_S_kW(i,j),P_eq_kW(i,j),F_jet_net(i,j),BSFC_shaft(i,j),BSFC_eq(i,j),m_dot_a(i,j),m_dot_e(i,j),m_dot_f(i,j),f(i,j),M_e(i,j),TR(i,j)]= Turboprop_func(mode,b,Tmax,M0(i),h(j));
    end
end


%% 
% % Plots
figure(1)
plot(M0,BSFC_shaft*kgsecW2lbhrhp)
xlabel('M')
ylabel('BSFC_{shaft} [lb/h/ehp]')

figure(2)
plot(M0,round(P_S_kW))
xlabel('M')
ylabel('P_S [kW]')

figure(3)
plot(M0,round(F_jet_net))
xlabel('M')
ylabel('F_{jet} [N]')

figure(4)
plot(M0,m_dot_f*3600)
xlabel('M')
ylabel('Fuel flow rate [kg/h]')
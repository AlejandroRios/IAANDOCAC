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
%% Input data
M0 = 0.5;
altitude = 6000; % [m]

[P_S_kW,V0,BSFC_eq,BSFC_shaft,F_jet_net,P_eq] = Turboprop_func(mode,b,Tmax, M0,altitude)

%%
% % % %% Input data
% % % M0 = linspace(0.1,0.4,10);
% % % altitude = linspace(0,10000,3);
% % % Tt3_lim = 1500;
% % % Tmax =1295;
% % % mode = 1;
% % % for i=1:10
% % %     for j=1:3
% % %         [P_S_kW(i,j),V0(i,j),BSFC_eq(i,j),BSFC_shaft(i,j),F_jet_net(i,j),P_eq(i,j)] = Turboprop_func(mode,Tmax, M0(i),altitude(j));
% % %     end
% % % end
% % % 
% % % % Plots
% % % figure(1)
% % % plot(V0,BSFC_eq)
% % % xlabel('V0')
% % % ylabel('P_S')
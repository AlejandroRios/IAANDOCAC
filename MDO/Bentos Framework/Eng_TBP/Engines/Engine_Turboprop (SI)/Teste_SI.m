clear all
close all
clc


%% Input data

% Engine Limits 
pi_c_lim = 12.1;
Tt3_lim = 888;
Tt4_init = 1466.15; % [K] 

M0 = 0.166;
h = 0;

% [P_m0_dot,P,F_m0_dot,F,S,pi_c,f0,S_P,eta_P,eta_TH,eta_O,m0_dot] = Turboprop_function_SI(Tt4_init,Tt3_lim,pi_c_lim, M0,h);
[P_m0_dot,P,F_m0_dot,F,S,pi_c,f0,S_P,eta_P,eta_TH,eta_O,m0_dot,T0,Tt0,Tt3i,Tt3,Tt4,Tt4_5i,Tt4_5,Tt5i,Tt5,Tt9] = Turboprop_function_SI(Tt4_init,Tt3_lim,pi_c_lim, M0,h);
P/1000
S_P
F
%% Input data

% n = 10;
% M0 = linspace(0.1,0.8,n);
% h = linspace(0,30000,n);
% 
% % Engine Limits 
% pi_c_lim = 14;
% Tt3_lim = 888;
% Tt4_init = 1366;  
% 
% for i=1:n
%     for j=1:n
%        [P_m0_dot(i,j),P(i,j),F_m0_dot(i,j),F(i,j),S(i,j),pi_c(i,j),f0(i,j),S_P(i,j),eta_P(i,j),eta_TH(i,j),eta_O(i,j),m0_dot(i,j)] = Turboprop_function_SI(Tt4_init,Tt3_lim,pi_c_lim, M0(i),h(j))
%     end
% end

%%

% figure(1)
% plot(M0,P_m0_dot)
% xlabel('Mach')
% ylabel('P/m0 dot')
% % axis([0.1 1 18 32])
% grid on
% 
% figure(2)
% plot(M0,P)
% xlabel('Mach')
% ylabel('P [Watts]')
% % axis([0.1 1 0 15000])
% grid on
% 
% figure(3)
% plot(M0,F_m0_dot)
% xlabel('Mach')
% ylabel('Fm0dot')
% % axis([0.1 1 0 15000])
% grid on
% 
% figure(4)
% plot(M0,F)
% xlabel('Mach')
% ylabel('F [N]')
% % axis([0.1 1 0 15000])
% grid on
% 
% figure(5)
% plot(M0,S)
% xlabel('Mach')
% ylabel('S  [Kg.m/J.s]')
% % axis([0.1 1 0.1 0.6])
% grid on
% 
% figure(6)
% plot(M0,pi_c)
% xlabel('Mach')
% ylabel('\pi_c')
% % axis([0.1 15000 0 0.6])
% grid on
% 
% figure(7)
% plot(M0,f0)
% xlabel('Mach')
% ylabel('f0')
% % axis([0.1 15000 0 0.6])
% grid on
% 
% figure(8)
% plot(M0,S_P)
% xlabel('Mach')
% ylabel('S_P [kg/hkW]')
% % axis([0.1 15000 0 0.6])
% grid on
% 
% figure(9)
% plot(M0,m0_dot)
% xlabel('Mach')
% ylabel('m0dot [kg/s]')
% % axis([0.1 15000 0 0.6])
% grid on

%%

% fig3 = figure(3)
% % export to pdf
% set(fig3,'Units','Inches');
% pos = get(fig3,'Position');
% set(fig3,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(fig3,'09_3','-dpdf','-r0')



%%
T0,Tt0,Tt3i,Tt3,Tt4,Tt4_5i,Tt4_5,Tt5i,Tt5,Tt9
 %-------------------------------------------------------------------------
%  figure(1)
%  Tplot=[T0,T0,Tt3i,Tt3, Tt4, Tt4_5i, Tt4_5, Tt5i,Tt5, Tt9];
%  staPlot=[0 1 2 3 4 5 6 7 8 9];
%  plot(staPlot,Tplot,'b')
%  text(1,T0,'LP Compressor','Rotation',90)
%  text(2,T0,'HP Compressor','Rotation',90)
%  text(3,T0,'Combustor','Rotation',90)
%  text(4,T0,'HP Turbine','Rotation',90)
%  text(5,T0,'LP Turbine','Rotation',90)
%  text(6,T0,'Free Turbine','Rotation',90)
%  text(7,T0,'Entering the Nozzle','Rotation',90)
%  xlabel('Station')
%  ylabel('Total Temperature [K]')
%  figure (2)
%  Pplot=[P0, P0,P03_LP, P03_HP, P04, P05, P06, P07, P07];
%  plot(staPlot,round(Pplot),'r')
%  text(1,P0,'LP Compressor','Rotation',90)
%  text(2,P0,'HP Compressor','Rotation',90)
%  text(3,P0,'Combustor','Rotation',90)
%  text(4,P0,'HP Turbine','Rotation',90)
%  text(5,P0,'LP Turbine','Rotation',90)
%  text(6,P0,'Free Turbine','Rotation',90)
%  text(7,P0,'Entering the Nozzle','Rotation',90)
%  xlabel('Station')
%  ylabel('Total Pressure [kPa]')
%--------------------------------------------------------------------------
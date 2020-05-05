clear all
close all
clc


%% Input data

% Engine Limits 
pi_c_lim = 30;
Tt3_lim = 888.88;
Tt4_init = 1250;


M0 = 0.71;
h = 32808.4;

[P_m0_dot,P,F_m0_dot,F,S,pi_c,f0,S_P,eta_P,eta_TH,eta_O,m0_dot] = Turboprop_function_SI(Tt4_init,Tt3_lim,pi_c_lim, M0,h);

P/1000
S_P
F
% %% Input data
% 
% M0 = linspace(0.1,0.8,10);
% h = linspace(0,25000,10);
% 
% % Engine Limits 
% pi_c_lim = 30;
% Tt3_lim = 888.88;
% Tt4_init = 1777.778;
% 
% for i=1:10
%     for j=1:10
%        [F_m0_dot(i,j),F(i,j),S(i,j),pi_c(i,j)] = Turboprop_function_SI(Tt4_init,Tt3_lim,pi_c_lim, M0(i),h(j))
%     end
% end
% 
% %%
% figure(1)
% plot(M0,pi_c)
% xlabel('Mach')
% ylabel('\pi_c')
% % axis([0.1 1 18 32])
% grid on
% 
% figure(2)
% plot(M0,F)
% xlabel('Mach')
% ylabel('F [N]')
% % axis([0.1 1 0 15000])
% grid on
% 
% figure(3)
% plot(M0,S)
% xlabel('Mach')
% ylabel('S [(lbm/hr)/lbf]')
% % axis([0.1 1 0.1 0.6])
% grid on
% 
% figure(4)
% plot(F,S)
% xlabel('F [N]')
% ylabel('S [(lbm/hr)/lbf]')
% % axis([0.1 15000 0 0.6])
% grid on


%%

% fig3 = figure(3)
% % export to pdf
% set(fig3,'Units','Inches');
% pos = get(fig3,'Position');
% set(fig3,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% print(fig3,'09_3','-dpdf','-r0')

clear all
close all
clc

M0 = linspace(0.1,0.8,10);
altitude = linspace(0,30000,10);
Tt4 = 3200;  

%% Input data
% Engine Limits 
pi_c_lim = 30;
Tt3_lim = 1600;
Tt4_init = 3200;

for i=1:10
    for j=1:10
        [F_m0_dot(i,j),F(i,j),S(i,j),pi_c(i,j)] = turboprop_func(Tt4_init,Tt3_lim,pi_c_lim, M0(i),altitude(j));
    end
end

%%
figure(1)
plot(M0,pi_c)
xlabel('Mach')
ylabel('\pi_c')
axis([0.1 1 18 32])

figure(2)
plot(M0,F/32.2)
xlabel('Mach')
ylabel('F [lbf]')
axis([0.1 1 0 15000])

figure(3)
plot(M0,S)
xlabel('Mach')
ylabel('S [(lbm/hr)/lbf]')
axis([0.1 1 0.1 0.6])

figure(4)
plot(F/32.2,S)
xlabel('F [lbf]')
ylabel('S [(lbm/hr)/lbf]')
axis([0.1 15000 0 0.6])


%%

fig3 = figure(3)
% export to pdf
set(fig3,'Units','Inches');
pos = get(fig3,'Position');
set(fig3,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig3,'09_3','-dpdf','-r0')
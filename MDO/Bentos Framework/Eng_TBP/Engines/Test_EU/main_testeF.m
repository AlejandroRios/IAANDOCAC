
clear all
close all
clc

M0 = linspace(0.2,0.8,10);
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
axis([0 0.8 0 40])

figure(2)
plot(M0,F)
xlabel('Mach')
ylabel('F')

figure(3)
plot(M0,S)
xlabel('Mach')
ylabel('S')

figure(4)
plot(F,S)
xlabel('F')
ylabel('S')

figure(5)
plot(M0,Tt3)
xlabel('M0')
ylabel('Tt3')
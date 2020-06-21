clear all
close all
clc
%% Main function running turboprop
clear all
close all
clc
%%
% convertion factors
m2ft = 3.28084;
% kgsecW2lbhrhp = 5.918e6; 
kgsecW2lbhrhp = 5918384.527;
kW2hp = 1.341;
N2lb = 0.2248;
%%
M0 = linspace(0.1,0.7,30);
altitude = [0, 5000, 10000, 15000, 20000,25000];

%% Input data
% Engine Limits 

P = zeros();
S = zeros();
Tt4 = zeros();
for i=1:length(M0)
    for j=1:length(altitude)
       [P(i,j),S(i,j),F(i,j),Tt4(i,j),pi_c(i,j)]  = PW120model(M0(i),altitude(j));
    end
end

%%
figure(1)
plot(M0, S,'LineWidth',2)
xlabel('M0')
ylabel('S [lb/(hp h)]')
legend('0 [ft]', '5000', '10000', '15000', '20000','25000')

figure(2)
plot(M0,P,'LineWidth',2)
xlabel('M0')
ylabel('P_S [kW] ')
legend('0 [ft]', '5000', '10000', '15000', '20000','25000')
figure(3)
plot(M0,F,'LineWidth',2)
xlabel('M0')
ylabel('F [N]')
legend('0 [ft]', '5000', '10000', '15000', '20000','25000')
figure(4)
plot(M0,pi_c,'LineWidth',2)
xlabel('M0')
ylabel('pi_c')
legend('0 [ft]', '5000', '10000', '15000', '20000','25000')
figure(5)
plot(M0,Tt4,'LineWidth',2)
xlabel('M0')
ylabel('T [K]')
legend('0 [ft]', '5000', '10000', '15000', '20000','25000')
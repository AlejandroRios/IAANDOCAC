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
M0 = linspace(0.1,0.4,10);
altitude = linspace(0,10000,3);

%% Input data
% Engine Limits 
% pi_c_lim = 30;
Tt3_lim = 1500;
Tmax =1295;
mode = 1;
for i=1:10
    for j=1:3
        [P_S_kW(i,j),V0(i,j),BSFC_eq(i,j),BSFC_shaft(i,j),F_jet_net(i,j),P_eq(i,j)] = Turboprop_function(mode,Tmax, M0(i),altitude(j));
    end
end

%%
figure(1)
plot(V0,BSFC_eq)
xlabel('V0')
ylabel('P_S')


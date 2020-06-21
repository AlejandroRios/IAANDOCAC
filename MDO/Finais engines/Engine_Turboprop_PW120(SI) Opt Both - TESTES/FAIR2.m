function [h, Pr, phi, Cp, R, gamma, a] = unFAIR(T,FAR)
% This function calulates the gas properties as function of the fuel/air
% ratio. Equations and constants for air and combustion products
% were taken from Elements of Gas Turbines and Rockets [Mattingly].



R  = 1.9857117/(28.97-f*0.946186);
Cp = (Cp_air + f*Cp_prod)/(1+f);
h  = (h_air + f*h_prod)/(1+f);
phi = (phi_air + f*phi_prod)/(1+f);


Pr = exp((phi-phi_ref)/R)
end
clear all
close all
clc

M0 = linspace(0,0.8,100);

eta_prop= zeros();
for i=1:length(M0)
    M0(i)
    [eta_prop(i)]= eta(M0(i));
end

plot(M0,eta_prop)

function [eta_prop] = eta(M0)
eta_propmax = 0.95;

if M0 <= 0.1
    eta_prop = 10*M0*eta_propmax;
elseif M0 > 0.1 && M0 <= 0.7
    eta_prop = eta_propmax;
elseif M0 > 0.7 && M0 <= 0.85
    eta_prop = (1 - (M0-0.7)/3)*eta_propmax;
end

eta_prop = eta_prop;
end
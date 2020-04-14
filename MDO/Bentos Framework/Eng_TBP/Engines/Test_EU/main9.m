clear all
clc
close all

%% TURBOPROP ENGINE
%% Convertion factors
BTU_to_ftlbf = 778.16;
ftlbf_to_BTU = 1/778.16;
psi_to_lbft2 = 144;
KPa_to_psi = 0.145038;
K_to_R = 1.8;
ft_to_m = 0.3048;
%% Inputs
altitude = 25000;
ISADEV = 0;
%--------------Flight parameters-------------------------
atm=atmosphere(altitude,ISADEV);
P0 = atm(5);                            %[KPA]
T0 = atm(1);                            % [K]
M0 = 0.3;
%--------------System parameters-------------------------
h_PR = 42.8e6;                           % [J/Kg]

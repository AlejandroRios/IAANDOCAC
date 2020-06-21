%{
Function  : Fobjective
Descrip.  : Objective function for the error optimization of PW120 engine
Author    : Alejandro Rios
Email     : aarc.88@gmail.com
Language  : Matlab
PhD collaboration: ITA - Airbus
Aeronautical Institute of Technology
Date      : May/2020
%}

%--------------------------------------------------------------------------
% Funcao Objetivo
%--------------------------------------------------------------------------
function y = Fobjective(x)
% tic
try

[P_TO,ESFC_TO,P_cruise] = turb_sizing(x);

%% Take-off 
% max takeoff
P_TO_ref = 1566;
ESFC_TO_ref = 0.485;
P_TO_error = abs(P_TO - P_TO_ref )/P_TO_ref; 
ESFC_TO_error = abs(ESFC_TO - ESFC_TO_ref)/ESFC_TO_ref; 
y_TO = (P_TO_error + ESFC_TO_error )*100;
%% Cruise
% max cruise 25000 ft
P_cruise_ref = 1295;
% ESFC_cruise_ref = 0.303;
P_cruise_error = abs(P_cruise - P_cruise_ref )/P_cruise_ref;
y_cruise = (P_cruise_error)*100;
%% Total
y = y_TO+y_cruise;
catch ME
y =  1000;  
end
% toc
end
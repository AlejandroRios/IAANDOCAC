clear all
close all
clc

fixedW = 400;
R = 600*1852; %convert nmi to m
L_over_D = 10;
PSFC = 0.4*1.657e-06; %convert lbm/hr/bhp to 1/m
eta_prop = 0.8;

segments = {.98 %startup, runup, taxi, takeoff
.99 %climb
breguet('Prop','Cruise', R, L_over_D, PSFC, false, eta_prop)
.99}; %decent, landing, taxi, shutdown

fuel_safety_margin = 0.06;
FF = (1+fuel_safety_margin)*missionfuelburn(segments{:});

EWfunc = @(W0) 3.03*W0.^-.235;
W0 = fuelfractionsizing(EWfunc, fixedW, FF)
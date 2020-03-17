clc
clear

Alt         = 0;  % [m]
prclp       = 3;     % pressure ratio provided by LP compressor
prchp       = 4.2;   % pressure ratio provided by HP compressor
M_flight    = 0.12;
D_inlet     = 0.3280;
T0_4        = 1295;
Power_shaft = 1491;  % [kW]

[ehp, SFC, fmax]=tprop_design_bento(Alt,D_inlet,M_flight,...
        prclp,prchp,T0_4,Power_shaft)
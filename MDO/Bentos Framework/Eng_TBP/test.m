clear all
clc
% Ex. 10.8.1 M Sforza - Theory of Aerospace Propulsion pg 520
%%
eta_ad_c = 0.8;     % Turbine expansion efficiency
eta_ad_e = 0.9;     % Turbine expansion efficiency
eta_n = 0.9;        % Nozzle expansion efficiency
eta_b = 0.9;        % Combutor efficiency
eta_p = 0.8;        % Propulsive efficiency

pt2_pt0 = 0.9;      % Inlet pressure recovery 
pt3_pt2 = 6.5;      % Compressor pressure ratio
pt4pt3_pt3 = -0.05; % Burner pressure loss
pt4_pt3 = 1 + pt4pt3_pt3;

Q = 28.3;           % Volumetric flow rate m3/s

Qf = 44;            % Fuel heating value (MJ/kg) - Avgas
Tt4 = 1145;         % Turbine inlet temperature (K)

M0 = 0.7;           % Flight Mach number

p0 = 101.3;         % Pressure sea level p0 = 101.3 kPa
T0 = 288;           % Temperature sea level T0 = 288 K
a0 = 340.3;         % Speed of sound sea lever a0 = 340.3 m/s
%%
pt2 = pt2_pt0*p0*(1+(M0^2)/5)^3.5;
Tt0 = T0*(1+(M0^2)/5);
Tt2 = Tt0;
pt4 = pt4_pt3*pt3_pt2*pt2;
pt3 = pt3_pt2*pt2;
%% Non dimensional thrust power required

TP_pt2Q = eta_p *...
    (4*eta_ad_e*(Tt4/Tt0)*(1 - (p0/pt4)^(1/4)) - (3.5/eta_ad_c)*((pt3_pt2)^(2/7) -1))-...
    ((7*M0^2)/(5+M0^2))*(1-(1/(2*eta_p)));

% Thrust required 
TP = (pt2*1000)*Q*TP_pt2Q; % Watts







function SFC = Specific_Fuel_Consumption(M0)
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
Qf = Qf*1000;       % Fuel heating value (J/kg) - Avgas
Tt4 = 1145;         % Turbine inlet temperature (K)

M0 = M0;           % Flight Mach number

p0 = 101.3;         % Pressure sea level p0 = 101.3 kPa
T0 = 288;           % Temperature sea level T0 = 288 K
a0 = 340.3;         % Speed of sound sea lever a0 = 340.3 m/s
R = 0.287;          % kJ/KgK
R = R*1000;         % Nm/KgK

V0 = a0*M0;
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


%% Burner entry Temperature Tt3

Tt3 = Tt2 * (1 + (1/eta_ad_c)*(pt3_pt2^(2/7) - 1));

%% Fuel-to-air ratio

f_a = (1.15*Tt4 - Tt3)/(eta_b*Qf - 1.15*Tt4);

%% Airflow rate 

m_dot = (pt2*(1000)*Q)/(R*Tt2);

%% Fuel flow rate

mf_dot = f_a*m_dot;

%% Specific Fuel Consumption:

Ctp = (3600*mf_dot)/(TP/1000);

%% Engine Power Required 

SP = (TP/1000)/eta_p;

%% Nozzle exit velocity 

Ve = V0/eta_p;

%% Thrust contriburion from jet exhaust

Fn = m_dot*(Ve-V0);

%%

SFC = Ctp;
end



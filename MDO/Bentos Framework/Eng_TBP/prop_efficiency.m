function PropEfficiency=prop_efficiency(BHP, V, H, Dp, Nv)

%This routine estimates the propeller efficiency for a constant speed propeller,
%by iterating the propulsive disk equations with a user supplied viscous profile efficiency.

%  Input variables:
%   BHP = Engine horse power at condition in BHP
%   V   = Velocity at condition in ft/s
%   H   = Pressure Altitude in ft
%   Dp = Propeller diameter in ft
%   Nv = User entered viscous profile efficiency


%Presets

    A = 3.14159265358979 * Dp ^ 2 / 4;                  % Prop area (ftˆ2)

    rho = 0.002378 *(1 - 0.0000068756 * H) ^ 4.2561;    % Air density at pressure alt

    Np = 0.5;                                            % Initial propeller efficiency

% Check the value of V to prevent a function crash

    if V == 0 

        PropEfficiency = 0;

        return

    end

%Iterate to get a solution
Delta=1e06;

    while Delta >  1e-04

        T = Np*BHP*550/V ;                         %Thrust (lbf)
        w = 0.5 * (sqrt(V*V + 2*T /(rho*A)) - V);  %Induced velocity (ft/s)

        Ni = 1/ (1 + w / V);                            %Ideal efficiency

        Npnew = Nv * Ni; %New efficiency

        Delta = abs(Np - Npnew)  ;                      %Difference

        Np = Npnew;                                     %Set a new Np before next iteration

    end

    PropEfficiency = Np;

    end
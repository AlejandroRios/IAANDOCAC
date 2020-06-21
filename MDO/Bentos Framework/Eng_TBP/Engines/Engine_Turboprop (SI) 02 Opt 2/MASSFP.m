function [TtdT, PtdP, MFP] = MASSFP(Tt, f, M, ht, Prt, gammat, at)
BTU_to_ft_lb = 780;
% Inputs: Case, Tt, f, and M
% Outputs: Tt/T, Pt/P, and MFP
g_c = 1;             % [m/s]
gamman=NaN;R=NaN;Pr=NaN;T=NaN;

if nargin < 7
    % in: T0 [K]; f | out: ht [J/kg]; Prt [Pa]; R0 [J/KgK] ;
    [~, ht, Prt, ~, ~, ~, gammat, at] = FAIR(1, f, Tt);
end
Vguess = (M*at)/(1+((gammat-1)/2)*M^2);
fminsearch(@vals, Vguess);
function Verror = vals(V)
    h = ht - V^2/(2);
    [T, ~, Pr, ~, ~, R, gamman, a] = FAIR(2, f, [], h);
    Vn = M*a;
    if V ~= 0 
        Verror = abs((V-Vn)/V);
    else
        Verror = abs(V-Vn);
    end
end
TtdT = Tt/T;
PtdP = Prt/Pr;
MFP = (M/PtdP)*sqrt((gamman*g_c)/R*TtdT);
end


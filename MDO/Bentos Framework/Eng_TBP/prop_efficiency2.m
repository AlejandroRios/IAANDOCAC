function p_eta=prop_efficiency2(V0,P0,H)
%--------------------------------------------------------------------------
% Ref. Howe pg 67 e 68
%--------------------------------------------------------------------------
%  V0 forward speed m/s
%  P0 maximum  engine shaft power (kW)
%
nDp=63; % Large turbo propeller driven transport aircraft with up to six-bladed propeller



J=V0/nDp;

if J < 1
p_eta=0.82*(J^0.4);
else
j=0.30*((log10(J))^2.4);
p_eta=(0.82*(J^0.16))/(10^j);
end

% z is the number of propeller blades)
z=round(0.40*(P0^0.35))
z=max(6,z);

p_eta_max = 1.8*rho*(z^0.15)*(nDp^3.7)*J*(P0^0.095)/1e07;

p_eta=min(p_eta,p_eta_max);
end % function



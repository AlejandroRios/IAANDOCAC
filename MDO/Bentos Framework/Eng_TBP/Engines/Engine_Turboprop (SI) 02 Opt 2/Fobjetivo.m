%--------------------------------------------------------------------------
% Funcao Objetivo
%--------------------------------------------------------------------------
function y = Fobjetivo(x)

[P,ESFC] = turb_sizing(x);


Pow_ref = 1491;
ESFC_ref = 0.47;


P_error = abs(Pow_ref-P)^2;
ESFC_error = abs(ESFC_ref-ESFC)^2;

y = P_error + ESFC_error;
end
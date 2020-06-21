%--------------------------------------------------------------------------
% Funcao Objetivo
%--------------------------------------------------------------------------
function y = Fobjetivo(x)

[P,S_P] = turb_sizing(x);


P_ref = 1566;
ESFC_ref = 0.485;

% 
% P_error = abs(Pow_ref-P)^2;
% ESFC_error = abs(ESFC_ref-ESFC)^2;

P_error = abs((P) - P_ref)/P_ref;
ESFC_error = abs((S_P) - ESFC_ref )/ESFC_ref ;

y = P_error + ESFC_error;
end
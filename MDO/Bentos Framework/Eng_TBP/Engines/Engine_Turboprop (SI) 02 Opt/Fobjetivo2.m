%--------------------------------------------------------------------------
% Funcao Objetivo
%--------------------------------------------------------------------------
function y = Fobjetivo2(x)

[diffP,diffESFC]= turb_sizing2(x);


% max takeoff
% P_ref = 1566;
% ESFC_ref = 0.485;

% max cruise 25000 ft
% P_ref = 1231;
% ESFC_ref = 0.303;




% 
% P_error = abs(Pow_ref-P)^2;
% ESFC_error = abs(ESFC_ref-ESFC)^2;

% P_error = abs((P) - P_ref)/P_ref;
% ESFC_error = abs((S_P) - ESFC_ref )/ESFC_ref ;

y = (diffP);
% y = (P_error)*100;
end
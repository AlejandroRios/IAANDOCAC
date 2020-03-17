function [CL,CD, CD0,CDI,CDW]=Calc_ANN_CLCD_Alfa(X,winglet,netCDW,netCDI,netCD0,netCL)
% Estimaçao dos  coef. de arrasto e sustentação por redes neurais
% Configurações asa-fuselagemSEM WINGLET
%--------------------------------------------------------------------------
%  X(1)           0 0.85;     % Mach cruzeiro
%  X(2)           0 13000;    % Altitude [m]
%  X(3)           7 12;       % Alongamento
%  X(4)           0.3 0.5;    % Afilamento
%  X(5)           0 5;        % Diedro
%  X(6)           0.3 0.4;    % Posição da quebra (fração da semi-envergadura)
%  X(7)           2 4;        % Incidência na raiz
%  X(8)           -0.5 1.5;   % Incidência na quebra
%  X(9)           -5 1;       % Incidência na ponta
%  X(10)           40 250;    % Área da asa  [m2]
%  X(11)           -5 8;      % Ângulo de ataque [ grau]
%  X(12)           10 35;     % Enflechamento do bordo de ataque
%  X(13:18)                   % Dados do winglet
%  X(19:32)        0  1;      % pesos do aerofolio da raiz
%  X(33:46)        0  1;      % pesos do aerofolio da quebra
%  X(47:60)        0  1;      % pesos do aerofolio da ponta
%  X(61)                      % comprimento da fuselagem
%  X(62)                      % diametro da fuselagem central
%  X(63)                      % altura da fuselagem central
%  X(64)                      % Area molhada da fuselagem [m2]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Xx=X;

Xx(1:18)  = real2norm(X(1:18), 0);
Xx(61:64) = real2norm(X(61:64), 0);

if(~winglet)
   Xxx = [Xx(1:12) Xx(19:64)];
else
   Xxx = Xx;
end


CL=Calc_ANN_CL(Xxx,netCL);

CD0=Calc_ANN_CD0(Xxx,netCD0);
CDI=Calc_ANN_CDI(Xxx,netCDI);
CDW=Calc_ANN_CDW(Xxx,netCDW);

% 
CD=CD0+CDI+CDW;

clear Xx Xxxx
end % function
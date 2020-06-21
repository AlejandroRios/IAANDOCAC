function [ limites ] = limites_parametros(flag)
if(flag ~= 1)
limites = [0, 0.85;     % 1     : Mach cruzeiro
           0, 13000;    % 2     : Altitude
           7, 12;       % 3     : Alongamento
           0.3, 0.5;    % 4     : Afilamento
           0, 5;        % 5     : Diedro
           0.3, 0.4;    % 6     : Posi��o da quebra (fra��o da semi-envergadura)
           2, 4;        % 7     : Incid�ncia na raiz
           -0.5, 1.5;   % 8     : Incid�ncia na quebra
           -5, 1;       % 9     : Incid�ncia na ponta
           40, 250;     % 10    : �rea de refer�ncia da asa
           -5, 8;       % 11    : �ngulo de ataque
           10, 35;      % 12    : Enflechamento do bordo de ataque
           1.5, 3;      % 13    : Alongamento do winglet
           0.2, 0.5;    % 14    : Afilamento do winglet
           0.5, 0.7;    % 15    : Fra��o da corda da ponta da asa
           20, 35;      % 16    : Enflechamento do bordo de ataque do winglet
           10, 80;      % 17    : Diedro do winglet
           -5, 1];      % 18    : Tor��o do winglet
    limites(19:60,1)=0; % 19-60 : Pesos perfis
    limites(19:60,2)=1; % 19-60 : Pesos perfis
    limites(61,1)=20;   % 61    : Comp. da fuselagem
    limites(61,2)=40;   % 61    : Comp. da fuselagem
    limites(62,1)=2;    % 62    : Larg. da fuselagem
    limites(62,2)=6;    % 62    : Larg. da fuselagem
    limites(63,1)=2;    % 63    : Alt. da fuselagem
    limites(63,2)=6;    % 63    :Alt. da fuselagem
    limites(64,1)=200;  % 64    : Area molhada da fuselagem
    limites(64,2)=600;  % 64    : Area molhada da fuselagem
else
    limites = [-1.5 1.5;    % CMAlfa
           -1 2;            % CL
           0 0.1;           % CDF
           0 1;             % CDI
           0 0.3];          % CDW
end
end
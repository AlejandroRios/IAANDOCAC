%{
Function  : TURBC
Descrip.  : Solve a system of equations to determine the
            high-pressure turbine performance parameters.
            Based on Mattingly - Aircraft Engine Design
Author    : Alejandro Rios
Email     : aarc.88@gmail.com
Language  : Matlab
PhD collaboration: ITA - Airbus
Aeronautical Institute of Technology
Date      : May/2020
%}

function [pi_tH, Tau_tH, Tt4_5] = TURBC(Tt4, f, A4dA4_5, M4, M4_5, eta_tH, Tt4_5_R, Tt3, beta, epsilon1, epsilon2)
% Inputs: Tt4, f, (A4/A4_5), M4, M4_5, eta_tH, Tt4_5_R, Tt3, beta,
% epsilon1, espilon2
% Outputs: pi_tH, tau_tH, Tt4_5

[~, ht4, ~, ~, ~, ~, ~, ~] = FAIR(1, f, Tt4);
[~, ~, MFP4] = MASSFP(Tt4, f, M4);
[~, ht3, ~, ~, ~, ~, ~, ~] = FAIR(1, 0, Tt3);
m_dot_f = f*(1-beta-epsilon1-epsilon2);
m_dot_4 = (1+f)*(1-beta-epsilon1-epsilon2);
m_dot_4_1 = (1+f)*(1-beta-epsilon1-epsilon2) + epsilon1;
m_dot_4_5 = (1+f)*(1-beta-epsilon1-epsilon2) + epsilon1 + epsilon2;
f4_1 = m_dot_f/(m_dot_4_1-m_dot_f);
f4_5 = m_dot_f/(m_dot_4_5-m_dot_f);
ht4_1 = (m_dot_4*ht4+epsilon1*ht3)/(m_dot_4+epsilon1);
[~, ~, Prt4_1, ~, ~, ~, ~, ~] = FAIR(2, f4_1, [], ht4_1);
Tt4_5 = Tt4_5_R;

while true % Label 1
    [~, ~, MFP4_5] = MASSFP(Tt4_5, f4_5, M4_5);
    pi_tH = (m_dot_4_5/m_dot_4)*(MFP4/MFP4_5)*A4dA4_5*sqrt(Tt4_5/Tt4);
    [~, ~, ~, ~, ~, ~, ~, ~] = FAIR(1, f4_5, Tt4_5);
    Prt4_4i = pi_tH*Prt4_1;
    [~, ht4_4i, ~, ~, ~, ~, ~, ~] = FAIR(3, f4_1, [],[], Prt4_4i);
    ht4_4 = ht4_1-eta_tH*(ht4_1-ht4_4i);
    Tau_tH = ht4_4/ht4_1;
    ht4_5 = (m_dot_4_1*ht4_4+epsilon2*ht3)/(m_dot_4_1+epsilon2);
    [Tt4_5n, ~, ~, ~, ~, ~, ~, ~] = FAIR(2, f4_5, [], ht4_5);
    if abs(Tt4_5 - Tt4_5n) > 0.01
        Tt4_5 = Tt45n;
        continue; % Goto 1
    else
        break; %Exit Loop
    end
end
end
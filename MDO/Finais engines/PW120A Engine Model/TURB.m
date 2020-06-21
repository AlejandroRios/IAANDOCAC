%{
Function  : TURB
Descrip.  : Solve a system of equations to determine the
            low-pressure turbine performance parameters.
            Based on Mattingly - Aircraft Engine Design
Author    : Alejandro Rios
Email     : aarc.88@gmail.com
Language  : Matlab
PhD collaboration: ITA - Airbus
Aeronautical Institute of Technology
Date      : May/2020
%}

function [pi_t, Tau_t, T_te] = TURB(Tti, f, AidAe, Mi, Me, eta_ti, TteR)
% Inputs: Tti, f, (Ai /Ae), Mi, Me, eta_t, TteR
% Outputs: pi_t, Tau_t, Tte

[~, hti, Prti, phiti, cpti, Rti, gammati, ati] = FAIR(1, f, Tti);
[Ti, ~, MFPi] = MASSFP(Tti, f, Mi);
T_te = TteR;
while true % Label 1
    [Te, Pe, MFPe] = MASSFP(T_te, f, Me);
    [hte, Prte, phite, cpte, Rte, gammate, ate] = FAIR (1, f, T_te);
    pi_t = (MFPi/MFPe)*AidAe*sqrt(T_te/Tti);
    Prtei = pi_t*Prti;
    [Ttei, htei, ~, phitei, cptei, Rtei, gammatei, atei] = FAIR(3, f,[],[], Prtei);
    hte = hti - eta_ti*(hti - htei);
    Tau_t = (hte/hti);
    [Tten, ~, Prte, phite, cpte, Rte, gammate, ate] = FAIR(2, f,[], hte);
    Tte_error = abs(T_te - Tten);
    if Tte_error > 0.01
        T_te = Tten;
        continue; % Go to 1
    else 
        break;
    end
end


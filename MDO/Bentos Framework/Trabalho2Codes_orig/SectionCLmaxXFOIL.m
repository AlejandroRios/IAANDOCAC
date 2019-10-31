function [clmax_airfoil,flagsuc]=SectionCLmaxXFOIL(Mach,AirportElevation,PROOT,Craiz,...
    PKINK,Cquebra,PTIP,Cponta)
%
flagsuc = 0; % success flag, initially ok
% Conversion factors
%--------------------------------------------------------------------------
ft2m    = 0.3048;
m2ft    = 1./ft2m;
atm        = atmosfera(AirportElevation*m2ft,0);
    TAE    = atm(1); % temperatura [K]
%	T8     = TAE;
    ro     = atm(6); % densidade [Kg/m³]
    va     = atm(7); % velocidade do som [m/s]
% ***** air viscosity (begin)******
    mi0    = 18.27E-06;
    Tzero  = 291.15; % Reference temperature
    Ceh    = 120; % C = Sutherland's constant for the gaseous material in question
    mi     = mi0*((TAE+Ceh)/(Tzero+Ceh))*((TAE/Tzero)^1.5);
%--------------------------------------------------------------------------
Reynolds   = ro*Mach*va/mi;
cd Airfoil
% Root airfoil
nameroot=strrep(PROOT,'.dat','');
xfoil_sim_data.airfoil_name=nameroot;
xfoil_sim_data.id  = 1;
xfoil_sim_data.Mach = Mach;
xfoil_sim_data.Re = Reynolds*Craiz; % Reynolds number
[clmax,~,flagsuc1] = xfoil_run3(xfoil_sim_data);
if flagsuc1 > 0
    flagsuc=flagsuc1;
    cd ..
    return
end
clmax_airfoil(1) = clmax;
% Break station
namekink=strrep(PKINK,'.dat','');
xfoil_sim_data.airfoil_name=namekink;
xfoil_sim_data.Re = Reynolds*Cquebra; % Reynolds number
[clmax,~,flagsuc2] = xfoil_run3(xfoil_sim_data);
if flagsuc2 > 0
    flagsuc=flagsuc2;
    cd ..
    return
end
clmax_airfoil(2) = clmax;
% Tip station
nametip=strrep(PTIP,'.dat','');
xfoil_sim_data.airfoil_name=nametip;
xfoil_sim_data.Re = Reynolds*Cponta; % Reynolds number
[clmax,~,flagsuc3] = xfoil_run3(xfoil_sim_data);
if flagsuc3 > 0
    flagsuc=flagsuc3;
    cd ..
    return
end
clmax_airfoil(3) = clmax;
cd ..
clear nameroot namekink xfoil_sim_data
end % function
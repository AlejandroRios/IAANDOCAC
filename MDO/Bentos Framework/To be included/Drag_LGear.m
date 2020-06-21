function [CD_main, CD_nose]=Drag_LGear(nlg,mlg,nstrut,nmain,nnose,Sref)
% Ref: Drag Force and Drag Coefficient
% Sadraey M., Aircraft Performance Analysis, VDM Verlag Dr. Müller, 2009
%
%****************************************************************************
%   Inputs:
%          Dmain = Diametro do pneu do trem de pouso principal [m]
%          Dnose = Diametro do pneu do trem de pouso do nariz [m]
%          Wmain = Largura do pneu do trem de pouso principal [m]
%          Wnose = Largura do pneu do trem de pouso do nariz [m]
%          Lstrutmain = Comprimento do munhao do TDP principal [m]
%          Lstrutnose = Comprimento do munhao do TDP do nariz [m]
%          Dstrutmain = Diametro do munhao do TDP principal [m]
%          Dstrutnose = Diametro do munhao do TDP do nariz [m]
%          nstrut     = numero de munhoes do TDP principal
%          nmain      = numero d epneus do TDP principal por munhao
%          nnose      = numero de pneus do TDP do nariz 
%          Sref       = Wing reference area [m2]
%****************************************************************************
Dmain      = mlg.tyred;
Dnose      = nlg.tyred;
Wmain      = mlg.tyrew;
Wnose      = nlg.tyrew;
Lstrutmain = mlg.trupist;
Lstrutnose = nlg.trupist;
Dstrutmain = mlg.trudiam;
Dstrutnose = nlg.trudiam;
% Constants
CDLGw = 0.30; %(no fairing)
CDLGs = 1.2 ; % vertical cylinder LD infinity (Table 3.1)
%
Swheel_main = Dmain*Wmain;
Swheel_nose = Dnose*Wnose;
Sstrut_main = Lstrutmain*Dstrutmain;
Sstrut_nose = Lstrutnose*Dstrutnose;
% TDP principal 
CD_wheel_main = 0;
for i=1:nstrut
CD_wheel_main = CD_wheel_main+ CDLGw*nmain*Swheel_main/Sref;
end
CD_strut_main = nstrut*CDLGs*Sstrut_main/Sref;
CD_main       = CD_strut_main  + CD_wheel_main;
% TDP nariz
CD_wheel_nose = CDLGw*nnose*Swheel_nose/Sref;
CD_strut_nose = CDLGs*Sstrut_nose/Sref;
CD_nose       = CD_strut_nose  + CD_wheel_nose;
% Miscelleaneous drag
CD_main = 1.10*CD_main;
CD_nose = 1.10*CD_nose;
end
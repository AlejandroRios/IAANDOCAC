function mfuelloiter=loiter(altesp,Machesp,mesperai,tempespera,ctloiter,sw,...
    arw,phi14,afilam,wMAC,tcmed,nedebasa,df,Swet_tot)
% This routine calculates the amount of fuel burned during loiter
%--------------------------------------------------------------------------
dmfuelloiter = 1000;
mfuelloiter  = 50;
%vespera      = Machesp*vsom;
    bw=sqrt(arw*sw);
    cd0=cd0torenbeek(Machesp,sw,bw,wMAC,tcmed,df,altesp,Swet_tot);      
% Iteration is needed because Oswald's factor depends on speed
while dmfuelloiter > 3
eesp       = oswaldf(Machesp, arw, phi14, afilam, tcmed, nedebasa);
k          = 1/(pi*arw*eesp);
cd=2*cd0;
cl=sqrt(cd0/k);
ldmaxauton=cl/cd;

%Machesp = min(0.50,vespera/vsom);
tempesperah=tempespera/60;
T1=(tempesperah/ldmaxauton)*ctloiter;
fmassesp = 1/exp(T1);
newfuel=mesperai*(1-fmassesp);
dmfuelloiter=abs(newfuel-mfuelloiter);
mfuelloiter = newfuel;
end
%fprintf('\n Loiter Mach number: %4.2f \n',Machesp)
end % function
%--------------------------------------------------------------------------
function e=oswaldf(Mach,AR,phi14,afilam,tcmed,nedebasa)
% Oswald's factor calculation
% Reference: Prof. Dieter Scholz Hamburg Angewandte Wissenschaft
%               Universitaet
rad  = pi/180;
%
aux1 = 1+0.12*Mach^6;
aux2 = 0.1*(3*nedebasa+1)/((4+AR)^0.8);
fy   = 0.005*(1+1.5*(afilam-0.6)^2);
aux3 = (0.142+ fy*AR*((10*tcmed)^0.33))/(cos(phi14*rad)^2);
e    = 1/(aux1*(1+aux2+aux3));
end % function
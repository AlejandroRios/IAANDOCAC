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
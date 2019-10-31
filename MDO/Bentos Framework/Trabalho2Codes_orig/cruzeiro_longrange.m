function [mcombc,Mach_calc,time_cru]=cruzeiro_longrange(Hft,masscruzi,...
    arw,sw,wMAC,rangem,MMO,...
    afilam, nedebasa,phi14,df,ctref,Href,Mref,BPR,tcroot,tcbreak,tctip,...
    Swet_tot)
% This routine calculates the fuel mass burned during cruise
tcmed = (0.50*(tcroot+tcbreak) + 0.50*(tcbreak+tctip))/2; % average section max. thickness of the wing
%
atm   = atmosfera(Hft,0);
rhoi  = atm(6);
vsomi = atm(7);
mld   = -10000;
   
for NMach=0.65:0.01:MMO
ecruise = oswaldf(NMach, arw, phi14, afilam, tcmed, nedebasa);
 % Long-range lift coefficient
vcruzi  = NMach*vsomi;
bw      = sqrt(arw*sw); % wingspan
CD0     = cd0torenbeek(NMach,sw,bw,wMAC,tcmed,df,Hft,Swet_tot);
cl_long = masscruzi*9.81/(0.50*rhoi*sw*vcruzi*vcruzi);
%cdw     = cdwave(NMach,cl_long,phi14,tcmed); % wave drag
%CDw=CDW_DELFT(NMach,tcmed,cl_long,phi14,afilam,arw)
CDw=CDW_SHEVELL(phi14,MMO,NMach);
k       = 1/(pi*arw*ecruise);
cd      = CD0 + k*(cl_long^2) + CDw;
mldcalc = NMach*cl_long/cd;
%
    if mldcalc > mld
    mld       = mldcalc;
    Mach_calc = NMach;
%     Machmax = NMach;
    ct=TSFC(ctref,Href,Mref,BPR,Hft,NMach);
    masfrac   = exp((rangem*cd*ct)/(3600*cl_long*vcruzi));
    massfin   = masscruzi/masfrac;
    mcombc    = masscruzi-massfin; 
    time_cru  = rangem/(3600*Mach_calc*vsomi);  % [h]
    end
end % for
%fprintf(' \n Machmax: %4.2f L/D max : %5.2f \n', Machmax, mld/Machmax)

end % function
function cdwindmilli=CDWINDMILLTOREN(jmach,ediam,ebypass)
% Windmilling drag(Torenbeek)
%
VN               = 0.92; 
   if ebypass < 3.5
   VN = 0.42;
   end   
AN=pi*ediam*ediam/4;
term1=2/(1+0.16*jmach*jmach);
cdwindmilli=0.0785*(ediam*ediam)+term1*AN*VN*(1-VN);
end % function
function CDW=Calc_ANN_CDW(x,netCDW)
% Estima coeficiente de arrasto de onda
%--------------------------------------------------------------------------

CDWi=sim(netCDW,x');
iCD1=[0 0 0 0 CDWi];
CDest_poc=norm2real(iCD1,1);
CDW=max(0,CDest_poc(5));

clear y iCD1 CDest_poc

end
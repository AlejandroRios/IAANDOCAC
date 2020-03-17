function CDI=Calc_ANN_CDI(x,netCDI)

CDIi=sim(netCDI,x');
iCD1=[0 0 0 CDIi 0];
CDest_poc=norm2real(iCD1,1);
CDI=CDest_poc(4);

clear y iCD1 CDest_poc

end
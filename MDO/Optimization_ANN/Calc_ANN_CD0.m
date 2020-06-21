function CD0=Calc_ANN_CD0(x,netCD0)

CDF=sim(netCD0,x');
iCD1=[0 0 CDF 0 0];
CDest_poc=norm2real(iCD1,1);
CD0=CDest_poc(3);

clear y iCD1 CDest_poc

end
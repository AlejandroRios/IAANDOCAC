function CL=Calc_ANN_CL(x,netCL)


CLinter=sim(netCL,x');
iCL1=[0 CLinter 0 0 0];
CLest_poc=norm2real(iCL1,1);

CL=CLest_poc(2);

clear iCL1 CLest_poc

end % function
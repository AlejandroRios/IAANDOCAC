function [CLCD, CD]=calc_ANN_WLET(XX)

% --------------------- Load Trained Neural Networks ----------------------
tic
netCDI  = importdata('ANN_WLET_CDI_57000_60_40.mat');
netCDW  = importdata('ANN_WLET_CDW_57000_100_60.mat');
netCD0  = importdata('ANN_WLET_CD0_57000_100_60.mat');
netCL   = importdata('ANN_WLET_CL_57000_80_40.mat');

%--------------------------------------------------------------------------

winglet=true;



[CL,CD, CD0,CDI,CDW]=Calc_ANN_CLCD_Alfa(XX,winglet,netCDW,netCDI,netCD0,netCL);

CLCD=CL/CD;
fprintf('\n     Zero-lift drag: % 7.5f ',CD0)
fprintf('\n       Induced drag: % 7.5f ',CDI)
fprintf('\n          Wave drag: % 7.5f ',CDW)
fprintf('\n   Lift coefficient: % 5.3f ',CL)
fprintf('\n Lift-to-drag ratio: % 5.2f \n',CLCD)

toc

end % function

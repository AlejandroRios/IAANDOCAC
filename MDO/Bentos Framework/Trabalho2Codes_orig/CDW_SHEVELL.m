function DCDw=CDW_SHEVELL(phi14,MMO,M)
%--------------------------------------------------------------------------
rad=pi/180;
A=0.00057;
B=3.34821;
% A=0.001171;
% B=3.543;
%--------------------------------------------------------------------------
% MMO=0.77;
% phi14=17.5;
% M=0.70;
%
MDD=MMO+0.03;
auxcos=(cos(rad*phi14))^3;
T1=0.002/(A*auxcos);
T1 = B + atan(T1);
Mcrit= B*MDD/T1;

DCDw= auxcos*A*tan(B*(M/Mcrit) - B);
end % FUNCTION
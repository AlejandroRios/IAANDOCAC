function error=resolvecoef(airfoil_params,xp,ysup,yinf,Hte,EspBF)

% This functions regenerates coordiantes with given airfoil parameters
% and then check if they are close to de desired ones.

% airfoil leading edge radius (0.03 <> 0.15) ||| rBA
% airfoil thickness ratio (0.08 0.12) ||| t_c
% airfoil thickness line angle at trailing edge (-0.24 0.10) ||| phi
% airfoil maximum thickness chord-wise position (0.20 <> 0.46) ||| X_tcmax
% airfoil camber line angle at leading edge (-0.2 <> 0.1) ||| theta
% airfoil camber line angle at trailing edge (-0.300 -0.005) ||| epsilon
% airfoil maximum camber (0.00 <> 0.03) ||| Ycmax
% airfoil camber at maximum thichness chord-wise position (0.000 <> 0.025) ||| YCtcmax
% airfoil maximum camber chord-wise position (0.50 <> 0.80) ||| X_Ycmax

r0      = airfoil_params(1);
t_c     = airfoil_params(2);
phi     = airfoil_params(3);
X_tcmax = airfoil_params(4);
theta   = airfoil_params(5);
epsilon = airfoil_params(6);
Ycmax   = airfoil_params(7);
YCtcmax = airfoil_params(8);
X_Ycmax = airfoil_params(9);

%Generating sobieski coefficients
[A, B]=generate_sobieski_coeff(r0, phi, X_tcmax, t_c, theta, epsilon, X_Ycmax, Ycmax, YCtcmax, Hte, EspBF);

%Regenerating airfoil coordinates
[ysup_rev, yinf_rev] = generate_sobieski_coordinates(A,B,xp);

% Compute difference between coordinates
error = sum((ysup-ysup_rev).^2) + sum((yinf-yinf_rev).^2);
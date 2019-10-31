function [A_rev, B_rev]=generate_sobieski_coeff(rBA, phi, X_tcmax, t_c, theta, epsilon, X_Ycmax, Ycmax, YCtcmax, Hte, EspBF)

% These are constant parameters
%EspBF = 0.0025; % Trailing edge thickness
%Hte = 0.0; % Trailing edge height (distance to the chord-line)

%Thickness matrix
Mt = [1 0 0 0 0; ...
    2 2 2 2 2; ...
    2*sqrt(X_tcmax) 2*X_tcmax 2*X_tcmax^2 2*X_tcmax^3 2*X_tcmax^4; ...
    1/2/sqrt(X_tcmax) 1 2*X_tcmax 3*X_tcmax^2 4*X_tcmax^3; ...
    1 2 4 6 8];

xt = [sqrt(2*rBA); EspBF; t_c; 0; phi];

%Camber matrix
Mc = [1 0 0 0 0 0; ...
    1 2 3 4 5 6; ...
    X_Ycmax X_Ycmax^2 X_Ycmax^3 X_Ycmax^4 X_Ycmax^5 X_Ycmax^6; ...
    1 2*X_Ycmax 3*X_Ycmax^2 4*X_Ycmax^3 5*X_Ycmax^4 6*X_Ycmax^5; ...
    X_tcmax X_tcmax^2 X_tcmax^3 X_tcmax^4 X_tcmax^5 X_tcmax^6; ...
    1 1 1 1 1 1];

xc = [theta; epsilon; Ycmax; 0; YCtcmax; Hte];

%Solving systems
A_rev = Mt\xt;
B_rev = Mc\xc;

%%%%%%%%%%%%%%%%%%%%%%
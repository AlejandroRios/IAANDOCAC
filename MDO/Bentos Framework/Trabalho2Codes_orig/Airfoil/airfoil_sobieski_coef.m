%
function [r0, t_c, phi, X_tcmax, theta, epsilon, Ycmax, YCtcmax, X_Ycmax, xp, yu, yl ]=airfoil_sobieski_coef(fileToRead1)
%
% Read airfoil coordinates from file
[coordinates,~]=get_airfoil_coord(fileToRead1);
% Split x and y coordinates
xperfil=coordinates(:,1)';
yperfil=coordinates(:,2)';
nperfil=size(xperfil,2);
% Compute distance between consecutive points
ds=zeros(1,nperfil);
ds(1)=0;
for i=2:nperfil
    dx=xperfil(i)-xperfil(i-1);
    dy=yperfil(i)-yperfil(i-1);
    ds(i)=ds(i-1)+ sqrt(dx*dx+dy*dy);
end
% Find leading edge index
xa=xperfil(1);
xb=xperfil(2);
ind=1;
while xb < xa
    ind=ind+1;
    xa=xperfil(ind);
    xb=xperfil(ind+1);
end
% Generate chord-wise positions using cosine spacing
x_coordinates_nodes = 60;
xp = linspace(0,1,x_coordinates_nodes);
xp = fliplr(cos(xp*pi)/2+0.5);
% Interpolate upper skin
dsaux=ds(1:ind);
xaux=xperfil(1:ind);
dsinterp=spline(xaux,dsaux,xp); %Find skin positions that correspond to chordwise positions
ysup=spline(ds,yperfil,dsinterp); % Find vertical coordinate at given skin positions
% Interpolate lower skin
dsaux=[];
dsaux=ds(ind:nperfil);
dsinterp=[];
xaux=xperfil(ind:nperfil);
dsinterp=spline(xaux,dsaux,xp);
yinf=spline(ds,yperfil,dsinterp);
% Now get airfoil parameters that get closest to the required shape
% We will do this by minimizing the square error between computed and
% required coordinates.

% Define bounds for variables
LB=[0.015, 0.08,  -0.24, 0.20, -0.2, -0.300, -0.050, -0.050, 0.50, 0.0025, 0];
UB=[0.20, 0.16,   0.10, 0.46,  0.1, -0.005, 0.030, 0.025, 0.80, 0.0025, 0];
airfoil_params0=0.50*(UB+LB); %Set initial guess

% These airfoil parameters are constant
Hte = 0.0; %x(10);
EspBF = 0.0025; %x(11);

% MATLAB
options = optimset('Display','off','MaxFunEvals',10000,'TolFun',1e-8,'TolX',1e-8,...
    'MaxIter',19000,'DiffMinChange',1e-4,'Algorithm','sqp');
airfoil_params=fmincon(@(airfoil_params) resolvecoef(airfoil_params,xp,ysup,yinf,Hte,EspBF), airfoil_params0,[],[],[],[],LB,UB,[],options);

% OCTAVE
%airfoil_params0=0.50*(UB+LB);
%airfoil_params = sqp(airfoil_params0, @(airfoil_params) resolvecoef(airfoil_params,xp,ysup,yinf,Hte,EspBF), [], [], LB, UB);

% Split parameters
r0      = airfoil_params(1);
t_c     = airfoil_params(2);
phi     = airfoil_params(3);
X_tcmax = airfoil_params(4);
theta   = airfoil_params(5);
epsilon = airfoil_params(6);
Ycmax   = airfoil_params(7);
YCtcmax = airfoil_params(8);
X_Ycmax = airfoil_params(9);

% Get new coordinates with the final results
[a, b]=generate_sobieski_coeff(r0, phi, X_tcmax, t_c, theta, epsilon, X_Ycmax, Ycmax, YCtcmax, Hte, EspBF);
%
[yu, yl] = generate_sobieski_coordinates(a,b,xp);
%
plot(coordinates(:,1),coordinates(:,2),'-k')
hold on
plot(xp,yu,'b')
hold on
plot(xp,yl,'r')
hold on

clear ds
end
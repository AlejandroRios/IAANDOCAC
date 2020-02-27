clear all 
close all

n = 3;

%'Curve 1'
% t = linspace((3/4)*pi, (5/4)*pi, n);
t = linspace(-1.5, 1, n);
% x1 = cos(t);
% y1 = sin(t);
% x1 = t;
% y1 = t+1;
x1 = t;
y1 = t.*t + t - 1;

%'Curve 2'
% u = linspace((1/2)*pi, (3/2)*pi, n);
u = linspace(-1.5, 1, n);
% x2 = 2*cos(u);
% y2 = sin(u);
% x2 = u;
% y2 = u+2;
x2 = u;
y2 = 2 - u.*u;



% 'Euclidean distance'


A = [x1;y1];
B = [x2;y2];


% plot(x1,y1)
% hold on
% plot(x2,y2)

[hd D] = HausdorffDist(A,B,[],'visualize')
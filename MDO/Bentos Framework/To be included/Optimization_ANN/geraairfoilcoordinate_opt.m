%
function [xp, ysup, yinf ]=geraairfoilcoordinate_opt(np,fileToRead1)
%
% Read airfoil coordinates from file
[coordinates,~]=get_airfoil_coord_opt(fileToRead1);
% Split x and y coordinates
xperfil=coordinates(:,1)';
yperfil=coordinates(:,2)';
nperfil=size(xperfil,2);
% Compute distance between consecutive points
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
x_coordinates_nodes = np;
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
% hold on
% plot(xp,ysup,'xb')
% hold on
% plot(xp,yinf,'xr')
% hold on
end % function
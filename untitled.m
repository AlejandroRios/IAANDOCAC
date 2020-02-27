n = 2

t = linspace(3/4*pi,5/4*pi,n)
u = linspace((1/2)*pi, (3/2)*pi, n)

x1 = cos(t)
y1 = sin(t)
z1 = t
x2 = 2*cos(u)
y2 = sin(u)
z2 = 2*u

d = sqrt( (x2-x1).^2 + (y2-y1).^2 + (z2 - z1).^2 )

% cmax = 0
% for i=1:n
%     cmin = inf
%     for j=1:n
%     d = sqrt( (x2(j)-x1(i)).^2 + (y2(j)-y1(i)).^2 );
%     if d<cmax
%         cmin = 0;
%         break
%     end
%     cmin = min(cmin,d)
%     
%     end
%     cmax = max(cmax,cmin)
% end
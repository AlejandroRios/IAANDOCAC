function deltaY=FIND_DY(xu,yu)

n=size(xu,2);

ds=zeros(1,n);
ds(1)=0;
for i=2:n
dx=xu(i)-xu(i-1);
dy=yu(i)-yu(i-1);
ds(i)=ds(i-1)+sqrt(dx^2 + dy^2);
end % for
s015=spline(xu,ds,0.0015);
y015=spline(ds,yu,s015);
%
s6=spline(xu,ds,0.06);
y6=spline(ds,yu,s6);
deltaY=y6-y015;

clear ds dx dy
end %function
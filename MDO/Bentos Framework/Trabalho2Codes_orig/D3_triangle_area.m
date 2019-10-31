function A=D3_triangle_area(x,y,z)
% Area calculation of a 3D triangle
% x(1)=0;
% x(2)=2;
% x(3)=1;
% y(1)=0;
% y(2)=0;
% y(3)=5;
% z(1)=1;
% z(2)=1;
% z(3)=1;
%--------------------------------------------------------------------------
x1=x(1);
x2=x(2);
x3=x(3);
%
y1=y(1);
y2=y(2);
y3=y(3);
%
z1=z(1);
z2=z(2);
z3=z(3);
%A=sqrt(s*(s-a)*(s-b)*(s-c));
% Method  2
% https://math.stackexchange.com/questions/128991/how-to-calculate-area-of-3d-triangle
T1=(x2*y1 - x3*y1 - x1*y2 + x3*y2 + x1*y3 - x2*y3)^2;
T2=(x2*z1 - x3*z1 - x1*z2 + x3*z2 + x1*z3 - x2*z3)^2;
T3=(y2*z1 - y3*z1 - y1*z2 + y3*z2 + y1*z3 - y2*z3)^2;
A=(sqrt(T1+T2+T3)/2);
end % function
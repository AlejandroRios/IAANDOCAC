function [v0 pt0 Tt0]=inlet(R,g,T0,m0,p0,cp);
v0=(m0*((g*R*T0)^0.5));
pt0=((((1+(((g-1)*(m0^2))/2))^(g/(g-1)))*p0));
Tt0=(T0*(1+(((m0^2)*0.5*g*R)/cp)));
end
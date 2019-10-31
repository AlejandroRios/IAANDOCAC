function schrenk_lift_dist

clc
clear
b=24;
SW=41;
CL=0.50;
V=60;
L=CL*0.50*1.225*(V^2)*SW

n=30;
dx=(b/2)/(n-1);
eta=zeros(1,n);
V=4*L/(pi*b);
for i=1:n
 eta(i) = (i-1)*dx;   
 cl(i)  = ElipDist(eta(i),V,b);
end

plot(eta,cl,'b')
% fun =@(x,V,b) V*sqrt(1- (x.*2/b)^2 );
Soma=integral(@(x)ElipDist(x,V,b),0,b/2)

end  % function

function Valor=ElipDist(y,V,b)

Valor=V*sqrt(1- (y*2/b)^2 );
end
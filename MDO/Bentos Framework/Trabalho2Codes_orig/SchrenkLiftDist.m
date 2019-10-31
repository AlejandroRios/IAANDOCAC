function cl=SchrenkLiftDist(wS,wTR,wAR)
% Schrenk methodology for lift distribution
% clc
% clear
% close all
%
% wS=41;
% wAR=7;
% wTR=0.50;
b=sqrt(wAR*wS);
Croot=wS*2/(b*(1+wTR));
Ctip=Croot*wTR;
%--------------------------------------------------------------------------
n=30;
dalfa=(pi/2)/(n-1);
Chord_slope=(Ctip-Croot)/(b/2);
cl=zeros(1,n);
Celip=zeros(1,n);
Cwing=zeros(1,n);
Cschrenk=zeros(1,n);
for i=1:n
alfa=pi/2 - (i-1)*dalfa;
y(i)=b*cos(alfa)/2;
aux=y(i)/(b/2);
Celip(i)=((4*wS)/(pi*b))*sqrt(1- aux^2);
Cwing(i) = Croot + Chord_slope*y(i);
Cschrenk(i)=0.50*(Celip(i)+Cwing(i));
cl(i)=Cschrenk(i)/Cwing(i);
end

 plot(y/(b/2),cl,'b')
% 
% CL=0;
% for i=1:(n-1)
% dy=y(i+1)-y(i);
% CL = CL + (cl(i)+cl(i+1))*dy/2;
% end



end
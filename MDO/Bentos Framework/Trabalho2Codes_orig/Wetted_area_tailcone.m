function SWET_TC=Wetted_area_tailcone(fus_h,fus_w,lf,ltail)
% fus_h=3.3;
% fus_w=3.01;
% lf=30;
% ltail=7;
% Ellipse do final da cabina de passageiros
ai=fus_w/2;
bi=0.90*fus_h/2;
% Ellipse do final da fuselagem
af=0.250; % m
bf=0.30; % m
z0f=bi-bf;
%
np=20;
teta=(0:1/np:1)*pi;
%
xi(1:np)=lf-ltail;
zi=bi*cos(teta);
yi=ai*sin(teta);
%
xf(1:np)=lf;
zf=z0f + bf*cos(teta);
yf= af*sin(teta);
SWET_TC = 0;
for ie=1:(np-1)
xe(1)=xi(ie);
ye(1)=yi(ie);
ze(1)=zi(ie);
xe(2)=xf(ie);
ye(2)=yf(ie);
ze(2)=zf(ie);
xe(3)=xf(ie+1);
ye(3)=yf(ie+1);
ze(3)=zf(ie+1);
xe(4)=xi(ie+1);
ye(4)=yi(ie+1);
ze(4)=zi(ie+1);
xe(5)=xe(1);
ye(5)=ye(1);
ze(5)=ze(1);
% Triangle # 1
xt(1)=xe(1);
xt(2)=xe(2);
xt(3)=xe(4);
yt(1)=ye(1);
yt(2)=ye(2);
yt(3)=ye(4);
zt(1)=ze(1);
zt(2)=ze(2);
zt(3)=ze(4);
A1=D3_triangle_area(xt,yt,zt);
%  plot3(xt,yt,zt)
%  hold on
% Triangle # 2
xt(1)=xe(2);
xt(2)=xe(3);
xt(3)=xe(4);
yt(1)=ye(2);
yt(2)=ye(3);
yt(3)=ye(4);
zt(1)=ze(2);
zt(2)=ze(3);
zt(3)=ze(4);
A2=D3_triangle_area(xt,yt,zt);
%  plot3(xt,yt,zt)
%  hold on
SWET_TC = SWET_TC + A1 + A2;
end % for ie=1
%  axis equal
%  xlabel('x')
%  ylabel('y')
%  zlabel('z')
SWET_TC = 2*SWET_TC;
clear A1 A2 xt yt zt xe ye ze
end % function
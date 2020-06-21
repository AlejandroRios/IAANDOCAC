function [c,ceq]=ThicknessConstraint(x)
ceq=[];

% perfil da ponta e quebra
p1 = 'proot.dat';
p2 = 'quebra.dat';
p3 = 'ponta.dat';
p4 = 'naca12.dat';
%p5 = 'naca64a410.dat';
p5 = 'naca23012.dat';
p6 = 'naca652415.dat';
p7 = 'naca21010.dat';
p8 = 'ptipF100.dat';
p9= 'rae2822.dat';
p10= 'naca0009.dat';
p11= 'ptipE1m.dat';
p12= 'PQ3.dat';
p13= 'PR2.dat';
p14='kc135a.dat';
%--------------------------------------------------------------------------
p={p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14};
n=size(p,2);
%
xx=x(6:19);  %Tip-station airfoil
yy=sum(xx);
xxx=xx/yy; % weight normalization 
cd ..
np =60;
ypu(1:np)=0;
ypl(1:np)=0;
for j=1:n
fileToRead=char(p(j));
[~ , yuout, ylout ]=geraairfoilcoordinate(np,fileToRead);  
clear fileToRead
    for k=1:np
    ypu(k)=ypu(k)+xxx(j)*yuout(k);
    ypl(k)=ypl(k)+xxx(j)*ylout(k);
    end
end
%
thickness_p = 0;
for k=1:np
    thick=ypu(k)-ypl(k);
    if thick > thickness_p
        thickness_p = thick;
    end
end



% Aplica restricao que o 9,8% < esp da ponta < 11,5%

c(1)= thickness_p - 0.115;
c(2)= 0.098 - thickness_p;

  if c(1) > 0 || c(2) >  0
      fprintf('\n Unsuited airfoil configuration \n')
  end
  
  cd Optimization
  
  clear fileToRead ypu ypl thick p

end % function
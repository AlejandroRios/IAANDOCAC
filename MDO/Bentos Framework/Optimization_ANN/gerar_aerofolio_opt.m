function [xout, ypl, ypu]=gerar_aerofolio_opt(X)

%X=[0.00527063593126306,0.000166004171261627,0.999999718873761,0,0.000125484523318835,0.273963323794879,0.0229407425200868,0.0399743750286701,0.00396315462197663,0.0290174780370235,0.00692659256665422,1.03551528679084e-06,8.43149532495894e-06,4.14107297539258e-06]

% Banco de aerofólios:
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
xx=X;
yy=sum(xx);
xxx=xx/yy;
np =60;
ypu(1:np)=0;
ypl(1:np)=0;
for j=1:n
fileToRead=char(p(j));

[xout, yuout, ylout]=geraairfoilcoordinate_opt(np,fileToRead);  

%xistos=size(xout,2)
    for k=1:np
    ypu(k)=ypu(k)+xxx(j)*yuout(k);
    ypl(k)=ypl(k)+xxx(j)*ylout(k);
    end
end
%
% xuinv=xout(np:-1:2);
% yuinv=ypu(np:-1:2);
%
% Outputs airfoil file
% cd Airfoil
% fid=fopen(nome_arquivo,'w+');
% fprintf(fid,'XISTOS AIRFOIL COORDINATES \n');
% fprintf(fid,'%f  %f \n',[xuinv; yuinv]);
% fprintf(fid,'%f  %f \n',[xout; ypl]);
% fclose(fid);   
% cd ..
clear  yuout ylout xuinv yuinv p fid
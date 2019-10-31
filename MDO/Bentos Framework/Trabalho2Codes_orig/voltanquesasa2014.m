% Esta rotina computa 0 volume do tanque externo (entre a quebra e
% a raiz do aileron
yinterno=ymed1;
yexterno=ymed2;
%acha perfil externo
deltay=wingb/2-yinterno;


xuperfilext=xutip;
yuperfilext=yukink + ((yexterno-yinterno)/deltay)*(yutip-yukink);
ylperfilext=ylkink + ((yexterno-yinterno)/deltay)*(yltip-ylkink);
Cext = Cquebra + ((yexterno-yinterno)/deltay)*(Cponta-Cquebra);
heighte = ymed2-ymed1;
icount=0;
for i=1:1:nukink
    if xuperfilext(i) < limitepe && xuperfilext(i) >= limited
    icount=icount+1;
    xpolye(icount)=xuperfilext(i);
    ypolye(icount)=yuperfilext(i);
    xpolyi(icount)=xukink(i);
    ypolyi(icount)=yukink(i);
    end
end
for i=nukink:-1:1
    if xuperfilext(i) < limitepe && xuperfilext(i) >= limited
    icount=icount+1;
    xpolye(icount)=xuperfilext(i);
    ypolye(icount)=ylperfilext(i);
    xpolyi(icount)=xlkink(i);
    ypolyi(icount)=ylkink(i);
    end
end
%xistosxlkink=xlkink
%xistosylkink=ylkink
% a percentagem da corda na secao da raiz nao eh a memsma da long traseira
yinterno=yfusjunc;
yexterno=ymed3;
%xistosquebra=yquebra
%acha perfil externo
deltay=yquebra-yinterno;

gradaux= (yexterno-yinterno)/deltay;

xuperfilint=xuroot;
for j=1:size(xuroot,2)
yuperfilint(j)=yuroot(j) + gradaux*(yukink(j)-yuroot(j));
ylperfilint(j)=ylroot(j) + gradaux*(ylkink(j)-ylroot(j));
end
Csupint = Cinter + ((yexterno-yinterno)/deltay)*(Cquebra-Cinter);


limitedr = limited;

icount=0;
for i=1:1:size(xuroot,2)
    if xuperfilint(i) <= limitepi1 && xuperfilint(i) >= limitedr
    icount=icount+1;
    xpolyroot(icount)=xuroot(i);
    ypolyroot(icount)=yuperfilint(i);
    end
end
%xistosxlroot=xlroot
%xistosylroot=ylroot
for i=size(xuroot,2):-1:1
    if xuperfilint(i) <= limitepi1 && xuperfilint(i) >= limitedr
    icount=icount+1;
    xpolyroot(icount)=xuroot(i);
    ypolyroot(icount)=ylperfilint(i);
    end
end
%
% Area molhada no perfil da interseccao asa-fuselagem
icount=0;

for i=1:1:size(xuroot,2)
    if xuroot(i) <= limitepi2 && xuroot(i) >= limitedr
    icount=icount+1;
    xpolyroot1(icount)=xuroot(i);
    ypolyroot1(icount)=yuroot(i);
    end
end
%xistosxlroot=xlroot
%xistosylroot=ylroot
for i=size(xuroot,2):-1:1
    if xuroot(i) <= limitepi2 && xuroot(i) >= limitedr
    icount=icount+1;
    xpolyroot1(icount)=xuroot(i);
    ypolyroot1(icount)=ylroot(i);
    end
end
%
areae=polyarea(xpolye,ypolye)*Cext*Cext;
areai=polyarea(xpolyi,ypolyi)*Cquebra*Cquebra;
arearootsup=polyarea(xpolyroot,ypolyroot)*Csupint*Csupint;
arearootinf=polyarea(xpolyroot1,ypolyroot1)*Cinter*Cinter;
% Calculo dos volumes
voltanqueext=0.98*(heighte/3)*(areai + areae + sqrt(areai*areae)); % 2% de perdas devido a nervuras, revestimento e outros equip
voltanqueint=0.98*(deltay/3)*(arearootinf + arearootsup + sqrt(arearootinf*arearootsup)); % 2% de perdas devido a nervuras, revestimento e outros equip
%



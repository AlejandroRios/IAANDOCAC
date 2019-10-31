function [posxmunhao, xcgtanques, wingfuelcapacitykg,aflape]= ...
    winglaywei2018a(planffusdf,wingcrank,wingsweepLE, wingb,...
    longtras, slat,Ccentro,Cquebra, Cponta,PEng, xutip, yutip, ...
   yltip, xukink,xlkink, yukink, ylkink, xuroot, xlroot, yuroot, ylroot )
% Generates wing structural layout and estimates fuel storage
% Author: Bento Mattos
% Version 2013R3b

% OBS: Wing leading edge must be of constant sweep
% Input:
% poslongtras = Posicao da longarina traseira (fracional)
% AR = Wing aspect ratio;
% Chord at fuselage centerline (CRaiz)
% Chord at wingtip (Cponta)
% Chord at kink station (Cquebra)
% PSILE: Leading-edge sweepback angle
% Aileron basis as semi-span fraction (posaileron)
% If the wing has slat device (slat = 1 means yes; otherwise no slat)
% Location of the kink station as semi-span fraction (wing.ybreak)

% Initialization
rad            = pi/180;
wingfuelcapacitykg = 0;
nukink         = size(yukink,2);
%
nervspacing  = 22; % (pol) Roskam Vol III pg 220 suggests 24
nervspacm    = nervspacing* 0.0254;  %cm)
denquerosene = 803; % jet A1 density
% longtras     = 0.72;
angquebralongtras=0;
%
diamfus     = planffusdf;
% Craiz       = Craiz;
% Cponta      = wingct;
% Cquebra     = wingc1;
fquebra     = wingcrank;
poslongtras = longtras;
%posaileron  = 0.75; % inicio do aileron (fracao da semienvergadura)

% Variaveis auxiliares
bdiv2       = 0.50*wingb;
xquebraBA   = bdiv2*fquebra*tan(rad*wingsweepLE);
yquebra     = fquebra*bdiv2;
%yinfaileron = posaileron*bdiv2;
% localizacao da longarina dianteira como fracao da corda
if slat > 0
    fraclongdi = 0.25;
else
    fraclongdi = 0.15;
end
limited = fraclongdi;
% Dados do trem de pouso:
pneu.diam = 0.80; % diam do pneu em metros
pneu.height = 0.25; % largura do pneu (m)
lmunhao=1.3; % Comprimento do munhao (m)

% Intersecao asa-fuselagem
yfusjunc=diamfus/2;

% Vetor para Aramzernar Todas as Nervuras
% Nerv = [x1 y1 x2 y2]
Nerv = zeros(0,4);

% Calcula a corda na intersecao

xbainter=yfusjunc*tan(rad*wingsweepLE); % coord do ba na intersecao

xbfquebra = xquebraBA + Cquebra;

if xbfquebra == Ccentro
    xbfinter = xbfquebra;
else
inclinabf=(yquebra-0)/((xquebraBA + Cquebra) - Ccentro);

xbfinter=Ccentro+(yfusjunc-0)/inclinabf; % coord do bf na intersecao
end
%
Cinter = xbfinter - xbainter;
wlay.Cinter = Cinter;

%
aux1=bdiv2*tan(rad*wingsweepLE);
aux2=xquebraBA;

% *** Forma em planta da asa***
xw=[0 xbainter aux1 (aux1+Cponta) (aux2+Cquebra) xbfinter Ccentro];
yw=[0 yfusjunc bdiv2 bdiv2 yquebra yfusjunc 0];

figure(7)
%
plot(xw,yw,'k') % Desenha forma em planta
hold on

%
xfus=[-2 Ccentro+2];
yfus=[diamfus/2 diamfus/2];

plot(xfus,yfus,'--c')
hold on
%


% *** Ponta da asa ***
xcontrolpoint2=bdiv2*tan(rad*wingsweepLE);
xcontrolpoint3=bdiv2*tan(rad*wingsweepLE)+Cponta;
xcontrolpoint4=aux2+Cquebra;
ycontrolpoint3=bdiv2;
ycontrolpoint4=fquebra*bdiv2;
inclinabf=(ycontrolpoint4-ycontrolpoint3)/(xcontrolpoint4-xcontrolpoint3);
xprojbfponta=xcontrolpoint3+(1.05*bdiv2-ycontrolpoint3)/inclinabf;

% projecao do BF da ponta
xpp=[xcontrolpoint2 (xcontrolpoint2+0.15*Cponta) xprojbfponta (xcontrolpoint2+Cponta)];
ypp=[bdiv2 (bdiv2+0.025*bdiv2) (bdiv2+0.05*bdiv2) bdiv2];


plot(xpp,ypp,'-k')
hold on

% *** Longarina dianteira

 xld = [(yfusjunc*tan(rad*wingsweepLE)+fraclongdi*Cinter) (bdiv2*tan(rad*wingsweepLE)+fraclongdi*Cponta)];
 yld = [yfusjunc  bdiv2];
 


plot(xld,yld,'-b')
hold on

% *** Fim longarina dianteira ***

% *** Longarina traseira (LT) ***
    
% LT externa
x1aux=(poslongtras*Cquebra+bdiv2*fquebra*tan(rad*wingsweepLE));
xlte =[x1aux (bdiv2*tan(rad*wingsweepLE)+poslongtras*Cponta)];
ylte=[bdiv2*fquebra  bdiv2];

plot(xlte,ylte,'-b')
hold on

% LT Interna

inclnt=x1aux-(bdiv2*tan(rad*wingsweepLE)+poslongtras*Cponta);
inclnt=(bdiv2*fquebra - bdiv2)/inclnt;
anglti=atan(inclnt)+angquebralongtras*pi/180; % adiciona angulo graus para aumentar o tamanho do caixao central
xltintern=x1aux+((yfusjunc-bdiv2*fquebra)/tan(anglti));
xlti=[xltintern x1aux];
ylti=[yfusjunc bdiv2*fquebra];

plot(xlti,ylti,'-b')
hold on

xlt = xlti;
xlt(3) = xlte(2);

ylt = ylti;
ylt(3) = ylte(2);
        
% *** Fim da longarina traseita ***

% ************************   Nervuras ********************************
% ++++  Na quebra
%
x1aux = yfusjunc*tan(rad*wingsweepLE) + fraclongdi*Cinter;
y1aux = yfusjunc;
x2aux = bdiv2*tan(rad*wingsweepLE) + fraclongdi*Cponta;
y2aux = bdiv2;

if x1aux == x2aux
xnq(1) = x1aux;
else
inclinald=(y2aux-y1aux)/(x2aux-x1aux);
x0 = x1aux;
y0 = y1aux;
xnq(1) = (yquebra-y0)/inclinald + x0;
end
%

xnq(2)= xquebraBA+poslongtras*Cquebra;
ynq(1)= yquebra;
ynq(2) = ynq(1);

Nerv = vertcat(Nerv,[xnq ynq]);
plot(xnq,ynq,'-b')
hold on


% Coordendas da nervura na quebra
xtnervq = xnq(2);
ytnervq = ynq(2);
xdnervq = xnq(1);
ydnervq = ynq(1);

% Nervura da asa externa com origem na quebra(eh perpendicular ah longarina
% traseira)
x1aux = xquebraBA + poslongtras*Cquebra;
y1aux = yquebra;

x2aux = bdiv2*tan(rad*wingsweepLE) + poslongtras*Cponta;
y2aux = bdiv2;

nervkinknormal =0; % a principio esta nervura nao existe
nnervext  = 1; % Por enquanto, apenas a nervura padrao da quebra eh levada em conta
if x2aux == x1aux
    anglte    = pi/2;
    angnev    =  0;
else
    inclinalt = (y2aux-y1aux)/(x2aux-x1aux);
    if inclinalt > 0
        anglte         = atan(inclinalt);
        angnev         = pi/2 + anglte;
        % testa se o angulo entrea nerv da quebra e esta nervura eh maior
        % que 5 graus
        if (pi-angnev) > 5*rad
        nervkinknormal = 1; % nervura serah considerada
        nnervext  = 2;
        end
    end
end
x02=xnq(2);
y02=ynq(2);
inclinanerv=tan(angnev);
x01=yfusjunc*tan(rad*wingsweepLE) + fraclongdi*Cinter;
y01=yfusjunc;
%
 if nervkinknormal == 1
 % acha intersecao com a longarina dianteira
 xnqa(1)=xnq(2); % coord x do ponto da longarina traseira na quebra
 ynqa(1)=ynq(2); % coord y do ponto da longarina traseira na quebra
 %
 term1 = (y02-y01)-inclinanerv*x02+inclinald*x01;
 xinerv=term1/(inclinald-inclinanerv);
 yinerv=y01+inclinald*(xinerv-x01);
 xnqa(2)=xinerv;
 ynqa(2)=yinerv;
 %
 Nerv = vertcat(Nerv,[xnqa ynqa]);
 plot(xnqa,ynqa,'-b')
 hold on
 else
    yinerv      = yquebra;
 end
%
% Restante das nervuras do caixao central externo

%
ytnerv = y02;
xtnerv = x02;
ydnerv = yinerv;
%
jnervext=0;
deltay=nervspacm;
    if anglte == 0
    deltax = 0;
    else
    deltax = deltay/tan(anglte);
    end
    % parte 1 ateh o flape
while (ydnerv+deltay) < bdiv2
% descobre coord da nova nervura na LT
ytnerv=ytnerv+deltay;
xtnerv=xtnerv+deltax;
jnervext=jnervext+1;
xnervext(jnervext,1)=xtnerv;
ynervext(jnervext,1)=ytnerv;
xnq(2)=xtnerv;
ynq(2)=ytnerv;
% Calcula intersecao com a LD
ydnerv=ydnerv+deltay;
xdnerv=x01+(ydnerv-y01)/inclinald;
xnervext(jnervext,2)=xdnerv;
ynervext(jnervext,2)=ydnerv;
xnq(1)=xdnerv;
ynq(1)=ydnerv;
nnervext=nnervext+1;

Nerv = vertcat(Nerv,[xnq ynq]);
plot(xnq,ynq,'-b')
hold on
end

% Ultima nervura (fracionaria)

if (ytnerv+deltay) < bdiv2;
    jnervext=jnervext+1;
    ytnerv = ytnerv+deltay;
    xtnerv = xtnerv+deltax;
    xnq(1) = xtnerv;
    ynq(1) = ytnerv;
	xdnerv = (ytnerv-y01 + x01*inclinald-inclinanerv*xtnerv)/(inclinald-inclinanerv);
	ydnerv = y01 + inclinald*(xdnerv-x01);
	yinerv = ydnerv;
    sinerv = xdnerv;
	 if ydnerv > bdiv2
	 yinerv = bdiv2;
     y01p = bdiv2;
     x01p = bdiv2*tan(rad*wingsweepLE);
     xinerv = (ytnerv-y01p + x01p*0-inclinanerv*xtnerv)/(0-inclinanerv); % inclinacao d apont eh zero
     end
    xnervext(jnervext,1)=xtnerv;
    ynervext(jnervext,1)=ytnerv;
    xnervext(jnervext,2)=xinerv;
    ynervext(jnervext,2)=yinerv;
    %xdnerv = xtnerv + (bdiv2-ytnerv)/inclinanerv;
    xnq(2) = xdnerv;
    ynq(2) = yinerv;
    nnervext=nnervext+1;
    
    Nerv = vertcat(Nerv,[xnq ynq]);
    plot(xnq,ynq,'-b')
    hold on
end

fprintf('\n Nervuras na asa externa (incluindo a da quebra): %2.0f \n',nnervext)

% Nervuras no caixao central interno
xtnerv = xtnervq;
ytnerv = ytnervq;
xdnerv = xdnervq;
ydnerv = ydnervq;

nni =0;
deltay = 0.60*deltay;
while (ytnerv-yfusjunc-deltay) > (nervspacm/2)
    ytnerv = ytnerv - deltay;
    xtnerv = xtnervq +(ytnerv-ytnervq)/tan(anglti);
ydnerv = ytnerv;
xdnerv = x01+(ydnerv-y01)/inclinald;
xnq(1) = xdnerv;
ynq(1) = ydnerv;
nni = nni + 1;
xnervint(nni,1) = xdnerv;
ynervint(nni,1) = ydnerv;
xnq(2) = xtnerv;
ynq(2) = ytnerv;
xnervint(nni,2) = xtnerv;
ynervint(nni,2) = ytnerv;


Nerv = vertcat(Nerv,[xnq ynq]);
plot(xnq,ynq,'-b')
hold on

end

nni=nni+1;

% nervura na juncao asa-fuselagem;

xnq(1) = xld(1);
ynq(1) = yld(1);
xnervint(nni,1) = xnq(1);
ynervint(nni,1) = ynq(1);
xnq(2) = xlti(1);
ynq(2) = ylti(1);
xnervint(nni,2) = xnq(2);
ynervint(nni,2) = ynq(2);
%

Nerv = vertcat(Nerv,[xnq ynq]);
plot(xnq,ynq,'-b')
hold on
fprintf('\n Nervuras na asa interna (excluindo a da quebra): %2.0f \n',nni)

% *** Aileron ***
% comprimento estimado do aileron: aprox. 25% da semi-envergadura
xail(1)=bdiv2*tan(rad*wingsweepLE)+poslongtras*Cponta;
yail(1)=bdiv2;
xail(2)=bdiv2*tan(rad*wingsweepLE)+Cponta;
yail(2)=bdiv2;
%
yinfaileron=0.75*bdiv2;
% Procura a nervura mais proxima de yinfaileron
minnerv=1e06;
 for j=1:jnervext
     if abs(yinfaileron-ynervext(j,1)) < minnerv
         minnerv=abs(yinfaileron-ynervext(j,1));
         mem=j;
     end
 end
ytop_tanque_externo=0.85*bdiv2;
minnerv=1e06;
for j=1:jnervext
    if abs(ytop_tanque_externo-ynervext(j,1)) < minnerv
        minnerv=abs(ytop_tanque_externo-ynervext(j,1));
        memtqe=j;
    end
end
% calcula intesecao com BF
tg1 = inclinabf;
tg2 = 0;
x1 = xcontrolpoint3;
y1 = ycontrolpoint3;
x2 = xnervext(mem,1);
y2 = ynervext(mem,1);
%
term1 = (y2-y1)-tg2*x2+tg1*x1;
xail(3)=term1/(tg1-tg2);
yail(3)=y1+tg1*(xail(3)-x1);
%
xail(4)=xnervext(mem,1);
yail(4)=ynervext(mem,1);
fill(xail,yail,'r')
hold on
xcombe=[];
ycombe=[];
% Tanque de combustível na asa externa
if PEng == 2
xcombe(1)=xtnervq;
ycombe(1)=ytnervq;
xcombe(2)=xdnervq;
ycombe(2)=ydnervq;
xcombe(3)=xnervext(memtqe,2);
ycombe(3)=ynervext(memtqe,2);
xcombe(4)=xnervext(memtqe,1);
ycombe(4)=ynervext(mem,1);
else
xcombe(1)=xnervext(1,1);
ycombe(1)=ynervext(1,1);
xcombe(2)=xnervext(1,2);
ycombe(2)=ynervext(1,2);
xcombe(3)=xnervext(memtqe,2);
ycombe(3)=ynervext(memtqe,2);
xcombe(4)=xnervext(memtqe,1);
ycombe(4)=ynervext(memtqe,1);
end
%
patch(xcombe,ycombe,'g','FaceAlpha',0.2)
hold on
%
xcgtqe = sum(xcombe)/4;  % CG do tanque externo
ycgtqe = sum(ycombe)/4;
%
% Calcula capacidade dos tanques (duas semi-asas)
limitepe =poslongtras;
%
% estacoes da base inf e sup do tanque externo (ymed1 e ymed2)
ymed1=0.50*(ynervext(1,1)+ynervext(1,2));
ymed2=0.50*(ynervext(memtqe,1)+ynervext(memtqe,2));

% estacao superior do tanque interno da asa
if PEng == 2
ymed3=ytnervq;
limitepi1=poslongtras;

aux=max(xnervint(nni,1),xnervint(nni,2));
limitepi2=(aux-yfusjunc*tan(rad*wingsweepLE))/Cinter;
else
ymed3=ynervint(1,2);   
deltaysta=yquebra-yfusjunc;
Csupint = Cinter + ((ymed3-yfusjunc)/deltaysta)*(Cquebra-Cinter);
xbainter = yfusjunc*tan(rad*wingsweepLE);
xbaint  = xbainter + ((ymed3-yfusjunc)/deltaysta)*(xquebraBA-xbainter);
aux=max(xnervint(1,1),xnervint(1,2));
limitepi1=(aux-xbaint)/Csupint;
aux=max(xnervint(nni,1),xnervint(nni,2));
limitepi2=(aux-yfusjunc*tan(rad*wingsweepLE))/Cinter;
end

%fprintf('\n cheguei aqui: volume de tanque da asa \n')
voltanquesasa2014
%fprintf('\n Passei por aqui: volume de tanque da asa \n')

capacidadete=2.*voltanqueext*denquerosene;
%
fprintf('\n Capacidade dos tanques externos:(ambas semiasas) %4.0f kg \n',capacidadete)
%
% Capacidade dos tanques da asa interna
xcombi=[];
ycombi=[];
if PEng == 2
xcombi(1)=xdnervq;
ycombi(1)=ydnervq;
xcombi(2)=xtnervq;
ycombi(2)=ytnervq;
xcombi(3)=xnervint(nni,2);
ycombi(3)=ynervint(nni,2);
xcombi(4)=xnervint(nni,1);
ycombi(4)=ynervint(nni,1);
else
xcombi(1)=xnervint(1,1);
ycombi(1)=ynervint(1,1);
xcombi(2)=xnervint(1,2);
ycombi(2)=ynervint(1,2);
xcombi(3)=xnervint(nni,2);
ycombi(3)=ynervint(nni,2);
xcombi(4)=xnervint(nni,1);
ycombi(4)=ynervint(nni,1);
%fprintf('\n +++  passei por aqui xcombi \n')
end

xcgtqi = sum(xcombi)/4;  % CG do tanque interno
ycgtqi = sum(ycombi)/4;
% Desenha tanque da semi-asa interna
patch(xcombi,ycombi,'g','FaceAlpha',0.2)
hold on


capacidadeti=2*voltanqueint*denquerosene;

fprintf('\n Capacidade dos tanques internos: %4.0f kg \n',capacidadeti)

% Capacidade total dos tanques
% Considera perdas devido a nervuras, longarinas, revestimento, bombas
% etc...
if capacidadeti > 0&& capacidadete > 0
wingfuelcapacitykg=capacidadeti + capacidadete; 
end

fprintf('\n Capacidade total dos tanques: %4.0f kg \n',wingfuelcapacitykg)

% Localizacao do CG dos tanques de combustivel
xcgtanques = (xcgtqe*capacidadete + xcgtqi*capacidadeti)/(capacidadeti+capacidadete);
fprintf('\n Localizacao do CG dos tanques x = %4.2f  \n',xcgtanques)

% *** Flape externo ***
xflape(1)=xail(3)+1;
yflape(1)=yail(3) - 0.10;

x1aux = xquebraBA + Cquebra;
y1aux = yquebra;
x2aux = bdiv2*tan(rad*wingsweepLE) + Cponta;
y2aux = bdiv2;

    if x1aux == x2aux 
    xflape(1) = x1aux;
    else
    gradbfaux = (y2aux-y1aux)/(x2aux-x1aux);
    xflape(1) = (yflape(1)-y1aux)/gradbfaux + x1aux;
    end

% Intersecao com a LT
tg1 = 0;
tg2 = inclnt;
x1 = xail(3);
y1 = yail(3)-0.10;
x2 = xnervext(mem,1);
y2 = ynervext(mem,1);
term1 = (y2-y1)-tg2*x2+tg1*x1;
xflape(2)=term1/(tg1-tg2);
yflape(2)=y1+tg1*(xflape(2)-x1);
xflape(3)= x02;
yflape(3)= y02;
xflape(4)= fquebra*bdiv2*tan(rad*wingsweepLE)+Cquebra;
yflape(4)= fquebra*bdiv2;

fill(xflape,yflape,'m')
hold on

aflape=polyarea(xflape,yflape);
fprintf('\n Area dos flapes externos (recolhidos): %4.0f m2 \n',2*aflape)
% Insere nervura auxiliar para o flape externo
xnervaf(1) = xflape(2);
ynervaf(1) = yflape(2);
% intersecao com a LD

%tg1 = atan(inclinald) +pi/2;
%tg1=tan(tg1);
%tg2 = inclinald;
%x1 = xflape(2);
%y1 = yflape(2);
%x2 = xnervext(mem,2);
%y2 = ynervext(mem,2);
%term1 = (y2-y1)-tg2*x2+tg1*x1;
x1aux = yfusjunc*tan(rad*wingsweepLE) + fraclongdi*Cinter;
y1aux = yfusjunc;
x2aux = bdiv2*tan(rad*wingsweepLE) + fraclongdi*Cponta;
y2aux = bdiv2;

if x1aux == x2aux
    xnervaf(2) = x1aux;
    ynervaf(2) = yflape(2);
else
    tg1 = (y2aux-y1aux)/(x2aux-x1aux);
    tg2= tan(angnev);
    x1 = x1aux;
    y1 = y1aux;
    x2 = xflape(2);
    y2 = yflape(2);
    term1 = (y2-y1)-tg2*x2+tg1*x1;
    xnervaf(2) = term1/(tg1-tg2);
    ynervaf(2) = y2+tg2*(xnervaf(2)-x2);  
end

plot(xnervaf,ynervaf,'-b')
hold on

% Flape interno
xflapi(1) = xflape(4);
yflapi(1) = yflape(4);
xflapi(2) = xflape(3);
yflapi(2) = yflape(3);
cordafi=xflape(4)-xflape(3);
xflapi(3) = yfusjunc*(tan(rad*wingsweepLE)) + Cinter - cordafi;
yflapi(3) = yfusjunc;
xflapi(4) = yfusjunc*(tan(rad*wingsweepLE)) + Cinter;
yflapi(4) = yfusjunc;
fill(xflapi,yflapi,'m')
hold on

% posicao em x do munhao
posxmunhao = (xflapi(3)+xltintern)/2;
fprintf('\n Posicao do munhao do trem de pouso principal x= %4.2f \n',posxmunhao)

axis equal
title('Wing Structural Layout')
%fim = max(Craiz,bdiv2*tan(rad*wing.sweepLE)+Cponta);
%fim = round(fim+1);
%set(gca,'XTick',0:1:fim)
%

  if exist('wlayout.jpg') > 0 %#ok<EXIST>
  delete ('wlayout.jpg');
  end
%print -djpeg -f7 -r300 'wlayout.jpg'

close(figure(7))

figure(11)
subplot(4,1,1)
plot(xuperfilext,yuperfilext)
hold on
plot(xuperfilext,ylperfilext)
title('Tip airfoil - fuel contact area')
hold on
fill(xpolye,ypolye,'r')
axis equal
subplot(4,1,2)
plot(xukink,yukink)
hold on
plot(xlkink,ylkink)
hold on
fill(xpolyi,ypolyi,'g')
hold on
title('Kink airfoil - fuel contact area')
subplot(4,1,3)
plot(xuroot,yuperfilint)
hold on
plot(xlroot,ylperfilint)
hold on
fill(xpolyroot,ypolyroot,'y')
title('Upper internal tank airfoil - fuel contact area')
hold on
subplot(4,1,4)
plot(xuroot,yuroot)
hold on
plot(xlroot,ylroot)
hold on
fill(xpolyroot1,ypolyroot1,'b')
title('Lower internal tank airfoil - fuel contact area')
hold on
axis equal
  if exist('tankprofiles.jpg') > 0 %#ok<EXIST>
  delete ('tankprofiles.jpg');
  end
%print -djpeg -f11 -r300 'tankprofiles.jpg'

close(figure(11))
% Check de consistencia
if wingfuelcapacitykg <= 0 || aflape <= 0
    checkconsistency = 1; % fail
else
    checkconsistency = 0; % ok
end

%
clear xw yw xflapi yflapi xflape yflape xail yail xnq ynq xnervint ynervint
clear xlte ylte xlti ylti x1 x2 y1 y2 xnervaf ynervaf 
clear xnervext xyervext xpolyroot xpolyroot1 ypolyroot ypolyroot1
clear lmunhao mem minnerv limitepi1 limitepi2 jnervext deltax inclnt
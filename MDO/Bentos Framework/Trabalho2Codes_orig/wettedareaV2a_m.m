function [Swet, wingSwet, FusSwet_m2, ...
    ESwet,lf, lco, ltail,EnginLength_m, ...
    wYMAC,wMAC,wSweepLE, wSweepC2,ht,vt,pylon,...
    Ccentro,Craiz,Cquebra, Cponta, ...
    xutip, yutip, xltip, yltip,xubreak,yubreak,xlbreak,ylbreak,...
    xuraiz,yuraiz,xlraiz,ylraiz, PHTout]...
    = wettedareaV2a_m(Ceiling,CruiseMach,MMO,NPax,NSeat,NCorr,...
    SEATwid,AisleWidth,SeatPitch,...
    Kink_semispan,Swing,wAR,wTR,wSweep14,wTwist,PWing,fus_w,fus_h,...
    ediam,PEng,T0,VTarea,VTAR,VTTR,VTSweep,...
    HTarea,HTAR,HTTR,PHT,htac_rel,wlet_present,wlet_AR,wlet_TR,...
    PROOT,PKINK,PTIP)
%%%%%%%%%%%%%%%Dimensionamento%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
rad             = pi/180;
FusDiam         = sqrt(fus_w*fus_h);
%--------------------------------------------------------------------------
aux             = split(PROOT,".");
fileToRead1     = aux{1};
clear aux
aux             = split(PKINK,".");
fileToRead2     = aux{1};
clear aux
aux             = split(PTIP,".");
fileToRead3     = aux{1};
clear aux
%
n=max(2,PEng); % number of engines
fprintf('\n')
fprintf('\n *** Single-engine Thrust = %6.0f  lb ***\n',T0);
fprintf('\n')
%
if PWing > 2
    PWing = 2;
    fprintf('\n *** Warning: Wing location reset to %g ***\n',PWing);
end
%
if PWing < 1
    PWing = 1;
    fprintf('\n*** Warning: Wing location reset to %g ***\n',PWing);
end
%
%
if PHT > 2
PHT = 2;
fprintf('\n *** Warning: EH config reset to %g ***\n',PHT);
end
%
if PHT < 1
PHT = 1;
fprintf('\n *** Warning: EH config reset to %g ***\n',PHT);
end
%
if PEng == 2 || PEng == 3 
    PHT= 2;
end
%
PEngm   = PEng;
% switch PEng
%     case 2
%         if PWing == 2 && PHT == 1
%             PHT = 2; % asa alta ==> HT em "T"
%             fprintf('\n Warning: HT config reset to %g \n',PHT);
%             PEngm  = 1; % asa alta ==> motores na asa
%             fprintf('\n Warning: Engine location reset to %g \n',PEng);
%         end       
%     case 3
%         PHT   = 2; % Um motor eh central na fuselagem ==> EH em "T"
%         fprintf('\n *** Warning: EH config reset to %g ***\n',PHT);
%     case 4
%         if PWing == 2
%             PHT  = 2;
%             fprintf('\n *** Warning: EH config reset to %g *** \n',var.ht);
%         end
% end
%
PHTout = PHT;
PEng = PEngm;
%
airplane.npax   = NPax;
airplane.naisle = NCorr; % numero de corredores
airplane.nseat  = NSeat; % numero de assentos por fileira
airplane.wseat  = SEATwid; % [m] largura do assento
airplane.waisle = AisleWidth; % [m] largura corredor 
airplane.pitch  = SeatPitch; % [m]  
%
fuselage.df     = FusDiam;
fuselage.wfus   = FusDiam;
%
fuselage.lcab= paxcab_leng(NPax,NSeat,airplane.pitch,AisleWidth,SEATwid);
fuselage.tail=size_tailcone(NPax,PEng,FusDiam,FusDiam);
%
FUSELAGE_lnose_df = 1.67;
fuselage.lco      = FUSELAGE_lnose_df*fuselage.df;
%
fuselage.length =fuselage.lcab+fuselage.tail+fuselage.lco; % comprimento fuselagem [m]
%fesbeltez_f      = fuselage.length/fuselage.df;

%fuselage.Swet    = pi*FusDiam*fuselage.length*((1-(2/fesbeltez_f))^(2/3))*(1+(1/fesbeltez_f^2)); % [m2]
%
lf               = fuselage.length;
lco              = fuselage.lco;
ltail            = fuselage.tail;
lcab             = lf - (ltail+lco);
% Calculo da area molhada da fuselagem
% --> Fuselagem dianteira
SWET_FF=Wetted_area_forwfus(fus_h,fus_w,lco);
% --> Cabina de passageiros
% calculo da excentricidade da elipse (se��o transversal da fuselagem)
a=max(fus_w,fus_h)/2;
b=min(fus_w,fus_h)/2;
c=sqrt(a^2-b^2);
e=c/a;
p=pi*a*(2-(e^2/2) + (3*e^4)/16);
SWET_PAXCAB=p*lcab;
% --> Cone de cauda
SWET_TC=Wetted_area_tailcone(fus_h,fus_w,lf,ltail);
% Hah ainda que se descontar a area do perfil da raiz da asa
% Sera feito mais adiante
fuselage.Swet=SWET_FF+SWET_PAXCAB+SWET_TC;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%WING%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TRAPEZOIDAL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wing.ir     = 2;
wing.iq     = 0;
twist       = wTwist;
wing.it     = wing.ir + twist;
wingtrap.S  = Swing; % [m�]area da asa 
wing.S      = Swing;
wingtrap.AR = wAR; % Alongamento da asa 
wing.b      = sqrt(wingtrap.AR*wingtrap.S); %  envergadura
wingtrap.TR = wTR; % afilamento
wingtrap.c0 = 2*wingtrap.S/(wing.b*(1+wingtrap.TR));% [m] corda no centro
wing.sweep  = wSweep14; %[�] enflechamento 1/4c
wing.et     = twist; % [�] torcao
 if PWing == 1 % 
 wing.di=2.5; % [�] diedro para asa baixa
     if PEng == 2 
     wing.di=3;
     end
 else
 wing.di=-2.5; % [�] diedro para asa alta
 end
%
wing.ct=wingtrap.TR*wingtrap.c0; % [m] corda na ponta
wingtrap.mgc=wingtrap.S/wing.b; % [m] corda media geometrica
wingtrap.mac=2/3*wingtrap.c0*(1+wingtrap.TR+wingtrap.TR^2)/(1+wingtrap.TR); % [m] corda media geometrica
wingtrap.ymac=wing.b/6*(1+2*wingtrap.TR)/(1+wingtrap.TR); % [m] posi�ao y da mac
wing.sweepLE=1/rad*(atan(tan(rad*wing.sweep)+1/wingtrap.AR*(1-wingtrap.TR)/(1+wingtrap.TR))); % [�] enflechamento bordo de ataque
wing.sweepC2=1/rad*(atan(tan(rad*wing.sweep)-1/wingtrap.AR*(1-wingtrap.TR)/(1+wingtrap.TR))); % [�] enflechamento C/2
wSweepC2    = wing.sweepC2;
wing.sweepTE=1/rad*(atan(tan(rad*wing.sweep)-3/wingtrap.AR*(1-wingtrap.TR)/(1+wingtrap.TR))); % [�] enflechamento bordo de fuga

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%REFERENCE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wing.crank = Kink_semispan; % porcentagem da corda

wing.s0=fuselage.df/2; % [m] y da raiz da asa
wing.s1=wing.crank*wing.b/2; % [m] y da quebra
wing.c1=(wing.b/2*tan(rad*wing.sweepLE)+wing.ct)-(wing.s1*tan(rad*wing.sweepLE)+(wing.b/2-wing.s1)*tan(rad*wing.sweepTE)); % [m] corda da quebra
wingtrap.cr=(wing.b/2*tan(rad*wing.sweepLE)+wing.ct)-(wing.s0*tan(rad*wing.sweepLE)+(wing.b/2-wing.s0)*tan(rad*wing.sweepTE)); % [m] corda da raiz fus trap
wing.cb=wingtrap.cr+(wing.s1-wing.s0)*tan(rad*wing.sweepTE); % corda da raiz fus crank 
wing.Sexp=(wing.cb+wing.c1)*(wing.s1-wing.s0)+(wing.c1+wing.ct)*(wing.b/2-wing.s1); % area exposta 
wingref.cr=wing.Sexp/(wing.b/2-wing.s0)-wing.ct; % corda na juncao com a fus da asa de ref
wingref.c0=(wing.b/2*wingref.cr-wing.s0*wing.ct)/(wing.b/2-wing.s0); % [m] corda na raiz  da asa de ref
%
wing.c0=wingtrap.c0+wing.s1*tan(rad*wing.sweepTE); %[m] chord at root
wing.TR=wing.ct/wingref.c0; % taper ratio actual wing
%
wingref.cponta=wingref.c0*wing.TR;
wingref.mgc=wingref.c0*(1+wing.TR)/2; % mgc asa de ref
wingref.mac=2/3*wingref.c0*(1+wing.TR+wing.TR^2)/(1+wing.TR); % mac da asa ref
wingref.ymac=wing.b/6*(1+2*wing.TR)/(1+wing.TR); % y da mac da asa ref
wing.AR=wing.b/wingref.mgc; % alongamento asa real
wingref.S=wing.b*wingref.mgc; % reference area [m�]
wing.bexp=wing.b-fuselage.df/2; % envergadura asa exposta
wing.ARexp=(wing.bexp^2)/(wing.Sexp/2); % exposed wing aspect ratio
wing.TRexp=wing.ct/wing.cb; % afilamento asa exposta

wMAC     = wingref.mac;
wYMAC    = wingref.ymac;
wSweepLE = wing.sweepLE;

xle=0.4250*fuselage.length; % inital estimative
wing.xac=xle+wingref.ymac*tan(rad*wing.sweepLE)+0.25*wingref.mac;
wing.xac_rel=wing.xac/wingref.mac;

wing.cail=(wing.b/2*tan(rad*wing.sweepLE)+wing.ct)-((0.75*wing.b/2)*tan(rad*wing.sweepLE)+(wing.b/2-(0.75*wing.b/2))*tan(rad*wing.sweepTE)); % corda no aileron
wing.Sail=(wing.cb+wing.c1)*(wing.s1-wing.s0)+(wing.c1+wing.cail)*((0.75*wing.b/2)-wing.s1); % area exposta com flap

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WING WETTED AREA %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
wingloc   = PWing;
semispan  = wing.b/2;
sweepLE   = wing.sweepLE;
iroot     = wing.ir;
ikink     = wing.iq;
itip      = wing.it;
wingdi    = wing.di;
wtaper    = wing.TR;
yposeng   = Kink_semispan;
Ccentro   = wing.c0;
Craiz     = wing.cb;
Cquebra   = wing.c1;
Cponta    = wing.ct;

engine.de = ediam/0.98; % [m]
ediam     = engine.de;

[wing.Swet, xutip, yutip, xltip, yltip,...
    xubreak,yubreak,xlbreak,ylbreak, xuraiz,yuraiz,xlraiz,ylraiz] ...
    = wingwettedarea(ediam,wingloc,FusDiam,Ccentro,Craiz,Cquebra,...
    Cponta,semispan,sweepLE,iroot,ikink,itip,0,yposeng,wingdi,wtaper,...
    fileToRead1,fileToRead2,fileToRead3);
% descontar a area do perfil da raiz da asa da area molhada da fuselagem
npontos=size(xuraiz,2)-1;
xperroot=[xuraiz(npontos+1:-1:2), xlraiz];
yperroot=[yuraiz(npontos+1:-1:2), ylraiz];
ARaiz=polyarea(Craiz*xperroot,Craiz*yperroot);
fuselage.Swet=fuselage.Swet - 2*ARaiz;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WINGLET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wlet.Swet      = 0;
if wlet_present == 1
wlet_CR        = 0.65*Cponta;
wlet_b         = wlet_AR*wlet_CR*(1+wlet_TR)/2;
wlet_S         = wlet_CR*(1 + wlet_TR)*wlet_b/2;
wlet_tau       = 1; % Perfil da ponta = perfil da raiz
wlet_TC_root   = 0.09; % Assume-se 9% da espessura relativa do perfil
Taux           = 1 + 0.25*(wlet_TC_root*((1 + wlet_tau*wlet_TR)/(1 + wlet_TR)));
wlet.Swet      = 2*wlet_S*Taux; % [m2]
end
%----------------------------------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%VERTICAL TAIL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initial guess for VT area
vt.S=VTarea;
vt.Sv_Sw=vt.S/wingref.S; % rela�ao de areas
vt.AR=VTAR; % alongamento EV
vt.TR=VTTR; % Afilamento EV
vt.sweep=VTSweep; % Enfl c/4 EV
vt.et=0; % torcao EV
vt.di=90; % diedro RV
vt.b=sqrt(vt.AR*vt.S); % Envergadura EV (m)
vt.c0=2*vt.S/(vt.b*(1+vt.TR)); % corda de centro 
vt.ct=vt.TR*vt.c0; % corda da ponta 
vt.cr=vt.ct/vt.TR; % corda na raiz
vt.mgc=vt.S/vt.b; % mgc
vt.mac=2/3*vt.c0*(1+vt.TR+vt.TR^2)/(1+vt.TR); %mac
vt.ymac=2*vt.b/6*(1+2*vt.TR)/(1+vt.TR);
vt.sweepLE=1/rad*(atan(tan(rad*vt.sweep)+1/vt.AR*(1-vt.TR)/(1+vt.TR))); % [�] enflechamento bordo de ataque
vt.sweepC2=1/rad*(atan(tan(rad*vt.sweep)-1/vt.AR*(1-vt.TR)/(1+vt.TR))); % [�] enflechamento C/2
vt.sweepTE=1/rad*(atan(tan(rad*vt.sweep)-3/vt.AR*(1-vt.TR)/(1+vt.TR))); % [�] enflechamento bordo de fuga
%lv=(0.060*wingref.S*wing.b)/vt.S; % fisrt estimate
%lv=lh - 0.25*ht.ct - vt.b * tan(rad*vt.sweepLE) + 0.25*vt.c0 + vt.ymac*tan(rad*vt.sweep); % braco da EV
%vt.v=vt.S*lv/(wingref.S*wing.b); % volume de cauda   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% VT wetted area %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vt.tcroot = 0.11; % [%]espessura relativa raiz
vt.tctip  = 0.11; % [%]espessura relativa ponta
vt.tcmed  = (vt.tcroot+3*vt.tctip)/4; % [%]espessura media
vt.tau    = vt.tctip/vt.tcroot;
dorsalfinSwet = 1; % additional area due to the dorsal fin [m2]
vt.Swet=2*vt.S*(1+0.25*vt.tcroot*((1+vt.tau*vt.TR)/(1+vt.TR)))+dorsalfinSwet; % [m2] 
% Read geometry of VT airfoil
cd Airfoil
[coordinates,~]=get_airfoil_coord('pvt.dat');
cd ..
xvt=coordinates(:,1)';
yvt=coordinates(:,2)';
AVT=polyarea(xvt*vt.cr,yvt*vt.cr);
% Desconta area da intersecao VT-fuselagem da area molhada da fuselagem
fuselage.Swet=fuselage.Swet - AVT;
%----------------------------------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%HORIZONTAL TAIL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ht=sizeht(HTarea,HTAR,HTTR,PHT,Swing,wSweep14,lf,vt.sweepLE,vt.ct,vt.c0,vt.b,...
    htac_rel,CruiseMach+0.05,Ceiling);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ENGINE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

engine.length = 2.22*((T0)^0.4)*(MMO^0.2)*2.54/100; % [m] Raymer pg 19

switch PEng
    case 1
        % livro 6 pag 111 fig 4.41 x/l=0.6
        wing.se    = Kink_semispan*wing.b/2; % [m] y do motor
		wing.seout = wing.se;
        wing.ce    = wing.c0-wing.se*tan(rad*wing.sweepLE); % corda da seccao do motor
    case 2
        wing.se    = fuselage.df/2+0.65*engine.de*cos(15*rad);
		wing.seout = wing.se;
	case 3
	        % livro 6 pag 111 fig 4.41 x/l=0.6
        wing.se    = Kink_semispan*wing.b/2; % [m] y do motor
		wing.seout = wing.se;
        wing.ce    = wing.c0-wing.se*tan(rad*wing.sweepLE); % corda da seccao do motor
    case 4
        % livro 6 pag 111 fig 4.41 x/l=0.6
        wing.se    = Kink_semispan*wing.b/2; % [m] y do motor
        wing.seout = (var.yEng+0.3)*wing.b/2; % [m] y do motor externo distancia entre os dois 30% de b 
        wing.ce = wing.c0-wing.se*tan(rad*wing.sweepLE); % corda da seccao do motor
        wing.ceout=(wing.b/2*tan(rad*wing.sweepLE)+wing.ct)-(wing.seout*tan(rad*wing.sweepLE)+(wing.b/2-wing.seout)*tan(rad*wing.sweepTE));
end

%%%%%%%%%%%%%%%%%%%%%%%%%AREA MOLHADA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% Engine %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% aux1=(1-2/auxdiv)^2/3;
% engine.Swet=pi*engine.de*engine.length*aux1*(1+1/((engine.length/engine.de)^2)); % [m2]
ln   = 0.50*engine.length; % Fan cowling
ll   = 0.25*ln;
lg   = 0.40*engine.length; % Gas generator
lp   = 0.10*engine.length; % Plug
esp  = 0.12;
Dn   = (1.+esp)*ediam;
Dhl  = ediam;
Def  = (1+esp/2)*ediam;
Dg   = 0.50*Dn;
Deg  = 0.90*Dg;
Dp   = lp/2;
swet_fan_cowl = ln*Dn*(2+0.35*(ll/ln)+0.80*((ll*Dhl)/(ln*Dn)) + 1.15*(1-ll/ln)*(Def/Dn));
swet_gas_gen  = pi*lg*Dg*(1- 0.333*(1-(Deg/Dg)*(1-0.18*((Dg/lg)^(5/3)))));
swet_plug     = 0.7*pi*Dp*lp;
engine.Swet=swet_fan_cowl+swet_gas_gen+swet_plug;
ESwet      = engine.Swet;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PYLON%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch PEng
    case 1
        pylon.c0 = wing.ce;
        pylon.ct = engine.length;
        pylon.TR = pylon.ct/pylon.c0;
        pylon.mgc=pylon.c0*(1+pylon.TR)/2;
        pylon.mac=2/3*pylon.c0*(1+pylon.TR+pylon.TR^2)/(1+pylon.TR); %mac
        % x/l=-0.6 e z/d = 0.85 figure 4.41 pag 111
        pylon.b = 0.85*engine.de - 0.5*engine.de;
        pylon.x = 0.6*wing.ce;
        pylon.AR=pylon.b/pylon.mgc;
        pylon.S=pylon.b*pylon.mgc;
        pylon.sweepLE = (1/rad)*tan(pylon.b/pylon.x);
        pylon.sweep = (1/rad)*tan(pylon.sweepLE*rad)+((1-pylon.TR)/(pylon.AR*(1-pylon.TR)));
    case 2
        pylon.c0 = engine.length;
        pylon.ct = 0.80*engine.length;
        pylon.TR = pylon.ct/pylon.c0;
        pylon.mgc=pylon.c0*(1+pylon.TR)/2;
        pylon.mac=2/3*pylon.c0*(1+pylon.TR+pylon.TR^2)/(1+pylon.TR); %mac
        % t/d=0.65 figure 4.42 pag 113  ang=15
        pylon.b = 0.65*engine.de-engine.de/2;
        pylon.AR=pylon.b/pylon.mgc;
        pylon.S=pylon.b*pylon.mgc;
        pylon.sweep = 0;
    case 3
        pylon.c0 = engine.length;
        pylon.ct = engine.length;
        pylon.TR = pylon.ct/pylon.c0;
        pylon.mgc=pylon.c0*(1+pylon.TR)/2;
        pylon.mac=2/3*pylon.c0*(1+pylon.TR+pylon.TR^2)/(1+pylon.TR); %mac
        % t/d=0.65 figure 4.42 pag 113  ang=15
        pylon.b = 0.65*engine.de-engine.de/2;
        pylon.AR=pylon.b/pylon.mgc;
        pylon.S=pylon.b*pylon.mgc;
        pylon.sweep = 0;        
    case 4 
        pylon.c0 = wing.ce;
        pylon.ct = engine.length;
        pylon.TR = pylon.ct/pylon.c0;
        pylon.mgc=pylon.c0*(1+pylon.TR)/2;
        pylon.mac=2/3*pylon.c0*(1+pylon.TR+pylon.TR^2)/(1+pylon.TR); %mac
        % x/l=-0.6 e z/d = 0.85 figure 4.41 pag 111
        pylon.b = 0.85*engine.de - 0.5*engine.de;
        pylon.x = 0.6*wing.ce;
        pylon.AR=pylon.b/pylon.mgc;
        pylon.S=pylon.b*pylon.mgc;
        pylon.sweepLE = (1/rad)*tan(pylon.b/pylon.x);
        pylon.sweep = (1/rad)*tan(pylon.sweepLE*rad)+((1-pylon.TR)/(pylon.AR*(1-pylon.TR)));
        % engine out
        pylon.c0out = wing.ceout;
        pylon.ctout = engine.length;
        pylon.TRout = pylon.ctout/pylon.c0out;
        pylon.mgcout=pylon.c0out*(1+pylon.TRout)/2;
        pylon.macout=2/3*pylon.c0out*(1+pylon.TRout+pylon.TRout^2)/(1+pylon.TRout); %mac
        % x/l=-0.6 e z/d = 0.85 figure 4.41 pag 111
        pylon.bout = 0.85*engine.de - 0.5*engine.de;
        pylon.xout = 0.6*wing.ceout;
        pylon.ARout=pylon.bout/pylon.mgcout;
        pylon.Sout=pylon.bout*pylon.mgcout;
        pylon.sweepLEout = (1/rad)*tan(pylon.bout/pylon.xout);
        pylon.sweepout = (1/rad)*tan(pylon.sweepLEout*rad)+((1-pylon.TRout)/(pylon.ARout*(1-pylon.TRout)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%WETTED AREA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pylon.tcroot=0.10; % [%]espessura relativa raiz
pylon.tctip=0.10; % [%]espessura relativa ponta
pylon.tcmed=(pylon.tcroot+pylon.tctip)/2; % [%]espessura media
if PEng == 1 || PEng == 2 || PEng == 3
        pylon.Swet=2*pylon.S*(1+0.25*pylon.tcroot*(1+(pylon.tcroot/pylon.tctip)*pylon.TR)/(1+pylon.TR)); % [m2]
else
        pylon.Swetin=2*pylon.S*(1+0.25*pylon.tcroot*(1+(pylon.tcroot/pylon.tctip)*pylon.TR)/(1+pylon.TR)); % [m2]
        pylon.Swetout=2*pylon.Sout*(1+0.25*pylon.tcroot*(1+(pylon.tcroot/pylon.tctip)*pylon.TRout)/(1+pylon.TRout)); % [m2]
        pylon.Swet = pylon.Swetin + pylon.Swetout;
end
%
%  *************** Definicoes adicionais **********************************
%slat = logical(var.SLATDEFLEC);
% cg dos tanques de combust�vel da asa e posicao do trem d pouso principal
%winglaywei2013
dorsalfin.Swet=0.1;
wingSwet=wing.Swet;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TOTAL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
airplane.Swet=fuselage.Swet+wing.Swet+ht.Swet+vt.Swet+ n*(engine.Swet)+...
    pylon.Swet+dorsalfin.Swet+wlet.Swet;
Swet          = airplane.Swet;
FusSwet_m2    = fuselage.Swet;
EnginLength_m = engine.length;
%%
fprintf('\n ----------------- Wetted areas [m2] ---------------------')
fprintf('\n        Fuselage: %8.1f ',fuselage.Swet)
fprintf('\n                          Fuselage lengths [m]:')
fprintf('\n                                      Front: %5.2f',lco)
fprintf('\n                                  Pax cabin: %5.2f',lcab)
fprintf('\n                                   Tailcone: %5.2f',ltail)
fprintf('\n            Wing: %8.1f ',wing.Swet)
fprintf('\n         Winglet: %8.1f ',wlet.Swet)
fprintf('\n         Engines: %8.1f ',n*engine.Swet)
fprintf('\n          Pylons: %8.1f ',pylon.Swet)
fprintf('\n              HT: %8.1f ',ht.Swet)
fprintf('\n              VT: %8.1f ',vt.Swet)
fprintf('\n ==> Grand Total: %8.1f ',airplane.Swet)
fprintf('\n ---------------- End Wetted areas ----------------------\n')
%
%%
clear Taux Deg Dg Dp 
end % function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PLOT Airplane (Top View)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PlotAirplane_topview_2(fuselage,wing,ht,vt,pylon,engine,wlet,PHT)
%__________________________________________________________________________
figure(5)
rad   = pi/180;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ht2   = ht.b/2; %(HT semispan)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TOP VIEW%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%_________________________________________________________________________%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%FUSELAGE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COCKPIT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
df=fuselage.df;
lf=fuselage.length;
%
cockpit.r          = fuselage.df/2; % height [m]
cockpit.parameter1 = 2; % paramero elipse
cockpit.parameter2 = 1.3; % paramero elipse
aux2               = 0;

for aux1=0:0.01:fuselage.lco
    aux2=aux2+1;
    cockpit.x(aux2)=aux1;
    cockpit.y(aux2)=real((cockpit.r^cockpit.parameter2-(((aux1-fuselage.lco)^cockpit.parameter1)*(cockpit.r^cockpit.parameter2)/(fuselage.lco^cockpit.parameter1)))^(1/cockpit.parameter2));
    cockpit.w(aux2)=2*cockpit.y(aux2);
end
ncock=size(cockpit.x,2);
cockpit.x=[cockpit.x, cockpit.x(ncock:-1:1)];
cockpit.y=[cockpit.y, -cockpit.y(ncock:-1:1)];
fill(cockpit.x,cockpit.y,'k')
hold on
% fill(cockpit.x,-cockpit.y,'k')
% hold on

%---------------------------- CABINA PAX ----------------------------------

cabine.x=[fuselage.lco, fuselage.lco+fuselage.lcab,...
    fuselage.lco+fuselage.lcab,fuselage.lco];
cabine.y=[df/2, df/2,-df/2,-df/2];
%cabine.w=fuselage.df;


fill(cabine.x,cabine.y,'k')
hold on
% fill(cabine.x,-cabine.y,'k')
% hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TAIL BOOM%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
auxfus=fuselage.lco+fuselage.lcab;
    if engine.PEng == 2
    auxfus2=0.50*engine.length;
    else
    auxfus2=2;
    end
tail.x=[auxfus, (auxfus+auxfus2), lf, lf];
tail.y=[df/2, 0.85*df/2, 0.40, 0];
ntail=size(tail.x,2);
tail.x=[tail.x, tail.x(ntail:-1:1)];
tail.y=[tail.y, -tail.y(ntail:-1:1)];
fill(tail.x,tail.y,'k')
hold on
% fill(tail.x,-tail.y,'k')
% hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%WING%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wingb2=wing.b/2;
wing.s1=wing.crank*wingb2;
tansweep=tan(wing.sweepLE*rad);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Inner Wing%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wing.x=[wing.xle, wing.xle+wing.s1*tansweep,...
    wing.xle+wing.s1*tansweep+wing.cq, wing.xle+wing.c0];
wing.y=[0, wing.s1, wing.s1, 0];

fill(wing.x,wing.y,'k')
hold on
fill(wing.x,-wing.y,'k') % Outra metade
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTER WING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear wing.x wing.y
wing.x=[wing.xle + wing.s1*tansweep, wing.xle+wingb2*tansweep,...
    wing.xle+wingb2*tansweep+wing.ct, wing.xle+wing.s1*tansweep+wing.cq];
wing.y=[wing.s1, wingb2, wingb2, wing.s1];
fill(wing.x,wing.y,'k')
hold on
fill(wing.x,-wing.y,'k') % Outra metade
hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%VERTICAL TAIL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
VT_x0=0.97*lf-0.30-vt.c0;
vtx=[VT_x0, VT_x0+ vt.b*tan(vt.sweepLE*rad),...
    VT_x0 + vt.b*tan(vt.sweepLE*rad)+vt.ct, VT_x0 + vt.c0];
vty=[0 0 0 0];

plot(vtx,vty)
hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%HORIZONTAL TAIL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch PHT
case 1
    auxf=0.92*lf;
    htx=[auxf-ht.c0, (auxf-ht.c0+ht2*tan(ht.sweepLE*rad)), ...
        (auxf-ht.c0+ht2*tan(ht.sweepLE*rad)+ht.ct), auxf];
    hty=[0, ht2, ht2, 0];
 %   
    fill(htx,hty,'k')
    fill(htx,-hty,'k') % plot inverso
    otherwise
    HT_x0=VT_x0+vt.b*tan(vt.sweepLE*rad);
    htx=[HT_x0,HT_x0+ht2*tan(ht.sweepLE*rad),...
        HT_x0+ht2*tan(ht.sweepLE*rad)+ht.ct, (HT_x0+ht.c0)];
    hty=[0, ht2, ht2, 0];
%
    fill(htx,hty,'k')
    fill(htx,-hty,'k') % espelho do lado direito
end  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PYLON %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
auxpyl      = VT_x0 - engine.length;
compmotor   = engine.length;

if engine.PEng == 2
 
    pyl.x(1) = auxpyl+0.20*compmotor;
    pyl.x(2) = pyl.x(1);
    pyl.x(3) = pyl.x(2) + pylon.ct;
    pyl.x(4) = pyl.x(2) + pylon.c0;
    
    pyl.y(1) = df/2;
    pyl.y(2) = df/2 + pylon.b;
    pyl.y(3) = df/2 + pylon.b;
    pyl.y(4) = pyl.y(1);
        
    pyl.x(5) = pyl.x(2) + pylon.c0;
    pyl.x(6) = pyl.x(2) + pylon.ct;
    pyl.x(7) = pyl.x(1);
    pyl.x(8) = auxpyl+0.20*compmotor;
   
    pyl.y(5) = -df/2;
    pyl.y(6) = -df/2 - pylon.b;
    pyl.y(7) = -df/2 - pylon.b;
    pyl.y(8) = -df/2;
%
    fill(pyl.x,pyl.y,'k')
    hold on
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ENGINE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch engine.PEng
    case 1
        % livro 6 pag 111 fig 4.41 x/l=0.6
        aux = wing.xle + wing.crank*wing.b/2*tan(rad*wing.sweepLE);
        x1 = aux -0.40*engine.length;
        x2 = x1 + engine.length;
        engine.x=[x1 x1 x2 x2];
        y1 = wing.crank*wing.b/2 - engine.de/2;
        y2 = y1 + engine.de;
        engine.y=[y1 y2 y2 y1];
        
        fill(engine.x,engine.y,'k')
        hold on
        fill(engine.x,-engine.y,'k') % plot inverso
        hold on
    case 2
%         livro 6 pag 116 fig 4.42 t/D = 0.6 ang=15
        engine.x(1)=0.97*lf - vt.c0 - engine.length;
        engine.x(2)=0.97*lf - vt.c0 - engine.length;
        engine.x(3)=0.97*lf - vt.c0;
        engine.x(4)=0.97*lf - vt.c0;

        engine.y(1)=df/2+0.65*engine.de*cos(15*rad)-engine.de/2;
        engine.y(2)=df/2+0.65*engine.de*cos(15*rad)+engine.de/2;
        engine.y(3)=df/2+0.65*engine.de*cos(15*rad)+engine.de/2;
        engine.y(4)=df/2+0.65*engine.de*cos(15*rad)-engine.de/2;

        fill(engine.x,engine.y,'y')
        hold on
        fill(engine.x,-engine.y,'y') % plot inverso
        hold on
    case 3
        engine.x=[lf-vt.c0-engine.length fuselage.length-vt.c0-engine.length fuselage.length-vt.c0 fuselage.length-vt.c0 fuselage.length-vt.c0-engine.length ];
        engine.y=[df/2+0.65*engine.de*cos(15*rad)-engine.de/2 fuselage.df/2+0.65*engine.de*cos(15*rad)+engine.de/2 fuselage.df/2+0.65*engine.de*cos(15*rad)+engine.de/2 fuselage.df/2+0.65*engine.de*cos(15*rad)-engine.de/2 fuselage.df/2+0.65*engine.de*cos(15*rad)-engine.de/2];
        
        engine.x2=[lf-vt.c0/2+engine.length/2 fuselage.length-vt.c0/2+engine.length/2 fuselage.length-vt.c0/2-engine.length/2 fuselage.length-vt.c0/2-engine.length/2 fuselage.length-vt.c0/2+engine.length/2];
        engine.y2=[engine.de/2 -engine.de/2 -engine.de/2 engine.de/2 engine.de/2];
        
        plot(engine.x,engine.y)
        hold on
        plot(engine.x,-engine.y) % plot inverso
        hold on
        plot(engine.x2,engine.y2)
        hold on
    case 4
        % livro 6 pag 111 fig 4.41 x/l=0.6
        engine.x=[wing.xle+wing.se*tan(rad*wing.sweepLE)-0.6*wing.ce wing.xle+wing.se*tan(rad*wing.sweepLE)-0.6*wing.ce wing.xle+wing.se*tan(rad*wing.sweepLE)-0.6*wing.ce+engine.length wing.xle+wing.se*tan(rad*wing.sweepLE)-0.6*wing.ce+engine.length wing.xle+wing.se*tan(rad*wing.sweepLE)-0.6*wing.ce];
        engine.y=[wing.se-engine.de/2 wing.se+engine.de/2 wing.se+engine.de/2 wing.se-engine.de/2 wing.se-engine.de/2];
        %motor externo
        engine.x2=[wing.xle+wing.seout*tan(rad*wing.sweepLE)-0.6*wing.ceout wing.xle+wing.seout*tan(rad*wing.sweepLE)-0.6*wing.ceout wing.xle+wing.seout*tan(rad*wing.sweepLE)-0.6*wing.ceout+engine.length wing.xle+wing.seout*tan(rad*wing.sweepLE)-0.6*wing.ceout+engine.length wing.xle+wing.seout*tan(rad*wing.sweepLE)-0.6*wing.ceout];
        engine.y2=[wing.seout-engine.de/2 wing.seout+engine.de/2 wing.seout+engine.de/2 wing.seout-engine.de/2 wing.seout-engine.de/2];

        plot(engine.x,engine.y)
        hold on
        plot(engine.x,-engine.y) % plot inverso
        hold on
        plot(engine.x2,engine.y2)
        hold on
        plot(engine.x2,-engine.y2) % plot inverso
        hold on
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%WINGLET%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if wlet.present == 1
psi            = wlet.sweepLE;   
Cr_wlet        = 0.45*wing.ct;
b_wlet         = wlet.AR*Cr_wlet*(1+wlet.TR)/2;
cledge_wlet    = b_wlet/cos(rad*psi);
Ct_wlet        = Cr_wlet*wlet.TR;
phi            = wlet.dihedral;
b_top          = cledge_wlet*cos(rad*phi)*cos(rad*psi);

x1 = wing.xle + (wingb2*tan(wing.sweepLE*rad)) + 0.55*wing.ct;
x2 = x1 + b_top*tan(rad*psi);
x3 = x2 + Ct_wlet;
x4 = x1 + 0.45*wing.ct;
xwlet = [x1, x2, x3, x4];
y1 = wingb2;
y2 = y1 + b_top;
y3 = y2;
y4 = y1;
ywlet = [y1, y2, y3, y4];
fill(xwlet,ywlet,'k')
hold on
fill(xwlet,-ywlet,'k')
hold on
end
axis equal
grid off
axis off

 print -djpeg -f5 -r300 '../Figures/topview.jpg'
close(figure(5))

clear aux1 aux2 xceg yceg xca yca pyl.x pyl.y engine.x engine.y vtx vty
clear htx hty x1 x2 x3 x4 y1 y2 y3 y4 xwlet ywlet auxf
end % function

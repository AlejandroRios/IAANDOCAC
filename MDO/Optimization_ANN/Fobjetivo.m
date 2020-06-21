function y=Fobjetivo(xOptvar,X)

wletAR=xOptvar(1);
wletTR=xOptvar(2);
wletSweep=xOptvar(3);
wletCant=xOptvar(4);
wletTwist=xOptvar(5);

XX=X;

XX(13)=wletAR;
XX(14)=wletTR;
XX(16)=wletSweep;
XX(17)=wletCant;
XX(18)=wletTwist;

Mach=0.70;
Alfa=1.5;
XX(1)=Mach;
XX(2)=12500;
XX(11)=Alfa;
[CLCD1, CD1]=calc_ANN_WLET(XX);

Mach=0.80;
Alfa=1.0;
XX(1)=Mach;
XX(11)=Alfa;
[CLCD2, CD2]=calc_ANN_WLET(XX);

DCD=(CD2-CD1)*10000 % DRAG RISE

if DCD > 35

y=0;
else
y=-(CLCD1+CLCD2)/2;
end

clear Mach Alfa wletAR wletTR wletSweep wletCant wletTwist
clear XX

end %function
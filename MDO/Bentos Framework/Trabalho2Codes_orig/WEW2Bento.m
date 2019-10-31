function WEW2=WEW2Bento(AR,W2_kg,MMO,TW,WS,FL,CW)
% Valores calculados
a=0.6672;
b=-1.1497;
c=0.9369;
C0= 0.1476;
C1=0.0194;
C2=0.1803;
C3=0.2036;
C4=0.2348;
C5=0.1126;
C6=0.2313;
C7=0.2760;
%
W2_norm=W2_kg/50000;
Sw_m2=((1/WS)*W2_kg)/100;
FL_norm=FL/30;
aux=(W2_norm*(AR/8)*TW*Sw_m2*MMO*FL_norm*CW);
WEW2=a + b*aux^C0;
WEW2=WEW2 + c*((W2_norm^C1)*((AR/8)^C2)*(TW^C3)*...
    (Sw_m2^C4)*(MMO^C5)*(FL_norm^C6)*(CW^C7)); 
end % function WEW@Ben
function LenFus= paxcab_leng(Npax,Nseat,SeatPitch,Aislewidth,SeatWidth)
% Calcula variacao de CG devido aos passageiros 
%clear;
%clc;
% Definicoes
figure(7)
GalleyProf  = 1.1;
ToilletProf = 1.5;
%Aislewidth  = 0.50;  % [m]
%SeatWidth   = 0.45;
SeatProf    = 0.48; % [m]
%SeatPitch   = 0.8128; % [m]
%
%Nseat =5;
%Npax =78;
%---------------------------------- BEGIN -------------------------
DeltaSeats = SeatPitch - SeatProf;
N1=floor(Npax/Nseat);
N2=Npax/Nseat - N1;
Nrow = N1;
if N2 > 0
    Nrow = N1+1;
end

x0=1.7; % entrance area
for j=1:Nrow
seattop_fileira(x0,Nseat,SeatWidth,SeatProf,Aislewidth)
x0=x0+SeatProf+DeltaSeats;
end
% **** Desenha Toillet
% Descobre lado de maior largura
Naux1 = floor(Nseat/2);
Naux2 = Nseat/2 - Naux1;
if Naux2 > 0
    NseatG = Naux1 + 1;
else
    NseatG = Naux1;
end
x0T = x0 - DeltaSeats + 0.1;
%LenFus = x0T;
x(1)= x0T;
y(1)= Naux1*SeatWidth + Aislewidth;
x(2)=x(1) + ToilletProf;
y(2)=y(1);
x(3)=x(2);
y(3)=y(2) + NseatG*SeatWidth;
x(4)=x(1);
y(4)=y(3);
fill(x,y,'y')
hold on
% **** Desenha Galley
x0G=x0T + 1. + ToilletProf; % walking area with 1 m large
LenFus = x0G;
x(1)=x0G;
y(1)=0;
x(2)=x(1)+GalleyProf;
y(2)=y(1);
x(3)=x(2);
y(3)=Nseat*SeatWidth+Aislewidth;
x(4)=x(1);
y(4)=y(3);
fill(x,y,'b')
hold on
% **** Desenha PaxCAB
x(1)=0;
y(1)=0;
x(2)=x(1)+ LenFus;
y(2)=y(1);
x(3)=x(2);
y(3)=Nseat*SeatWidth + Aislewidth;
x(4)=x(1);
y(4)=y(3);
plot(x,y,'k')
hold on
fprintf('\n Length of passenger cabin is %5.2f m \n',LenFus)
close(figure(7))
clear x y Naux1 Naux2
end % cgpax
%-------------------------------------------------------------------------
function seattop_fileira(x0,Nseat,SeatWidth,SeatProf,Aislewidth)
% descobre se Nseat é par ou ímpar
Naux1=floor(Nseat/2);
Naux2=Nseat/2 - Naux1;
if Naux2 > 0  % numero impar de fileiras
    %fprintf('\n Nseat é impar \n')
     y0=0;
     for i=1:Naux1
         x(1)=x0;
         y(1)=y0 + (i-1)*SeatWidth;
         x(2)=x(1)+SeatProf;
         y(2)=y(1);
         x(3)=x(2);
         y(3)=y(2)+SeatWidth;
         x(4)=x(1);
         y(4)=y(3);
         fill(x,y,'r')
         hold on
     end
    y0=Naux1*SeatWidth + Aislewidth;
     for i=1:(Nseat-Naux1)
         x(1)=x0;
         y(1)=y0 + (i-1)*SeatWidth;
         x(2)=x(1)+SeatProf;
         y(2)=y(1);
         x(3)=x(2);
         y(3)=y(2)+SeatWidth;
         x(4)=x(1);
         y(4)=y(3);
         fill(x,y,'r')
         hold on
      end
else % numero par de fileiras
     % fprintf('\n Nseat é par \n')
 
     y0=0;
     for i=1:Nseat/2
         x(1)=x0;
         y(1)=y0 + (i-1)*SeatWidth;
         x(2)=x(1)+SeatProf;
         y(2)=y(1);
         x(3)=x(2);
         y(3)=y(2)+SeatWidth;
         x(4)=x(1);
         y(4)=y(3);
         fill(x,y,'r')
         hold on
     end
    y0=(Nseat/2)*SeatWidth + Aislewidth;
     for i=1:Nseat/2
         x(1)=x0;
         y(1)=y0 + (i-1)*SeatWidth;
         x(2)=x(1)+SeatProf;
         y(2)=y(1);
         x(3)=x(2);
         y(3)=y(2)+SeatWidth;
         x(4)=x(1);
         y(4)=y(3);
         fill(x,y,'r')
         hold on
      end
end

axis equal
end % seattop_fileira


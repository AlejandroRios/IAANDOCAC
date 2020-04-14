function atm=atmosphere(hp,ISADEV)
% Input:
%      hp: pressure-altitude [ft]
%      ISADEV: ISA temperature deviation
%
%-------------------------------------------
% Output:
% atm(1)=temperatura isa [K]
% atm(2)=teta; 
% atm(3)=delta;
% atm(4)=sigma;
% atm(5)=pressure [KPa]
% atm(6)=air density [Kg/m�]
% atm(7)=sound speed [m/s]
% atm(8)= air viscosity


g=9.80665; %gravidadde
temp=288.15; %temperatura
rho=1.225; % densidade
pres=101325; % pressao
gama=1.4; % cp/cv
R=29.26; % constante dos gases

if hp <= 36089
    TAEs=temp-0.0019812*hp;
    delta=(TAEs/temp)^5.2561;%delta
else 
    TAEs=216.65;
    delta=0.223358*exp(-0.000048063*(hp-36089)); %delta
end
TAE=TAEs+ISADEV; % temperatura isa
teta=TAE/temp; 
sigma=delta/teta;
p=pres*delta/1000; % pressure
ro=rho*sigma; %densidade
va=sqrt(gama*g*R*TAE);% velocidade do som

atm(1)=TAE; % temperatura isa [K]
atm(2)=teta; 
atm(3)=delta;
atm(4)=sigma;
atm(5)=p; %[KPa]
atm(6)=ro; %[Kg/m�]
atm(7)=va; %[m/s]
% air viscosity
mi0=18.27E-06;
Tzero=291.15; % Reference temperature
Ceh= 120; % C = Sutherland's constant for the gaseous material in question
atm(8)=mi0*((TAE+Ceh)/(Tzero+Ceh))*((TAE/Tzero)^1.5);
end
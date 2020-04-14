clear
clc
close all
%-------------- Conversion factors ----------------------------------------
lb2kg    = 0.454;
kg2lb    = 1/lb2kg;
kW2hp    = 1.341;
%--------------------------------------------------------------------------
Alt      = 0;  % [m]
M_flight = 0;
% Engine data -------------------------------------------------------------
T0_4     = 1295;  % Turbine Inlet total temperature [K]
M_inlet  = 0.20;
D_inlet  = 0.3280;
nm       = 0.98;  % shaft mechanical efficiency
etai     = 0.95;  % Intake isentropic efficiency
prb      = 0.94;  % pressure drop at combustor
prclp    = 3;     % pressure ratio provided by LP compressor
prchp    = 4.2;   % pressure ratio provided by HP compressor
etalpc   = 0.85;  % LP compressor efficiency
etahpc   = 0.85;  % HP compressor efficiency
etab     = 0.99;  % Burner efficiency
mturb    = 0.98;  % HPT mechanical efficiency
etahpt   = 0.82;  % HPT polytropic efficiency
etalpt   = 0.88;  % Adiabic efficiency of LPT
etanoz   = 0.95;  % Adiabatic efficiency of the nozzle
% alpha    = 0.85; % Power split
PACC     = 22400; % Acessory Drive Power Requirement [W]
mbleed   = 0.0;  % bleed flow [kg/s]
Power_shaft = 1491;  % [kW]
% Constants ---------------------------------------------------------------
gama     = 1.4; % razao cp/cv do ar
R        = 287.2933;  % R gas const
Cpa      = 1005; % [J/kg K]
Cpg      = 1148; % {J/kg K]
PC       = 42800000;   % Poder calor�fico (J/kg) 
%--------------------------------------------------------------------------
% cd ..
[atm]  = atmosfera(Alt,0);
% cd Eng_TBP
Ta     = atm(1);
Pa     = atm(5)*1000; % [Pa]
vsom   = atm(7);
v0     = vsom*M_flight;
T0a    = (1 + 0.50*(gama-1)*M_flight^2)*Ta;
P0free = Pa*(T0a/Ta)^(gama/(gama-1));
P0a    = P0free*etai;

% Assume-se que a press�o de estagnacao e a temp de estagnacao nao variam na entrada de ar

T_1   = T0a/(1 + 0.50*(gama-1)*M_inlet^2);
P_1   = P0a/((T0a/T_1)^(gama/(gama-1)));
rho_1 = P_1/(R*T_1);

a_1   = sqrt(gama*R*T_1);
V_1   = a_1*M_inlet;
A1    = pi*(D_inlet^2)/4;
ma    = rho_1*V_1*A1;  % mass flow entering the compressor

%-- Compressor  de baixa --------------------------------------------------
gama2      = engine_getgamma(T0a);
cp2        = engine_getcp(T0a);
del_h_c_lp = cp2*T0a/etalpc*(prclp^((gama2-1)/gama2)-1);
del_t_c_lp = del_h_c_lp/cp2;
T0_3lp     = T0a + del_t_c_lp; % temperatura total na saida do compressor
P0_3lp     = P0a * prclp;      % Pressao total na saida do compressor
%ma_b       = ma - mbleed;
%-- Compressor  de alta --------------------------------------------------
gama3   = engine_getgamma(T0_3lp);
cp3     = engine_getcp(T0_3lp);
del_h_c = cp3*T0_3lp/etahpc*(prchp^((gama3-1)/gama3)-1);
del_t_c = del_h_c/cp3;
T0_3    = T0_3lp + del_t_c;  % temperatura total na saida do compressor
P0_3    = P0_3lp * prchp;     % Pressao total na saida do compressor

% ----- COMBUSTOR ---------------------------------------------------------
P0_4    = P0_3*prb;
f=(((Cpg*T0_4)-(Cpa*T0_3))/((PC*etab)-(Cpg*T0_4))); % fracao da massa do comb;
f=f + mbleed/ma;
ma_b=ma;
% Turbina de ALTA ---------------------------------------------------------
gama4    = engine_getgamma(T0_4);
cp4      = engine_getcp(T0_4);
% del_h_ht = del_h_c;
% del_t_ht = (del_h_ht + PACC)/cp4;
%T0_5     = T0_4 - del_t_ht;
T0_5     = T0_4 - (PACC + ma*cp2*(T0_3 - T0_3lp))/(ma_b*cp4*nm);
del_t_ht = T0_4 - T0_5;
del_h_ht = cp4*del_t_ht ;
prat5    = (1-del_h_ht/(cp4*T0_4*etahpt))^(gama4/(gama4-1));
P0_5     = P0_4 * prat5;
trat5    = T0_5/T0_4;
% Turbina de baixa --------------------------------------------------------
gama5    = engine_getgamma(T0_5);
cp5      = engine_getcp(T0_5);
% del_h_lt = del_h_c_lp;
% del_t_lt = del_h_lt/cp5;
% T0_6     = T0_5 - del_t_lt;
T0_6     = T0_5 - ma*cp2*(T0_3lp  - T0a)/(ma_b*cp5*nm);
del_t_lt = T0_5 - T0_6;
del_h_lt = cp5*del_t_lt ;
prat6    = (1-del_h_lt/(cp5*T0_5*etalpt))^(gama5/(gama5-1));
P0_6     = P0_5 * prat6;

% Turbina livre (Power Turbine) -------------------------------------------
 T0_7     = -(Power_shaft*1000 - ma_b*(1+f)*Cpg*T0_6*mturb)/(ma_b*(1+f)*Cpg*mturb);
 gama6    = engine_getgamma(T0_6);
 cp6      = engine_getcp(T0_6);
 del_t_pt = T0_6 - T0_7;
 del_h_pt = del_t_pt*cp6;
 prat7    = (1-del_h_pt/(cp6*T0_6*etalpt))^(gama6/(gama6-1));
 P0_7     = P0_6*prat7;
%   Tubeira ---------------------------------------------------------------
 cp7      = engine_getcp(T0_7);
 gama7    = engine_getgamma(T0_7);
 P0_8     = P0_7*etanoz;
 npr      = max(P0_8 / Pa,1);
 if (npr<=1.893)
    Pexit = Pa;
else
    Pexit = 0.52828*P0_8;
end
 prel       = Pexit/P0_8;
 T0_8       = T0_7;
 expoen     = (gama7-1)/gama7;
 M8         = (2/(gama7-1))*(prel^expoen -1);
 M8         = sqrt(max(0,M8));
 t8         = T0_8/(1+ (gama7-1)*M8*M8/2);
 Rje        = (gama7-1)/gama7*cp7; 
 a8         = sqrt(gama7*Rje*t8);  % speed of sound at exit
 v8         = M8*a8;
 rho8       = Pa/(Rje*t8);
 aexit      = ma_b/(v8*rho8);
 T_jet      = ma*(v8-v0) + (Pexit-Pa)*aexit*v8;
 Pow_jet    = T_jet*v8/1000; % [kW]
 Pow_jet_hp = 1.341*Pow_jet;
 ehp        = Pow_jet_hp + Power_shaft*kW2hp;
 TSFC       = f*ma_b*3600*kg2lb/ehp;
 %-------------------------------------------------------------------------
 figure(1)
 Tplot=[T0a, T0a,T0_3lp , T0_3, T0_4, T0_5, T0_6, T0_7, T0_8];
 staPlot=[0 1 2 3 4 5 6 7 8];
 plot(staPlot,Tplot,'b')
  text(1,T0a,'LP Compressor','Rotation',90)
 text(2,T0a,'HP Compressor','Rotation',90)
 text(3,T0a,'Combustor','Rotation',90)
 text(4,T0a,'HP Turbine','Rotation',90)
 text(5,T0a,'LP Turbine','Rotation',90)
 text(6,T0a,'Free Turbine','Rotation',90)
 text(7,T0a,'Entering the Nozzle','Rotation',90)
 xlabel('Station')
 ylabel('Total Temperature [K]')
 figure (2)
 Pplot=[P0free, P0a,P0_3lp , P0_3, P0_4, P0_5, P0_6, P0_7, P0_8];
 plot(staPlot,round(Pplot/1000),'r')
 text(1,P0free/1000,'LP Compressor','Rotation',90)
 text(2,P0free/1000,'HP Compressor','Rotation',90)
 text(3,P0free/1000,'Combustor','Rotation',90)
 text(4,P0free/1000,'HP Turbine','Rotation',90)
 text(5,P0free/1000,'LP Turbine','Rotation',90)
 text(6,P0free/1000,'Free Turbine','Rotation',90)
 text(7,P0free/1000,'Entering the Nozzle','Rotation',90)
 xlabel('Station')
 ylabel('Total Pressure [kPa]')
% %--------------------------------------------------------------------------
fprintf('\n Shaft power %i  %i [hp/kW]',round(1.341*Power_shaft),round(Power_shaft))
fprintf('\n Jet power %i  %i [hp/kW]',round(Pow_jet_hp),round(Pow_jet))
fprintf('\n Total power %i [hp] ',round(1.341*Power_shaft)+round(Pow_jet_hp))
fprintf('\n Thrust-specific fuel consumption %5.3f [lb/h/ehp]  ',TSFC)
fprintf('\n Turbine inlet total temperature %6.0f K ',T0_4)
fprintf('\n Overall Pressure Ratio %6.1f ',prclp*prchp)
fprintf('\n Mass flow rate through the LP compressor %5.2f kg/s ',ma)
fprintf('\n Fuel mass fraction %5.4f  ',f)
fprintf('\n Mach number at exit %6.3f ',M8)



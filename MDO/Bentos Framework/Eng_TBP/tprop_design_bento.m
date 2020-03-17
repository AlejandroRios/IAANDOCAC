%--------------------------------------------------------------------------
function [ehp, SFC, f]=tprop_design_bento(Alt,D_inlet,M_flight,...
        prclp,prchp,T0_4,Power_shaft)
%   Design Point is takeoff at sea level, ISA
% Input:
%        Alt: Design altitude [m]
%        D_inlet: inlet diameter [m]
%        prclp: Pressure ratio provided by LP compressor
%        prchp: Pressure ratio provided by HP compressor
%        T0_4: turbine inlet total temperature [K]
%        Power_shat: Shaft power [kW]
%        M_flight; freestream Mach Number
% Output:
%        ehp: Total power [hp]
%        SFC: Specific fuel consumption [lb/h/ehp]
%        f: mass fraction of fuel
%
%--------------------------------------------------------------------------
%-------------- Conversion factors ----------------------------------------
lb2kg    = 0.454;
kg2lb    = 1/lb2kg;
kW2hp    = 1.341;
m2ft     = 3.28084;
% Engine data -------------------------------------------------------------
%T0_4     = 1295;  % Turbine Inlet total temperature [K]
M_inlet  = 0.20;
%D_inlet  = 0.3280;
nm       = 0.98;  % shaft mechanical efficiency
etai     = 0.95;  % Intake isentropic efficiency
prb      = 0.94;  % pressure drop at combustor
etalpc   = 0.85;  % LP compressor efficiency
etahpc   = 0.85;  % HP compressor efficiency
etab     = 0.99;  % Burner efficiency
mturb    = 0.98;  % HPT mechanical efficiency
etahpt   = 0.82;  % HPT polytropic efficiency
etalpt   = 0.88;  % Adiabic efficiency of LPT
etanoz   = 0.95;  % Adiabatic efficiency of the nozzle
PACC     = 22400; % Acessory Drive Power Requirement
mbleed   = 0.0;  % bleed flow [kg/s]
% Constants ---------------------------------------------------------------
gama     = 1.4; % air cp/cv ratio
Cpg      = 1148; % {J/kg K]
PC       = 42800000;   % Poder calorífico (J/kg) 
%--------------------------------------------------------------------------
[atm]  = atmosfera(Alt*m2ft,0);
Ta     = atm(1);
Pa     = atm(5)*1000; % [Pa]
vsom   = atm(7);
v0     = vsom*M_flight;
T0a    = (1 + 0.50*(gama-1)*M_flight^2)*Ta;
Cpa    = engine_getcp(T0a);
R      = ((gama-1)/gama)*Cpa;
P0free = Pa*(T0a/Ta)^(gama/(gama-1));
P0a    = P0free*etai;
%--------------------------------------------------------------------------
% Assume-se que a pressão de estagnacao e a temperatura de estagnacao 
%   nao variam no caminho do ar externo até o início da entrada de ar
%--------------------------------------------------------------------------
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
T0_3    = T0_3lp + del_t_c;   % Temperatura total na saida do compressor
P0_3    = P0_3lp * prchp;     % Pressao total na saida do compressor
Cpa     = engine_getcp(T0_3);
% ----- COMBUSTOR ---------------------------------------------------------
P0_4    = P0_3*prb;
cp4     = engine_getcp(T0_4);
f=(((Cpg*T0_4)-(Cpa*T0_3))/((PC*etab)-(cp4*T0_4))); % fracao da massa do comb;
f=f + mbleed/ma; % Compessasao da extracao de ar de sangria com combustivel
ma_b=ma;
% Turbina de ALTA ---------------------------------------------------------
gama4    = engine_getgamma(T0_4);
%cp4      = engine_getcp(T0_4);
% del_h_ht = del_h_c;
% del_t_ht = (del_h_ht + PACC)/cp4;
%T0_5     = T0_4 - del_t_ht;
T0_5     = T0_4 - (PACC + ma*cp2*(T0_3 - T0_3lp))/(ma_b*cp4*nm);
del_t_ht = T0_4 - T0_5;
del_h_ht = cp4*del_t_ht ;
prat5    = (1-del_h_ht/(cp4*T0_4*etahpt))^(gama4/(gama4-1));
P0_5     = P0_4 * prat5;
%trat5    = T0_5/T0_4;
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
 npr      = max(P0_8/Pa,1);
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
 SFC        = f*ma_b*3600*kg2lb/ehp;
 %-------------------------------------------------------------------------
 fig1=figure(1);
 left_color=[1 0 0];
 right_color=[0 0 1];
 set(fig1,'defaultAxesColorOrder',[left_color; right_color]);
 Tplot=[T0a, T0a,T0_3lp , T0_3, T0_4, T0_5, T0_6, T0_7, T0_8];
 Pplot=[P0free, P0a,P0_3lp , P0_3, P0_4, P0_5, P0_6, P0_7, P0_8];
 staPlot=[0 1 2 3 4 5 6 7 8];
 yyaxis left
 plot(staPlot,Tplot,'-sr','MarkerFaceColor','r','MarkerEdgeColor','k')
 ylabel('Total Temperature [K]')
 text(1,T0a,'LP Compressor','Rotation',90)
 text(2,T0a,'HP Compressor','Rotation',90)
 text(3,T0a,'Combustor','Rotation',90)
 text(4,T0a,'HP Turbine','Rotation',90)
 text(5,T0a,'LP Turbine','Rotation',90)
 text(6,T0a,'Free Turbine','Rotation',90)
 text(7,T0a,'Entering the Nozzle','Rotation',90)
 text(7.9,T0a,'Exit','Rotation',90)
 ax.color='r';
%  Tmin=round(min(Tplot));
%  Tmax=round(max(Tplot));
%  yticks(Tmin:100:Tmax)
 yyaxis right
 plot(staPlot,round(Pplot/1000),'-ob','MarkerFaceColor','b','MarkerEdgeColor','k')
 xlabel('Station')
 ylabel('Total Pressure [kPa]')
 ax.color='g';
%  figure (2)
%  Pplot=[P0free, P0a,P0_3lp , P0_3, P0_4, P0_5, P0_6, P0_7, P0_8];
%  plot(staPlot,round(Pplot/1000),'-og','MarkerFaceColor','g','MarkerEdgeColor','k')
%  text(1,P0free/1000,'LP Compressor','Rotation',90)
%  text(2,P0free/1000,'HP Compressor','Rotation',90)
%  text(3,P0free/1000,'Combustor','Rotation',90)
%  text(4,P0free/1000,'HP Turbine','Rotation',90)
%  text(5,P0free/1000,'LP Turbine','Rotation',90)
%  text(6,P0free/1000,'Free Turbine','Rotation',90)
%  text(7,P0free/1000,'Entering the Nozzle','Rotation',90)
%  text(7.85,P0free/1000,'Exit','Rotation',90)
%  xlabel('Station')
%  ylabel('Total Pressure [kPa]')
%--------------------------------------------------------------------------
fprintf('\n Shaft power %i  %i [hp/kW]',round(1.341*Power_shaft),round(Power_shaft))
fprintf('\n Jet power %i  %i [hp/kW]',round(Pow_jet_hp),round(Pow_jet))
fprintf('\n Total power %i [hp] ',round(ehp))
fprintf('\n Thrust-specific fuel consumption %5.3f [lb/h/ehp]  ',SFC)
fprintf('\n Turbine inlet total temperature %6.0f K ',T0_4)
fprintf('\n Overall Pressure Ratio %6.1f ',prclp*prchp)
fprintf('\n Mass flow rate through the LP compressor %5.2f kg/s ',ma)
fprintf('\n Fuel mass fraction %5.4f  ',f)
fprintf('\n Mach number at exit %6.3f ',M8)
end % function

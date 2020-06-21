%{
Function  : Single_point_run
Descrip.  : Single point analysis of PW120 model based in Mattingly
Author    : Alejandro Rios
Email     : aarc.88@gmail.com
Language  : Matlab
PhD collaboration: ITA - Airbus
Aeronautical Institute of Technology
Date      : May/2020
%}

clear all
close all
% otimizando para ref 3
%       1     2    3     4     5      6    7    8    9 %   10     11    12     13    14    15    16     17    18   19     20   21 
%      M0|   B| eps1| eps|   pid|   pin| ecL| ecH|  etH|  etL|  etF| etamL| etamH| etap|  pic| fpicL|  taut|  Ar1|  Ar2|  Ar3|  Mc| 
x = [0.1188    0.0281    0.0511    0.0948    0.9950    0.9940    0.8434    0.8342    0.8715  0.8428    0.8287    0.9888    0.9751    0.9564   15.4661    0.5812    0.7281    0.6000 0.4365    0.7000    0.7000];
%% =========================================================================
% Execution: Parametric Analysis
% =========================================================================
h = 0;          % Altitude - [ft]
M0 = x(1);      % Mach number
% T0 and P0 are obtained from altitude
% =========================================================================
% Aircraft system parameters:
beta = x(2);       % Bleed air fraction
C_TOL = 0;         % Power Takeoff shaft power coefficienty - LP Spool
C_TOH = 0;         % Power Takeoff shaft power coefficienty - LP Spool
% =========================================================================
% Design limitations:
    % Fuel heating value:
    h_PR = 42798*1000;      % Fuel heating value Kerosene - [J/kg]
    % ---------------------------------------------------------------------
    % Component figures of merit: 
    epsilon1 = x(3);     % Cooling air #1 mass flow rate
    epsilon2 = x(4);     % Cooling air #2 mass flow rate

    % Total pressure ratio:
    pi_b = 0.97;        % Burner
    pi_dmax = x(5);     % Inlet/Difusser
    pi_n = x(6);        % Nozzle
    
    % Polytropic efficiency:
    e_cL = x(7);      % Compressor
    e_cH = x(8);
    e_tH = x(9);      % High pressure turbine
    e_tL = x(10);     % Low pressure turbine
    e_tF = x(11);
    
    % Component efficiency
    eta_b = 0.995;           % Burner
        % Mechanical
        eta_mL = x(12);      % Low pressure spool
        eta_mH = x(13);      % High pressure spool
        eta_mPL = 1;         % Power takeoff- LP spool
        eta_mPH = 1;         % Power takeoff -HP spool
    eta_prop = x(14);        % Proppeler
    eta_g = 0.98;            % Gearbox
% =========================================================================
% Design choices: 
pi_c = x(15);      % Total pressure ratio compressor
pi_cH = (pi_c/2)*x(16);      
pi_cL = pi_c/pi_cH;
tau_t = x(17);    % Total enthalpy ratio of turbine
Tt4 = 1466.15;    % Burner exit temperature - [K]
% =========================================================================
% Others
m0_dot = 6.7;   % Mass flow rate - [kg/s]

[F_m0_dot,S,P_m0_dot,S_P,f0,C_c,C_prop,eta_P,eta_TH,V9_a0,...
    pi_tH,pi_tL,...
    tau_cL,tau_cH,tau_tH,tau_tL,tau_tF,tau_lambda,tau_m1,tau_m2,...
    f,...
    eta_cL,eta_cH,eta_tH,eta_tL,eta_tF,...
    M9,Pt9_P9,P9_P0,Prt3_Prt2,T9_T0,...
    M0_R,T0_R,P0_R,F_R,P_R,pi_r,MFP4,h0,tau_r] = TURB_PARAMETRIC(h, M0,...
    beta, C_TOL, C_TOH,h_PR,...
    epsilon1,epsilon2,...
    pi_b, pi_dmax, pi_n,...
    e_cL,e_cH, e_tH, e_tL,e_tF,...
    eta_b, eta_mL, eta_mH, eta_mPL, eta_mPH,eta_prop,eta_g,...
    pi_cL,pi_cH, tau_t, Tt4,...
    m0_dot);

fprintf('\n =========================================================================')
fprintf('\n =========================================================================')
fprintf('\n Uninstalled power specific fuel consumption %i[Kg/J] %i  [lb/(hp h)] %i [Kg/(KW.hr)]',S_P,S_P*5.918e6, S_P*3.6e6)
fprintf('\n Power %i [kW] %i [hp] ',round(P_R/1000),round(P_R*0.001341))
fprintf('\n Thrust %i  %i [N]',round(F_R))
fprintf('\n Overall Pressure Ratio %i',(Prt3_Prt2))
fprintf('\n Compressor mass flow %i',(Prt3_Prt2))
fprintf('\n T turbine [K] %i',round(Tt4))

%% =========================================================================
% Execution Take-off: Performance Analysis
% =========================================================================
% =========================================================================
% Inputs:
% =========================================================================
% Performance choices:
    % Flight parameters:
    h = h;
    M0 = M0;
    % T0 and P0 are obtained from altitude
    % Throttle setting
    Tt4 = Tt4;         % Burner exit temperature 
% =========================================================================
% Design cosntants:
    % Total Pressure ratios
    pi_dmax = pi_dmax;     % Inlet/Diffuser
    pi_b = pi_b;        % Burner
    pi_n = pi_n;        % Nozzle
    
    % Adiabatic eff. of components
    eta_c = eta_cL*eta_cH;        % Compressor
    eta_tH = eta_tH;       % High pressure turbine
    eta_tL = eta_tL;       % Low pressure turbine
    % Component efficiency
    eta_b = eta_b;       % Burner  
        % Mechanical
        eta_mL = eta_mL;      % Low pressure spool
        eta_mH = eta_mH;      % High pressure spool
        eta_mPL = eta_mPL;     % Power takeoff - LP Spool
        eta_mPH = eta_mPH;     % Power takeoff - HP Spool
    eta_propmax = eta_prop;     % Propeller
    
    % Area ratio
    A4_A4_5 = x(18);
    A4_5_A5 = x(19);
    A5_A8 = x(20);
       
    % Others
    beta = beta;       % Bleed air fraction
    epsilon1 = epsilon1;     % Cooling air #1 mass flow rate
    epsilon2 = epsilon2;     % Cooling air #2 mass flow rate
    h_PR = h_PR;  % Fuel heating value
    P_TOL = 0;      % Power Takeoff shaft power extraction - LP Spool
    P_TOH = 0;      % Power Takeoff shaft power extraction - HP Spool
% =========================================================================
% Reference condition:
    % Flight parameters
    M0_R = M0_R;
    T0_R = T0_R;
    P0_R = P0_R;
% -------------------------------------------------------------------------
    % Component behavior: 
    pi_cL_R = pi_cL;
    pi_cH_R = pi_cH;
    pi_tH_R = pi_tH;
    pi_tL_R = pi_tL;
    pi_r_R = pi_r;
    pi_d_R = pi_dmax;
    
    
    tau_cL_R = tau_cL;
    tau_cH_R = tau_cH;
    tau_tH_R = tau_tH;
    tau_tL_R = tau_tL;
    tau_tF_R = tau_tF;
    tau_r_R = tau_r;
% -------------------------------------------------------------------------
    % Others:
    Tt4_R = Tt4;
    tau_m1_R = tau_m1;
    tau_m2_R = tau_m2;
    f_R = f;
    M8_R = M9;
    C_TOL_R = C_TOL;
    C_TOH_R = C_TOH;
    F_R = F_R;
    m0_dot_R = m0_dot;
    S_R = S;
    MFP4_R = MFP4;
    h0_R = h0;
% =========================================================================    
% Engine control limits:
    pi_c_max = pi_c;
    Tt3_max = 888.88;
    Pt3_max = 0;
    NL_percent = 1.2;
    NH_percent = 1.2;

[F,P_TO,m0_dot,S,S_P_TO,f0,eta_P,eta_TH,eta_O,C_c,C_prop,...
    V9_a0,Pt9_P9,P9_P0,T9_T0,...
    pi_cL,pi_cH,pi_tH,pi_tL,...
    tau_cL,tau_cH,tau_tH,tau_tL,tau_lambda,...
    tau_m1,tau_m2,f,M8,M9,...
    Tt4,...
    T_vec_TO,P_vec_TO] = TURB_PERFORMANCE(h,M0,...
    Tt4,...
    pi_dmax,pi_b,pi_n,...
    eta_cL,eta_cH,eta_tH,eta_tL,eta_tF,eta_b,eta_mL,eta_mH,eta_mPL,eta_mPH,eta_propmax,eta_g,...
    A4_A4_5, A4_5_A5,A5_A8,...
    beta,epsilon1,epsilon2,h_PR,P_TOL,P_TOH,...
    M0_R,T0_R,P0_R,...
    pi_cL_R,pi_cH_R,pi_tH_R,pi_tL_R,pi_r_R,pi_d_R,...
    tau_cL_R,tau_cH_R,tau_tH_R,tau_tL_R,tau_tF_R,...
    Tt4_R ,tau_m1_R,tau_m2_R,f_R, M8_R,C_TOL_R,C_TOH_R,...
    F_R,m0_dot_R,S_R,MFP4_R,h0_R,tau_r_R,...
    pi_c_max,Tt3_max,Pt3_max,NL_percent,NH_percent);

fprintf('\n =========================================================================')
fprintf('\n Uninstalled power specific fuel consumption %i[Kg/J] %i  [lb/(hp h)] %i [Kg/(KW.hr)]',S_P_TO,S_P_TO*5.918e6, S_P_TO*3.6e6)
fprintf('\n Power %i [kW] %i [hp] ',round(P_TO/1000),round(P_TO*0.001341))
fprintf('\n Thrust %i  %i [N]',round(F))
fprintf('\n Overall Pressure Ratio %i',(Prt3_Prt2))
fprintf('\n Compressor mass flow %i',(Prt3_Prt2))
fprintf('\n T turbine [K] %i',round(Tt4))

P_TO_ref = 1566;
ESFC_TO_ref = 0.485;

P_TO = P_TO/1000;
ESFC_TO = S_P_TO*5.918e6;

P_TO_error = abs(P_TO - P_TO_ref )/P_TO_ref;
ESFC_TO_error = abs(ESFC_TO - ESFC_TO_ref)/ESFC_TO_ref;

fprintf('\n Error P %i',(P_TO_error*100));
fprintf('\n Error SFC %i',(ESFC_TO_error*100));

%% =========================================================================
% Execution Cruise:: Performance Analysis
% =========================================================================
% =========================================================================
% Inputs:
% =========================================================================
% Performance choices:
    % Flight parameters:
 h = 25000;
    M0 = x(21);
    % T0 and P0 are obtained from altitude
    % Throttle setting
    Tt4 = Tt4;         % Burner exit temperature 
    
[F,P_cruise,m0_dot,S,S_P_cruise,f0,eta_P,eta_TH,eta_O,C_c,C_prop,...
    V9_a0,Pt9_P9,P9_P0,T9_T0,...
    pi_cL,pi_cH,pi_tH,pi_tL,...
    tau_cL,tau_cH,tau_tH,tau_tL,tau_lambda,...
    tau_m1,tau_m2,f,M8,M9,...
    Tt4,...
    T_vec_cruise,P_vec_cruise] = TURB_PERFORMANCE(h,M0,...
    Tt4,...
    pi_dmax,pi_b,pi_n,...
    eta_cL,eta_cH,eta_tH,eta_tL,eta_tF,eta_b,eta_mL,eta_mH,eta_mPL,eta_mPH,eta_propmax,eta_g,...
    A4_A4_5, A4_5_A5,A5_A8,...
    beta,epsilon1,epsilon2,h_PR,P_TOL,P_TOH,...
    M0_R,T0_R,P0_R,...
    pi_cL_R,pi_cH_R,pi_tH_R,pi_tL_R,pi_r_R,pi_d_R,...
    tau_cL_R,tau_cH_R,tau_tH_R,tau_tL_R,tau_tF_R,...
    Tt4_R ,tau_m1_R,tau_m2_R,f_R, M8_R,C_TOL_R,C_TOH_R,...
    F_R,m0_dot_R,S_R,MFP4_R,h0_R,tau_r_R,...
    pi_c_max,Tt3_max,Pt3_max,NL_percent,NH_percent);

fprintf('\n =========================================================================')
fprintf('\n Uninstalled power specific fuel consumption %i[Kg/J] %i  [lb/(hp h)] %i [Kg/(KW.hr)]',S_P_cruise,S_P_cruise*5.918e6, S_P_cruise*3.6e6)
fprintf('\n Power %i [kW] %i [hp] ',round(P_cruise/1000),round(P_cruise*0.001341))
fprintf('\n Thrust %i  %i [N]',round(F))
fprintf('\n Overall Pressure Ratio %i',(Prt3_Prt2))
fprintf('\n Compressor mass flow %i',(Prt3_Prt2))
fprintf('\n T turbine [K] %i',round(Tt4))


P_cruise_ref = 1295;
P_cruise = P_cruise/1000;
P_cruise_error = abs(P_cruise - P_cruise_ref )/P_cruise_ref ;

T_cruise_ref = 1366;
T_cruise = Tt4;
T_cruise_error = abs(T_cruise - T_cruise_ref )/T_cruise_ref ;

fprintf('\n Error P %i',(P_cruise_error*100));
fprintf('\n Error T %i',(T_cruise_error*100));

%% Plots
figure(1)
subplot(2,1,2)
Tplot= T_vec_cruise;
staPlot=[0 1 2 3 4 5 6 7 8];
plot(staPlot,T_vec_TO,'-ob',staPlot,T_vec_cruise,'-or','LineWidth',2)
text(1,0,'LP Compressor','Rotation',90)
text(2,0,'HP Compressor','Rotation',90)
text(3,0,'Combustor','Rotation',90)
text(4,0,'HP Turbine','Rotation',90)
text(5,0,'LP Turbine','Rotation',90)
text(6,0,'Free Turbine','Rotation',90)
text(7,0,'Nozzle','Rotation',90)
xlabel('Station')
ylabel('Total Temperature [K]')
grid on
subplot(2,1,1)
Pplot= P_vec_cruise/1000;
staPlot=[0 1 2 3 4 5 6 7 8];
plot(staPlot,P_vec_TO/1000,'-ob',staPlot,P_vec_cruise/1000,'-or','LineWidth',2)
xlabel('Station')
ylabel('Total Pressure [KPa]')
legend('Takeoff','Cruise')
grid on

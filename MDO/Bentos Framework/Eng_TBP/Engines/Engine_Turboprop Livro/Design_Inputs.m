clear all
close all
% otimizando para ref 2
% x =  [0.0988    0.3631    0.0866    0.0154    0.8946    0.9765    0.8602    0.8145    0.8851    1.0000    1.0000    0.8901    0.5061    0.0541    0.0738]
% otimizando para ref 3
% x =  [0.1001    0.0356    0.0379    0.0149    0.9843    0.9849    0.8935    0.8224    0.8380    1.0000    1.0000    0.9662    0.4870    0.1734    0.0644]
% otimizando para ref 3 com Mach restrito
% x = [0.0586    0.4618    0.0949    0.0881    0.9624    0.9168    0.8863    0.8609    0.9000    1.0000    1.0000    0.8298    0.4775    0.0268    0.1501]
% =========================================================================
% Inputs:
% =========================================================================
% =========================================================================
% Flight parameters:
h = 25000;          % Altitude - [ft]
M0 = 0.8;     % Mach number
% T0 and P0 are obtained from altitude
% =========================================================================
% Aircraft system parameters:
beta = 0;       % Bleed air fraction
C_TOL = 0;       % Power Takeoff shaft power coefficienty - LP Spool
C_TOH = 0;       % Power Takeoff shaft power coefficienty - LP Spool
% =========================================================================
% Design limitations:
    % Fuel heating value:
    h_PR = 42798*1000;      % Fuel heating value Kerosene - [J/kg]
    % ---------------------------------------------------------------------
    % Component figures of merit: 
    epsilon1 = 0.05;     % Cooling air #1 mass flow rate
    epsilon2 = 0.05;     % Cooling air #2 mass flow rate

    % Total pressure ratio:
    pi_b = 0.96;        % Burner
    pi_dmax = 0.97;     % Inlet/Difusser
    pi_n = 0.99;        % Nozzle
    
    % Polytropic efficiency:
    e_c = 0.9;      % Compressor
    e_tH = 0.89;    % High pressure turbine
    e_tL = 0.91;    % Low pressure turbine
    
    % Component efficiency
    eta_b = 0.995;           % Burner
        % Mechanical
        eta_mL = 0.99;      % Low pressure spool
        eta_mH = 0.98;      % High pressure spool
        eta_mPL = 1;     % Power takeoff- LP spool
        eta_mPH = 1;     % Power takeoff -HP spool
    eta_prop = 0.82;        % Proppeler
    eta_g = 0.99;           % Gearbox
% =========================================================================
% Design choices: 
pi_c = 10;      % Total pressure ratio compressor
tau_t = 0.7;      % Total enthalpy ratio of turbine
Tt4 = 1777.778;    % Burner exit temperature - [K]
% =========================================================================
% Others
m0_dot = 10;   % Mass flow rate - [kg/s]
% =========================================================================
% Execution:
% =========================================================================

[F_m0_dot,S,P_m0_dot,S_P,f0,C_c,C_prop,eta_P,eta_TH,V9_a0,...
    pi_tH,pi_tL,...
    tau_cL,tau_tH,tau_tL,tau_lambda,tau_m1,tau_m2,...
    f,...
    eta_c,eta_tH,eta_tL,...
    M9,Pt9_P9,P9_P0,Prt3_Prt2,T9_T0,...
    M0_R,T0_R,P0_R,F_R,P_R,pi_r,MFP4,h0,tau_r] = TURB_PARAMETRIC(h, M0,...
    beta, C_TOL, C_TOH,h_PR,...
    epsilon1,epsilon2,...
    pi_b, pi_dmax, pi_n,...
    e_c, e_tH, e_tL,...
    eta_b, eta_mL, eta_mH, eta_mPL, eta_mPH,eta_prop,eta_g,...
    pi_c, tau_t, Tt4,...
    m0_dot);

fprintf('\n Uninstalled specific power of the engine %i  %i [J/Kg]',round(P_m0_dot))
fprintf('\n Uninstalled power specific fuel consumption %i[Kg/J] %i  [lb/(hp h)] %i [Kg/(KW.hr)]',S_P,S_P*5.918e6, S_P*3.6e6)
fprintf('\n Power %i [kW] %i [hp] ',round(P_R/1000),round(P_R*0.001341))
fprintf('\n Thrust %i  %i [N]',round(F_R))
fprintf('\n Overall Pressure Ratio %i',(Prt3_Prt2))
fprintf('\n Compressor mass flow %i',(Prt3_Prt2))

fprintf('\n Uninstalled thrust specific fuel consumption %i[mg/N-s]',S*1e6)



P_ref = 1566;
ESFC_ref = 0.485;

% P_ref = 1491;
% ESFC_ref = 0.470;


error_P = abs((P_R/1000) - P_ref)/P_ref;
error_ESFC = abs((S_P*5.918e6) - ESFC_ref )/ESFC_ref ;

fprintf('\n Error P %i',error_P*100)
fprintf('\n Error SFC %i',error_ESFC*100)




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
    eta_c = eta_c;        % Compressor
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
    
    % Areas
    A4 = 20.2168;         % Burner exit
    A4_5 = 36.4869;       % Coolant mixer exit
    A8 = 57.1278;         % Nozzle exit
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
    pi_c_R = pi_c;
    pi_tH_R = pi_tH;
    pi_tL_R = pi_tL;
    pi_r_R = pi_r;
    pi_d_R = pi_dmax;
    
    tau_cL_R = tau_cL;
    tau_tH_R = tau_tH;
    tau_tL_R = tau_tL;
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
% =========================================================================
% Execution:
% =========================================================================



[F,P,m0_dot,S,S_P,f0,eta_P,eta_TH,eta_O,C_c,C_prop,...
    V9_a0,Pt9_P9,P9_P0,T9_T0,...
    pi_c,pi_tH,pi_tL,tau_c,tau_tH,tau_tL,tau_lambda,...
    tau_m1,tau_m2,f,M8,M9] = TURB_PERFORMANCE(h,M0,...
    Tt4,...
    pi_dmax,pi_b,pi_n,...
    eta_c,eta_tH,eta_tL,eta_b,eta_mL,eta_mH,eta_mPL,eta_mPH,eta_propmax,eta_g,...
    A4,A4_5,A8,...
    beta,epsilon1,epsilon2,h_PR,P_TOL,P_TOH,...
    M0_R,T0_R,P0_R,...
    pi_c_R,pi_tH_R,pi_tL_R,pi_r_R,pi_d_R,...
    tau_cL_R,tau_tH_R,tau_tL_R,...
    Tt4_R ,tau_m1_R,tau_m2_R,f_R, M8_R,C_TOL_R,C_TOH_R,...
    F_R,m0_dot_R,S_R,MFP4_R,h0_R,tau_r_R,...
    pi_c_max,Tt3_max,Pt3_max,NL_percent,NH_percent);


fprintf('\n ===================================================================')
fprintf('\n Uninstalled specific power of the engine %i  %i [J/Kg]',round(P_m0_dot))
fprintf('\n Uninstalled power specific fuel consumption %i[Kg/J] %i  [lb/(hp h)] %i [Kg/(KW.hr)]',S_P,S_P*5.918e6, S_P*3.6e6)
fprintf('\n Power %i [kW] %i [hp] ',round(P/1000),round(P*0.001341))
fprintf('\n Thrust %i  %i [N]',round(F))
fprintf('\n Overall Pressure Ratio %i',(Prt3_Prt2))
fprintf('\n Compressor mass flow %i',(Prt3_Prt2))
fprintf('\n Uninstalled thrust specific fuel consumption %i[mg/N-s]',S*1e6)
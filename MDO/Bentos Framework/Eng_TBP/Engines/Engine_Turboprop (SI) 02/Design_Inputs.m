clear all
close all


% =========================================================================
% Inputs:
% =========================================================================
% Flight parameters:
h = 0;
M0 = 0.166;
% T0 and P0 are obtained from altitude
% =========================================================================
% Aircraft system parameters:
beta = 0.0;        % Bleed air fraction
C_TOL = 0;       % Power Takeoff shaft power coefficienty - LP Spool
C_TOH = 0;       % Power Takeoff shaft power coefficienty - LP Spool
% =========================================================================
% Design limitations:
    % Fuel heating value:
    h_PR = 43.1e6;      % Fuel heating value Kerosene
    % ---------------------------------------------------------------------
    % Component figures of merit: 
    epsilon1 = 0.0;     % Cooling air #1 mass flow rate
    epsilon2 = 0.0;     % Cooling air #2 mass flow rate

    % Total pressure ratio:
    pi_b = 0.97;        % Burner
    pi_dmax = 0.95;     % Inlet/Difusser
    pi_n = 0.99;        % Nozzle
    
    % Polytropic efficiency:
    e_c = 0.9;      % Compressor
    e_tH = 0.89;    % High pressure turbine
    e_tL = 0.91;    % Low pressure turbine
    
    % Component efficiency
    eta_b = 0.995;           % Burner
        % Mechanical
        eta_mL = 0.98;      % Low pressure spool
        eta_mH = 0.99;      % High pressure spool
        eta_mPL = 0.95;     % Power takeoff- LP spool
        eta_mPH = 0.95;     % Power takeoff -HP spool
    eta_prop = 0.82;        % Proppeler
    eta_g = 0.98;           % Gearbox
% =========================================================================
% Design choices: 
pi_c = 12.1;      % Total pressure ratio compressor
tau_t = 0.5;    % Total enthalpy ratio of turbine
Tt4 = 1466.15;     % Burner exit temperature 
% =========================================================================
% Others
m0_dot = 100;   % Mass flow rate
% =========================================================================
% Execution:
% =========================================================================

[F_m0_dot,S,P_m0_dot,S_P,f0,C_c,C_prop,eta_P,eta_TH,V9_a0,...
    pi_tH,pi_tL,...
    tau_cL,tau_tH,tau_tL,tau_lambda,tau_m1,tau_m2,...
    f,...
    eta_c,eta_tH,eta_tL,...
    M9_R,Pt9_P9,P9_P0,T9_T0,...
    M0_R,T0_R,P0_R,F_R,pi_r,MFP4,h0,tau_r] = TURB_PARAMETRIC(h, M0,...
    beta, C_TOL, C_TOH,h_PR,...
    epsilon1,epsilon2,...
    pi_b, pi_dmax, pi_n,...
    e_c, e_tH, e_tL,...
    eta_b, eta_mL, eta_mH, eta_mPL, eta_mPH,eta_prop,eta_g,...
    pi_c, tau_t, Tt4,...
    m0_dot);


% =========================================================================
% Inputs:
% =========================================================================
% Performance choices:
    % Flight parameters:
    h = 0;
    M0 = 0.166;
    % T0 and P0 are obtained from altitude
    % Throttle setting
    Tt4 = 1466.15;         % Burner exit temperature 
% =========================================================================
% Design cosntants:
    % Total Pressure ratios
    pi_dmax = 0.95;     % Inlet/Diffuser
    pi_b = 0.97;        % Burner
    pi_n = 0.99;        % Nozzle
    
    % Adiabatic eff. of components
    eta_c = 0.9;        % Compressor
    eta_tH = 0.9;       % High pressure turbine
    eta_tL = 0.9;       % Low pressure turbine
    % Component efficiency
    eta_b = 0.995;       % Burner  
        % Mechanical
        eta_mL = 0.98;      % Low pressure spool
        eta_mH = 0.99;      % High pressure spool
        eta_mPL = 0.95;     % Power takeoff - LP Spool
        eta_mPH = 0.95;     % Power takeoff - HP Spool
    eta_propmax = 0.82;     % Propeller
    
    % Areas
    A4 = 1;         % Burner exit
    A4_5 = 1;       % Coolant mixer exit
    A8 = 1;         % Nozzle exit
    % Others
    beta = 0.2;       % Bleed air fraction
    epsilon1 = 0.0;     % Cooling air #1 mass flow rate
    epsilon2 = 0.0;     % Cooling air #2 mass flow rate
    h_PR = 43.1e6;  % Fuel heating value
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
    M8_R = M9_R;
    C_TOL_R = C_TOL;
    C_TOH_R = C_TOH;
    F_R = F_R;
    m0_dot_R = m0_dot;
    S_R = S;
    MFP4_R = MFP4;
    h0_R = h0;
% =========================================================================    
% Engine control limits:
    pi_c_max = 30;
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
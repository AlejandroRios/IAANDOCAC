function T=Thrust_jet(T0,BPR,h_ft,M)
% Calculo da tracao do motor
% Ref: Howe - Aircraft Conceptual Design Synthesis
%--------------------------------------------------------------------------
atm=atmosfera(h_ft,0);
rho=atm(6);
sigma=rho/1.225;

if M < 0.40
    K1=1;
    K2=0;
    K3=-0.60;
    K4=-0.04;
else
    K1=0.88;
    K2=-0.016;
    K3=-0.30;
    K4=0;
end
slinha=0.70;
if h_ft > 36089
    slinha=1;
end
tau_factor=(K1 + K2*BPR + (K3 + K4*BPR)*M)*(sigma^slinha);
T=T0*tau_factor;
end % function TSFC 
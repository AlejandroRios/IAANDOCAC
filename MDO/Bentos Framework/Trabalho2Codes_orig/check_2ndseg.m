function w2seg=check_2ndseg(AirportElevation,wS,bw,wMAC,tcmed,...
    neng,bflap,FusDiam,clmaxt,...
    W,VTS,VTSweep,ediam,ebypass,dflecflaptakeoff,k_ind_inc,Swet_tot)
%--------------------------------------------------------------------------
% Required T/W  for 2nd segment climb 
%--------------------------------------------------------------------------
g       = 9.80665;
rad     = pi/180;
ft2m    = 0.3048;
m2ft    = 1./ft2m;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
atm    = atmosfera(AirportElevation*m2ft,0);
    ro     = atm(6); % densidade [kg/m³]
    va     = atm(7); % velocidade do som [m/s]
%--------------------------------------------------------------------------
cl2seg              = clmaxt/1.44;
V                   = sqrt((W*g)/(cl2seg*wS*0.50*ro));
M                   = V/va;
M                   = max(0.20,M);
V                   = M*va;
q                   = (1/2)*ro*V*V;
cl2seg              = (W*g)/(q*wS);
CD0_airp_inc        = cd0torenbeek(M,wS,bw,wMAC,tcmed,FusDiam,...
    AirportElevation*m2ft,Swet_tot);
CD_airp             = CD0_airp_inc + k_ind_inc*(cl2seg^2);
% Drag increase due to flaps and rudder deflection
dcdflapetakeoff     = Drag_flap(dflecflaptakeoff,bflap);
dcdrudder           = 0.0020*cos(rad*VTSweep)*(VTS/wS); 
dcdwindmilli        = CDWINDMILLTOREN(M,ediam,ebypass);
%
cd2seg              = CD_airp+dcdflapetakeoff+dcdrudder+(dcdwindmilli/wS);
ld2seg              = cl2seg/cd2seg;
%
w2seg = 1;
switch neng
case 2 
w2seg =2*(1/ld2seg+atan(0.024));
case 3
w2seg =(3/2)*(1/ld2seg+atan(0.027));
case 4
w2seg =(4/3)*(1/ld2seg+atan(0.03));
end
%
end % function
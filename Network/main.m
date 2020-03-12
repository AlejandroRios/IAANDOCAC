clear all
clc
% 
fixedW = 600;
      R = 200*1852;         %convert nmi to m
      L_over_D = 12;
      PSFC = 0.4*1.657e-06; %convert lbm/hr/bhp to 1/m
      eta_prop = 0.6;

      segments = {.98  %startup, runup, taxi, takeoff
                  .99          %climb
             breguet('Prop','Cruise', R, L_over_D, PSFC, false, eta_prop)
                  .99};        %decent, landing, taxi, shutdown

      fuel_safety_margin = 0.06;
      FF = (1+fuel_safety_margin)*missionfuelburn(segments{:});

      EWfunc = @(W0) 3.03*W0.^-.235;
      W0 = fuelfractionsizing(EWfunc, fixedW, FF)

% [R, t]    = breguet('Jet', 'Range', 0.7, 0.866*18, 0.5, 500)

%  A0 = 3.03; A = linspace(.8*A0,1.2*A0,30);
%       W0 = fuelfractionsizing({A -0.235}, 400, 1.06*missionfuelburn...
%        (.98,.99,breguet('Prop','Cruise',1111200,10,6.628e-07,0,.8),.99));
%       plot(A,W0); xlabel('A'); ylabel('W0 (lb)')


%  R = 1852*(300:2:1000)'; %convert nmi to m
%       fixedW = 200:2:600;
%       [R, fixedW] = meshgrid(R,fixedW);
%       W0 = fuelfractionsizing({3.03 -.235},fixedW,1.06*missionfuelburn...
%      (.98,.99,breguet('Prop','Cruise',R,10,6.628e-07,0,.8),.99),[],1320);
%       surfc(R/1852,fixedW,W0,'LineStyle','none')
%       xlabel('Range (nmi)'); ylabel('Fixed Weights (lb)')
%       zlabel('Gross Weight (lb)')
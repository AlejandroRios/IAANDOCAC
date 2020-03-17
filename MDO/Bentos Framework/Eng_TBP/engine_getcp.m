

function cp = getcp(temp)

tempr = temp*1.8;      % converte de kelvin para rankine

a =  -4.4702130e-13;
b =  -5.1286514e-10;
c =   2.8323331e-05;
d =  0.2245283;
      
cp = a*tempr^3 + b*tempr^2 + c*tempr + d; % btu/(lb*R)

cp = cp*4187.65276736494;    % J/(kg*K)

%**************************************************************************
%
%   Função para obter mach em função da vazão mássica por área (mdot_a)
%   Retirado do código fonte do software EngineSim da NASA
%   http://www.grc.nasa.gov/WWW/K-12/airplane/ngnsim.html
%
%   input:  mdot_a [kg/(s.m^2)]
%           gama
%           P - Total Pressure [Pa]
%           T - Total Temperature [K]
%   output: Mach
%
%**************************************************************************
%function Mach=getmach(mdot_a,gama,P,T,R)

% f fun is parameterized, you can use anonymous functions to capture the problem-dependent parameters. For example, suppose you want to find a zero of the function myfun defined by the following M-file function.
% function f = flow(mach,mdot_a,gama,P,T,R)
% f = ......
% Note that myfun has an extra parameter a, so you cannot pass it directly to fzero. To optimize for a specific value of a, such as a = 2.
% % Assign the value to a. 
% a = 2; % define parameter first% 
% Call fzero with a one-argument anonymous function that captures that value of a and calls myfun with two arguments:
% x = fzero(@(x) flow(mach,mdot_a,gama,P,T,R),0.1)

%Mach = fzero(@(Mach) flow(Mach,mdot_a,gama,P,T,R),[0 1]); 

% function f=fflow(mach,mdot_a,gama,P,T,R)
% 
% fator1 = -0.5*(gama+1)/(gama-1);
% fator2 = (1 + 0.5*(gama-1)*mach^2)^fator1;
% f = mdot_a - P*sqrt(gama/(R*T))*mach*fator2;
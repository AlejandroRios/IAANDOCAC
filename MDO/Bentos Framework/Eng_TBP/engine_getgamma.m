function gamma = getgamma(temp)

tempr = temp*1.8;      % converte de kelvin para rankine

a =  -7.6942651e-13;
b =  1.3764661e-08;
c =  -7.8185709e-05;
d =  1.436914;

gamma = a*tempr^3 + b*tempr^2 + c*tempr + d;

%**************************************************************************
%
%   Função para obter cp em função da temperatura
%   Retirado do código fonte do software EngineSim da NASA
%   http://www.grc.nasa.gov/WWW/K-12/airplane/ngnsim.html
%
%   input: temperatura [K]
%   output: Cp [J/(kg*K)]
%
%**************************************************************************
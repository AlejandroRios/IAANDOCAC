%{
Function  : main
Descrip.  : GA main function for the error optimization of PW120 engine
Author    : Alejandro Rios
Email     : aarc.88@gmail.com
Language  : Matlab
PhD collaboration: ITA - Airbus
Aeronautical Institute of Technology
Date      : May/2020
%}

function main_genetico
clc
clear 
close all

Nvar = 21;
PopSize = 50;

if exist('population.dat','file') > 0
    delete 'population.dat';
end

options=gaoptimset('CrossoverFcn',{'crossoverscattered'},...
                    'EliteCount',1,...
                    'PopulationSize',PopSize,...
                    'TolFun', 1.0e-4,...
                    'Generations',1000,...
                    'Display','iter',...
                    'PlotFcns',{@gaplotbestindiv,@gaplotbestf});
% Engine variables               
%       1     2    3     4     5      6    7    8    9 %   10     11    12     13    14    15    16     17    18   19     20   21 
%      M0|   B| eps1| eps|   pid|   pin| ecL| ecH|  etH|  etL|  etF| etamL| etamH| etap|  pic| fpicL|  taut|  Ar1|  Ar2|  Ar3|  Mc|   
lb = [0.1; 0.02;  0.02; 0.02; 0.880; 0.900; 0.8; 0.8; 0.80; 0.80; 0.80;  0.90;  0.90; 0.80; 12; 0.58;  0.60;  0.4;  0.4;  0.5; 0.3];
ub = [0.2;  0.1;   0.1;  0.1; 0.995; 0.995; 0.9; 0.9; 0.91; 0.91; 0.91;  0.99;  0.99; 0.99; 20;  0.7;  0.75;  0.6;  0.6;  0.7; 0.7];


[x,~,~,~,population]=ga(@Fobjetivo,Nvar,[],[],[],[],lb,ub,[],[],options);
%--------------------------------------------------------------------------
% Screen output of the optimal engine characteristics
optimal_engine=x
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%    Write last population to file
%--------------------------------------------------------------------------
format='';
for i=1:Nvar
    format = strcat(format,'%f   ');
end
format = strcat(format,'\n');
output = fopen('population.dat', 'w+');
for i=1:PopSize
fprintf(output, format, population(i,1:1:Nvar));
end
fclose(output);
end % function
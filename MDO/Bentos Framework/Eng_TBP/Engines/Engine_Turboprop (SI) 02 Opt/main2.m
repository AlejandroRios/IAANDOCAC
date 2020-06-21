function main_genetico

clc
clear 
close all

% Design variables

% 1- CTOL
% 2- CTOH
% 3- epsilon1
% 4- epsilon2
% 5- pi_dmax
% 6- pi_n
% 7- e_c
% 8- e_tH
% 9- e_tL
% 10- eta_mPL
% 11- eta_mPH
% 12- eta_prop
% 13- tau_t
% 14- Beta
% 15- Mach
% 16- mdot0
Nvar = 2;
PopSize = 50;

if exist('population.dat','file') > 0
    delete 'population.dat';
end

options=gaoptimset('CrossoverFcn',{'crossoverscattered'},...
                    'EliteCount',1,...
                    'PopulationSize',PopSize,...
                    'TolFun', 1.0e-10,...
                    'Generations',200,...
                    'Display','iter',...
                    'PlotFcns',{@gaplotbestindiv,@gaplotbestf});
% %    1     2    3     4     5       6     7     8      9    10   11    12     13
% lb=[ 0;    0;  0.0;   0;   0.88;   0.9;  0.8;  0.8;   0.8;   1;   1;   0.8;    0.45; 0.0; 0.0; 0];
% ub=[ 0;    0;  0.1;  0.1;  0.995; 0.995; 0.9;  0.91;  0.91;  1;   1;   0.99;   0.75; 0.1; 0.7; 50];

lb = [0;0]; 
ub = [2;2];

[xx,~,~,output,population]=ga(@Fobjetivo2,Nvar,[],[],[],[],lb,ub,[],[],options);
%--------------------------------------------------------------------------
% Screen output of the optimal airplane characteristics
optimal_airplane=xx
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
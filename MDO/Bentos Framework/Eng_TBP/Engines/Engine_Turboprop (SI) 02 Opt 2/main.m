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
% 14- beta
% 15- pi_b
% 16- eta_b
% 17- M0
% 18- Tt4
Nvar = 18;
PopSize = 200;

if exist('population.dat','file') > 0
    delete 'population.dat';
end

options=gaoptimset('CrossoverFcn',{'crossoverscattered'},...
                    'EliteCount',1,...
                    'PopulationSize',PopSize,...
                    'TolFun', 1.0e-10,...
                    'Generations',Nvar*100,...
                    'Display','iter',...
                    'PlotFcns',{@gaplotbestindiv,@gaplotbestf});
%    1  2  3     4     5      6      7    8     9     10  11  12    13    14
lb=[ 0; 0; 0.0;  0.0;  0.88;  0.9;   0.8; 0.8;  0.8;  0;  0;  0.8;  0.45; 0;    0.90; 0.88;  0;   1000/1000];
ub=[ 1; 1; 0.1;  0.1;  0.995; 0.995; 0.9; 0.91; 0.91; 1;  1;  0.99; 0.75; 0.2;  0.96; 0.995; 0.2; 1700/1000];
[x,~,~,output,population]=ga(@Fobjetivo,Nvar,[],[],[],[],lb,ub,[],[],options);
%--------------------------------------------------------------------------
% Screen output of the optimal airplane characteristics
optimal_airplane=x
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
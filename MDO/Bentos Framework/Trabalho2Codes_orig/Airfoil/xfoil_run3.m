function [clmax,ldmax,flag_success]=xfoil_run3(xfoil_sim_data)
%
%close('all')
fclose('all');
%
% This MATLAB code calls XFOIL panel program to calculate de Clmax and 
% L/D for a given airfoil at specified flow conditions.
% CREDIT: Ney Secco ITA
%
flag_success = 0; % initially ok
%
%xfoil_sim_data.airfoil_name='../Airfoil/pkink'; % Airfoil coordinates
% is read from file with "dat" extension

xfoil_sim_data.N=160;
xfoil_sim_data.P=[];
xfoil_sim_data.T=0.45;
xfoil_sim_data.R=[];
xfoil_sim_data.XT=[];
xfoil_sim_data.XB=[];
xfoil_sim_data.iter=160;
xfoil_sim_data.min_alpha=0;
xfoil_sim_data.max_alpha=22*pi/180;
xfoil_sim_data.step_alpha=0.10*pi/180;
xfoil_sim_data.delete_source=0;
xfoil_sim_data.turn_bijective=0;
%xfoil_sim_data.id  = 1;
plot_mode = 1;
% time2check = 5;
% checks2kill = 4;

airfoil=xfoil_xfez(xfoil_sim_data,plot_mode);
sizeresults=size(airfoil.results.cl,2);
%
if sizeresults < 3
    flag_success =1;
    return
else
clseq=airfoil.results.cl;
i=1;
while clseq(i+1) > clseq(i) && i<= (sizeresults-2)
    clmax=clseq(i);
    i=i+1;
end
% 
ldmax = 0;
%
for i=1:sizeresults
    ld=airfoil.results.cl(i)/airfoil.results.cd(i);
    ldmax=max(ldmax,ld);
end

fprintf('\n Airfoil: %s has clmax = %f and L/D max = %f \n',...
    xfoil_sim_data.airfoil_name,clmax,ldmax)
%
clear clseq airfoil
end
end % function
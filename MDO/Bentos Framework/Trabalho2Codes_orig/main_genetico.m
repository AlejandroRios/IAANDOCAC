function main_genetico
clc
clear
close all
%------------------------ Variaveis de projeto ----------------------------
% 1-  Area de referencia da asa [m2]
% 2-  Alongamento da asa
% 3-  Afilamento da asa
% 4-  Enflechamento da asa a 1/4 de corda
% 5-  Torção da asa
% 6-  Posicao da quebra no bordo de fuga da asa (fracao da semi-envergadura)
% 7-  Incidencia da estacao da quebra
% 8-  Razao de altura/largura da secao transversal da cabina de passageiros
% 9-  Indice do perfil da raiz
% 10- Indice do perfil da quebra
% 11- Indice do perfil da ponta
% 12- Indice de escolha do motor
% 13- Teto de serviço [pes]
%                = 1 ==> 35000 pes
%                = 2 ==> 36000 pes
%                = 3 ==> 37000 pes
%                = 4 ==> 38000 pes
%                = 5 ==> 39000 pes
%                = 6 ==> 40000 pes
%                = 7 ==> 41000 pes
%--------------------------------------------------------------------------
IntCon = [9,10,11,12,13];
Nvar=13;
PopSize=36;
%
if exist('population.dat','file') > 0
    delete 'population.dat';
end
options=gaoptimset('EliteCount',1,'PopulationSize',PopSize,...
    'Generations',15,'Display','iter',...
    'PlotFcns',{@gaplotbestindiv,@gaplotbestf,@gaplotgenealogy});
%    1     2    3     4     5     6    7   8     9   10  11   12   13
lb=[ 80;  7.5; 0.2;   15;  -5;   0.3;  0;  1;   1;  1;   1;   1;   1];
ub=[110;  11;  0.48;  30;  -1.5; 0.38; 1; 1.1;  4;  4;   5;   2;   7];
[x,~,~,output,population]=ga(@Fobjetivo,Nvar,[],[],[],[],lb,ub,[],IntCon,options);
%--------------------------------------------------------------------------
% Screen output of the optimal airplane characteristics
optimal_airplane=x
%--------------------------------------------------------------------------
xx=x;
xx(13)=35000 + (x(13)-1)*1000; % [ft]
[DOC_USnm, ~,...
               fuselage, wing, ht,vt,pylon,engine,wlet] = airp_calc_14u(xx);
%--------------------------------------------------------------------------
%               Airplane top view
%--------------------------------------------------------------------------
cd Plotairplane
figure(21)
PlotAirplane_topview_2(fuselage,wing,ht,vt,pylon,engine,wlet,2)
print -djpeg -f21 -r300 'TopView.jpg'
close(figure(21));
cd ..
%--------------------------------------------------------------------------
fprintf('\n ****** Optimal airplane characteristics  **** \n')
fprintf(' Wing area: %5.2f m2              \n',xx(1))
fprintf(' Wing AR: %5.2f                   \n',xx(2))
fprintf(' Wing TR: %5.2f                   \n',xx(3))
fprintf(' Wing quarter-chord sweep: %5.2f  \n',xx(4))
fprintf(' Wing twist: %5.2f   degrees       \n',xx(5))
fprintf(' TE break station @ : %5.1f percent of semispan  \n',xx(6)*100)
fprintf(' Kink break station incidence: %5.2f degree(s) \n',xx(7));
fprintf(' Fuselage height-to-width ratio : %5.1f   \n',xx(8))

fprintf(' Root airfoil: no %i   \n',xx(9))
fprintf(' Break-station airfoil: no %i   \n',xx(10))
fprintf(' Tip station airfoil: no %i   \n',xx(11))
fprintf(' MMO: %5.2f  \n',xx(11))
fprintf(' Engine choice: %i \n',xx(12))
fprintf(' Service ceiling: %i ft \n',xx(13))
fprintf(' DOC: %6.3f US$/nm    \n',DOC_USnm)
fprintf('*********************************************** \n')
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



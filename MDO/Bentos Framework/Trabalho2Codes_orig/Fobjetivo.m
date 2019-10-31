%--------------------------------------------------------------------------
% Funcao Objetivo com penalizacao do DOC
%           se aviao viola qq uma das restricpes
%--------------------------------------------------------------------------
function y = Fobjetivo(x)
% ajusta teto de servico para altitudes que difiram em 1000 pes
% xx=x(13)/1000;
% ceiling_main_str=sprintf('%5.0f',xx);
% ceiling_main=str2double(ceiling_main_str);
% ceiling_frac=round(ceiling_main - x(13)/1000);
% x(13)= 1000*ceiling_main+ceiling_frac;
xx=x;
xx(13)=35000 + (x(13)-1)*1000; % [ft]
%--------------- fim do ajuste --------------------------------------------
%---------------- Dimensionamento do Aviao e calculo do DOC ---------------
[DOC_USnm, Flag_constraints,~,~,~,~,~,~,~] = airp_calc_14u(xx);

%penalização do objetivo (DOC) caso configuração não atenda às restrições
violations=sum(Flag_constraints);
    if abs(violations) > 0 
    y = 20 + 0.50*violations*DOC_USnm;
    else
    y = DOC_USnm;
    end

end
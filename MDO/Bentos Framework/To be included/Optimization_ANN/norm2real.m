function [ parametros ] = norm2real(parametros_normalizados,flag)

n = size(parametros_normalizados);
parametros = parametros_normalizados;

limites = limites_parametros(flag);

for i = 1:n(2)
    parametros(:,i) = parametros_normalizados(:,i).*(limites(i, 2)-limites(i, 1))+limites(i, 1);
end

end


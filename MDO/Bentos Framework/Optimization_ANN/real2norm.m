function [ parametros_normalizados ] = real2norm(parametros, flag)

n = size(parametros);
parametros_normalizados = parametros;

limites = limites_parametros(flag);

for i = 1:n(2)
    parametros_normalizados(:,i) = (parametros(:,i) - limites(i, 1))/(limites(i, 2) - limites(i, 1));
end

end


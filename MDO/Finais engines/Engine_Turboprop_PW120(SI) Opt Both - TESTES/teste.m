pi_c = 20;

factor = linspace(0.45,0.7,100);
pi_cH = (pi_c/2).*factor ;
pi_cL = pi_c./pi_cH;

pi_total = pi_cH.*pi_cL
plot(factor,pi_cH,factor,pi_cL,factor,pi_total)
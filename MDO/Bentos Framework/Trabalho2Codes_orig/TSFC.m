function c=TSFC(c_ref,href_ft,Mref,BPR,h_ft,M)
% Calculo do consumo especifico do motor
% Valores de referência são para a MMO na altitude de cruzeiro
% Ref: Howe - Aircraft Conceptual Design Synthesis
%--------------------------------------------------------------------------
% Passo 1: Ajusta parametro para condicao de referencia
atm=atmosfera(href_ft,0);
rho=atm(6);
sigma_ref=rho/1.225;
T1=(1-0.15*(BPR^0.65));
T2=(1+0.28*(1+0.063*BPR*BPR)*Mref);
c_linha= c_ref/(T1*T2*(sigma_ref^0.08));
% Passo 2: Calculo no ponto desejado
atm=atmosfera(h_ft,0);
sigma=atm(6)/1.225;
T2=(1+0.28*(1+0.063*BPR*BPR)*M);
c=c_linha*T1*T2*(sigma^0.08);
end % function TSFC 
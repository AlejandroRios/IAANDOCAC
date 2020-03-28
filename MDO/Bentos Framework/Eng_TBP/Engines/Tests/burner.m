function [pt4 f]=burner(prb,pt3,Tt3,cpaf,Tt4,cp,LHV,nb);
pt4=(prb*pt3);
f=(((cpaf*Tt4)-(cp*Tt3))/((LHV*nb)-(cpaf*Tt4)));
end
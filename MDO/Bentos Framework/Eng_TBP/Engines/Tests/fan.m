function [pt13 Tt13]=fan(pt2,prf,g,nf,Tt2);
pt13=(prf*pt2);
Tt13=(((((prf^((g-1)/g))-1)/nf)+1)*Tt2);
end
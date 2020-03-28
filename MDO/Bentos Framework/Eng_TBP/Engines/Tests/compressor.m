function [pt3 Tt3]=compressor(prc,pt2,g,nc,Tt2);
pt3=(prc*pt2);
Tt3=(((((prc^((g-1)/g))-1)/nc)+1)*Tt2);
end
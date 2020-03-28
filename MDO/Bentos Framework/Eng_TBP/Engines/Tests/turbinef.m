function [Tt5 pt5]=turbinef(pt4,Tt4,cp,Tt3,Tt2,f,cpaf,gaf,nm,Tt13,alpha,et);
Tt5=(Tt4-((cp*((Tt3-Tt2)+(alpha*(Tt13-Tt2)))/((1+f)*cpaf*nm))));
taut=Tt5/Tt4;
prt=(taut)^(gaf/((gaf-1)*et));
pt5=prt*pt4;
end
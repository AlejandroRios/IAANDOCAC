function [v0 pt0 Tt0 pt2 Tt2 pt3 Tt3 pt4 f pt45 Tt45 pt5 Tt5 Tt9 pt9 m9 p9 T9 v9  spthrttl TSFC nth np no spthrpropRspthrttl]=turboprop(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nmhpt,nlpt,nmlpt,ehpt,ngb,nprop,nnzl,Raf,alpha)
a0=((g*R*T0)^0.5);
v0=(m0*((g*R*T0)^0.5));
pt0=((((1+(((g-1)*(m0^2))/2))^(g/(g-1)))*p0));
Tt0=(T0*(1+(((m0^2)*0.5*g*R)/cp)));
pt2=(prd*pt0);
Tt2=Tt0;
pt3=(prc*pt2);
Tt3=(((((prc^((g-1)/g))-1)/nc)+1)*Tt2);
pt4=(prb*pt3);
f=(((cpaf*Tt4)-(cp*Tt3))/((LHV*nb)-(cpaf*Tt4)));
Tt45=Tt4-(((Tt3-Tt2)*cp)/(cpaf*nmhpt*(1+f)));
tauhpt=Tt45/Tt4;
prhpt=(tauhpt)^(gaf/((gaf-1)*ehpt));
pt45=prhpt*pt4;
Tt5=Tt45-(nlpt*alpha*Tt45*(1-(p0/pt45)^((gaf-1)/gaf)));
taulpt=Tt5/Tt45;
prlpt=(1-((1-taulpt)/nlpt))^((gaf)/(gaf-1));
pt5=prlpt*pt45;
Tt9=Tt5;
T9i=Tt5/((pt5/p0)^((gaf-1)/gaf));
T9=Tt5-(nnzl*(Tt5-T9i));
v9=((2*cpaf*(Tt5-T9))^0.5);
a9=((gaf*R*T9)^0.5);
m9=v9/a9;

if m9<1
    p9=p0;
   pt9=((((1+(((gaf-1)*(m9^2))/2))^(gaf/(gaf-1)))*p9)); 
   prn=pt9/pt5;
   spthrprop=(nprop*ngb*nmlpt*((nlpt*alpha*cpaf*Tt45*(1-(p0/pt45)^((gaf-1)/gaf)))*(1+f)))/v0;
   spthrcore=((1+f)*v9)-v0;
   sppwrprop=ngb*nmlpt*(nlpt*alpha*cpaf*Tt45*(1-(p0/pt45)^((gaf-1)/gaf)))*(1+f);
   sppwrcore=0.5*(((1+f)*v9*v9)-(v0*v0));
   spthrttl=spthrcore+spthrprop;
   spthrpropRspthrttl=spthrprop/spthrttl;
   TSFC=(f*10^6)/spthrttl;
   nth=((sppwrcore+sppwrprop)/(f*LHV));
   np=(spthrttl*v0)/(sppwrcore+sppwrprop);
   no=np*nth;
   
else
end
function [v01 pt01 Tt01 pt21 Tt21 pt31 Tt31 pt41 f1 pt451 Tt451 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91  spthrttl1 TSFC1 nth1 np1 no1 spthrpropRspthrttl1]=turboprop1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nmhpt,nlpt,nmlpt,ehpt,ngb,nprop,nnzl,Raf,alpha)
a01=(g*R*T0)^0.5;
v01=(m0*((g*R*T0)^0.5));
pt01=((((1+(((g-1)*(m0^2))/2))^(g/(g-1)))*p0));
Tt01=(T0*(1+(((m0^2)*0.5*g*R)/cp)));
pt21=(prd*pt01);
Tt21=Tt01;
pt31=(prc*pt21);
Tt31=(((((prc^((g-1)/g))-1)/nc)+1)*Tt21);
pt41=(prb*pt31);
f1=(((cpaf*Tt4)-(cp*Tt31))/((LHV*nb)-(cpaf*Tt4)));
Tt451=Tt4-(((Tt31-Tt21)*cp)/(cpaf*nmhpt*(1+f1)));
tauhpt1=Tt451/Tt4;
prhpt1=(tauhpt1)^(gaf/((gaf-1)*ehpt));
pt451=prhpt1*pt41;
Tt51=Tt451-(nlpt*alpha*Tt451*(1-(p0/pt451)^((gaf-1)/gaf)));
taulpt1=Tt51/Tt451;
prlpt1=(1-((1-taulpt1)/nlpt))^((gaf)/(gaf-1));
pt51=prlpt1*pt451;
Tt91=Tt51;
T9i1=Tt51/((pt51/p0)^((gaf-1)/gaf));
T91=Tt51-(nnzl*(Tt51-T9i1));
v91=((2*cpaf*(Tt51-T91))^0.5);
a91=((gaf*R*T91)^0.5);
m91=v91/a91;
if m91<1
    p91=p0;
   pt91=((((1+(((gaf-1)*(m91^2))/2))^(gaf/(gaf-1)))*p91)); 
   prn1=pt91/pt51;
   spthrprop1=(nprop*ngb*nmlpt*((nlpt*alpha*cpaf*Tt451*(1-(p0/pt451)^((gaf-1)/gaf)))*(1+f1)))/v01;
   spthrcore1=((1+f1)*v91)-v01;
   sppwrprop1=ngb*nmlpt*(nlpt*alpha*cpaf*Tt451*(1-(p0/pt451)^((gaf-1)/gaf)))*(1+f1);
   sppwrcore1=0.5*(((1+f1)*v91*v91)-(v01*v01));
   spthrttl1=spthrcore1+spthrprop1;
   TSFC1=(f1*10^6)/spthrttl1;
   nth1=((sppwrcore1+sppwrprop1)/(f1*LHV));
   np1=(spthrttl1*v01)/(sppwrcore1+sppwrprop1);
   no1=np1*nth1;
   spthrpropRspthrttl1=spthrprop1/spthrttl1;
else
end
function [v01 pt01 Tt01 pt21 Tt21 pt31 Tt31 pt41 f1 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91 A9Rm01 veff1 spthr1 TSFC1 nth1 np1 no1 st1]=analysis1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nt,prn,Raf)
v01=(m0*((g*R*T0)^0.5));
pt01=((((1+(((g-1)*(m0^2))/2))^(g/(g-1)))*p0));
Tt01=(T0*(1+(((m0^2)*0.5*g*R)/cp)));
pt21=(prd*pt01);
Tt21=Tt01;
pt31=(prc*pt21);
Tt31=(((((prc^((g-1)/g))-1)/nc)+1)*Tt21);
pt41=(prb*pt31);
f1=(((cpaf*Tt4)-(cp*Tt31))/((LHV*nb)-(cpaf*Tt4)));
pt51=(pt41*(((((((Tt4-((cp*(Tt31-Tt21))/((1+f1)*cpaf)))/Tt4)-1)/nt)+1))^((gaf)/(gaf-1))));
Tt51=(Tt4-((cp*(Tt31-Tt21))/((1+f1)*cpaf)));
Tt91=Tt51;
pt91=(prn*pt51);
if (pt51/p0)>(((gaf+1)/2)^(gaf/(gaf-1)))
    m91=1;
    p91=(pt91/((1+(0.5*(gaf-1)*((m91)^2)))^(gaf/(gaf-1))));
    T91=(Tt91/(1+(0.5*(gaf-1)*((m91)^2))));
    v91=((2*cpaf*(Tt51-T91))^0.5);
    A9Rm01=((1+f1)*((Raf*T91)/(p91*v91)));
    veff1=(v91+(A9Rm01*((p91-p0)/(1+f1))));
    spthr1=((((1+f1)*v91)-v01)+(A9Rm01*(p91-p0)));
    TSFC1=((f1/spthr1)*10^6);
    nth1=((((1+f1)*((veff1)^2))-((v01)^2))/(2*f1*LHV));
    np1=((2*spthr1*v01)/(((1+f1)*((veff1)^2))-(v01)^2));
    no1=(nth1*np1);
    st1='The flow is chocked at the nozzle exit';
else
    p91=p0;
    m91=(((((pt91/p91)^((gaf-1)/(gaf)))-1)*(2/(gaf-1)))^0.5);
     T91=(Tt91/(1+(0.5*(gaf-1)*((m91)^2))));
    v91=((2*cpaf*(Tt51-T91))^0.5);
    A9Rm01=((1+f1)*((Raf*T91)/(p91*v91)));
    veff1=(v91+(A9Rm01*((p91-p0)/(1+f1))));
    spthr1=((((1+f1)*v91)-v01)+(A9Rm01*(p91-p0)));
    TSFC1=((f1/spthr1)*10^6);
    nth1=((((1+f1)*((veff1)^2))-((v01)^2))/(2*f1*LHV));
    np1=((2*spthr1*v01)/(((1+f1)*((veff1)^2))-(v01)^2));
    no1=(nth1*np1);
    st1='The flow is chocked at the nozzle exit';
end
end
function [v0 pt0 Tt0 pt2 Tt2 pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 veff spthr TSFC nth np no st]=analysis(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,et,prn,Raf)
v0=(m0*((g*R*T0)^0.5));
pt0=((((1+(((g-1)*(m0^2))/2))^(g/(g-1)))*p0));
Tt0=(T0*(1+(((m0^2)*0.5*g*R)/cp)));
pt2=(prd*pt0);
Tt2=Tt0;
pt3=(prc*pt2);
Tt3=(((((prc^((g-1)/g))-1)/nc)+1)*Tt2);
pt4=(prb*pt3);
f=(((cpaf*Tt4)-(cp*Tt3))/((LHV*nb)-(cpaf*Tt4)));
Tt5=(Tt4-((cp*(Tt3-Tt2))/((1+f)*cpaf)));
tau=Tt5/Tt4;
prt=tau^((et*g)/(g-1));
pt5=prt*pt4;
Tt9=Tt5;
pt9=(prn*pt5);
if (pt5/p0)>(((gaf+1)/2)^(gaf/(gaf-1)))
    m9=1;
    p9=(pt9/((1+(0.5*(gaf-1)*((m9)^2)))^(gaf/(gaf-1))));
    T9=(Tt9/(1+(0.5*(gaf-1)*((m9)^2))));
    v9=((2*cpaf*(Tt5-T9))^0.5);
    A9Rm0=((1+f)*((Raf*T9)/(p9*v9)));
    veff=(v9+(A9Rm0*((p9-p0)/(1+f))));
    spthr=((((1+f)*v9)-v0)+(A9Rm0*(p9-p0)));
    TSFC=((f/spthr)*10^6);
    nth=((((1+f)*((veff)^2))-((v0)^2))/(2*f*LHV));
    np=((2*spthr*v0)/(((1+f)*((veff)^2))-(v0)^2));
    no=(nth*np);
    st='The flow is chocked at the nozzle exit';
else
    p9=p0;
    m9=(((((pt9/p9)^((gaf-1)/(gaf)))-1)*(2/(gaf-1)))^0.5);
    T9=(Tt9/(1+(0.5*(gaf-1)*((m9)^2))));
    v9=((2*cpaf*(Tt5-T9))^0.5);
    A9Rm0=((1+f)*((Raf*T9)/(p9*v9)));
    veff=(v9+(A9Rm0*((p9-p0)/(1+f))));
    spthr=((((1+f)*v9)-v0)+(A9Rm0*(p9-p0)));
    TSFC=((f/spthr)*10^6);
    nth=((((1+f)*((veff)^2))-((v0)^2))/(2*f*LHV));
    np=((2*spthr*v0)/(((1+f)*((veff)^2))-(v0)^2));
    no=(nth*np);
    st='The flow is unchocked at the nozzle exit';
end
end
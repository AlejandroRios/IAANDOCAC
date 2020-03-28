function [a0 v0 pt0 Tt0 pt2 Tt2 pt13 Tt13 pt19 Tt19 m19 T19 p19 r19 v19 v19eff pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 veff nspthrf nspthr rfc nth nspthrs np no TSFC nspthrsalpha]=turbofan(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nm,prn,Raf,et,prf,prfn,nf,alpha)
a0=((g*R*T0)^0.5);
v0=(m0*((g*R*T0)^0.5));
pt0=((((1+(((g-1)*(m0^2))/2))^(g/(g-1)))*p0));
Tt0=(T0*(1+(((m0^2)*0.5*g*R)/cp)));
pt2=(prd*pt0);
Tt2=Tt0;
[pt13 Tt13]=fan(pt2,prf,g,nf,Tt2);
pt19=pt13*prfn;
Tt19=Tt13;
if (pt13/p0)>(((g+1)/2)^(g/(g-1)))
    m19=1;
    T19=(Tt19/(1+(0.5*(g-1)*((m19)^2))));
    p19=(pt19/((1+(0.5*(g-1)*((m19)^2)))^(g/(g-1))));
    r19=p19/(R*T19);
    v19=((g*R*T19)^0.5)*m19;
    v19eff=v19+((1-(p0/p19))*(p19/(r19*v19)));
else
    p19=p0;
    m19=(((((pt19/p19)^((g-1)/(g)))-1)*(2/(g-1)))^0.5);
    T19=(Tt19/(1+(0.5*(g-1)*((m19)^2))));
    r19=p19/(R*T19);
    v19=((g*R*T19)^0.5)*m19;
    v19eff=v19+((1-(p0/p19))*(p19/(r19*v19)));
end
    
[pt3 Tt3]=compressor(prc,pt2,g,nc,Tt2);
[pt4 f]=burner(prb,pt3,Tt3,cpaf,Tt4,cp,LHV,nb);
[Tt5 pt5]=turbinef(pt4,Tt4,cp,Tt3,Tt2,f,cpaf,gaf,nm,Tt13,alpha,et);
Tt9=Tt5;
pt9=(prn*pt5);
if (pt5/p0)>(((gaf+1)/2)^(gaf/(gaf-1)))
    m9=1;
    p9=(pt9/((1+(0.5*(gaf-1)*((m9)^2)))^(gaf/(gaf-1))));
    T9=(Tt9/(1+(0.5*(gaf-1)*((m9)^2))));
    v9=((2*cpaf*(Tt5-T9))^0.5);
    A9Rm0=((1+f)*((Raf*T9)/(p9*v9)));
    veff=(v9+(A9Rm0*((p9-p0)/(1+f))));
    nspthrf=((alpha*(v19eff-v0))/((1+alpha)*a0));
    nspthr=((((1+f)*veff)-v0)/((1+alpha)*a0));
    nspthrs=nspthr+nspthrf;
    rfc=(nspthrf/nspthr);
    nth=(((alpha*(v19eff^2))+((1+f)*((veff)^2))-(((v0)^2)*(1+alpha)))/(2*f*LHV));
    np=((2*nspthrs*(1+alpha)*a0*v0)/((alpha*(v19eff^2))+((1+f)*((veff)^2))-(((v0)^2)*(1+alpha))));
    no=nth*np;
    TSFC=(f*10^6/(nspthrs*a0*(1+alpha)));
    nspthrsalpha=nspthrs*(1+alpha);
else
    p9=p0;
    m9=(((((pt9/p9)^((gaf-1)/(gaf)))-1)*(2/(gaf-1)))^0.5);
   T9=(Tt9/(1+(0.5*(gaf-1)*((m9)^2))));
    v9=((2*cpaf*(Tt5-T9))^0.5);
    A9Rm0=((1+f)*((Raf*T9)/(p9*v9)));
    veff=(v9+(A9Rm0*((p9-p0)/(1+f))));
    nspthrf=((alpha*(v19eff-v0))/((1+alpha)*a0));
    nspthr=((((1+f)*veff)-v0)/((1+alpha)*a0));
    nspthrs=nspthr+nspthrf;
    rfc=(nspthrf/nspthr);
    nth=(((alpha*(v19eff^2))+((1+f)*((veff)^2))-(((v0)^2)*(1+alpha)))/(2*f*LHV));
    np=((2*nspthrs*(1+alpha)*a0*v0)/((alpha*(v19eff^2))+((1+f)*((veff)^2))-(((v0)^2)*(1+alpha))));
    no=nth*np;
    TSFC=(f*10^6/(nspthrs*a0*(1+alpha)));
    nspthrsalpha=nspthrs*(1+alpha);
end
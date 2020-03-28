function [a01 v01 pt01 Tt01 pt21 Tt21 pt131 Tt131 pt191 Tt191 m191 T191 p191 r191 v191 v19eff1 pt31 Tt31 pt41 f1 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91 A9Rm01 veff1 nspthrf1 nspthr1 rfc1 nth1 nspthrs1 np1 no1 TSFC1 nspthrsalpha1]=turbofan1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nm,prn,Raf,et,prf,prfn,nf,alpha)
a01=(g*R*T0)^0.5;
v01=(m0*((g*R*T0)^0.5));
pt01=((((1+(((g-1)*(m0^2))/2))^(g/(g-1)))*p0));
Tt01=(T0*(1+(((m0^2)*0.5*g*R)/cp)));
pt21=(prd*pt01);
Tt21=Tt01;
[pt131 Tt131]=fan(pt21,prf,g,nf,Tt21);
pt191=pt131*prfn;
Tt191=Tt131;
if (pt131/p0)>(((g+1)/2)^(g/(g-1)))
    m191=1;
    T191=(Tt191/(1+(0.5*(g-1)*((m191)^2))));
    p191=(pt191/((1+(0.5*(g-1)*((m191)^2)))^(g/(g-1))));
    r191=p191/(R*T191);
    v191=((g*R*T191)^0.5);
    v19eff1=v191+((1-(p0/p191))*(p191/(r191*v191)));
else
    p191=p0;
    m191=(((((pt191/p191)^((g-1)/(g)))-1)*(2/(g-1)))^0.5);
    T191=(Tt191/(1+(0.5*(g-1)*((m191)^2))));
    r191=p191/(R*T191);
    v191=((g*R*T191)^0.5*m191);
    v19eff1=v191+((1-(p0/p191))*(p191/(r191*v191)));
end
    
pt31=(prc*pt21);
Tt31=(((((prc^((g-1)/g))-1)/nc)+1)*Tt21);
pt41=(prb*pt31);
f1=(((cpaf*Tt4)-(cp*Tt31))/((LHV*nb)-(cpaf*Tt4)));
[Tt51 pt51]=turbinef(pt41,Tt4,cp,Tt31,Tt21,f1,cpaf,gaf,nm,Tt131,alpha,et);
Tt91=Tt51;
pt91=(prn*pt51);
if (pt51/p0)>(((gaf+1)/2)^(gaf/(gaf-1)))
    m91=1;
    p91=(pt91/((1+(0.5*(gaf-1)*((m91)^2)))^(gaf/(gaf-1))));
    T91=(Tt91/(1+(0.5*(gaf-1)*((m91)^2))));
    v91=((2*cpaf*(Tt51-T91))^0.5);
    A9Rm01=((1+f1)*((Raf*T91)/(p91*v91)));
    veff1=(v91+(A9Rm01*((p91-p0)/(1+f1))));
    nspthrf1=((alpha*(v19eff1-v01))/((1+alpha)*a01));
    nspthr1=((((1+f1)*veff1)-v01)/((1+alpha)*a01));
    nspthrs1=nspthr1+nspthrf1;
    rfc1=(nspthrf1/nspthr1);
    nth1=(((alpha*(v19eff1^2))+((1+f1)*((veff1)^2))-(((v01)^2)*(1+alpha)))/(2*f1*LHV));
    np1=((2*nspthrs1*(1+alpha)*a01*v01)/((alpha*(v19eff1^2))+((1+f1)*((veff1)^2))-(((v01)^2)*(1+alpha))));
    no1=nth1*np1;
    TSFC1=(f1*10^6/(nspthrs1*a01*(1+alpha)));
    nspthrsalpha1=nspthrs1*(1+alpha);
else
    p91=p0;
    m91=(((((pt91/p91)^((gaf-1)/(gaf)))-1)*(2/(gaf-1)))^0.5);
    T91=(Tt91/(1+(0.5*(gaf-1)*((m91)^2))));
    v91=((2*cpaf*(Tt51-T91))^0.5);
    A9Rm01=((1+f1)*((Raf*T91)/(p91*v91)));
    veff1=(v91+(A9Rm01*((p91-p0)/(1+f1))));
    nspthrf1=((alpha*(v19eff1-v01))/((1+alpha)*a01));
    nspthr1=((((1+f1)*veff1)-v01)/((1+alpha)*a01));
    nspthrs1=nspthr1+nspthrf1;
    rfc1=(nspthrf1/nspthr1);
    nth1=(((alpha*(v19eff1^2))+((1+f1)*((veff1)^2))-(((v01)^2)*(1+alpha)))/(2*f1*LHV));
    np1=((2*nspthrs1*(1+alpha)*a01*v01)/((alpha*(v19eff1^2))+((1+f1)*((veff1)^2))-(((v01)^2)*(1+alpha))));
    no1=nth1*np1;
    TSFC1=(f1*10^6/(nspthrs1*a01*(1+alpha)));
    nspthrsalpha1=nspthrs1*(1+alpha);
end
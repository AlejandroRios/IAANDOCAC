%%%%%%%%%%%%%%%%%%%%%%%%CDLfus%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eq 4.33 pag 79
% CDLfus = 2a²Sbfus/S + n.Cdc.|a|³.Splfus/S

function CDLfus = DragIndFus(AIRPLANECL0,AIRPLANECLA,asaref,lf,df,CL,mach,PEng)

%
cockpit.r=df/2; % height [m]
cockpit.parameter1=2; % paramero elipse
cockpit.parameter2=1.3; % paramero elipse
aux2=0;
Aco=0;
fuslco  = 4.5; %
for aux1=0:0.01:fuslco
    aux2=aux2+1;
    cockpit.x(aux2)=aux1;
    cockpit.y(aux2)=real((cockpit.r^cockpit.parameter2-(((aux1-fuslco)^cockpit.parameter1)*(cockpit.r^cockpit.parameter2)/(fuslco^cockpit.parameter1)))^(1/cockpit.parameter2));
    cockpit.w(aux2)=2*cockpit.y(aux2);
    Acoi(aux2) = cockpit.w(aux2)* 0.01; %integral da area;
    Aco = Aco+Acoi(aux2);
end
    if PEng == 2
    fuselagetail_df=2.0;  
    else
    fuselagetail_df=1.8; % relacao coni/diametro Roskam vol 2 pag 110
    end
fustail = fuselagetail_df*df;
tail.r=df/2;
tail.parameter1=1;
tail.parameter2=2;
aux4=0;
Atail=0;
for aux3=0:0.01:fustail
    aux4=aux4+1;
    tail.x(aux4)=aux3;
    tail.y(aux4)=real(((tail.r^tail.parameter2)*(1-((tail.x(aux4)/fustail)^tail.parameter1)))^(1/tail.parameter2));
    tail.w(aux4)=2*tail.y(aux4);
    Ataili(aux4) = tail.w(aux4)*0.01;
    Atail = Atail + Ataili(aux4);
end
fuslcab=lf-fuslco-fustail;
Acab = fuslcab*df;
%
Sbfus = 0.06; % Area da Base
a = (CL - AIRPLANECL0)/(AIRPLANECLA*180/pi);
Splfus = Aco + Acab + Atail;

% interpolacao fig 4.19 pag 80
lf_df = lf/df;
n_xv = [2.08797	3.16015	3.87494	5.1847	6.67241	7.80274	8.93277	10.1809	11.1323	12.5587	13.9841	15.3509	16.5981	18.0235	19.3894	20.9332	22.3584	23.7829	25.3265	27.7008];
n_yv = [0.559184	0.581348	0.596124	0.619747	0.643352	0.659568	0.6743	0.686049	0.697829	0.711044	0.719804	0.73154	0.738833	0.747593	0.754874	0.762136	0.76941	0.773715	0.779492	0.786665];
if lf_df > max(n_xv)
    lf_df = max(n_xv);
end
n = interp1(n_xv,n_yv,lf_df);

% interpolacao fig 4.20 pag 80
Mc = mach*sin(abs(a));
cdc_xv = [0.0	0.101794	0.178716	0.264548	0.303062	0.353461	0.403966	0.442619	0.505132	0.56178	0.621492	0.666341	0.705151	0.729046	0.761799	0.797441	0.847876	0.898223	0.942601	0.986944];
cdc_yv = [1.20	1.20	1.20	1.20866	1.2174	1.23495	1.27019	1.30253	1.36724	1.44082	1.53209	1.6116	1.67049	1.70876	1.74407	1.76756	1.79101	1.79971	1.79958	1.79355];
cdc = interp1(cdc_xv,cdc_yv,Mc);
T1=2*(a^2)*Sbfus/asaref;
T2=n*cdc*((abs(a))^3)*Splfus/asaref;
CDLfus =  T1 + T2;